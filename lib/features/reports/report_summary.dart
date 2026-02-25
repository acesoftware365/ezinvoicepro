// lib/features/reports/report_summary.dart

/// ✅ USADO POR MonthlyReportsScreen
class ReportSummary {
  final int invoiceCount;

  final double subtotal;
  final double tax;
  final double tip;
  final double total;

  const ReportSummary({
    required this.invoiceCount,
    required this.subtotal,
    required this.tax,
    required this.tip,
    required this.total,
  });

  factory ReportSummary.zero() => const ReportSummary(
    invoiceCount: 0,
    subtotal: 0,
    tax: 0,
    tip: 0,
    total: 0,
  );
}

/// ✅ USADO POR ReportsExportService (PDF/CSV avanzado)
class ReportResult {
  final int invoicesCount;

  final double totalSales; // sum(total)
  final double totalTax; // sum(taxAmount)
  final double totalTip; // sum(tip)
  final double net; // sum(subtotal)

  final int unsentCount;
  final int sentCount;
  final int paidCount;
  final int overdueCount;

  const ReportResult({
    required this.invoicesCount,
    required this.totalSales,
    required this.totalTax,
    required this.totalTip,
    required this.net,
    required this.unsentCount,
    required this.sentCount,
    required this.paidCount,
    required this.overdueCount,
  });

  static const empty = ReportResult(
    invoicesCount: 0,
    totalSales: 0,
    totalTax: 0,
    totalTip: 0,
    net: 0,
    unsentCount: 0,
    sentCount: 0,
    paidCount: 0,
    overdueCount: 0,
  );
}
