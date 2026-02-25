// lib/features/reports/reports_export_service.dart

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:ezinvoice/features/reports/report_summary.dart';
import 'package:ezinvoice/features/reports/reports_service.dart';
import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:ezinvoice/services/purchases/feature_gate.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportsExportService {
  // =========================
  // Existing API (used by reports_screen)
  // =========================

  static Future<void> exportPdfAndShare({
    required bool byMonth,
    required int year,
    int? month,

    /// ✅ FIX iOS Share: pásalo desde el screen (context: context)
    BuildContext? context,
  }) async {
    final title = byMonth
        ? 'Report_${_monthName(month ?? 1)}_$year'
        : 'Report_Year_$year';

    final invoices = byMonth
        ? await ReportsService.loadMonthlyInvoices(
            year: year,
            month: month ?? DateTime.now().month,
          )
        : await ReportsService.loadYearlyInvoices(year: year);

    final report = ReportsService.computeReport(invoices);
    final isFree = !FeatureGate.allowed(ProFeature.removePdfBranding);

    final bytes = await _buildPdfBytes(
      title: title,
      report: report,
      invoices: invoices,
      byMonth: byMonth,
      year: year,
      month: month,
      isFree: isFree,
    );

    final file = await _writeFile(
      folderName: 'ez_invoice',
      fileName: '$title.pdf',
      bytes: bytes,
    );

    await _shareXFilesSafe(
      context: context,
      files: [XFile(file.path, mimeType: 'application/pdf')],
      text: 'PDF Report: $title',
      subject: title,
    );
  }

  // =========================
  // NEW CSV MENU ACTIONS
  // =========================

  /// 1) Share CSV as FILE attachment (Drive/Email/etc)
  static Future<void> shareCsvFile({
    required bool byMonth,
    required int year,
    int? month,

    /// ✅ FIX iOS Share
    BuildContext? context,
  }) async {
    final title = byMonth
        ? 'Report_${_monthName(month ?? 1)}_$year'
        : 'Report_Year_$year';

    final invoices = byMonth
        ? await ReportsService.loadMonthlyInvoices(
            year: year,
            month: month ?? DateTime.now().month,
          )
        : await ReportsService.loadYearlyInvoices(year: year);

    final report = ReportsService.computeReport(invoices);
    final isFree = !FeatureGate.allowed(ProFeature.removePdfBranding);

    final csv = _buildCsv(
      title: title,
      report: report,
      invoices: invoices,
      isFree: isFree,
    );
    final file = await _writeFile(
      folderName: 'ez_invoice',
      fileName: '$title.csv',
      text: csv,
    );

    // ✅ para que salgan más apps, usemos text/plain
    await _shareXFilesSafe(
      context: context,
      files: [XFile(file.path, mimeType: 'text/plain', name: '$title.csv')],
      text: 'CSV Report: $title',
      subject: title,
    );
  }

  /// 2) Share as TEXT (WhatsApp/SMS friendly)
  static Future<void> shareCsvAsText({
    required bool byMonth,
    required int year,
    int? month,

    /// ✅ FIX iOS Share (para Share.share también es buena práctica)
    BuildContext? context,
  }) async {
    // ✅ Cambiado "•" por "|"
    final title = byMonth
        ? 'Report | ${_monthName(month ?? 1)} $year'
        : 'Report | $year';

    final invoices = byMonth
        ? await ReportsService.loadMonthlyInvoices(
            year: year,
            month: month ?? DateTime.now().month,
          )
        : await ReportsService.loadYearlyInvoices(year: year);

    final r = ReportsService.computeReport(invoices);
    final isFree = !FeatureGate.allowed(ProFeature.removePdfBranding);

    final text = _buildSummaryText(title: title, r: r, isFree: isFree);

    // Share.share no pide origin, pero igual lo dejamos simple.
    await Share.share(text, subject: title);
  }

  /// 3) "Print CSV" -> generate a PDF table and share (then user can Print)
  static Future<void> printCsv({
    required bool byMonth,
    required int year,
    int? month,

    /// ✅ FIX iOS Share
    BuildContext? context,
  }) async {
    final title = byMonth
        ? 'Report_${_monthName(month ?? 1)}_${year}_PRINT'
        : 'Report_Year_${year}_PRINT';

    final invoices = byMonth
        ? await ReportsService.loadMonthlyInvoices(
            year: year,
            month: month ?? DateTime.now().month,
          )
        : await ReportsService.loadYearlyInvoices(year: year);

    final report = ReportsService.computeReport(invoices);
    final isFree = !FeatureGate.allowed(ProFeature.removePdfBranding);

    final bytes = await _buildPrintPdfBytes(
      title: title,
      report: report,
      invoices: invoices,
      byMonth: byMonth,
      year: year,
      month: month,
      isFree: isFree,
    );

    final file = await _writeFile(
      folderName: 'ez_invoice',
      fileName: '$title.pdf',
      bytes: bytes,
    );

    await _shareXFilesSafe(
      context: context,
      files: [XFile(file.path, mimeType: 'application/pdf')],
      text: 'Print: $title',
      subject: title,
    );
  }

  // =========================
  // ✅ SHARE HELPERS (FIX iOS)
  // =========================

  static Future<void> _shareXFilesSafe({
    required BuildContext? context,
    required List<XFile> files,
    String? text,
    String? subject,
  }) async {
    try {
      final origin = _shareOriginFromContext(context);

      await Share.shareXFiles(
        files,
        text: text,
        subject: subject,
        // ✅ FIX: requerido para evitar crash/error en iPad y algunos casos iPhone
        sharePositionOrigin: origin,
      );
    } catch (e) {
      // Fallback sin origin (por si context es null / renderBox null / etc.)
      debugPrint('❌ shareXFiles error: $e');
      await Share.shareXFiles(files, text: text, subject: subject);
    }
  }

  static Rect _shareOriginFromContext(BuildContext? context) {
    try {
      if (context == null) {
        return const Rect.fromLTWH(0, 0, 1, 1);
      }
      final renderObject = context.findRenderObject();
      final box = renderObject is RenderBox ? renderObject : null;
      if (box == null || !box.hasSize) {
        return const Rect.fromLTWH(0, 0, 1, 1);
      }
      final offset = box.localToGlobal(Offset.zero);
      final rect = offset & box.size;

      // Asegura que no sea 0,0,0,0
      if (rect.width <= 0 || rect.height <= 0) {
        return const Rect.fromLTWH(0, 0, 1, 1);
      }
      return rect;
    } catch (_) {
      return const Rect.fromLTWH(0, 0, 1, 1);
    }
  }

  // =========================
  // PDF GENERATORS
  // =========================

  static Future<Uint8List> _buildPdfBytes({
    required String title,
    required ReportResult report,
    required List<Invoice> invoices,
    required bool byMonth,
    required int year,
    int? month,
    required bool isFree,
  }) async {
    final bp = await BusinessProfileRepository().load();

    final doc = pw.Document();
    final now = DateTime.now();
    final dateStr = _fmtDate(now);

    // ✅ Cambiado "•" por "|" para evitar el cuadrito con X
    final headerTitle = byMonth
        ? 'Report | ${_monthName(month ?? 1)} $year'
        : 'Report | $year';

    final sortedInvoices = invoices.toList()
      ..sort((a, b) => a.createdAtMs.compareTo(b.createdAtMs));

    final pieSvg = _pieSvg(
      sales: report.totalSales,
      tax: report.totalTax,
      tip: report.totalTip,
      size: 140,
    );

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.letter,
          margin: const pw.EdgeInsets.fromLTRB(28, 28, 28, 28),
          buildBackground: isFree ? (_) => _freeWatermark() : null,
        ),
        build: (context) => [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    (bp.businessName.trim().isEmpty
                        ? 'Business'
                        : bp.businessName.trim()),
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Reports',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey600, width: 1),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      headerTitle,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Date: $dateStr',
                      style: const pw.TextStyle(fontSize: 9),
                    ),
                  ],
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 16),

          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 5,
                child: _card(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Breakdown',
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 140,
                            height: 140,
                            child: pw.SvgImage(svg: pieSvg),
                          ),
                          pw.SizedBox(width: 14),
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                _legendRow(
                                  color: PdfColors.blueGrey700,
                                  label: 'Total Sales',
                                  value: report.totalSales,
                                ),
                                _legendRow(
                                  color: PdfColors.orange700,
                                  label: 'Total Tax',
                                  value: report.totalTax,
                                ),
                                _legendRow(
                                  color: PdfColors.green700,
                                  label: 'Total Tip',
                                  value: report.totalTip,
                                ),
                                pw.SizedBox(height: 8),
                                pw.Divider(color: PdfColors.grey300),
                                _legendRow(
                                  color: PdfColors.black,
                                  label: 'Net',
                                  value: report.net,
                                  bold: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(width: 12),
              pw.Expanded(
                flex: 4,
                child: _card(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Invoices status',
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      _kv('Invoices', report.invoicesCount.toString()),
                      _kv('Unsent', report.unsentCount.toString()),
                      _kv('Sent', report.sentCount.toString()),
                      _kv('Paid', report.paidCount.toString()),
                      _kv('Overdue', report.overdueCount.toString()),
                    ],
                  ),
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 14),

          _card(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Totals',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Table(
                  border: pw.TableBorder.all(
                    color: PdfColors.grey300,
                    width: 0.7,
                  ),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(3),
                    1: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    _tableHeader(['Description', 'Total']),
                    _tableRow(['Total Sales', _money(report.totalSales)]),
                    _tableRow(['Total Tax', _money(report.totalTax)]),
                    _tableRow(['Total Tip', _money(report.totalTip)]),
                    _tableRow(['Net', _money(report.net)], bold: true),
                  ],
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 14),

          _card(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Invoices',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Table(
                  border: pw.TableBorder.all(
                    color: PdfColors.grey300,
                    width: 0.7,
                  ),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(4),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(2),
                    3: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    _tableHeader(['Description', 'Date', 'Status', 'Total']),
                    ...sortedInvoices.map((inv) {
                      // ✅ Cambiado "•" por "|"
                      final desc = inv.clientName.trim().isEmpty
                          ? inv.invoiceNumber
                          : '${inv.invoiceNumber} | ${inv.clientName}';
                      return _tableRow([
                        desc,
                        _fmtDateMs(inv.createdAtMs),
                        _statusLabel(inv),
                        _money(inv.total),
                      ]);
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 14),
          pw.Text(
            'Calculated from your invoices in Firestore.',
            style: pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'Powered by EzInvoice',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
          ),
        ],
      ),
    );

    return doc.save();
  }

  static Future<Uint8List> _buildPrintPdfBytes({
    required String title,
    required ReportResult report,
    required List<Invoice> invoices,
    required bool byMonth,
    required int year,
    int? month,
    required bool isFree,
  }) async {
    final doc = pw.Document();

    // ✅ Cambiado "•" por "|" para evitar el cuadrito con X
    final headerTitle = byMonth
        ? 'Print Report | ${_monthName(month ?? 1)} $year'
        : 'Print Report | $year';

    final sortedInvoices = invoices.toList()
      ..sort((a, b) => a.createdAtMs.compareTo(b.createdAtMs));

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.letter,
          margin: const pw.EdgeInsets.fromLTRB(28, 28, 28, 28),
          buildBackground: isFree ? (_) => _freeWatermark() : null,
        ),
        build: (_) => [
          pw.Text(
            headerTitle,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 12),

          _card(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Totals',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Table(
                  border: pw.TableBorder.all(
                    color: PdfColors.grey300,
                    width: 0.7,
                  ),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(3),
                    1: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    _tableHeader(['Description', 'Total']),
                    _tableRow(['Total Sales', _money(report.totalSales)]),
                    _tableRow(['Total Tax', _money(report.totalTax)]),
                    _tableRow(['Total Tip', _money(report.totalTip)]),
                    _tableRow(['Net', _money(report.net)], bold: true),
                  ],
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 14),

          _card(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Invoices',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Table(
                  border: pw.TableBorder.all(
                    color: PdfColors.grey300,
                    width: 0.7,
                  ),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(4),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(2),
                    3: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    _tableHeader(['Description', 'Date', 'Status', 'Total']),
                    ...sortedInvoices.map((inv) {
                      // ✅ Cambiado "•" por "|"
                      final desc = inv.clientName.trim().isEmpty
                          ? inv.invoiceNumber
                          : '${inv.invoiceNumber} | ${inv.clientName}';
                      return _tableRow([
                        desc,
                        _fmtDateMs(inv.createdAtMs),
                        _statusLabel(inv),
                        _money(inv.total),
                      ]);
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return doc.save();
  }

  // =========================
  // CSV BUILDERS
  // =========================

  static String _buildCsv({
    required String title,
    required ReportResult report,
    required List<Invoice> invoices,
    required bool isFree,
  }) {
    final b = StringBuffer();

    if (isFree) {
      b.writeln('FREE VERSION');
      b.writeln('');
    }

    b.writeln('Report,$title');
    b.writeln('Invoices,${report.invoicesCount}');
    b.writeln('Unsent,${report.unsentCount}');
    b.writeln('Sent,${report.sentCount}');
    b.writeln('Paid,${report.paidCount}');
    b.writeln('Overdue,${report.overdueCount}');
    b.writeln('');

    b.writeln('Total Sales,${report.totalSales.toStringAsFixed(2)}');
    b.writeln('Total Tax,${report.totalTax.toStringAsFixed(2)}');
    b.writeln('Total Tip,${report.totalTip.toStringAsFixed(2)}');
    b.writeln('Net,${report.net.toStringAsFixed(2)}');
    b.writeln('');

    b.writeln('Invoice No,Client,Date,Status,Total,Tax,Tip,Subtotal,Due Date');

    for (final inv in invoices) {
      final due = inv.dueAtMs != null ? _fmtDateMs(inv.dueAtMs!) : '';
      b.writeln(
        [
          _csv(inv.invoiceNumber),
          _csv(inv.clientName),
          _csv(_fmtDateMs(inv.createdAtMs)),
          _csv(_statusLabel(inv)),
          inv.total.toStringAsFixed(2),
          inv.taxAmount.toStringAsFixed(2),
          inv.tip.toStringAsFixed(2),
          inv.subtotal.toStringAsFixed(2),
          _csv(due),
        ].join(','),
      );
    }

    return b.toString();
  }

  static String _buildSummaryText({
    required String title,
    required ReportResult r,
    required bool isFree,
  }) {
    final lines = <String>[
      if (isFree) 'FREE VERSION',
      if (isFree) '',
      title,
      '',
      'Invoices: ${r.invoicesCount}',
      'Unsent: ${r.unsentCount}',
      'Sent: ${r.sentCount}',
      'Paid: ${r.paidCount}',
      'Overdue: ${r.overdueCount}',
      '',
      'Total Sales: ${_money(r.totalSales)}',
      'Total Tax: ${_money(r.totalTax)}',
      'Total Tip: ${_money(r.totalTip)}',
      'Net: ${_money(r.net)}',
    ];
    return lines.join('\n');
  }

  static String _csv(String v) {
    final x = v.replaceAll('"', '""');
    if (x.contains(',') || x.contains('\n')) return '"$x"';
    return x;
  }

  // =========================
  // FILE HELPERS
  // =========================

  static Future<File> _writeFile({
    required String folderName,
    required String fileName,
    Uint8List? bytes,
    String? text,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final folder = Directory('${dir.path}/$folderName');
    if (!await folder.exists()) await folder.create(recursive: true);

    final realFile = File('${folder.path}/$fileName');

    if (bytes != null) {
      await realFile.writeAsBytes(bytes, flush: true);
      return realFile;
    }

    await realFile.writeAsString(text ?? '', flush: true);
    return realFile;
  }

  // =========================
  // PIE SVG (no CustomPainter)
  // =========================

  static String _pieSvg({
    required double sales,
    required double tax,
    required double tip,
    required double size,
  }) {
    final total = max(0.0001, sales + tax + tip);

    final parts = <_SvgPart>[
      _SvgPart(value: sales, color: '#455A64'),
      _SvgPart(value: tax, color: '#EF6C00'),
      _SvgPart(value: tip, color: '#2E7D32'),
    ];

    final cx = size / 2;
    final cy = size / 2;
    final r = size / 2;

    double startAngle = -pi / 2;

    final paths = <String>[];
    for (final p in parts) {
      final sweep = (p.value <= 0) ? 0.0 : (p.value / total) * (2 * pi);
      if (sweep <= 0) continue;

      final endAngle = startAngle + sweep;

      final x1 = cx + r * cos(startAngle);
      final y1 = cy + r * sin(startAngle);
      final x2 = cx + r * cos(endAngle);
      final y2 = cy + r * sin(endAngle);

      final largeArc = sweep > pi ? 1 : 0;

      final d = [
        'M $cx $cy',
        'L $x1 $y1',
        'A $r $r 0 $largeArc 1 $x2 $y2',
        'Z',
      ].join(' ');

      paths.add('<path d="$d" fill="${p.color}"/>');

      startAngle = endAngle;
    }

    final border =
        '<circle cx="$cx" cy="$cy" r="$r" fill="none" stroke="#757575" stroke-width="1"/>';

    return '''
<svg xmlns="http://www.w3.org/2000/svg" width="$size" height="$size" viewBox="0 0 $size $size">
  ${paths.join('\n  ')}
  $border
</svg>
''';
  }

  // =========================
  // PDF UI HELPERS
  // =========================

  static pw.Widget _card({required pw.Widget child}) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300, width: 1),
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  static pw.Widget _freeWatermark() {
    return pw.Align(
      alignment: pw.Alignment.bottomCenter,
      child: pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 10),
        child: pw.Text(
          'FREE VERSION',
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: 28,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey600,
            letterSpacing: 6,
          ),
        ),
      ),
    );
  }

  static pw.TableRow _tableHeader(List<String> cells) {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey300),
      children: cells
          .map(
            (t) => pw.Padding(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              child: pw.Text(
                t,
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  static pw.TableRow _tableRow(List<String> cells, {bool bold = false}) {
    return pw.TableRow(
      children: cells
          .map(
            (t) => pw.Padding(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              child: pw.Text(
                t,
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  static pw.Widget _kv(String k, String v) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Text(
              k,
              style: pw.TextStyle(fontSize: 9, color: PdfColors.grey800),
            ),
          ),
          pw.Text(
            v,
            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );
  }

  static pw.Widget _legendRow({
    required PdfColor color,
    required String label,
    required double value,
    bool bold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.Container(
            width: 10,
            height: 10,
            decoration: pw.BoxDecoration(color: color),
          ),
          pw.SizedBox(width: 8),
          pw.Expanded(
            child: pw.Text(
              label,
              style: pw.TextStyle(
                fontSize: 9,
                fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
              ),
            ),
          ),
          pw.Text(
            _money(value),
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // FORMAT HELPERS
  // =========================

  static String _money(double v) => '\$${v.toStringAsFixed(2)}';

  static String _fmtDate(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
  }

  static String _fmtDateMs(int ms) =>
      _fmtDate(DateTime.fromMillisecondsSinceEpoch(ms));

  static String _monthName(int m) {
    const names = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final mm = max(1, min(12, m));
    return names[mm - 1];
  }

  static String _statusLabel(Invoice inv) {
    if (inv.isPaid) return 'Paid';

    final due = inv.dueAtMs;
    final now = DateTime.now();
    final today0 = DateTime(
      now.year,
      now.month,
      now.day,
    ).millisecondsSinceEpoch;

    final isOverdue = due != null && due < today0;
    if (isOverdue) return 'Overdue';

    if (inv.isSent) return 'Sent';
    return 'Unsent';
  }
}

class _SvgPart {
  final double value;
  final String color;
  _SvgPart({required this.value, required this.color});
}
