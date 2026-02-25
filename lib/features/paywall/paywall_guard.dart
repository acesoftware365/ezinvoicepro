
import 'package:flutter/material.dart';
import 'package:ezinvoice/features/paywall/paywall_screen.dart';
import 'package:ezinvoice/services/purchases/subscription_manager.dart';

class PaywallGuard {
  static Future<bool> requirePro(BuildContext context) async {
    if (SubscriptionManager.instance.state.value.isPro) return true;

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PaywallScreen()),
    );

    return SubscriptionManager.instance.state.value.isPro;
  }
}
