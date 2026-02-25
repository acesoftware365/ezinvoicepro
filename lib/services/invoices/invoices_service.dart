import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';

class InvoicesService {
  static CollectionReference<Map<String, dynamic>> _ref() {
    final u = FirebaseAuth.instance.currentUser!;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(u.uid)
        .collection('invoices');
  }

  static Stream<List<Invoice>> streamInvoices() {
    return _ref()
        .orderBy('createdAtMs', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Invoice.fromDoc(id: d.id, map: d.data())).toList());
  }

  static Future<void> add(Invoice inv) async {
    // si viene con id vacío => Firestore genera
    await _ref().add(inv.toMap());
  }

  static Future<void> update(String id, Invoice inv) async {
    await _ref().doc(id).set(inv.toMap(), SetOptions(merge: true));
  }

  static Future<void> delete(String id) async {
    await _ref().doc(id).delete();
  }

  /// ✅ USADO por InvoiceFormScreen para crear INV-xxxx
  static Future<String> generateInvoiceNumber() async {
    // Formato: INV-YYYYMMDD-#### (secuencia simple)
    final now = DateTime.now();
    final y = now.year.toString().padLeft(4, '0');
    final m = now.month.toString().padLeft(2, '0');
    final d = now.day.toString().padLeft(2, '0');
    final dateKey = '$y$m$d';

    // contamos cuántas invoices hay hoy (simple y robusto)
    final start = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    final end = DateTime(now.year, now.month, now.day + 1).millisecondsSinceEpoch;

    final q = await _ref()
        .where('createdAtMs', isGreaterThanOrEqualTo: start)
        .where('createdAtMs', isLessThan: end)
        .get();

    final seq = (q.docs.length + 1).toString().padLeft(4, '0');
    return 'INV-$dateKey-$seq';
  }

  /// ✅ USADO por InvoiceFormScreen para tax default
  static Future<double> getDefaultTaxRate() async {
    final bp = await BusinessProfileRepository().load();
    final v = bp.defaultTaxRate;
    if (v.isNaN) return 0.0;
    if (v < 0) return 0.0;
    if (v > 100) return 100.0;
    return v;
  }

  /// ✅ Sent / Unsent
  static Future<void> markAsSent({required String id}) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _ref().doc(id).set(
      {
        'status': InvoiceStatus.sent,
        'sentAtMs': now,
      },
      SetOptions(merge: true),
    );
  }

  static Future<void> markAsUnsent({required String id}) async {
    await _ref().doc(id).set(
      {
        // si no está paid, vuelve a unpaid
        'status': InvoiceStatus.unpaid,
        'sentAtMs': null,
      },
      SetOptions(merge: true),
    );
  }

  /// ✅ Paid / Unpaid
  static Future<void> markAsPaid({
    required String id,
    required String paymentMethod,
    required String paymentNote,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _ref().doc(id).set(
      {
        'status': InvoiceStatus.paid,
        'paidAtMs': now,
        'paymentMethod': paymentMethod,
        'paymentNote': paymentNote,
      },
      SetOptions(merge: true),
    );
  }

  static Future<void> markAsUnpaid({required String id}) async {
    await _ref().doc(id).set(
      {
        // si está sent, se queda sent; si no, vuelve unpaid
        'status': InvoiceStatus.unpaid,
        'paidAtMs': null,
        'paymentMethod': PaymentMethod.other,
        'paymentNote': '',
      },
      SetOptions(merge: true),
    );
  }

  /// ✅ opcional: actualizar due date (ya te lo pedía tu form)
  static Future<void> updateDueAtMs(String id, int? dueAtMs) async {
    await _ref().doc(id).set(
      {'dueAtMs': dueAtMs},
      SetOptions(merge: true),
    );
  }
}
