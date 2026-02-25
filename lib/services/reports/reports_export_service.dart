// lib/services/reports/reports_export_service.dart

import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportsExportService {
  static Future<Directory> _folder() async {
    final dir = await getApplicationDocumentsDirectory();
    final folder = Directory('${dir.path}/ez_invoice/reports');
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    return folder;
  }

  static String _safe(String s) => s.replaceAll(RegExp(r'[^a-zA-Z0-9\-_]'), '_');

  static Future<File> exportCsv({
    required String fileName,
    required List<List<String>> rows,
  }) async {
    final folder = await _folder();
    final file = File('${folder.path}/${_safe(fileName)}.csv');

    final csv = rows.map((r) => r.map(_csvCell).join(',')).join('\n');
    await file.writeAsString(csv, flush: true);

    return file;
  }

  static String _csvCell(String v) {
    final s = v.replaceAll('"', '""');
    if (s.contains(',') || s.contains('\n') || s.contains('"')) {
      return '"$s"';
    }
    return s;
  }

  /// ✅ PDF simple (una tabla)
  static Future<File> exportPdf({
    required String fileName,
    required String title,
    required List<List<String>> table,
  }) async {
    final bytes = await _pdfBytesSingle(title: title, table: table);
    final folder = await _folder();
    final file = File('${folder.path}/${_safe(fileName)}.pdf');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  /// ✅ PDF detallado (múltiples tablas: Summary + Invoices)
  static Future<File> exportPdfMulti({
    required String fileName,
    required String title,
    required List<_PdfSection> sections,
  }) async {
    final bytes = await _pdfBytesMulti(title: title, sections: sections);
    final folder = await _folder();
    final file = File('${folder.path}/${_safe(fileName)}.pdf');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<Uint8List> _pdfBytesSingle({
    required String title,
    required List<List<String>> table,
  }) async {
    final doc = pw.Document();
    final headers = table.isNotEmpty ? table.first : <String>[];
    final data = table.length > 1 ? table.sublist(1) : <List<String>>[];

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(24),
        build: (_) => [
          pw.Text(title, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 12),
          pw.TableHelper.fromTextArray(
            headers: headers,
            data: data,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            cellStyle: const pw.TextStyle(fontSize: 9),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.6),
          ),
        ],
      ),
    );

    return doc.save();
  }

  static Future<Uint8List> _pdfBytesMulti({
    required String title,
    required List<_PdfSection> sections,
  }) async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(24),
        build: (_) {
          final widgets = <pw.Widget>[
            pw.Text(title, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 12),
          ];

          for (final s in sections) {
            widgets.add(
              pw.Text(
                s.heading,
                style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
            );
            widgets.add(pw.SizedBox(height: 8));

            final headers = s.table.isNotEmpty ? s.table.first : <String>[];
            final data = s.table.length > 1 ? s.table.sublist(1) : <List<String>>[];

            widgets.add(
              pw.TableHelper.fromTextArray(
                headers: headers,
                data: data,
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
                cellStyle: const pw.TextStyle(fontSize: 9),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.6),
              ),
            );

            widgets.add(pw.SizedBox(height: 14));
          }

          return widgets;
        },
      ),
    );

    return doc.save();
  }
}

class _PdfSection {
  final String heading;
  final List<List<String>> table;

  const _PdfSection({required this.heading, required this.table});
}
