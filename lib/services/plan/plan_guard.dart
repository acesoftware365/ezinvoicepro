import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ezinvoice/features/paywall/paywall_screen.dart';
import 'package:ezinvoice/services/purchases/subscription_manager.dart';

class PlanGuard {
  PlanGuard._();

  static DateTime _monthStart(DateTime now) => DateTime(now.year, now.month, 1);
  static DateTime _monthEnd(DateTime now) => DateTime(now.year, now.month + 1, 1);

  static Future<int> _getFreeLimitFromUserDoc() async {
    final user = FirebaseAuth.instance.currentUser!;
    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final data = doc.data() ?? {};
    final limit = data['freeMonthlyInvoiceLimit'];
    if (limit is int) return limit;
    if (limit is num) return limit.toInt();
    return 20;
  }

  static Future<int> _countInvoicesThisMonth() async {
    final user = FirebaseAuth.instance.currentUser!;
    final now = DateTime.now();
    final start = _monthStart(now).millisecondsSinceEpoch;
    final end = _monthEnd(now).millisecondsSinceEpoch;

    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('invoices')
        .where('createdAtMs', isGreaterThanOrEqualTo: start)
        .where('createdAtMs', isLessThan: end)
        .get();

    return snap.size;
  }

  static Future<void> _openPaywall(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaywallScreen(onClose: () => Navigator.pop(context)),
      ),
    );
  }

  /// ✅ Asegura que el usuario puede crear una invoice AHORA.
  /// - Pro: true
  /// - Free: valida límite mensual (Firestore)
  /// Si no puede, muestra dialog + opción Upgrade y devuelve false.
  static Future<bool> ensureCanCreateInvoice(BuildContext context) async {
    final isPro = SubscriptionManager.instance.state.value.isPro;
    if (isPro) return true;

    final limit = await _getFreeLimitFromUserDoc();
    final count = await _countInvoicesThisMonth();

    if (count < limit) return true;

    if (!context.mounted) return false;

    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Límite alcanzado'),
        content: Text(
          'Plan Free: $count / $limit facturas este mes.\n\n'
              'Upgrade a Pro para ilimitado.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _openPaywall(context);
            },
            child: const Text('Upgrade'),
          ),
        ],
      ),
    );

    return false;
  }
}
