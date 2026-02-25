// lib/services/pdf/invoice_pdf_service.dart

import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../models/business_profile.dart';
import '../../repositories/business_profile_repository.dart';
import '../style/app_theme_presets.dart';

// ✅ Pro vs Free (branding)
import '../purchases/feature_gate.dart';

/// =======================
/// PDF MODE
/// =======================
enum PdfDocType { invoice, receipt }

/// =======================================================
/// DTOs usados por el PDF (para evitar dependencia directa del modelo Invoice)
/// =======================================================

class InvoiceItemData {
  final String description;
  final double qty;
  final double unitPrice;

  /// Fecha del item (service date). Si viene null, el PDF usa la fecha de la invoice.
  final DateTime? itemDate;

  const InvoiceItemData({
    required this.description,
    required this.qty,
    required this.unitPrice,
    this.itemDate,
  });

  double get lineTotal => qty * unitPrice;
}

class InvoiceData {
  final String invoiceNumber;
  final DateTime createdAt;
  final DateTime? dueDate;

  // Cliente
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String customerAddress;

  // Items
  final List<InvoiceItemData> items;

  // Tax
  final double? taxRatePercent;

  // Tip
  final double tipAmount;
  final bool? tipIsPercent;
  final double? tipPercent;

  // Discount fijo ($)
  final double discount;

  final String note;

  // ✅ Receipt data
  final bool isPaid;
  final DateTime? paidAt;
  final String paymentMethod; // cash|zelle|card|check|other
  final String paymentNote;

  const InvoiceData({
    required this.invoiceNumber,
    required this.createdAt,
    this.dueDate,
    required this.customerName,
    this.customerPhone = '',
    this.customerEmail = '',
    this.customerAddress = '',
    required this.items,
    this.taxRatePercent,
    this.tipAmount = 0.0,
    this.tipIsPercent,
    this.tipPercent,
    this.discount = 0.0,
    this.note = '',
    this.isPaid = false,
    this.paidAt,
    this.paymentMethod = 'other',
    this.paymentNote = '',
  });
}

class InvoicePdfService {
  static Future<Uint8List> generatePdfBytes(
    InvoiceData invoice, {
    PdfDocType type = PdfDocType.invoice,
  }) async {
    final BusinessProfile business = await BusinessProfileRepository().load();
    final style = _styleForPalette(business.paletteId);
    final layoutId = AppThemePresets.normalizeLayout(business.invoiceLayoutId);
    final layoutLabel = AppThemePresets.layoutLabel(layoutId);
    final paletteLabel = AppThemePresets.paletteLabel(business.paletteId);

    final doc = pw.Document();
    final logoImage = await _loadLogoImage(business.logoFilePath);
    final currency = _currencySymbol(business.currencyCode);

    // Totales
    final subtotal = invoice.items.fold<double>(
      0.0,
      (s, it) => s + it.lineTotal,
    );

    final taxRate = invoice.taxRatePercent ?? business.defaultTaxRate; // 0-100
    final taxAmount = subtotal * (taxRate / 100.0);

    final tip = invoice.tipAmount.isNaN
        ? 0.0
        : (invoice.tipAmount < 0 ? 0.0 : invoice.tipAmount);
    final discount = invoice.discount.isNaN
        ? 0.0
        : (invoice.discount < 0 ? 0.0 : invoice.discount);

    final total = subtotal + taxAmount + tip - discount;

    // ✅ Branding: Free = true, Pro = false
    final showBranding = !FeatureGate.allowed(ProFeature.removePdfBranding);
    final showFreeWatermark = showBranding;

    final isReceipt = type == PdfDocType.receipt;

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.letter,
          margin: const pw.EdgeInsets.all(24),
          buildBackground: showFreeWatermark ? (_) => _freeWatermark() : null,
        ),
        build: (_) => [
          _buildHeader(
            business: business,
            logo: logoImage,
            invoice: invoice,
            isReceipt: isReceipt,
            style: style,
            layoutId: layoutId,
          ),
          if (isReceipt) ...[
            pw.SizedBox(height: 12),
            _buildPaidStamp(
              isPaid: invoice.isPaid,
              paidAt: invoice.paidAt,
              paymentMethod: invoice.paymentMethod,
              style: style,
              layoutId: layoutId,
            ),
          ],
          pw.SizedBox(height: 16),
          _buildBillTo(invoice, style: style, layoutId: layoutId),
          pw.SizedBox(height: 16),
          _buildItemsTable(
            invoice: invoice,
            currency: currency,
            style: style,
            layoutId: layoutId,
          ),
          pw.SizedBox(height: 16),
          _buildTotals(
            currency: currency,
            subtotal: subtotal,
            taxRate: taxRate,
            taxAmount: taxAmount,
            tip: tip,
            tipIsPercent: invoice.tipIsPercent,
            tipPercent: invoice.tipPercent,
            discount: discount,
            total: total,
            style: style,
            layoutId: layoutId,
          ),
          if (invoice.note.trim().isNotEmpty) ...[
            pw.SizedBox(height: 14),
            pw.Text(
              'Message:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 6),
            pw.Text(invoice.note.trim()),
          ],
          if (isReceipt &&
              invoice.isPaid &&
              invoice.paymentNote.trim().isNotEmpty) ...[
            pw.SizedBox(height: 14),
            pw.Text(
              'Payment Note:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 6),
            pw.Text(invoice.paymentNote.trim()),
          ],
          pw.SizedBox(height: 20),
          _buildFooter(
            business: business,
            showBranding: showBranding,
            style: style,
            docTypeLabel: isReceipt ? 'Receipt' : 'Invoice',
            layoutLabel: layoutLabel,
            paletteLabel: paletteLabel,
          ),
        ],
      ),
    );

    return doc.save();
  }

  static Future<File> generateAndSavePdf(
    InvoiceData invoice, {
    PdfDocType type = PdfDocType.invoice,
  }) async {
    final bytes = await generatePdfBytes(invoice, type: type);

    final dir = await getApplicationDocumentsDirectory();
    final folder = Directory('${dir.path}/ez_invoice');
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    final safeInv = invoice.invoiceNumber.replaceAll(
      RegExp(r'[^a-zA-Z0-9\-_]'),
      '_',
    );
    final prefix = (type == PdfDocType.receipt) ? 'receipt' : 'invoice';

    // ✅ aquí sale: receipt_INV-....pdf
    final file = File('${folder.path}/${prefix}_$safeInv.pdf');

    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  // =======================================================
  // PDF WIDGETS
  // =======================================================

  static pw.Widget _buildHeader({
    required BusinessProfile business,
    required pw.MemoryImage? logo,
    required InvoiceData invoice,
    required bool isReceipt,
    required _InvoicePdfStyle style,
    required String layoutId,
  }) {
    final title = isReceipt ? 'RECEIPT' : 'INVOICE';
    final company = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          business.businessName.trim().isEmpty
              ? 'Business'
              : business.businessName.trim(),
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        if (business.ownerName.trim().isNotEmpty)
          pw.Text(business.ownerName.trim()),
        if (business.phone.trim().isNotEmpty)
          pw.Text('Tel: ${business.phone.trim()}'),
        if (business.email.trim().isNotEmpty)
          pw.Text('Email: ${business.email.trim()}'),
        if (business.address.trim().isNotEmpty)
          pw.Text(business.address.trim()),
      ],
    );

    final invoiceMeta = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: style.primary,
          ),
        ),
        pw.SizedBox(height: 6),
        pw.Text('No: ${invoice.invoiceNumber}'),
        pw.Text('Date: ${_fmtDate(invoice.createdAt)}'),
        if (!isReceipt && invoice.dueDate != null)
          pw.Text('Due: ${_fmtDate(invoice.dueDate!)}'),
        if (isReceipt && invoice.isPaid && invoice.paidAt != null)
          pw.Text('Paid: ${_fmtDate(invoice.paidAt!)}'),
      ],
    );

    if (layoutId == AppThemePresets.layoutProfessional) {
      return pw.Column(
        children: [
          pw.Container(height: 4, color: style.primary),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  if (logo != null)
                    pw.Container(
                      width: 50,
                      height: 50,
                      child: pw.Image(logo, fit: pw.BoxFit.cover),
                    ),
                  if (logo != null) pw.SizedBox(width: 10),
                  company,
                ],
              ),
              invoiceMeta,
            ],
          ),
        ],
      );
    }

    if (layoutId == AppThemePresets.layoutCorporate) {
      return pw.Container(
        padding: const pw.EdgeInsets.all(12),
        decoration: pw.BoxDecoration(
          color: style.soft,
          border: pw.Border.all(color: style.primary, width: 1.2),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [company, invoiceMeta],
        ),
      );
    }

    if (layoutId == AppThemePresets.layoutModern) {
      return pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Container(
              padding: const pw.EdgeInsets.all(12),
              color: style.soft,
              child: company,
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(12),
              border: pw.Border.all(color: style.primary, width: 1.2),
            ),
            child: invoiceMeta,
          ),
        ],
      );
    }

    // minimal
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (logo != null)
              pw.Container(
                width: 54,
                height: 54,
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Image(logo, fit: pw.BoxFit.cover),
              ),
            if (logo != null) pw.SizedBox(width: 12),
            company,
          ],
        ),
        pw.Container(
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(width: 1, color: style.primary),
            borderRadius: pw.BorderRadius.circular(10),
            color: style.soft,
          ),
          child: invoiceMeta,
        ),
      ],
    );
  }

  static pw.Widget _buildPaidStamp({
    required bool isPaid,
    required DateTime? paidAt,
    required String paymentMethod,
    required _InvoicePdfStyle style,
    required String layoutId,
  }) {
    if (!isPaid) return pw.Container();

    String methodLabel(String m) {
      switch (m.toLowerCase().trim()) {
        case 'cash':
          return 'Cash';
        case 'zelle':
          return 'Zelle';
        case 'card':
          return 'Card';
        case 'check':
          return 'Check';
        default:
          return 'Other';
      }
    }

    final paidDate = paidAt != null ? _fmtDate(paidAt) : '';
    final borderColor = layoutId == AppThemePresets.layoutModern
        ? style.accent
        : style.primary;

    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(
          layoutId == AppThemePresets.layoutProfessional ? 6 : 12,
        ),
        border: pw.Border.all(
          color: borderColor,
          width: layoutId == AppThemePresets.layoutCorporate ? 1.5 : 1.2,
        ),
        color: style.soft,
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(10),
              border: pw.Border.all(color: borderColor, width: 2),
            ),
            child: pw.Text(
              'PAID',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
                color: borderColor,
                letterSpacing: 1.5,
              ),
            ),
          ),
          pw.SizedBox(width: 12),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                if (paidDate.isNotEmpty)
                  pw.Text(
                    'Paid Date: $paidDate',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Method: ${methodLabel(paymentMethod)}',
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildBillTo(
    InvoiceData invoice, {
    required _InvoicePdfStyle style,
    required String layoutId,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: layoutId == AppThemePresets.layoutCorporate
            ? style.soft
            : PdfColors.white,
        borderRadius: pw.BorderRadius.circular(
          layoutId == AppThemePresets.layoutProfessional ? 4 : 10,
        ),
        border: pw.Border.all(
          width: layoutId == AppThemePresets.layoutCorporate ? 1.3 : 1,
          color: style.border,
        ),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Bill To',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            invoice.customerName.trim().isEmpty
                ? 'Cliente'
                : invoice.customerName.trim(),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildItemsTable({
    required InvoiceData invoice,
    required String currency,
    required _InvoicePdfStyle style,
    required String layoutId,
  }) {
    final headers = <String>[
      '#',
      'Descripción',
      'Fecha',
      'Qty',
      'Precio',
      'Total',
    ];

    final data = <List<String>>[];
    for (int i = 0; i < invoice.items.length; i++) {
      final it = invoice.items[i];
      final effectiveDate = it.itemDate ?? invoice.createdAt;

      data.add([
        '${i + 1}',
        it.description,
        _fmtDate(effectiveDate),
        _fmtQty(it.qty),
        '$currency${_fmtMoney(it.unitPrice)}',
        '$currency${_fmtMoney(it.lineTotal)}',
      ]);
    }

    final headerColor = layoutId == AppThemePresets.layoutModern
        ? style.accent
        : style.primary;
    final borderWidth = layoutId == AppThemePresets.layoutProfessional
        ? 1.0
        : 0.6;

    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        color: layoutId == AppThemePresets.layoutCorporate
            ? style.soft
            : PdfColors.white,
        border: pw.Border.all(color: style.border, width: borderWidth),
        borderRadius: pw.BorderRadius.circular(
          layoutId == AppThemePresets.layoutProfessional ? 4 : 10,
        ),
      ),
      child: pw.TableHelper.fromTextArray(
        headers: headers,
        data: data,
        headerStyle: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 10,
          color: PdfColors.white,
        ),
        cellStyle: const pw.TextStyle(fontSize: 9),
        headerDecoration: pw.BoxDecoration(color: headerColor),
        cellAlignment: pw.Alignment.centerLeft,
        columnWidths: {
          0: const pw.FlexColumnWidth(0.4),
          1: const pw.FlexColumnWidth(2.6),
          2: const pw.FlexColumnWidth(1.1),
          3: const pw.FlexColumnWidth(0.7),
          4: const pw.FlexColumnWidth(1.0),
          5: const pw.FlexColumnWidth(1.0),
        },
        cellAlignments: {
          0: pw.Alignment.center,
          3: pw.Alignment.centerRight,
          4: pw.Alignment.centerRight,
          5: pw.Alignment.centerRight,
        },
        border: pw.TableBorder.all(color: style.border, width: borderWidth),
      ),
    );
  }

  static pw.Widget _buildTotals({
    required String currency,
    required double subtotal,
    required double taxRate,
    required double taxAmount,
    required double tip,
    required bool? tipIsPercent,
    required double? tipPercent,
    required double discount,
    required double total,
    required _InvoicePdfStyle style,
    required String layoutId,
  }) {
    pw.Row line(String label, String value, {bool bold = false}) {
      return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ],
      );
    }

    String tipLabel = 'Tip';
    if (tipIsPercent == true && (tipPercent ?? 0) > 0) {
      tipLabel = 'Tip (${(tipPercent!).toStringAsFixed(2)}%)';
    }

    return pw.Align(
      alignment: pw.Alignment.centerRight,
      child: pw.Container(
        width: 260,
        padding: const pw.EdgeInsets.all(12),
        decoration: pw.BoxDecoration(
          color: layoutId == AppThemePresets.layoutModern
              ? style.soft
              : PdfColors.white,
          borderRadius: pw.BorderRadius.circular(
            layoutId == AppThemePresets.layoutProfessional ? 4 : 10,
          ),
          border: pw.Border.all(
            width: layoutId == AppThemePresets.layoutCorporate ? 1.4 : 1,
            color: style.primary,
          ),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            line('Subtotal', '$currency${_fmtMoney(subtotal)}'),
            pw.SizedBox(height: 6),
            line(
              'Tax (${taxRate.toStringAsFixed(2)}%)',
              '$currency${_fmtMoney(taxAmount)}',
            ),
            pw.SizedBox(height: 6),
            line(tipLabel, '$currency${_fmtMoney(tip)}'),
            if (discount > 0) ...[
              pw.SizedBox(height: 6),
              line('Discount', '- $currency${_fmtMoney(discount)}'),
            ],
            pw.Divider(),
            line('Total', '$currency${_fmtMoney(total)}', bold: true),
          ],
        ),
      ),
    );
  }

  static pw.Widget _buildFooter({
    required BusinessProfile business,
    required bool showBranding,
    required _InvoicePdfStyle style,
    required String docTypeLabel,
    required String layoutLabel,
    required String paletteLabel,
  }) {
    final footerText = business.footerNote.trim().isEmpty
        ? 'Gracias por su preferencia.'
        : business.footerNote.trim();

    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(footerText, style: const pw.TextStyle(fontSize: 10)),
          pw.SizedBox(height: 6),
          pw.Text(
            '$docTypeLabel style: $layoutLabel | Palette: $paletteLabel',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
          ),
          if (showBranding) ...[
            pw.SizedBox(height: 8),
            pw.Text(
              'Powered by EzInvoice',
              style: pw.TextStyle(fontSize: 9, color: style.primary),
            ),
          ],
        ],
      ),
    );
  }

  // =======================================================
  // HELPERS
  // =======================================================

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

  static _InvoicePdfStyle _styleForPalette(String paletteId) {
    switch (AppThemePresets.normalizePalette(paletteId)) {
      case AppThemePresets.paletteProfessional:
        return const _InvoicePdfStyle(
          primary: PdfColor.fromInt(0xFF1E3A5F),
          soft: PdfColor.fromInt(0xFFEAF1F8),
          border: PdfColor.fromInt(0xFF99B2CB),
          accent: PdfColor.fromInt(0xFF2B5D92),
        );
      case AppThemePresets.paletteCorporate:
        return const _InvoicePdfStyle(
          primary: PdfColor.fromInt(0xFF0D4A3A),
          soft: PdfColor.fromInt(0xFFE8F4EF),
          border: PdfColor.fromInt(0xFF8CB3A4),
          accent: PdfColor.fromInt(0xFF1D7A5F),
        );
      case AppThemePresets.paletteModern:
        return const _InvoicePdfStyle(
          primary: PdfColor.fromInt(0xFF0F766E),
          soft: PdfColor.fromInt(0xFFE6F6F4),
          border: PdfColor.fromInt(0xFF8BCDC8),
          accent: PdfColor.fromInt(0xFFF59E0B),
        );
      case AppThemePresets.paletteSlate:
        return const _InvoicePdfStyle(
          primary: PdfColor.fromInt(0xFF334155),
          soft: PdfColor.fromInt(0xFFF3F4F6),
          border: PdfColor.fromInt(0xFF94A3B8),
          accent: PdfColor.fromInt(0xFF0F172A),
        );
      case AppThemePresets.paletteMinimal:
      default:
        return const _InvoicePdfStyle(
          primary: PdfColor.fromInt(0xFF4B5563),
          soft: PdfColor.fromInt(0xFFF9FAFB),
          border: PdfColor.fromInt(0xFFD1D5DB),
          accent: PdfColor.fromInt(0xFF1F2937),
        );
    }
  }

  static Future<pw.MemoryImage?> _loadLogoImage(String? path) async {
    try {
      if (path == null || path.isEmpty) return null;
      final f = File(path);
      if (!await f.exists()) return null;
      final bytes = await f.readAsBytes();
      return pw.MemoryImage(bytes);
    } catch (_) {
      return null;
    }
  }

  static String _currencySymbol(String code) {
    switch (code) {
      case 'DOP':
        return 'RD\$';
      case 'EUR':
        return '€';
      case 'USD':
      default:
        return '\$';
    }
  }

  static String _fmtDate(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  static String _fmtMoney(double n) => n.toStringAsFixed(2);

  static String _fmtQty(double n) {
    if (n % 1 == 0) return n.toInt().toString();
    return n.toStringAsFixed(2);
  }
}

class _InvoicePdfStyle {
  final PdfColor primary;
  final PdfColor soft;
  final PdfColor border;
  final PdfColor accent;

  const _InvoicePdfStyle({
    required this.primary,
    required this.soft,
    required this.border,
    required this.accent,
  });
}
