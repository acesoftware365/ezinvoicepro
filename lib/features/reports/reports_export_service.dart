// lib/features/reports/reports_export_service.dart

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:ezinvoice/features/reports/report_summary.dart';
import 'package:ezinvoice/features/reports/reports_service.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/models/business_profile.dart';
import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:ezinvoice/services/purchases/feature_gate.dart';
import 'package:ezinvoice/services/style/app_theme_presets.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
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
    Rect? sharePositionOrigin,
  }) async {
    final labels = _ReportLabels(context);
    final title = byMonth
        ? labels.fileMonthly(month ?? 1, year)
        : labels.fileYearly(year);

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
      context: context,
    );

    final file = await _writeFile(
      folderName: 'ez_invoice',
      fileName: '$title.pdf',
      bytes: bytes,
    );

    await _shareXFilesSafe(
      context: context,
      sharePositionOrigin: sharePositionOrigin,
      files: [XFile(file.path, mimeType: 'application/pdf')],
      text: labels.pdfShareText(title),
      subject: title,
    );
  }

  /// Builds the same bytes that the PDF export action shares, for the in-app
  /// preview. Keeping this in the export service prevents the preview and file
  /// from drifting apart visually.
  static Future<Uint8List> buildPdfPreviewBytes({
    required bool byMonth,
    required int year,
    int? month,
    BuildContext? context,
  }) async {
    final labels = _ReportLabels(context);
    final title = byMonth
        ? labels.fileMonthly(month ?? 1, year)
        : labels.fileYearly(year);
    final invoices = byMonth
        ? await ReportsService.loadMonthlyInvoices(
            year: year,
            month: month ?? DateTime.now().month,
          )
        : await ReportsService.loadYearlyInvoices(year: year);
    final report = ReportsService.computeReport(invoices);

    return _buildPdfBytes(
      title: title,
      report: report,
      invoices: invoices,
      byMonth: byMonth,
      year: year,
      month: month,
      isFree: !FeatureGate.allowed(ProFeature.removePdfBranding),
      context: context,
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
    Rect? sharePositionOrigin,
  }) async {
    final labels = _ReportLabels(context);
    final title = byMonth
        ? labels.fileMonthly(month ?? 1, year)
        : labels.fileYearly(year);

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
      labels: labels,
    );
    final file = await _writeFile(
      folderName: 'ez_invoice',
      fileName: '$title.csv',
      text: csv,
    );

    // ✅ para que salgan más apps, usemos text/plain
    await _shareXFilesSafe(
      context: context,
      sharePositionOrigin: sharePositionOrigin,
      files: [XFile(file.path, mimeType: 'text/plain', name: '$title.csv')],
      text: labels.csvShareText(title),
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
    Rect? sharePositionOrigin,
  }) async {
    final labels = _ReportLabels(context);
    final title = byMonth
        ? labels.textMonthly(month ?? 1, year)
        : labels.textYearly(year);

    final invoices = byMonth
        ? await ReportsService.loadMonthlyInvoices(
            year: year,
            month: month ?? DateTime.now().month,
          )
        : await ReportsService.loadYearlyInvoices(year: year);

    final r = ReportsService.computeReport(invoices);
    final isFree = !FeatureGate.allowed(ProFeature.removePdfBranding);

    final text = _buildSummaryText(
      title: title,
      r: r,
      isFree: isFree,
      labels: labels,
    );

    // Share.share no pide origin, pero igual lo dejamos simple.
    await Share.share(
      text,
      subject: title,
      sharePositionOrigin: _shareOriginFromContext(
        context,
        preferredOrigin: sharePositionOrigin,
      ),
    );
  }

  /// 3) "Print CSV" -> generate a PDF table and share (then user can Print)
  static Future<void> printCsv({
    required bool byMonth,
    required int year,
    int? month,

    /// ✅ FIX iOS Share
    BuildContext? context,
    Rect? sharePositionOrigin,
  }) async {
    final labels = _ReportLabels(context);
    final title = byMonth
        ? '${labels.fileMonthly(month ?? 1, year)}_PRINT'
        : '${labels.fileYearly(year)}_PRINT';

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
      context: context,
    );

    final file = await _writeFile(
      folderName: 'ez_invoice',
      fileName: '$title.pdf',
      bytes: bytes,
    );

    await _shareXFilesSafe(
      context: context,
      sharePositionOrigin: sharePositionOrigin,
      files: [XFile(file.path, mimeType: 'application/pdf')],
      text: labels.printShareText(title),
      subject: title,
    );
  }

  static Future<void> _shareXFilesSafe({
    required BuildContext? context,
    Rect? sharePositionOrigin,
    required List<XFile> files,
    String? text,
    String? subject,
  }) {
    final origin = _shareOriginFromContext(
      context,
      preferredOrigin: sharePositionOrigin,
    );

    // iPad requires a non-empty source rect. Do not retry without it.
    return Share.shareXFiles(
      files,
      text: text,
      subject: subject,
      sharePositionOrigin: origin,
    );
  }

  static Rect _shareOriginFromContext(
    BuildContext? context, {
    Rect? preferredOrigin,
  }) {
    if (_isUsableOrigin(preferredOrigin)) return preferredOrigin!;

    try {
      final renderObject = context?.findRenderObject();
      final box = renderObject is RenderBox ? renderObject : null;
      if (box != null && box.hasSize) {
        final rect = box.localToGlobal(Offset.zero) & box.size;
        if (_isUsableOrigin(rect)) return rect;
      }

      final viewSize = MediaQuery.maybeOf(context!)?.size;
      if (viewSize != null && viewSize.width > 2 && viewSize.height > 2) {
        return Rect.fromCenter(
          center: viewSize.center(Offset.zero),
          width: 1,
          height: 1,
        );
      }
    } catch (_) {
      // The final non-zero origin below is safe for the native share sheet.
    }
    return const Rect.fromLTWH(1, 1, 1, 1);
  }

  static bool _isUsableOrigin(Rect? rect) {
    return rect != null &&
        rect.left.isFinite &&
        rect.top.isFinite &&
        rect.width.isFinite &&
        rect.height.isFinite &&
        rect.width > 0 &&
        rect.height > 0;
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
    required BuildContext? context,
  }) async {
    final labels = _ReportLabels(context);
    final bp = await BusinessProfileRepository().load();
    final logo = await _loadReportLogo(bp);
    final isProTemplates = FeatureGate.allowed(ProFeature.premiumTemplates);
    final paletteId = isProTemplates
        ? AppThemePresets.normalizePalette(bp.reportPaletteId)
        : AppThemePresets.paletteMinimal;
    final reportLayout = isProTemplates
        ? AppThemePresets.normalizeLayout(bp.reportLayoutId)
        : AppThemePresets.layoutMinimal;
    final style = _styleForPalette(paletteId);
    final chart = _chartForPalette(paletteId);
    final layoutLabel = labels.layoutLabel(reportLayout);
    final paletteLabel = labels.paletteLabel(paletteId);
    final stylePaletteLine = _stylePaletteLine(
      context: context,
      docType: labels.document,
      style: layoutLabel,
      palette: paletteLabel,
    );

    final doc = pw.Document();
    final now = DateTime.now();
    final dateStr = labels.formatDate(now);

    // ✅ Cambiado "•" por "|" para evitar el cuadrito con X
    final headerTitle = byMonth
        ? labels.textMonthly(month ?? 1, year)
        : labels.textYearly(year);

    final sortedInvoices = invoices.toList()
      ..sort((a, b) => a.createdAtMs.compareTo(b.createdAtMs));

    final pieSvg = _pieSvg(
      sales: report.sales,
      tax: report.totalTax,
      tip: report.totalTip,
      size: 140,
      salesHex: chart.salesHex,
      taxHex: chart.taxHex,
      tipHex: chart.tipHex,
    );

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.letter,
          margin: const pw.EdgeInsets.fromLTRB(28, 28, 28, 28),
          buildBackground: isFree ? (_) => _freeWatermark(labels) : null,
        ),
        build: (context) => [
          _buildReportHeader(
            businessName: bp.businessName,
            logo: logo,
            headerTitle: headerTitle,
            dateStr: dateStr,
            style: style,
            layoutId: reportLayout,
            labels: labels,
          ),

          pw.SizedBox(height: 16),

          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 5,
                child: _card(
                  style: style,
                  layoutId: reportLayout,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        labels.breakdown,
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
                                  color: chart.sales,
                                  label: labels.sales,
                                  value: report.sales,
                                ),
                                _legendRow(
                                  color: chart.tax,
                                  label: labels.totalTax,
                                  value: report.totalTax,
                                ),
                                _legendRow(
                                  color: chart.tip,
                                  label: labels.totalTip,
                                  value: report.totalTip,
                                ),
                                pw.SizedBox(height: 8),
                                pw.Divider(color: style.border),
                                _legendRow(
                                  color: style.primary,
                                  label: labels.totalInvoiced,
                                  value: report.totalInvoiced,
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
                  style: style,
                  layoutId: reportLayout,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        labels.invoicesStatus,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      _kv(labels.invoices, report.invoicesCount.toString()),
                      _kv(labels.unsent, report.unsentCount.toString()),
                      _kv(labels.sent, report.sentCount.toString()),
                      _kv(labels.paid, report.paidCount.toString()),
                      _kv(labels.overdue, report.overdueCount.toString()),
                    ],
                  ),
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 14),

          _card(
            style: style,
            layoutId: reportLayout,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  labels.totals,
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Table(
                  border: pw.TableBorder.all(
                    color: style.border,
                    width: reportLayout == AppThemePresets.layoutProfessional
                        ? 1
                        : 0.7,
                  ),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(3),
                    1: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    _tableHeader(
                      [labels.description, labels.total],
                      style: style,
                      layoutId: reportLayout,
                    ),
                    _tableRow([
                      labels.sales,
                      _money(report.sales),
                    ], layoutId: reportLayout),
                    _tableRow([
                      labels.totalTax,
                      _money(report.totalTax),
                    ], layoutId: reportLayout),
                    _tableRow([
                      labels.totalTip,
                      _money(report.totalTip),
                    ], layoutId: reportLayout),
                    _tableRow(
                      [labels.totalInvoiced, _money(report.totalInvoiced)],
                      bold: true,
                      layoutId: reportLayout,
                    ),
                  ],
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 14),

          _card(
            style: style,
            layoutId: reportLayout,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  labels.invoices,
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Table(
                  border: pw.TableBorder.all(
                    color: style.border,
                    width: reportLayout == AppThemePresets.layoutProfessional
                        ? 1
                        : 0.7,
                  ),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(4),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(2),
                    3: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    _tableHeader(
                      [
                        labels.description,
                        labels.date,
                        labels.status,
                        labels.total,
                      ],
                      style: style,
                      layoutId: reportLayout,
                    ),
                    ...sortedInvoices.map((inv) {
                      // ✅ Cambiado "•" por "|"
                      final desc = inv.clientName.trim().isEmpty
                          ? inv.invoiceNumber
                          : '${inv.invoiceNumber} | ${inv.clientName}';
                      return _tableRow([
                        desc,
                        labels.formatDateMs(inv.createdAtMs),
                        labels.statusLabel(inv),
                        _money(inv.total),
                      ], layoutId: reportLayout);
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 14),
          pw.Text(
            stylePaletteLine,
            style: pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            labels.poweredBy,
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
    required BuildContext? context,
  }) async {
    final labels = _ReportLabels(context);
    final bp = await BusinessProfileRepository().load();
    final logo = await _loadReportLogo(bp);
    final isProTemplates = FeatureGate.allowed(ProFeature.premiumTemplates);
    final paletteId = isProTemplates
        ? AppThemePresets.normalizePalette(bp.reportPaletteId)
        : AppThemePresets.paletteMinimal;
    final reportLayout = isProTemplates
        ? AppThemePresets.normalizeLayout(bp.reportLayoutId)
        : AppThemePresets.layoutMinimal;
    final style = _styleForPalette(paletteId);
    final chart = _chartForPalette(paletteId);
    final layoutLabel = labels.layoutLabel(reportLayout);
    final paletteLabel = labels.paletteLabel(paletteId);
    final stylePaletteLine = _stylePaletteLine(
      context: context,
      docType: labels.document,
      style: layoutLabel,
      palette: paletteLabel,
    );
    final doc = pw.Document();

    // ✅ Cambiado "•" por "|" para evitar el cuadrito con X
    final headerTitle = byMonth
        ? labels.printMonthly(month ?? 1, year)
        : labels.printYearly(year);

    final sortedInvoices = invoices.toList()
      ..sort((a, b) => a.createdAtMs.compareTo(b.createdAtMs));

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.letter,
          margin: const pw.EdgeInsets.fromLTRB(28, 28, 28, 28),
          buildBackground: isFree ? (_) => _freeWatermark(labels) : null,
        ),
        build: (_) => [
          _buildReportHeader(
            businessName: bp.businessName,
            logo: logo,
            headerTitle: headerTitle,
            dateStr: labels.formatDate(DateTime.now()),
            style: style,
            layoutId: reportLayout,
            labels: labels,
          ),
          pw.SizedBox(height: 12),

          _card(
            style: style,
            layoutId: reportLayout,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  labels.totals,
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Table(
                  border: pw.TableBorder.all(
                    color: style.border,
                    width: reportLayout == AppThemePresets.layoutProfessional
                        ? 1
                        : 0.7,
                  ),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(3),
                    1: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    _tableHeader(
                      [labels.description, labels.total],
                      style: style,
                      layoutId: reportLayout,
                    ),
                    _tableRow([
                      labels.sales,
                      _money(report.sales),
                    ], layoutId: reportLayout),
                    _tableRow([
                      labels.totalTax,
                      _money(report.totalTax),
                    ], layoutId: reportLayout),
                    _tableRow([
                      labels.totalTip,
                      _money(report.totalTip),
                    ], layoutId: reportLayout),
                    _tableRow(
                      [labels.totalInvoiced, _money(report.totalInvoiced)],
                      bold: true,
                      layoutId: reportLayout,
                    ),
                  ],
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 14),

          _card(
            style: style,
            layoutId: reportLayout,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  labels.invoices,
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Table(
                  border: pw.TableBorder.all(
                    color: style.border,
                    width: reportLayout == AppThemePresets.layoutProfessional
                        ? 1
                        : 0.7,
                  ),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(4),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(2),
                    3: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    _tableHeader(
                      [
                        labels.description,
                        labels.date,
                        labels.status,
                        labels.total,
                      ],
                      style: style,
                      layoutId: reportLayout,
                    ),
                    ...sortedInvoices.map((inv) {
                      // ✅ Cambiado "•" por "|"
                      final desc = inv.clientName.trim().isEmpty
                          ? inv.invoiceNumber
                          : '${inv.invoiceNumber} | ${inv.clientName}';
                      return _tableRow([
                        desc,
                        labels.formatDateMs(inv.createdAtMs),
                        labels.statusLabel(inv),
                        _money(inv.total),
                      ], layoutId: reportLayout);
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            stylePaletteLine,
            style: pw.TextStyle(fontSize: 8, color: chart.sales),
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
    required _ReportLabels labels,
  }) {
    final b = StringBuffer();

    if (isFree) {
      b.writeln(labels.freeVersion);
      b.writeln('');
    }

    b.writeln('${labels.document},$title');
    b.writeln('${labels.invoices},${report.invoicesCount}');
    b.writeln('${labels.unsent},${report.unsentCount}');
    b.writeln('${labels.sent},${report.sentCount}');
    b.writeln('${labels.paid},${report.paidCount}');
    b.writeln('${labels.overdue},${report.overdueCount}');
    b.writeln('');

    b.writeln('${labels.sales},${report.sales.toStringAsFixed(2)}');
    b.writeln('${labels.totalTax},${report.totalTax.toStringAsFixed(2)}');
    b.writeln('${labels.totalTip},${report.totalTip.toStringAsFixed(2)}');
    b.writeln(
      '${labels.totalInvoiced},${report.totalInvoiced.toStringAsFixed(2)}',
    );
    b.writeln('');

    b.writeln(
      [
        labels.invoiceNumber,
        labels.client,
        labels.date,
        labels.status,
        labels.total,
        labels.tax,
        labels.tip,
        labels.subtotal,
        labels.dueDate,
      ].join(','),
    );

    for (final inv in invoices) {
      final due = inv.dueAtMs != null ? labels.formatDateMs(inv.dueAtMs!) : '';
      b.writeln(
        [
          _csv(inv.invoiceNumber),
          _csv(inv.clientName),
          _csv(labels.formatDateMs(inv.createdAtMs)),
          _csv(labels.statusLabel(inv)),
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
    required _ReportLabels labels,
  }) {
    final lines = <String>[
      if (isFree) labels.freeVersion,
      if (isFree) '',
      title,
      '',
      '${labels.invoices}: ${r.invoicesCount}',
      '${labels.unsent}: ${r.unsentCount}',
      '${labels.sent}: ${r.sentCount}',
      '${labels.paid}: ${r.paidCount}',
      '${labels.overdue}: ${r.overdueCount}',
      '',
      '${labels.sales}: ${_money(r.sales)}',
      '${labels.totalTax}: ${_money(r.totalTax)}',
      '${labels.totalTip}: ${_money(r.totalTip)}',
      '${labels.totalInvoiced}: ${_money(r.totalInvoiced)}',
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
    required String salesHex,
    required String taxHex,
    required String tipHex,
  }) {
    final total = max(0.0001, sales + tax + tip);

    final parts = <_SvgPart>[
      _SvgPart(value: sales, color: salesHex),
      _SvgPart(value: tax, color: taxHex),
      _SvgPart(value: tip, color: tipHex),
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

  static pw.Widget _card({
    required pw.Widget child,
    required _ReportPdfStyle style,
    required String layoutId,
  }) {
    final isProfessional = layoutId == AppThemePresets.layoutProfessional;
    final isCorporate = layoutId == AppThemePresets.layoutCorporate;
    final isModern = layoutId == AppThemePresets.layoutModern;
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: style.border,
          width: isCorporate ? 1.3 : 1,
        ),
        color: isModern || isCorporate ? style.soft : PdfColors.white,
        borderRadius: pw.BorderRadius.circular(isProfessional ? 4 : 10),
      ),
      child: child,
    );
  }

  static pw.Widget _freeWatermark(_ReportLabels labels) {
    return pw.Align(
      alignment: pw.Alignment.bottomCenter,
      child: pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 10),
        child: pw.Text(
          labels.freeVersion,
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

  static pw.TableRow _tableHeader(
    List<String> cells, {
    required _ReportPdfStyle style,
    required String layoutId,
  }) {
    final headerColor = layoutId == AppThemePresets.layoutModern
        ? style.accent
        : style.primary;
    return pw.TableRow(
      decoration: pw.BoxDecoration(color: headerColor),
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
                  color: PdfColors.white,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  static _ReportPdfStyle _styleForPalette(String paletteId) {
    switch (AppThemePresets.normalizePalette(paletteId)) {
      case AppThemePresets.paletteProfessional:
        return const _ReportPdfStyle(
          primary: PdfColor.fromInt(0xFF1E3A5F),
          soft: PdfColor.fromInt(0xFFEAF1F8),
          border: PdfColor.fromInt(0xFF99B2CB),
          accent: PdfColor.fromInt(0xFF2B5D92),
        );
      case AppThemePresets.paletteCorporate:
        return const _ReportPdfStyle(
          primary: PdfColor.fromInt(0xFF0D4A3A),
          soft: PdfColor.fromInt(0xFFE8F4EF),
          border: PdfColor.fromInt(0xFF8CB3A4),
          accent: PdfColor.fromInt(0xFF1D7A5F),
        );
      case AppThemePresets.paletteModern:
        return const _ReportPdfStyle(
          primary: PdfColor.fromInt(0xFF0F766E),
          soft: PdfColor.fromInt(0xFFE6F6F4),
          border: PdfColor.fromInt(0xFF8BCDC8),
          accent: PdfColor.fromInt(0xFFF59E0B),
        );
      case AppThemePresets.paletteSlate:
        return const _ReportPdfStyle(
          primary: PdfColor.fromInt(0xFF334155),
          soft: PdfColor.fromInt(0xFFF3F4F6),
          border: PdfColor.fromInt(0xFF94A3B8),
          accent: PdfColor.fromInt(0xFF0F172A),
        );
      case AppThemePresets.paletteMinimal:
      default:
        return const _ReportPdfStyle(
          primary: PdfColor.fromInt(0xFF4B5563),
          soft: PdfColor.fromInt(0xFFF9FAFB),
          border: PdfColor.fromInt(0xFFD1D5DB),
          accent: PdfColor.fromInt(0xFF1F2937),
        );
    }
  }

  static _ChartStyle _chartForPalette(String paletteId) {
    switch (AppThemePresets.normalizePalette(paletteId)) {
      case AppThemePresets.paletteProfessional:
        return const _ChartStyle(
          sales: PdfColor.fromInt(0xFF1E3A5F),
          tax: PdfColor.fromInt(0xFF2B5D92),
          tip: PdfColor.fromInt(0xFF6B8FB8),
          salesHex: '#1E3A5F',
          taxHex: '#2B5D92',
          tipHex: '#6B8FB8',
        );
      case AppThemePresets.paletteCorporate:
        return const _ChartStyle(
          sales: PdfColor.fromInt(0xFF0D4A3A),
          tax: PdfColor.fromInt(0xFF1D7A5F),
          tip: PdfColor.fromInt(0xFF4FA68A),
          salesHex: '#0D4A3A',
          taxHex: '#1D7A5F',
          tipHex: '#4FA68A',
        );
      case AppThemePresets.paletteModern:
        return const _ChartStyle(
          sales: PdfColor.fromInt(0xFF0F766E),
          tax: PdfColor.fromInt(0xFFF59E0B),
          tip: PdfColor.fromInt(0xFF14B8A6),
          salesHex: '#0F766E',
          taxHex: '#F59E0B',
          tipHex: '#14B8A6',
        );
      case AppThemePresets.paletteSlate:
        return const _ChartStyle(
          sales: PdfColor.fromInt(0xFF334155),
          tax: PdfColor.fromInt(0xFF0F172A),
          tip: PdfColor.fromInt(0xFF64748B),
          salesHex: '#334155',
          taxHex: '#0F172A',
          tipHex: '#64748B',
        );
      case AppThemePresets.paletteMinimal:
      default:
        return const _ChartStyle(
          sales: PdfColor.fromInt(0xFF4B5563),
          tax: PdfColor.fromInt(0xFF1F2937),
          tip: PdfColor.fromInt(0xFF6B7280),
          salesHex: '#4B5563',
          taxHex: '#1F2937',
          tipHex: '#6B7280',
        );
    }
  }

  static Future<pw.MemoryImage?> _loadReportLogo(
    BusinessProfile profile,
  ) async {
    Uint8List? bytes;
    try {
      final encoded = profile.logoDataBase64?.trim() ?? '';
      if (encoded.isNotEmpty) {
        bytes = base64Decode(encoded);
      } else {
        final path = profile.logoFilePath?.trim() ?? '';
        if (path.isNotEmpty) {
          final file = File(path);
          if (await file.exists()) bytes = await file.readAsBytes();
        }
      }
    } catch (_) {
      bytes = null;
    }

    if (bytes == null || bytes.isEmpty) return null;
    return pw.MemoryImage(bytes);
  }

  static pw.Widget _buildReportHeader({
    required String businessName,
    pw.ImageProvider? logo,
    required String headerTitle,
    required String dateStr,
    required _ReportPdfStyle style,
    required String layoutId,
    required _ReportLabels labels,
  }) {
    final name = businessName.trim().isEmpty
        ? labels.business
        : businessName.trim();
    final businessDetails = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          name,
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          labels.document,
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
    final left = logo == null
        ? businessDetails
        : pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                width: 44,
                height: 44,
                padding: const pw.EdgeInsets.all(4),
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  border: pw.Border.all(color: style.border, width: 0.8),
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: pw.Image(logo, fit: pw.BoxFit.contain),
              ),
              pw.SizedBox(width: 9),
              businessDetails,
            ],
          );
    final right = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          headerTitle,
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
            color: style.primary,
          ),
        ),
        pw.Text(
          '${labels.date}: $dateStr',
          style: const pw.TextStyle(fontSize: 9),
        ),
      ],
    );

    if (layoutId == AppThemePresets.layoutProfessional) {
      return pw.Column(
        children: [
          pw.Container(height: 4, color: style.primary),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [left, right],
          ),
        ],
      );
    }

    if (layoutId == AppThemePresets.layoutCorporate) {
      return pw.Container(
        padding: const pw.EdgeInsets.all(10),
        decoration: pw.BoxDecoration(
          color: style.soft,
          border: pw.Border.all(color: style.primary, width: 1.2),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [left, right],
        ),
      );
    }

    if (layoutId == AppThemePresets.layoutModern) {
      return pw.Row(
        children: [
          pw.Expanded(
            child: pw.Container(
              padding: const pw.EdgeInsets.all(10),
              color: style.soft,
              child: left,
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: style.primary, width: 1.2),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: right,
          ),
        ],
      );
    }

    // minimal
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        left,
        pw.Container(
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: style.border, width: 1),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: right,
        ),
      ],
    );
  }

  static pw.TableRow _tableRow(
    List<String> cells, {
    bool bold = false,
    required String layoutId,
  }) {
    final isProfessional = layoutId == AppThemePresets.layoutProfessional;
    return pw.TableRow(
      children: cells
          .map(
            (t) => pw.Padding(
              padding: pw.EdgeInsets.symmetric(
                horizontal: 8,
                vertical: isProfessional ? 5 : 6,
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

  static String _stylePaletteLine({
    required BuildContext? context,
    required String docType,
    required String style,
    required String palette,
  }) {
    if (context != null) {
      final t = AppLocalizations.of(context);
      return t.stylePaletteFootnote(docType, style, palette);
    }
    return '$docType style: $style | Palette: $palette';
  }
}

class _ReportLabels {
  _ReportLabels(BuildContext? context)
    : _t = context == null ? null : AppLocalizations.of(context);

  final AppLocalizations? _t;

  String get document => _t?.reportDocument ?? 'Report';
  String get printDocument => _t?.reportPrintDocument ?? 'Print report';
  String get breakdown => _t?.reportBreakdown ?? 'Breakdown';
  String get invoicesStatus => _t?.reportInvoicesStatus ?? 'Invoice status';
  String get invoices => _t?.reportInvoices ?? 'Invoices';
  String get status => _t?.reportStatus ?? 'Status';
  String get totals => _t?.reportTotals ?? 'Totals';
  String get sales => _t?.reportSales ?? 'Sales';
  String get totalTax => _t?.reportTotalTax ?? 'Total tax';
  String get totalTip => _t?.reportTotalTip ?? 'Total tip';
  String get totalInvoiced => _t?.reportTotalInvoiced ?? 'Total invoiced';
  String get unsent => _t?.reportUnsent ?? 'Unsent';
  String get sent => _t?.reportSent ?? 'Sent';
  String get paid => _t?.reportPaid ?? 'Paid';
  String get overdue => _t?.reportOverdue ?? 'Overdue';
  String get invoiceNumber => _t?.reportInvoiceNumber ?? 'Invoice no.';
  String get client => _t?.reportClient ?? 'Client';
  String get dueDate => _t?.reportDueDate ?? 'Due date';
  String get description => _t?.reportDescription ?? 'Description';
  String get date => _t?.reportDate ?? 'Date';
  String get total => _t?.pdfTotal ?? 'Total';
  String get tax => _t?.pdfTax ?? 'Tax';
  String get tip => _t?.pdfTip ?? 'Tip';
  String get subtotal => _t?.pdfSubtotal ?? 'Subtotal';
  String get freeVersion => _t?.reportFreeVersion ?? 'FREE VERSION';
  String get poweredBy => _t?.reportPoweredBy ?? 'Powered by EzInvoice';
  String get business => _t?.pdfBusiness ?? 'Business';

  String fileMonthly(int month, int year) =>
      _t?.reportFileMonthly(monthName(month), year) ??
      'Report_${monthName(month)}_$year';
  String fileYearly(int year) =>
      _t?.reportFileYearly(year) ?? 'Report_Year_$year';
  String textMonthly(int month, int year) =>
      _t?.reportTextMonthly(monthName(month), year) ??
      'Report | ${monthName(month)} $year';
  String textYearly(int year) => _t?.reportTextYearly(year) ?? 'Report | $year';
  String printMonthly(int month, int year) =>
      '$printDocument | ${monthName(month)} $year';
  String printYearly(int year) => '$printDocument | $year';
  String pdfShareText(String title) =>
      _t?.reportPdfShareText(title) ?? 'PDF report: $title';
  String csvShareText(String title) =>
      _t?.reportCsvShareText(title) ?? 'CSV report: $title';
  String printShareText(String title) =>
      _t?.reportPrintShareText(title) ?? 'Print: $title';

  String formatDate(DateTime date) =>
      DateFormat.yMMMd(_t?.localeName ?? 'en').format(date);
  String formatDateMs(int milliseconds) =>
      formatDate(DateTime.fromMillisecondsSinceEpoch(milliseconds));
  String monthName(int month) => DateFormat.MMM(
    _t?.localeName ?? 'en',
  ).format(DateTime(2026, month.clamp(1, 12)));

  String statusLabel(Invoice invoice) {
    if (invoice.isPaid) return paid;
    final due = invoice.dueAtMs;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    if (due != null && due < today) return overdue;
    return invoice.isSent ? sent : unsent;
  }

  String layoutLabel(String layoutId) {
    switch (AppThemePresets.normalizeLayout(layoutId)) {
      case AppThemePresets.layoutProfessional:
        return _t?.styleProfessional ?? 'Professional';
      case AppThemePresets.layoutCorporate:
        return _t?.styleCorporate ?? 'Corporate';
      case AppThemePresets.layoutModern:
        return _t?.styleModern ?? 'Modern';
      default:
        return _t?.styleMinimal ?? 'Minimal';
    }
  }

  String paletteLabel(String paletteId) {
    switch (AppThemePresets.normalizePalette(paletteId)) {
      case AppThemePresets.paletteProfessional:
        return _t?.styleProfessional ?? 'Professional';
      case AppThemePresets.paletteCorporate:
        return _t?.styleCorporate ?? 'Corporate';
      case AppThemePresets.paletteModern:
        return _t?.styleModern ?? 'Modern';
      case AppThemePresets.paletteSlate:
        return _t?.styleSlate ?? 'Slate';
      default:
        return _t?.styleMinimal ?? 'Minimal';
    }
  }
}

class _SvgPart {
  final double value;
  final String color;
  _SvgPart({required this.value, required this.color});
}

class _ReportPdfStyle {
  final PdfColor primary;
  final PdfColor soft;
  final PdfColor border;
  final PdfColor accent;

  const _ReportPdfStyle({
    required this.primary,
    required this.soft,
    required this.border,
    required this.accent,
  });
}

class _ChartStyle {
  final PdfColor sales;
  final PdfColor tax;
  final PdfColor tip;
  final String salesHex;
  final String taxHex;
  final String tipHex;

  const _ChartStyle({
    required this.sales,
    required this.tax,
    required this.tip,
    required this.salesHex,
    required this.taxHex,
    required this.tipHex,
  });
}
