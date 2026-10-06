import 'package:flutter/foundation.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
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

  /// Localized labels used by the Pro gate dialog.
  static String title(AppLocalizations t, ProFeature feature) {
    switch (feature) {
      case ProFeature.unlimitedInvoices:
        return t.proFeatureUnlimitedInvoices;
      case ProFeature.removePdfBranding:
        return t.proFeatureRemovePdfBranding;
      case ProFeature.exportCsv:
        return t.proFeatureExportCsv;
      case ProFeature.premiumTemplates:
        return t.proFeaturePremiumTemplates;
      case ProFeature.detailedTaxReport:
        return t.proFeatureDetailedTaxReport;
    }
  }

  static String subtitle(AppLocalizations t, ProFeature feature) {
    switch (feature) {
      case ProFeature.unlimitedInvoices:
        return t.proFeatureUnlimitedInvoicesDescription(
          freeMonthlyInvoiceLimit,
        );
      case ProFeature.removePdfBranding:
        return t.proFeatureRemovePdfBrandingDescription;
      case ProFeature.exportCsv:
        return t.proFeatureExportCsvDescription;
      case ProFeature.premiumTemplates:
        return t.proFeaturePremiumTemplatesDescription;
      case ProFeature.detailedTaxReport:
        return t.proFeatureDetailedTaxReportDescription;
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
