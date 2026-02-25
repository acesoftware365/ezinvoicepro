import 'package:flutter/material.dart';
import 'package:ezinvoice/services/purchases/feature_gate.dart';
// TODO: importa tu paywall screen real
// import 'package:ezinvoice/features/paywall/paywall_screen.dart';

class RequirePro {
  static Future<void> run(
      BuildContext context, {
        required ProFeature feature,
        required VoidCallback onAllowed,
      }) async {
    if (FeatureGate.allowed(feature)) {
      onAllowed();
      return;
    }

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('${FeatureGate.title(feature)} (Pro)'),
        content: Text(FeatureGate.subtitle(feature)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Not now'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Upgrade to Pro'),
          ),
        ],
      ),
    );

    if (ok == true) {
      // ✅ Aquí empujas tu paywall real
      // Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallScreen()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Open Paywall (connect PaywallScreen here)')),
      );
    }
  }
}
