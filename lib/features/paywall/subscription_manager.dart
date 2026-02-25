import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

// ✅ NUEVO: para sincronizar con Firestore el plan Pro
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  // iOS: com.ezinvoice.pro.monthly / com.ezinvoice.pro.yearly
  // Android: mismo id (recomendado)
  static const String kMonthlyId = 'com.ezinvoice.pro.monthly';
  static const String kYearlyId = 'com.ezinvoice.pro.yearly';

  final Set<String> _productIds = {kMonthlyId, kYearlyId};

  StreamSubscription<List<PurchaseDetails>>? _purchaseSub;

  // Productos cargados (para mostrar precios)
  ProductDetails? monthlyProduct;
  ProductDetails? yearlyProduct;

  // Estado observable
  final ValueNotifier<SubscriptionState> state =
  ValueNotifier(const SubscriptionState(isPro: false, plan: ProPlan.none));

  bool _initialized = false;

  /// ✅ Helper seguro para llamar desde cualquier pantalla sin duplicar init
  Future<void> safeInit() async {
    try {
      await init();
    } catch (e) {
      debugPrint('❌ safeInit error: $e');
    }
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
  }

  Future<void> dispose() async {
    await _purchaseSub?.cancel();
    _purchaseSub = null;
  }

  Future<void> loadProducts() async {
    final response = await _iap.queryProductDetails(_productIds);

    if (response.error != null) {
      debugPrint('❌ queryProductDetails error: ${response.error}');
      return;
    }

    if (response.productDetails.isEmpty) {
      debugPrint('⚠️ No se encontraron productos. ¿Ya los creaste en App Store/Play?');
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
    // Para suscripciones se usa buyNonConsumable (in_app_purchase maneja subscriptions así)
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

  /// Restaurar compras (iOS esencial, Android útil)
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
      // Si está pending, no hacemos nada aún
      if (purchase.status == PurchaseStatus.pending) {
        continue;
      }

      // Si hubo error
      if (purchase.status == PurchaseStatus.error) {
        debugPrint('❌ Compra error: ${purchase.error}');
        // Completar si aplica
        if (purchase.pendingCompletePurchase) {
          await _iap.completePurchase(purchase);
        }
        continue;
      }

      // Comprado o restaurado
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        // MVP: verificación local por ID
        if (purchase.productID == kMonthlyId) {
          isPro = true;
          plan = ProPlan.monthly;
        } else if (purchase.productID == kYearlyId) {
          isPro = true;
          plan = ProPlan.yearly;
        }

        // Completar compra en iOS/Android cuando sea necesario
        if (purchase.pendingCompletePurchase) {
          await _iap.completePurchase(purchase);
        }
      }
    }

    await _setPro(isPro: isPro, plan: plan);
  }

  // ✅ NUEVO: sincroniza estado a Firestore para que HomeScreen lo vea
  Future<void> _syncToFirestore({required bool isPro, required ProPlan plan}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final planString = isPro
        ? (plan == ProPlan.yearly ? 'pro' : 'pro') // mantén "pro" para tu Home
        : 'free';

    // Puedes guardar más detalle si quieres:
    // planKind: 'monthly' / 'yearly' / 'none'
    final planKind = plan == ProPlan.monthly
        ? 'monthly'
        : plan == ProPlan.yearly
        ? 'yearly'
        : 'none';

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'isPro': isPro,
          'plan': planString, // HomeScreen usa esto
          'proPlan': planKind, // opcional útil
          'updatedAtMs': DateTime.now().millisecondsSinceEpoch,
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      debugPrint('❌ Firestore sync error: $e');
    }
  }

  Future<void> _setPro({required bool isPro, required ProPlan plan}) async {
    final newState = state.value.copyWith(isPro: isPro, plan: plan);

    if (state.value.isPro == newState.isPro && state.value.plan == newState.plan) {
      return;
    }

    state.value = newState;

    if (kDebugMode) debugPrint('✅ Pro: $isPro | Plan: $plan');

    // ✅ Esto es lo que arregla tu HomeScreen (FREE badge + Upgrade + bloqueo)
    await _syncToFirestore(isPro: isPro, plan: plan);
  }
}
