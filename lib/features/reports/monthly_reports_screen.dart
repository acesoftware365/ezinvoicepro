import 'dart:io';

import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/invoice.dart';
import '../../models/business_profile.dart';
import '../../repositories/business_profile_repository.dart';

import 'report_summary.dart';
import 'reports_service.dart';
import 'date_ranges.dart';

class MonthlyReportsScreen extends StatefulWidget {
  final List<Invoice> invoices;

  const MonthlyReportsScreen({super.key, required this.invoices});

  @override
  State<MonthlyReportsScreen> createState() => _MonthlyReportsScreenState();
}

class _MonthlyReportsScreenState extends State<MonthlyReportsScreen> {
  late DateTime _selectedMonth;
  ReportSummary _summary = ReportSummary.zero();

  bool _loadingProfile = true;
  BusinessProfile _business = BusinessProfile.empty();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month, 1);
    _recalc();
    _loadBusinessProfile();
  }

  Future<void> _loadBusinessProfile() async {
    try {
      final p = await BusinessProfileRepository().load();
      if (!mounted) return;
      setState(() {
        _business = p;
        _loadingProfile = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loadingProfile = false);
    }
  }

  void _recalc() {
    final from = monthStart(_selectedMonth);
    final to = monthEndExclusive(_selectedMonth);

    _summary = ReportsService.summarize(
      invoices: widget.invoices,
      from: from,
      to: to,
    );

    setState(() {});
  }

  Future<void> _pickMonth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedMonth,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(now.year + 5, 12, 31),
    );
    if (picked == null) return;

    setState(() {
      _selectedMonth = DateTime(picked.year, picked.month, 1);
    });
    _recalc();
  }

  String _monthLabel(DateTime d, AppLocalizations t) {
    return DateFormat.yMMMM(t.localeName).format(d);
  }

  String _currencySymbol(String code) {
    switch (code) {
      case 'DOP':
        return 'RD\$';
      case 'EUR':
        return '€';
      case 'USD':
        return '\$';
      default:
        return '$code ';
    }
  }

  String _money(double n) {
    final sym = _currencySymbol(_business.currencyCode);
    return '$sym${n.toStringAsFixed(2)}';
  }

  Future<File> _exportMonthlyCsv() async {
    final from = monthStart(_selectedMonth);
    final to = monthEndExclusive(_selectedMonth);

    final filtered = widget.invoices.where((inv) {
      final d = DateTime.fromMillisecondsSinceEpoch(inv.createdAtMs);
      return !d.isBefore(from) && d.isBefore(to);
    }).toList();

    final rows = <List<String>>[
      [
        'invoiceNumber',
        'createdAt',
        'subtotal',
        'taxRate',
        'taxAmount',
        'tip',
        'total',
        'currency',
        'businessName',
      ],
    ];

    for (final inv in filtered) {
      final dt = DateTime.fromMillisecondsSinceEpoch(inv.createdAtMs);
      rows.add([
        inv.invoiceNumber,
        _fmtDate(dt),
        inv.subtotal.toStringAsFixed(2),
        inv.taxRate.toStringAsFixed(2),
        inv.taxAmount.toStringAsFixed(2),
        inv.tip.toStringAsFixed(2),
        inv.total.toStringAsFixed(2),
        _business.currencyCode,
        _business.businessName,
      ]);
    }

    final csv = _toCsv(rows);

    final dir = await getApplicationDocumentsDirectory();
    final folder = Directory('${dir.path}/ez_invoice/reports');
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    final fileName =
        'monthly_report_${_selectedMonth.year}_${_selectedMonth.month.toString().padLeft(2, '0')}.csv';
    final file = File('${folder.path}/$fileName');
    await file.writeAsString(csv, flush: true);

    return file;
  }

  String _fmtDate(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  String _toCsv(List<List<String>> rows) {
    final sb = StringBuffer();
    for (final row in rows) {
      sb.writeln(row.map(_csvEscape).join(','));
    }
    return sb.toString();
  }

  String _csvEscape(String value) {
    final v = value.replaceAll('"', '""');
    if (v.contains(',') || v.contains('\n') || v.contains('"')) {
      return '"$v"';
    }
    return v;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final label = _monthLabel(_selectedMonth, t);

    final businessTitle = _loadingProfile
        ? t.processing
        : (_business.businessName.trim().isEmpty
              ? t.businessProfileTitle
              : _business.businessName.trim());

    final currencyLine = _loadingProfile
        ? ''
        : '${t.currencyLabel}: ${_business.currencyCode}';
    final taxLine = _loadingProfile
        ? ''
        : '${t.taxDefaultLabel}: ${_business.defaultTaxRate.toStringAsFixed(2)}%';

    return Scaffold(
      appBar: AppBar(
        title: Text(t.reportForBusiness(businessTitle)),
        actions: [
          IconButton(
            tooltip: t.selectReportMonth,
            onPressed: _pickMonth,
            icon: const Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.store_outlined),
                title: Text(businessTitle),
                subtitle: Text(
                  [
                    currencyLine,
                    taxLine,
                  ].where((e) => e.isNotEmpty).join('  •  '),
                ),
              ),
            ),
            const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: const Icon(Icons.date_range_outlined),
                title: Text(label),
                subtitle: Text(t.tapToChangeMonth),
                trailing: const Icon(Icons.chevron_right),
                onTap: _pickMonth,
              ),
            ),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.monthSummaryTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _kv(t.invoicesLabel, _summary.invoiceCount.toString()),
                    _kv(t.subtotalTitle, _money(_summary.subtotal)),
                    _kv(t.taxTitle, _money(_summary.tax)),
                    _kv(t.tipTitle, _money(_summary.tip)),
                    const Divider(),
                    _kv(t.totalTitle, _money(_summary.total), bold: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.actions,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.download_outlined),
                        label: Text(t.exportCsv),
                        onPressed: () async {
                          try {
                            final file = await _exportMonthlyCsv();
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(t.csvSaved(file.path))),
                            );
                          } catch (e) {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(t.csvExportError(e))),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kv(String k, String v, {bool bold = false}) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(k, style: style),
          Text(v, style: style),
        ],
      ),
    );
  }
}
