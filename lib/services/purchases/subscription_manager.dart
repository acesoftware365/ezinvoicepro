import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

enum ProPlan { none, monthly, yearly }

class SubscriptionState {
  final bool isPro;
  final ProPlan plan;
  final String? priceMonthly;
  final String? priceYearly;

  const SubscriptionState({
    required this.isPro,
    required this.plan,
    this.priceMonthly,
    this.priceYearly,
  });

  SubscriptionState copyWith({
    bool? isPro,
    ProPlan? plan,
    String? priceMonthly,
    String? priceYearly,
  }) {
    return SubscriptionState(
      isPro: isPro ?? this.isPro,
      plan: plan ?? this.plan,
      priceMonthly: priceMonthly ?? this.priceMonthly,
      priceYearly: priceYearly ?? this.priceYearly,
    );
  }
}

/// Maneja compras/suscripción.
/// Nota: Para producción, debes verificar recibos en servidor o usar verificación (Firebase/Cloud Function),
/// pero para MVP funciona con verificación local.
class SubscriptionManager {
  SubscriptionManager._();
  static final SubscriptionManager instance = SubscriptionManager._();

  final InAppPurchase _iap = InAppPurchase.instance;

  // ✅ IDs sugeridos (crea los mismos en App Store Connect / Play Console)
  static const String kMonthlyId = 'com.ezinvoice.pro.monthly';
  static const String kYearlyId = 'com.ezinvoice.pro.yearly';

  final Set<String> _productIds = {kMonthlyId, kYearlyId};

  StreamSubscription<List<PurchaseDetails>>? _purchaseSub;

  // Productos cargados (para mostrar precios)
  ProductDetails? monthlyProduct;
  ProductDetails? yearlyProduct;

  // ✅ Estado observable
  final ValueNotifier<SubscriptionState> state = ValueNotifier(
    const SubscriptionState(isPro: false, plan: ProPlan.none),
  );

  bool _initialized = false;

  String? _currentUserEmail;

  /// Mantiene referencia del usuario actual para diagnóstico.
  /// No otorga privilegios ni desbloquea features.
  void setCurrentUserEmail(String? email) {
    _currentUserEmail = email?.trim().toLowerCase();
  }

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    final available = await _iap.isAvailable();
    if (!available) {
      if (kDebugMode) debugPrint('❌ IAP no disponible en este device');
      return;
    }

    // Escuchar compras
    _purchaseSub = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onError: (e) => debugPrint('❌ purchaseStream error: $e'),
    );

    // Cargar productos
    await loadProducts();

    // Restaurar / re-chequear (recomendado al iniciar)
    await restorePurchases();

    if (kDebugMode) {
      debugPrint('✅ SubscriptionManager listo para $_currentUserEmail');
    }
  }

  Future<void> dispose() async {
    await _purchaseSub?.cancel();
    _purchaseSub = null;
  }

  Future<void> loadProducts() async {
    final response = await _iap.queryProductDetails(_productIds);

    debugPrint('🔍 Requested product IDs: $_productIds');
    debugPrint('❌ Not found IDs: ${response.notFoundIDs}');
    debugPrint('⚠️ Error: ${response.error}');
    debugPrint(
      '✅ Found products: ${response.productDetails.map((e) => e.id).toList()}',
    );

    if (response.error != null) {
      debugPrint('❌ queryProductDetails error: ${response.error}');
      return;
    }

    if (response.productDetails.isEmpty) {
      debugPrint(
        '⚠️ No se encontraron productos. ¿Ya los creaste en App Store/Play?',
      );
      return;
    }

    for (final p in response.productDetails) {
      if (p.id == kMonthlyId) monthlyProduct = p;
      if (p.id == kYearlyId) yearlyProduct = p;
    }

    state.value = state.value.copyWith(
      priceMonthly: monthlyProduct?.price,
      priceYearly: yearlyProduct?.price,
    );
  }

  /// Comprar plan mensual
  Future<void> buyMonthly() async {
    final p = monthlyProduct;
    if (p == null) {
      debugPrint('⚠️ Producto mensual no cargado');
      await loadProducts();
      return;
    }
    final param = PurchaseParam(productDetails: p);
    await _iap.buyNonConsumable(purchaseParam: param);
  }

  /// Comprar plan anual
  Future<void> buyYearly() async {
    final p = yearlyProduct;
    if (p == null) {
      debugPrint('⚠️ Producto anual no cargado');
      await loadProducts();
      return;
    }
    final param = PurchaseParam(productDetails: p);
    await _iap.buyNonConsumable(purchaseParam: param);
  }

  /// Restaurar compras
  Future<void> restorePurchases() async {
    try {
      await _iap.restorePurchases();
    } catch (e) {
      debugPrint('❌ restorePurchases error: $e');
    }
  }

  // -----------------------------
  // Manejo de compras
  // -----------------------------
  Future<void> _onPurchaseUpdate(List<PurchaseDetails> purchases) async {
    bool isPro = false;
    ProPlan plan = ProPlan.none;

    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.pending) continue;

      if (purchase.status == PurchaseStatus.error) {
        debugPrint('❌ Compra error: ${purchase.error}');
        if (purchase.pendingCompletePurchase) {
          await _iap.completePurchase(purchase);
        }
        continue;
      }

      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        if (purchase.productID == kMonthlyId) {
          isPro = true;
          plan = ProPlan.monthly;
        } else if (purchase.productID == kYearlyId) {
          isPro = true;
          plan = ProPlan.yearly;
        }

        if (purchase.pendingCompletePurchase) {
          await _iap.completePurchase(purchase);
        }
      }
    }

    _setPro(isPro: isPro, plan: plan);
  }

  void _setPro({required bool isPro, required ProPlan plan}) {
    final newState = state.value.copyWith(isPro: isPro, plan: plan);
    if (state.value.isPro == newState.isPro &&
        state.value.plan == newState.plan) {
      return;
    }

    state.value = newState;
    if (kDebugMode) debugPrint('✅ Pro: $isPro | Plan: $plan');
  }

  /// Sincroniza estado Pro desde backend (Firestore) para casos como cuenta demo de App Review.
  /// No ejecuta compras, solo refleja el entitlement ya aprobado en servidor.
  void syncFromBackend({required bool isPro, String? proPlan}) {
    ProPlan plan = ProPlan.none;
    if (isPro) {
      switch ((proPlan ?? '').toLowerCase().trim()) {
        case 'yearly':
          plan = ProPlan.yearly;
          break;
        case 'monthly':
          plan = ProPlan.monthly;
          break;
        default:
          plan = ProPlan.monthly;
      }
    }
    _setPro(isPro: isPro, plan: plan);
  }
}
