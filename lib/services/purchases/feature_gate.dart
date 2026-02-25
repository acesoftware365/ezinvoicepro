import 'package:flutter/foundation.dart';
import 'subscription_manager.dart';

/// Features que son SOLO Pro
enum ProFeature {
  removePdfBranding,
  exportCsv,
  premiumTemplates,
  detailedTaxReport,
  unlimitedInvoices,
}

class FeatureGate {
  FeatureGate._();

  /// 🔑 Fuente única de verdad
  static bool get isPro => SubscriptionManager.instance.state.value.isPro;

  /// ✅ LÍMITE FREE (hardcoded por ahora)
  /// Luego podemos moverlo a Firestore si quieres
  static const int _freeInvoiceLimit = 20;

  static int get freeMonthlyInvoiceLimit => _freeInvoiceLimit;

  /// Reglas por feature
  static bool allowed(ProFeature feature) {
    if (isPro) return true;

    switch (feature) {
      case ProFeature.unlimitedInvoices:
        return false; // Free NO ilimitado
      case ProFeature.removePdfBranding:
        return false;
      case ProFeature.exportCsv:
        return false;
      case ProFeature.premiumTemplates:
        return false;
      case ProFeature.detailedTaxReport:
        return false;
    }
  }

  /// Helpers para UI
  static String title(ProFeature f) {
    switch (f) {
      case ProFeature.unlimitedInvoices:
        return 'Unlimited invoices';
      case ProFeature.removePdfBranding:
        return 'Remove PDF branding';
      case ProFeature.exportCsv:
        return 'Export CSV';
      case ProFeature.premiumTemplates:
        return 'Premium templates';
      case ProFeature.detailedTaxReport:
        return 'Detailed tax report';
    }
  }

  static String subtitle(ProFeature f) {
    switch (f) {
      case ProFeature.unlimitedInvoices:
        return 'Free plan allows up to $freeMonthlyInvoiceLimit invoices per month.';
      case ProFeature.removePdfBranding:
        return 'Remove “Powered by EzInvoice” from PDFs.';
      case ProFeature.exportCsv:
        return 'Export your invoices to CSV.';
      case ProFeature.premiumTemplates:
        return 'Unlock premium invoice templates.';
      case ProFeature.detailedTaxReport:
        return 'See detailed tax breakdown reports.';
    }
  }

  static void debugPrintState() {
    if (kDebugMode) {
      debugPrint(
        'FeatureGate → isPro=$isPro | freeLimit=$freeMonthlyInvoiceLimit',
      );
    }
  }
}
