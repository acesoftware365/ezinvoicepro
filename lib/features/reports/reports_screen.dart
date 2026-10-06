// lib/features/reports/reports_screen.dart

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/models/business_profile.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:ezinvoice/services/ads/ads_manager.dart';
import 'package:ezinvoice/services/purchases/subscription_manager.dart';
import 'package:ezinvoice/services/style/app_theme_presets.dart';

import 'package:ezinvoice/features/reports/report_summary.dart';
import 'package:ezinvoice/features/reports/reports_service.dart';
import 'package:ezinvoice/features/reports/reports_export_service.dart';

import '../paywall/paywall_screen.dart';

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

  List<int> get _years {
    final now = DateTime.now().year;
    return List.generate(9, (i) => now - 6 + i);
  }

  String _monthName(int month) {
    return DateFormat.MMM(
      AppLocalizations.of(context).localeName,
    ).format(DateTime(2026, month.clamp(1, 12).toInt()));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final reportStream = _tab == 0
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
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 26),
          children: [
            _periodCard(t),
            const SizedBox(height: 14),
            StreamBuilder<ReportResult>(
              stream: reportStream,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final report = snap.data ?? ReportResult.empty;
                final title = _tab == 0
                    ? '${t.report} • ${_monthName(_month)} $_year'
                    : '${t.report} • $_year';
                return _reportContent(t, title, report);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _periodLabel() {
    if (_tab == 1) return '$_year';
    return '${_monthName(_month)} $_year';
  }

  Widget _periodCard(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: brandGreen.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: brandGreen,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.report,
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.58),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      _periodLabel(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () => _openPeriodPicker(t),
                icon: const Icon(Icons.edit_calendar_outlined, size: 18),
                label: Text(t.edit),
                style: TextButton.styleFrom(
                  foregroundColor: brandGreen,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _segmented(t),
        ],
      ),
    );
  }

  Widget _segmented(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: pageBg,
        borderRadius: BorderRadius.circular(14),
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
      borderRadius: BorderRadius.circular(11),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          boxShadow: selected
              ? [
                  BoxShadow(
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                    color: Colors.black.withValues(alpha: 0.08),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: selected
                  ? brandGreen
                  : Colors.black.withValues(alpha: 0.56),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openPeriodPicker(AppLocalizations t) async {
    final result = await showModalBottomSheet<_ReportPeriod>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        var draftTab = _tab;
        var draftMonth = _month;
        var draftYear = _year;
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.82,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            t.report,
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: t.close,
                          onPressed: () => Navigator.of(sheetContext).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: pageBg,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _sheetSegment(
                              label: t.byMonth,
                              selected: draftTab == 0,
                              onTap: () => setSheetState(() => draftTab = 0),
                            ),
                          ),
                          Expanded(
                            child: _sheetSegment(
                              label: t.byYear,
                              selected: draftTab == 1,
                              onTap: () => setSheetState(() => draftTab = 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    DropdownButtonFormField<int>(
                      initialValue: draftYear,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: t.yearLabel,
                        prefixIcon: const Icon(Icons.event_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      items: _years
                          .map(
                            (year) => DropdownMenuItem(
                              value: year,
                              child: Text('$year'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setSheetState(() => draftYear = value ?? draftYear),
                    ),
                    if (draftTab == 0) ...[
                      const SizedBox(height: 18),
                      Text(
                        t.monthLabel,
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(12, (index) {
                          final month = index + 1;
                          return ChoiceChip(
                            label: Text(_monthName(month)),
                            selected: draftMonth == month,
                            selectedColor: brandGreen.withValues(alpha: 0.15),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: draftMonth == month
                                  ? brandGreen
                                  : Colors.black.withValues(alpha: 0.72),
                            ),
                            onSelected: (_) =>
                                setSheetState(() => draftMonth = month),
                          );
                        }),
                      ),
                    ],
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => Navigator.of(sheetContext).pop(
                          _ReportPeriod(
                            tab: draftTab,
                            month: draftMonth,
                            year: draftYear,
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: brandGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        icon: const Icon(Icons.visibility_outlined),
                        label: Text(t.continueText),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result == null || !mounted) return;
    setState(() {
      _tab = result.tab;
      _month = result.month;
      _year = result.year;
    });
  }

  Widget _sheetSegment({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(11),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: selected
                ? brandGreen.withValues(alpha: 0.25)
                : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: selected ? brandGreen : Colors.black.withValues(alpha: 0.56),
          ),
        ),
      ),
    );
  }

  Widget _reportContent(AppLocalizations t, String title, ReportResult report) {
    return StreamBuilder<BusinessProfile>(
      stream: BusinessProfileRepository().stream(),
      builder: (context, profileSnapshot) {
        final profile = profileSnapshot.data ?? const BusinessProfile();
        return LayoutBuilder(
          builder: (context, constraints) {
            final textScale = MediaQuery.textScalerOf(context).scale(16) / 16;
            final useWideLayout =
                constraints.maxWidth >= 760 && textScale <= 1.3;
            final overview = _overviewCard(
              t,
              title,
              report,
              profile.currencyCode,
            );
            final status = _statusCard(t, report);
            final viewReport = _viewReportCard(t);

            if (useWideLayout) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: overview),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        status,
                        const SizedBox(height: 14),
                        viewReport,
                      ],
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                overview,
                const SizedBox(height: 14),
                status,
                const SizedBox(height: 14),
                viewReport,
              ],
            );
          },
        );
      },
    );
  }

  Widget _overviewCard(
    AppLocalizations t,
    String title,
    ReportResult report,
    String currencyCode,
  ) {
    final total = report.totalInvoiced;
    final salesShare = total > 0 ? report.sales / total : 0.0;
    final tipShare = total > 0 ? report.totalTip / total : 0.0;
    final taxShare = total > 0 ? report.totalTax / total : 0.0;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.62),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: brandGreen,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.totalInvoicedTitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.82),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _money(report.totalInvoiced, currencyCode),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 29,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: SizedBox(
              height: 7,
              child: Row(
                children: [
                  _breakdownSegment(salesShare, const Color(0xFF1F6E5C)),
                  _breakdownSegment(tipShare, const Color(0xFF3A8D81)),
                  _breakdownSegment(taxShare, const Color(0xFFE19C32)),
                  if (total <= 0)
                    const Expanded(child: ColoredBox(color: Color(0xFFE6EAEC))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final scale = MediaQuery.textScalerOf(context).scale(14) / 14;
              final canUseThreeColumns =
                  constraints.maxWidth >= 390 && scale <= 1.15;
              final metrics = [
                _metricTile(
                  label: t.salesTitle,
                  amount: _money(report.sales, currencyCode),
                  color: const Color(0xFF1F6E5C),
                ),
                _metricTile(
                  label: t.tipTitle,
                  amount: _money(report.totalTip, currencyCode),
                  color: const Color(0xFF3A8D81),
                ),
                _metricTile(
                  label: t.taxTitle,
                  amount: _money(report.totalTax, currencyCode),
                  color: const Color(0xFFE19C32),
                ),
              ];
              if (canUseThreeColumns) {
                return Row(
                  children: [
                    Expanded(child: metrics[0]),
                    const SizedBox(width: 8),
                    Expanded(child: metrics[1]),
                    const SizedBox(width: 8),
                    Expanded(child: metrics[2]),
                  ],
                );
              }
              return Column(
                children: [
                  metrics[0],
                  const SizedBox(height: 8),
                  metrics[1],
                  const SizedBox(height: 8),
                  metrics[2],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _breakdownSegment(double share, Color color) {
    if (share <= 0) return const SizedBox.shrink();
    return Expanded(
      flex: (share * 10000).round().clamp(1, 10000),
      child: ColoredBox(color: color),
    );
  }

  Widget _metricTile({
    required String label,
    required String amount,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              amount,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard(AppLocalizations t, ReportResult report) {
    final statusItems = [
      _ReportStatus(t.unsentLabel, report.unsentCount, const Color(0xFF697586)),
      _ReportStatus(t.sentLabel, report.sentCount, const Color(0xFF3977B8)),
      _ReportStatus(t.paidLabel, report.paidCount, const Color(0xFF1F8C63)),
      _ReportStatus(
        t.overdueLabel,
        report.overdueCount,
        const Color(0xFFC96145),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.receipt_long_outlined,
                color: brandGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  t.invoicesLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                t.invoiceCount(report.invoicesCount),
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.57),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final scale = MediaQuery.textScalerOf(context).scale(14) / 14;
              final twoColumns = constraints.maxWidth >= 310 && scale <= 1.25;
              if (!twoColumns) {
                return Column(
                  children: [
                    for (var i = 0; i < statusItems.length; i++) ...[
                      _statusTile(statusItems[i]),
                      if (i != statusItems.length - 1)
                        const SizedBox(height: 8),
                    ],
                  ],
                );
              }
              final width = (constraints.maxWidth - 8) / 2;
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: statusItems
                    .map(
                      (item) =>
                          SizedBox(width: width, child: _statusTile(item)),
                    )
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 12),
          Text(
            t.reportCalculatedHint,
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.48),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTile(_ReportStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: status.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              status.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '${status.count}',
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _viewReportCard(AppLocalizations t) {
    final viewReportLabel = t.viewReport;
    final previewHint = t.reviewBeforeExport;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            previewHint,
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.58),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _openReportPreview,
              style: FilledButton.styleFrom(
                backgroundColor: brandGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
              ),
              icon: const Icon(Icons.visibility_outlined),
              label: Text(viewReportLabel),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openReportPreview() {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _ReportPreviewScreen(
          byMonth: _tab == 0,
          year: _year,
          month: _tab == 0 ? _month : null,
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.black.withValues(alpha: 0.07)),
      boxShadow: [
        BoxShadow(
          blurRadius: 18,
          offset: const Offset(0, 8),
          color: Colors.black.withValues(alpha: 0.045),
        ),
      ],
    );
  }

  String _money(double amount, String currencyCode) {
    return '${currencyCode.trim().isEmpty ? 'USD' : currencyCode} ${amount.toStringAsFixed(2)}';
  }
}

class _ReportPeriod {
  const _ReportPeriod({
    required this.tab,
    required this.month,
    required this.year,
  });

  final int tab;
  final int month;
  final int year;
}

class _ReportStatus {
  const _ReportStatus(this.label, this.count, this.color);

  final String label;
  final int count;
  final Color color;
}

class _ReportDesignBar extends StatelessWidget {
  const _ReportDesignBar({this.showTitle = true});

  final bool showTitle;

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
        final palette = AppThemePresets.palettes.firstWhere(
          (item) => item.id == paletteId,
        );
        final primary = Color(palette.primary);
        final soft = Color(palette.soft);
        final accent = Color(palette.accent);

        return ValueListenableBuilder<SubscriptionState>(
          valueListenable: SubscriptionManager.instance.state,
          builder: (context, sub, _) {
            final isPro = sub.isPro;
            final palettePicker = _palettePicker(
              context: context,
              profile: p,
              paletteId: paletteId,
              primary: primary,
              soft: soft,
              repo: repo,
              t: t,
            );
            final layoutPicker = _layoutPicker(
              context: context,
              profile: p,
              layoutId: layoutId,
              accent: accent,
              soft: soft,
              repo: repo,
              t: t,
            );
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: primary.withValues(alpha: 0.16)),
                boxShadow: [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.08),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showTitle) ...[
                    Text(
                      t.reportStyleTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black.withValues(alpha: 0.78),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                  if (isPro) ...[
                    _stylePreview(palette: palette, layoutId: layoutId, t: t),
                    const SizedBox(height: 16),
                    Text(
                      t.customizeReport,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      t.reportPreviewUpdates,
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.56),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (!isPro) ...[
                    Text(
                      t.reportFreeStyleHint,
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.62),
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
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth >= 520) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: palettePicker),
                              const SizedBox(width: 12),
                              Expanded(child: layoutPicker),
                            ],
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            palettePicker,
                            const SizedBox(height: 10),
                            layoutPicker,
                          ],
                        );
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

  Widget _palettePicker({
    required BuildContext context,
    required BusinessProfile profile,
    required String paletteId,
    required Color primary,
    required Color soft,
    required BusinessProfileRepository repo,
    required AppLocalizations t,
  }) {
    return DropdownButtonFormField<String>(
      key: ValueKey('report_palette_$paletteId'),
      initialValue: paletteId,
      decoration: _styleInputDecoration(
        label: t.reportPaletteLabel,
        icon: Icons.palette_outlined,
        color: primary,
        softColor: soft,
      ),
      items: AppThemePresets.palettes
          .map(
            (item) => DropdownMenuItem(
              value: item.id,
              child: Row(
                children: [
                  _paletteDot(item.primary),
                  const SizedBox(width: 6),
                  _paletteDot(item.accent),
                  const SizedBox(width: 8),
                  Text(AppThemePresets.localizedPaletteLabel(t, item.id)),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (value) async {
        final next = AppThemePresets.normalizePalette(value);
        try {
          await repo.save(
            profile.copyWith(reportPaletteId: next, paletteId: next),
          );
        } catch (_) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.saveReportPaletteError)));
        }
      },
    );
  }

  Widget _layoutPicker({
    required BuildContext context,
    required BusinessProfile profile,
    required String layoutId,
    required Color accent,
    required Color soft,
    required BusinessProfileRepository repo,
    required AppLocalizations t,
  }) {
    return DropdownButtonFormField<String>(
      key: ValueKey('report_layout_$layoutId'),
      initialValue: layoutId,
      decoration: _styleInputDecoration(
        label: t.reportLayoutLabel,
        icon: Icons.dashboard_outlined,
        color: accent,
        softColor: soft,
      ),
      items: AppThemePresets.layouts
          .map(
            (item) => DropdownMenuItem(
              value: item.id,
              child: Text(AppThemePresets.localizedLayoutLabel(t, item.id)),
            ),
          )
          .toList(),
      onChanged: (value) async {
        final next = AppThemePresets.normalizeLayout(value);
        try {
          await repo.save(profile.copyWith(reportLayoutId: next));
        } catch (_) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.saveReportLayoutError)));
        }
      },
    );
  }

  Widget _stylePreview({
    required PalettePreset palette,
    required String layoutId,
    required AppLocalizations t,
  }) {
    final primary = Color(palette.primary);
    final soft = Color(palette.soft);
    final accent = Color(palette.accent);
    final layoutName = AppThemePresets.localizedLayoutLabel(t, layoutId);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: soft,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primary.withValues(alpha: 0.16)),
      ),
      child: Row(
        children: [
          Container(
            width: 74,
            height: 54,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: primary.withValues(alpha: 0.11),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 11,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 5),
                Container(height: 5, color: primary.withValues(alpha: 0.18)),
                const SizedBox(height: 4),
                Container(height: 5, color: accent.withValues(alpha: 0.62)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.yourReportPreview,
                  style: TextStyle(
                    color: primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${AppThemePresets.localizedPaletteLabel(t, palette.id)} · $layoutName',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.84),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Icon(Icons.visibility_outlined, color: primary, size: 18),
          ),
        ],
      ),
    );
  }

  InputDecoration _styleInputDecoration({
    required String label,
    required IconData icon,
    required Color color,
    required Color softColor,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color.withValues(alpha: 0.20)),
    );
    return InputDecoration(
      labelText: label,
      floatingLabelStyle: TextStyle(color: color, fontWeight: FontWeight.w800),
      prefixIcon: Container(
        width: 40,
        margin: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      filled: true,
      fillColor: softColor.withValues(alpha: 0.60),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: color, width: 1.5),
      ),
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

class _ReportPreviewScreen extends StatefulWidget {
  const _ReportPreviewScreen({
    required this.byMonth,
    required this.year,
    required this.month,
  });

  final bool byMonth;
  final int year;
  final int? month;

  @override
  State<_ReportPreviewScreen> createState() => _ReportPreviewScreenState();
}

class _ReportPreviewScreenState extends State<_ReportPreviewScreen> {
  static const _brandGreen = Color(0xFF1F6E5C);
  static const _pageBackground = Color(0xFFF6F7F9);

  int _previewTab = 0;
  bool _exporting = false;
  final _exportButtonKey = GlobalKey();

  Stream<ReportResult> get _reportStream {
    if (widget.byMonth) {
      return ReportsService.streamMonthlyReport(
        year: widget.year,
        month: widget.month!,
      );
    }
    return ReportsService.streamYearlyReport(year: widget.year);
  }

  String get _periodLabel {
    if (!widget.byMonth) return '${widget.year}';
    final month = DateFormat.MMM(
      AppLocalizations.of(context).localeName,
    ).format(DateTime(2026, widget.month!.clamp(1, 12).toInt()));
    return '$month ${widget.year}';
  }

  Future<void> _openReportStylePanel(AppLocalizations t) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: false,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF6F9F8),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 26),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 42,
                    height: 5,
                    decoration: BoxDecoration(
                      color: _brandGreen.withValues(alpha: 0.42),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1F6E5C), Color(0xFF155345)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: _brandGreen.withValues(alpha: 0.20),
                          blurRadius: 18,
                          offset: const Offset(0, 9),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.tune_rounded,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.reportStyleTitle,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                t.reportStyleLiveHint,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.80),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: t.close,
                          onPressed: () => Navigator.of(sheetContext).pop(),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.14,
                            ),
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  const _ReportDesignBar(showTitle: false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<bool> _ensureProOrRewardedReportExport() async {
    if (SubscriptionManager.instance.state.value.isPro) return true;

    await AdsManager.instance.init();
    AdsManager.instance.loadRewarded();
    var rewarded = false;
    final shown = await AdsManager.instance.showRewarded(
      rewardType: RewardType.exportReportOnce,
      onReward: () => rewarded = true,
    );
    if (shown && rewarded) return true;

    _snack(AppLocalizations.of(context).watchAdToExportReport);
    return false;
  }

  Rect _exportOrigin() {
    final renderObject = _exportButtonKey.currentContext?.findRenderObject();
    final box = renderObject is RenderBox ? renderObject : null;
    if (box != null && box.hasSize) {
      final rect = box.localToGlobal(Offset.zero) & box.size;
      if (rect.width > 0 && rect.height > 0) return rect;
    }

    final size = MediaQuery.sizeOf(context);
    return Rect.fromCenter(
      center: size.center(Offset.zero),
      width: 1,
      height: 1,
    );
  }

  Future<void> _exportPdf() async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      final allowed = await _ensureProOrRewardedReportExport();
      if (!allowed || !mounted) return;

      await ReportsExportService.exportPdfAndShare(
        context: context,
        sharePositionOrigin: _exportOrigin(),
        byMonth: widget.byMonth,
        year: widget.year,
        month: widget.month,
      );
    } catch (error) {
      _snack(AppLocalizations.of(context).reportExportError(error));
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<void> _exportCsvMenu() async {
    if (_exporting) return;
    final t = AppLocalizations.of(context);
    final origin = _exportOrigin();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (sheetContext) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 6, 14, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 6),
              ListTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: Text(t.shareCsvFile),
                subtitle: Text(t.shareCsvFileDescription),
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await _runExport(
                    () => ReportsExportService.shareCsvFile(
                      context: context,
                      sharePositionOrigin: origin,
                      byMonth: widget.byMonth,
                      year: widget.year,
                      month: widget.month,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.message_outlined),
                title: Text(t.shareReportAsText),
                subtitle: Text(t.shareReportAsTextDescription),
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await _runExport(
                    () => ReportsExportService.shareCsvAsText(
                      context: context,
                      sharePositionOrigin: origin,
                      byMonth: widget.byMonth,
                      year: widget.year,
                      month: widget.month,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.print_outlined),
                title: Text(t.printCsv),
                subtitle: Text(t.printReportDescription),
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await _runExport(
                    () => ReportsExportService.printCsv(
                      context: context,
                      sharePositionOrigin: origin,
                      byMonth: widget.byMonth,
                      year: widget.year,
                      month: widget.month,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _runExport(Future<void> Function() action) async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      final allowed = await _ensureProOrRewardedReportExport();
      if (!allowed || !mounted) return;
      await action();
    } catch (error) {
      _snack(AppLocalizations.of(context).reportExportError(error));
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<void> _exportCurrent() {
    return _previewTab == 0 ? _exportPdf() : _exportCsvMenu();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final previewLabel = t.reportPreview;

    return Scaffold(
      backgroundColor: _pageBackground,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _floatingExportButton(t),
      appBar: AppBar(
        backgroundColor: _brandGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          t.report,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => _openReportStylePanel(t),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.tune_outlined, size: 19),
            label: Text(
              t.edit,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<ReportResult>(
          stream: _reportStream,
          builder: (context, reportSnapshot) {
            if (reportSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (reportSnapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(t.errorWithDetails(reportSnapshot.error ?? '')),
                ),
              );
            }

            final report =
                reportSnapshot.data ??
                const ReportResult(
                  invoicesCount: 0,
                  sales: 0,
                  totalTax: 0,
                  totalTip: 0,
                  totalInvoiced: 0,
                  unsentCount: 0,
                  sentCount: 0,
                  paidCount: 0,
                  overdueCount: 0,
                );
            return StreamBuilder<BusinessProfile>(
              stream: BusinessProfileRepository().stream(),
              builder: (context, profileSnapshot) {
                final profile = profileSnapshot.data ?? const BusinessProfile();
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 108),
                  children: [
                    _previewHeader(
                      t: t,
                      profile: profile,
                      previewLabel: previewLabel,
                    ),
                    const SizedBox(height: 14),
                    _previewTabs(t),
                    const SizedBox(height: 14),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child: _previewTab == 0
                          ? _pdfPreview(
                              key: const ValueKey('pdf_preview'),
                              t: t,
                              report: report,
                              profile: profile,
                            )
                          : _csvPreview(
                              key: const ValueKey('csv_preview'),
                              t: t,
                              report: report,
                              profile: profile,
                            ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _previewHeader({
    required AppLocalizations t,
    required BusinessProfile profile,
    required String previewLabel,
  }) {
    final businessName = profile.businessName.trim().isEmpty
        ? t.reports
        : profile.businessName.trim();

    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: _brandGreen.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(Icons.description_outlined, color: _brandGreen),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                previewLabel,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$businessName · $_periodLabel',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.56),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE5F4EF),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            t.live,
            style: const TextStyle(
              color: _brandGreen,
              fontWeight: FontWeight.w900,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _previewTabs(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withValues(alpha: 0.07)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _previewTabButton(
              label: 'PDF',
              icon: Icons.picture_as_pdf_outlined,
              selected: _previewTab == 0,
              onTap: () => setState(() => _previewTab = 0),
            ),
          ),
          Expanded(
            child: _previewTabButton(
              label: 'CSV',
              icon: Icons.table_chart_outlined,
              selected: _previewTab == 1,
              onTap: () => setState(() => _previewTab = 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewTabButton({
    required String label,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? _brandGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected ? Colors.white : _brandGreen,
              ),
              const SizedBox(width: 7),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : _brandGreen,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pdfPreview({
    required Key key,
    required AppLocalizations t,
    required ReportResult report,
    required BusinessProfile profile,
  }) {
    final palette = _paletteFor(profile.reportPaletteId);
    final primary = Color(palette.primary);
    final pageKey = ValueKey(
      '${profile.reportPaletteId}:${profile.reportLayoutId}:${report.invoicesCount}:${report.totalInvoiced}',
    );

    return Container(
      key: key,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDF1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: const Offset(0, 10),
            color: primary.withValues(alpha: 0.12),
          ),
        ],
      ),
      child: AspectRatio(
        // Letter is the exact paper size used by the exported report.
        aspectRatio: 8.5 / 11,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: PdfPreview(
            key: pageKey,
            build: (_) => ReportsExportService.buildPdfPreviewBytes(
              byMonth: widget.byMonth,
              year: widget.year,
              month: widget.month,
              context: context,
            ),
            pages: const [0],
            allowPrinting: false,
            allowSharing: false,
            useActions: false,
            canChangePageFormat: false,
            canChangeOrientation: false,
            canDebug: false,
            dynamicLayout: false,
            padding: EdgeInsets.zero,
            previewPageMargin: EdgeInsets.zero,
            scrollViewDecoration: const BoxDecoration(color: Colors.white),
            pdfPreviewPageDecoration: const BoxDecoration(color: Colors.white),
            loadingWidget: Center(
              child: CircularProgressIndicator(color: primary),
            ),
          ),
        ),
      ),
    );
  }

  Widget _csvPreview({
    required Key key,
    required AppLocalizations t,
    required ReportResult report,
    required BusinessProfile profile,
  }) {
    final palette = _paletteFor(profile.reportPaletteId);
    final primary = Color(palette.primary);
    final soft = Color(palette.soft);
    final currency = profile.currencyCode.trim().isEmpty
        ? 'USD'
        : profile.currencyCode;

    final rows = [
      (t.salesTitle, _money(report.sales, currency)),
      (t.tipTitle, _money(report.totalTip, currency)),
      (t.taxTitle, _money(report.totalTax, currency)),
      (t.totalInvoicedTitle, _money(report.totalInvoiced, currency)),
    ];

    return Container(
      key: key,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: primary.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            blurRadius: 22,
            offset: const Offset(0, 9),
            color: primary.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            child: Row(
              children: [
                const Icon(Icons.table_chart_outlined, color: Colors.white),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'CSV · $_periodLabel',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(10),
            child: DataTable(
              headingRowColor: WidgetStatePropertyAll(soft),
              columns: [
                DataColumn(label: Text(t.report)),
                DataColumn(label: Text(t.totalInvoicedTitle)),
              ],
              rows: [
                for (final row in rows)
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          row.$1,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            row.$2,
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingExportButton(AppLocalizations t) {
    final isPdf = _previewTab == 0;
    final exportLabel = isPdf ? t.exportPdf : t.exportCsv;
    final exportIcon = isPdf
        ? Icons.picture_as_pdf_outlined
        : Icons.table_chart_outlined;

    return KeyedSubtree(
      key: _exportButtonKey,
      child: FloatingActionButton.extended(
        heroTag: 'report_export',
        onPressed: _exporting ? null : _exportCurrent,
        backgroundColor: _brandGreen,
        foregroundColor: Colors.white,
        icon: _exporting
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Icon(exportIcon),
        label: Text(
          exportLabel,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  PalettePreset _paletteFor(String paletteId) {
    final normalized = AppThemePresets.normalizePalette(paletteId);
    return AppThemePresets.palettes.firstWhere((p) => p.id == normalized);
  }

  String _money(double amount, String currencyCode) {
    return '$currencyCode ${amount.toStringAsFixed(2)}';
  }
}
