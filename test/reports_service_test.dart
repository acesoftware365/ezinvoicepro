import 'package:ezinvoice/features/reports/reports_service.dart';
import 'package:ezinvoice/models/invoice.dart';
import 'package:flutter_test/flutter_test.dart';

Invoice reportInvoice({
  required String id,
  required double subtotal,
  required double tax,
  required double tip,
  required double total,
  String status = InvoiceStatus.unsent,
  int? dueAtMs,
}) {
  return Invoice(
    id: id,
    invoiceNumber: id,
    clientId: 'client',
    clientName: 'Client',
    clientEmail: '',
    clientPhoneE164: '',
    createdAtMs: DateTime(2026, 10, 5).millisecondsSinceEpoch,
    dueAtMs: dueAtMs,
    status: status,
    paymentMethod: PaymentMethod.cash,
    paymentNote: '',
    items: const [],
    subtotal: subtotal,
    taxRate: 0,
    taxAmount: tax,
    tip: tip,
    tipIsPercent: false,
    tipPercent: 0,
    total: total,
    message: '',
  );
}

void main() {
  test('reports keep sales, tip, tax, and total invoiced separate', () {
    final result = ReportsService.computeReport([
      reportInvoice(
        id: 'oct-001',
        subtotal: 150,
        tax: 12.54,
        tip: 30,
        total: 192.54,
      ),
    ]);

    expect(result.invoicesCount, 1);
    expect(result.sales, 150);
    expect(result.totalTip, 30);
    expect(result.totalTax, 12.54);
    expect(result.totalInvoiced, 192.54);
    expect(
      result.totalInvoiced,
      closeTo(result.sales + result.totalTip + result.totalTax, 0.001),
    );
  });

  test('reports classify invoice status independently of totals', () {
    final yesterday = DateTime.now()
        .subtract(const Duration(days: 1))
        .millisecondsSinceEpoch;
    final result = ReportsService.computeReport([
      reportInvoice(id: 'unsent', subtotal: 10, tax: 0, tip: 0, total: 10),
      reportInvoice(
        id: 'sent',
        subtotal: 20,
        tax: 0,
        tip: 0,
        total: 20,
        status: InvoiceStatus.sent,
      ),
      reportInvoice(
        id: 'paid',
        subtotal: 30,
        tax: 0,
        tip: 0,
        total: 30,
        status: InvoiceStatus.paid,
      ),
      reportInvoice(
        id: 'overdue',
        subtotal: 40,
        tax: 0,
        tip: 0,
        total: 40,
        dueAtMs: yesterday,
      ),
    ]);

    expect(result.unsentCount, 1);
    expect(result.sentCount, 1);
    expect(result.paidCount, 1);
    expect(result.overdueCount, 1);
  });
}
