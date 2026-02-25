// lib/features/reports/reports_screen.dart

import 'package:flutter/material.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/models/business_profile.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:ezinvoice/services/purchases/subscription_manager.dart';
import 'package:ezinvoice/services/style/app_theme_presets.dart';

import 'package:ezinvoice/features/reports/report_summary.dart';
import 'package:ezinvoice/features/reports/reports_service.dart';
import 'package:ezinvoice/features/reports/reports_export_service.dart';

import '../paywall/paywall_screen.dart';
import '../paywall/paywall_guard.dart';

// ✅ Paywall guard

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  static const brandGreen = Color(0xFF1F6E5C);
  static const pageBg = Color(0xFFF6F7F9);

  int _tab = 0; // 0=month, 1=year
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;

  bool _exporting = false;

  List<int> get _years {
    final now = DateTime.now().year;
    return List.generate(9, (i) => now - 6 + i);
  }

  String _monthName(int m) {
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
    return names[m - 1];
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<bool> _ensureProOrPaywall() async {
    final ok = await PaywallGuard.requirePro(context);
    return ok;
  }

  Future<void> _exportPdf() async {
    if (_exporting) return;

    // ✅ FREE => Paywall, PRO => continue
    final ok = await _ensureProOrPaywall();
    if (!ok) return;

    setState(() => _exporting = true);
    try {
      await ReportsExportService.exportPdfAndShare(
        context: context, // ✅ FIX iOS sharePositionOrigin
        byMonth: _tab == 0,
        year: _year,
        month: _tab == 0 ? _month : null,
      );
    } catch (e) {
      _snack('Export PDF error: $e');
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<void> _exportCsvMenu() async {
    if (_exporting) return;

    // ✅ FREE => Paywall, PRO => continue
    final ok = await _ensureProOrPaywall();
    if (!ok) return;

    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 6, 14, 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 6),
                ListTile(
                  leading: const Icon(Icons.insert_drive_file_outlined),
                  title: const Text('Share CSV file'),
                  subtitle: const Text(
                    'Share the .csv attachment (email/drive/etc)',
                  ),
                  onTap: () async {
                    Navigator.pop(ctx);
                    await _runExport(
                      () => ReportsExportService.shareCsvFile(
                        context: context, // ✅ FIX iOS sharePositionOrigin
                        byMonth: _tab == 0,
                        year: _year,
                        month: _tab == 0 ? _month : null,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.message_outlined),
                  title: const Text('Share as text (WhatsApp / SMS)'),
                  subtitle: const Text('Sends a report summary as text'),
                  onTap: () async {
                    Navigator.pop(ctx);
                    await _runExport(
                      () => ReportsExportService.shareCsvAsText(
                        // Share.share (texto) no necesita origin
                        byMonth: _tab == 0,
                        year: _year,
                        month: _tab == 0 ? _month : null,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.print_outlined),
                  title: const Text('Print CSV'),
                  subtitle: const Text('Print as a table (PDF print)'),
                  onTap: () async {
                    Navigator.pop(ctx);
                    await _runExport(
                      () => ReportsExportService.printCsv(
                        context: context, // ✅ FIX iOS sharePositionOrigin
                        byMonth: _tab == 0,
                        year: _year,
                        month: _tab == 0 ? _month : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _runExport(Future<void> Function() action) async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      await action();
    } catch (e) {
      _snack('Export error: $e');
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final Stream<ReportResult> reportStream = _tab == 0
        ? ReportsService.streamMonthlyReport(year: _year, month: _month)
        : ReportsService.streamYearlyReport(year: _year);

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: brandGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          t.reports,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
          children: [
            const _ReportDesignBar(),
            const SizedBox(height: 12),
            _segmented(t),
            const SizedBox(height: 12),
            _filtersCard(t),
            const SizedBox(height: 12),

            StreamBuilder<ReportResult>(
              stream: reportStream,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(18),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final r = snap.data ?? ReportResult.empty;

                final title = _tab == 0
                    ? '${t.report} • ${_monthName(_month)} $_year'
                    : '${t.report} • $_year';

                return _reportCard(t, title, r);
              },
            ),

            const SizedBox(height: 12),
            _exportRow(t),
          ],
        ),
      ),
    );
  }

  Widget _segmented(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _segBtn(
              text: t.byMonth,
              selected: _tab == 0,
              onTap: () => setState(() => _tab = 0),
            ),
          ),
          Expanded(
            child: _segBtn(
              text: t.byYear,
              selected: _tab == 1,
              onTap: () => setState(() => _tab = 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _segBtn({
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? brandGreen.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? brandGreen : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: selected ? brandGreen : Colors.black.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }

  Widget _filtersCard(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        children: [
          if (_tab == 0) ...[
            DropdownButtonFormField<int>(
              value: _month,
              decoration: InputDecoration(
                labelText: t.monthLabel,
                prefixIcon: const Icon(Icons.calendar_month),
              ),
              items: List.generate(12, (i) {
                final m = i + 1;
                return DropdownMenuItem(value: m, child: Text(_monthName(m)));
              }),
              onChanged: (v) => setState(() => _month = v ?? _month),
            ),
            const SizedBox(height: 10),
          ],
          DropdownButtonFormField<int>(
            value: _year,
            decoration: InputDecoration(
              labelText: t.yearLabel,
              prefixIcon: const Icon(Icons.event),
            ),
            items: _years
                .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
                .toList(),
            onChanged: (v) => setState(() => _year = v ?? _year),
          ),
        ],
      ),
    );
  }

  Widget _reportCard(AppLocalizations t, String title, ReportResult r) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          const SizedBox(height: 10),

          _row('${t.invoicesLabel}:', r.invoicesCount.toString()),
          _row('${t.totalSalesLabel}:', r.totalSales.toStringAsFixed(2)),
          _row('${t.totalTaxLabel}:', r.totalTax.toStringAsFixed(2)),
          _row('${t.totalTipLabel}:', r.totalTip.toStringAsFixed(2)),
          _row('${t.netLabel}:', r.net.toStringAsFixed(2)),

          const Divider(height: 22),

          _row(t.unsentLabel, r.unsentCount.toString()),
          _row(t.sentLabel, r.sentCount.toString()),
          _row(t.paidLabel, r.paidCount.toString()),
          _row(t.overdueLabel, r.overdueCount.toString()),

          const SizedBox(height: 10),
          Text(
            t.reportCalculatedHint,
            style: TextStyle(
              color: Colors.black.withOpacity(0.45),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.black.withOpacity(0.70)),
            ),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _exportRow(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _exporting ? null : _exportPdf,
              icon: _exporting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.picture_as_pdf),
              label: Text(t.exportPdf),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _exporting ? null : _exportCsvMenu,
              icon: _exporting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.table_chart),
              label: Text(t.exportCsv),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportDesignBar extends StatelessWidget {
  const _ReportDesignBar();

  static const brandGreen = Color(0xFF1F6E5C);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final repo = BusinessProfileRepository();
    return StreamBuilder<BusinessProfile>(
      stream: repo.stream(),
      builder: (context, snap) {
        final p = snap.data ?? const BusinessProfile();
        final paletteId = AppThemePresets.normalizePalette(p.reportPaletteId);
        final layoutId = AppThemePresets.normalizeLayout(p.reportLayoutId);

        return ValueListenableBuilder<SubscriptionState>(
          valueListenable: SubscriptionManager.instance.state,
          builder: (context, sub, _) {
            final isPro = sub.isPro;
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black.withOpacity(0.06)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.reportStyleTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black.withOpacity(0.78),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (!isPro) ...[
                    Text(
                      t.reportFreeStyleHint,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.62),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PaywallScreen(),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: brandGreen,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.workspace_premium_outlined),
                      label: Text(t.upgradeToPro),
                    ),
                  ] else ...[
                    DropdownButtonFormField<String>(
                      key: ValueKey('report_palette_$paletteId'),
                      initialValue: paletteId,
                      decoration: InputDecoration(
                        labelText: t.reportPaletteLabel,
                        prefixIcon: const Icon(Icons.palette_outlined),
                      ),
                      items: AppThemePresets.palettes
                          .map(
                            (x) => DropdownMenuItem(
                              value: x.id,
                              child: Row(
                                children: [
                                  _paletteDot(x.primary),
                                  const SizedBox(width: 6),
                                  _paletteDot(x.accent),
                                  const SizedBox(width: 8),
                                  Text(x.label),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) async {
                        final next = AppThemePresets.normalizePalette(v);
                        try {
                          await repo.save(
                            p.copyWith(reportPaletteId: next, paletteId: next),
                          );
                        } catch (_) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(t.saveReportPaletteError)),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      key: ValueKey('report_layout_$layoutId'),
                      initialValue: layoutId,
                      decoration: InputDecoration(
                        labelText: t.reportLayoutLabel,
                        prefixIcon: const Icon(Icons.dashboard_outlined),
                      ),
                      items: AppThemePresets.layouts
                          .map(
                            (x) => DropdownMenuItem(
                              value: x.id,
                              child: Text(x.label),
                            ),
                          )
                          .toList(),
                      onChanged: (v) async {
                        final next = AppThemePresets.normalizeLayout(v);
                        try {
                          await repo.save(p.copyWith(reportLayoutId: next));
                        } catch (_) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(t.saveReportLayoutError)),
                          );
                        }
                      },
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _paletteDot(int colorValue) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Color(colorValue),
        shape: BoxShape.circle,
      ),
    );
  }
}
