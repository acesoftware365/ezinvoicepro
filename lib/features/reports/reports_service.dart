// lib/features/reports/reports_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/invoice.dart';
import 'date_ranges.dart';
import 'report_summary.dart';

class ReportsService {
  ReportsService._();

  // =========================
  // Auth / Path helpers
  // =========================

  static String _uidOrThrow() {
    final u = FirebaseAuth.instance.currentUser;
    if (u == null) throw Exception('User not logged in');
    return u.uid;
  }

  static CollectionReference<Map<String, dynamic>> _invoicesCol(String uid) {
    // ✅ Ajusta aquí si tu path es diferente
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('invoices');
  }

  // ✅ Tu Invoice.fromMap espera: (String id, Map<String,dynamic> data)
  static Invoice _toInvoice(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw Exception('Invoice document is empty: ${doc.id}');
    }
    return Invoice.fromMap(doc.id, data);
  }

  // =========================
  // ✅ STREAM: Monthly report
  // =========================

  static Stream<ReportResult> streamMonthlyReport({
    required int year,
    required int month,
  }) {
    final uid = _uidOrThrow();

    final m = DateTime(year, month, 1);
    final from = monthStart(m);
    final to = monthEndExclusive(m);

    final q = _invoicesCol(uid)
        .where('createdAtMs', isGreaterThanOrEqualTo: from.millisecondsSinceEpoch)
        .where('createdAtMs', isLessThan: to.millisecondsSinceEpoch);

    return q.snapshots().map((snap) {
      final invoices = snap.docs.map(_toInvoice).toList();
      return computeReport(invoices);
    });
  }

  // =========================
  // ✅ STREAM: Yearly report  (ESTE ES EL QUE TE FALTA)
  // =========================

  static Stream<ReportResult> streamYearlyReport({
    required int year,
  }) {
    final uid = _uidOrThrow();

    final from = DateTime(year, 1, 1);
    final to = DateTime(year + 1, 1, 1);

    final q = _invoicesCol(uid)
        .where('createdAtMs', isGreaterThanOrEqualTo: from.millisecondsSinceEpoch)
        .where('createdAtMs', isLessThan: to.millisecondsSinceEpoch);

    return q.snapshots().map((snap) {
      final invoices = snap.docs.map(_toInvoice).toList();
      return computeReport(invoices);
    });
  }

  // =========================
  // Load invoices (no stream)
  // =========================

  static Future<List<Invoice>> loadMonthlyInvoices({
    required int year,
    required int month,
  }) async {
    final uid = _uidOrThrow();

    final m = DateTime(year, month, 1);
    final from = monthStart(m);
    final to = monthEndExclusive(m);

    final snap = await _invoicesCol(uid)
        .where('createdAtMs', isGreaterThanOrEqualTo: from.millisecondsSinceEpoch)
        .where('createdAtMs', isLessThan: to.millisecondsSinceEpoch)
        .get();

    return snap.docs.map(_toInvoice).toList();
  }

  static Future<List<Invoice>> loadYearlyInvoices({
    required int year,
  }) async {
    final uid = _uidOrThrow();

    final from = DateTime(year, 1, 1);
    final to = DateTime(year + 1, 1, 1);

    final snap = await _invoicesCol(uid)
        .where('createdAtMs', isGreaterThanOrEqualTo: from.millisecondsSinceEpoch)
        .where('createdAtMs', isLessThan: to.millisecondsSinceEpoch)
        .get();

    return snap.docs.map(_toInvoice).toList();
  }

  // =========================
  // Used by MonthlyReportsScreen
  // =========================

  static ReportSummary summarize({
    required List<Invoice> invoices,
    required DateTime from,
    required DateTime to,
  }) {
    final filtered = invoices.where((inv) {
      final d = DateTime.fromMillisecondsSinceEpoch(inv.createdAtMs);
      return !d.isBefore(from) && d.isBefore(to);
    });

    int count = 0;
    double subtotal = 0;
    double tax = 0;
    double tip = 0;
    double total = 0;

    for (final inv in filtered) {
      count += 1;
      subtotal += inv.subtotal;
      tax += inv.taxAmount;
      tip += (inv.tip ?? 0.0);
      total += inv.total;
    }

    return ReportSummary(
      invoiceCount: count,
      subtotal: subtotal,
      tax: tax,
      tip: tip,
      total: total,
    );
  }

  // =========================
  // Used by ReportsExportService
  // =========================

  static ReportResult computeReport(List<Invoice> invoices) {
    final invoicesCount = invoices.length;

    double totalSales = 0;
    double totalTax = 0;
    double totalTip = 0;
    double net = 0;

    int unsentCount = 0;
    int sentCount = 0;
    int paidCount = 0;
    int overdueCount = 0;

    final now = DateTime.now();
    final today0 = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

    for (final inv in invoices) {
      totalSales += inv.total;
      totalTax += inv.taxAmount;
      totalTip += (inv.tip ?? 0.0);
      net += inv.subtotal;

      if (inv.isPaid) {
        paidCount += 1;
        continue;
      }

      final due = inv.dueAtMs;
      final isOverdue = due != null && due < today0;

      if (isOverdue) {
        overdueCount += 1;
      } else if (inv.isSent) {
        sentCount += 1;
      } else {
        unsentCount += 1;
      }
    }

    return ReportResult(
      invoicesCount: invoicesCount,
      totalSales: totalSales,
      totalTax: totalTax,
      totalTip: totalTip,
      net: net,
      unsentCount: unsentCount,
      sentCount: sentCount,
      paidCount: paidCount,
      overdueCount: overdueCount,
    );
  }
}
