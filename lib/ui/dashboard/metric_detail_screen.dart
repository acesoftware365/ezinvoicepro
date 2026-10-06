import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/services/invoices/invoices_service.dart';

enum DashboardMetric {
  sales,
  tip,
  billedTotal,
  tax;

  String label(AppLocalizations t) => switch (this) {
    sales => t.salesTitle,
    tip => t.tipTitle,
    billedTotal => t.totalInvoicedTitle,
    tax => t.taxTitle,
  };
  double amount(Invoice invoice) => switch (this) {
    sales => invoice.subtotal,
    tip => invoice.tip,
    billedTotal => invoice.total,
    tax => invoice.taxAmount,
  };
}

class MetricMonthSummary {
  MetricMonthSummary(
    List<Invoice> source,
    DateTime month,
    DashboardMetric metric,
  ) {
    invoices = source.where((invoice) {
      final date = DateTime.fromMillisecondsSinceEpoch(invoice.createdAtMs);
      return invoice.invoiceNumber != 'ERROR' &&
          date.year == month.year &&
          date.month == month.month;
    }).toList()..sort((a, b) => b.createdAtMs.compareTo(a.createdAtMs));
    daily = List.filled(DateTime(month.year, month.month + 1, 0).day, 0.0);
    for (final invoice in invoices) {
      daily[DateTime.fromMillisecondsSinceEpoch(invoice.createdAtMs).day - 1] +=
          metric.amount(invoice);
    }
  }
  late final List<Invoice> invoices;
  late final List<double> daily;
  double get total => daily.fold(0.0, (sum, value) => sum + value);
}

class MetricDetailScreen extends StatefulWidget {
  const MetricDetailScreen({
    super.key,
    required this.metric,
    this.invoices,
    this.initialMonth,
  });
  final DashboardMetric metric;
  final Stream<List<Invoice>>? invoices;
  final DateTime? initialMonth;
  @override
  State<MetricDetailScreen> createState() => _MetricDetailScreenState();
}

class _MetricDetailScreenState extends State<MetricDetailScreen> {
  late DateTime month;
  late Stream<List<Invoice>> invoices;
  @override
  void initState() {
    super.initState();
    final now = widget.initialMonth ?? DateTime.now();
    month = DateTime(now.year, now.month);
    invoices = widget.invoices ?? InvoicesService.streamInvoices();
  }

  String money(double value) => '\$${value.toStringAsFixed(2)}';
  void move(int offset) =>
      setState(() => month = DateTime(month.year, month.month + offset));

  Future<void> _choosePeriod(int firstYear, int lastYear) async {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      constraints: const BoxConstraints(maxWidth: 560),
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, refresh) {
          return SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * .85,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${t.monthLabel} / ${t.yearLabel}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        IconButton(
                          key: const ValueKey('close-period'),
                          tooltip: t.close,
                          onPressed: () => Navigator.pop(sheetContext),
                          icon: const Icon(Icons.close, size: 28),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            DropdownButtonFormField<int>(
                              key: const ValueKey('period-year'),
                              initialValue: month.year,
                              isExpanded: true,
                              decoration: InputDecoration(
                                labelText: t.yearLabel,
                                border: const OutlineInputBorder(),
                              ),
                              items: [
                                for (
                                  var year = lastYear;
                                  year >= firstYear;
                                  year--
                                )
                                  DropdownMenuItem(
                                    value: year,
                                    child: Text('$year'),
                                  ),
                              ],
                              onChanged: (value) {
                                if (value == null) return;
                                setState(
                                  () => month = DateTime(value, month.month),
                                );
                                refresh(() {});
                              },
                            ),
                            const SizedBox(height: 20),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final columns =
                                    MediaQuery.textScalerOf(context).scale(16) >
                                        24
                                    ? 1
                                    : constraints.maxWidth >= 450
                                    ? 3
                                    : 2;
                                return Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    for (var i = 1; i <= 12; i++)
                                      SizedBox(
                                        width:
                                            (constraints.maxWidth -
                                                12 * (columns - 1)) /
                                            columns,
                                        child: OutlinedButton(
                                          key: ValueKey('choose-month-$i'),
                                          style: OutlinedButton.styleFrom(
                                            minimumSize: const Size(0, 52),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 14,
                                            ),
                                            foregroundColor: const Color(
                                              0xFF1F7A64,
                                            ),
                                            backgroundColor: month.month == i
                                                ? const Color(0xFFEAF5F1)
                                                : Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(
                                              () => month = DateTime(
                                                month.year,
                                                i,
                                              ),
                                            );
                                            refresh(() {});
                                          },
                                          child: Semantics(
                                            selected: month.month == i,
                                            child: Row(
                                              children: [
                                                if (month.month == i) ...[
                                                  const Icon(
                                                    Icons.check,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 4),
                                                ],
                                                Expanded(
                                                  child: Text(
                                                    DateFormat.MMMM(
                                                      locale,
                                                    ).format(DateTime(2024, i)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final title = widget.metric.label(t);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F7A64),
        title: Text(title),
      ),
      body: SafeArea(
        child: StreamBuilder<List<Invoice>>(
          stream: invoices,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(t.metricLoadError),
                      TextButton(
                        onPressed: () => setState(() {
                          invoices =
                              widget.invoices ??
                              InvoicesService.streamInvoices();
                        }),
                        child: Text(t.profileRetry),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final summary = MetricMonthSummary(
              snapshot.data!,
              month,
              widget.metric,
            );
            final years = <int>{
              DateTime.now().year,
              month.year,
              for (final invoice in snapshot.data!)
                DateTime.fromMillisecondsSinceEpoch(invoice.createdAtMs).year,
            };
            final firstYear = math.min(2020, years.reduce(math.min));
            final lastYear = math.max(
              DateTime.now().year + 1,
              years.reduce(math.max),
            );
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          key: const ValueKey('previous-month'),
                          tooltip: MaterialLocalizations.of(
                            context,
                          ).previousMonthTooltip,
                          onPressed: () => move(-1),
                          icon: const Icon(Icons.chevron_left, size: 30),
                        ),
                        Expanded(
                          child: TextButton(
                            key: const ValueKey('choose-period'),
                            style: TextButton.styleFrom(
                              minimumSize: const Size(0, 52),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 12,
                              ),
                              foregroundColor: const Color(0xFF1F7A64),
                            ),
                            onPressed: () => _choosePeriod(firstYear, lastYear),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    DateFormat.yMMMM(locale).format(month),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.expand_more, size: 20),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          key: const ValueKey('next-month'),
                          tooltip: MaterialLocalizations.of(
                            context,
                          ).nextMonthTooltip,
                          onPressed: () => move(1),
                          icon: const Icon(Icons.chevron_right, size: 30),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          money(summary.total),
                          key: const ValueKey('metric-total'),
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('${t.invoices}: ${summary.invoices.length}'),
                        const SizedBox(height: 20),
                        Text(
                          money(
                            summary.daily.fold(
                              0.0,
                              (a, b) => math.max(a, b.abs()),
                            ),
                          ),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        // A bounded plot area, while the surrounding content grows and scrolls.
                        Semantics(
                          label:
                              '$title, ${DateFormat.yMMMM(locale).format(month)}, ${money(summary.total)}',
                          child: SizedBox(
                            height: 180,
                            width: double.infinity,
                            child: CustomPaint(
                              painter: _DailyBars(
                                summary.daily,
                                const Color(0xFF1F7A64),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '1',
                              semanticsLabel: DateFormat.yMMMd(
                                locale,
                              ).format(month),
                            ),
                            Text(t.dateLabel),
                            Text('${summary.daily.length}'),
                          ],
                        ),
                        if (summary.invoices.isEmpty) ...[
                          const SizedBox(height: 16),
                          Text(t.noInvoicesInPeriod),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(t.invoices, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                for (final invoice in summary.invoices)
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                invoice.invoiceNumber,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(invoice.clientName),
                              Text(
                                DateFormat.yMMMd(locale).format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    invoice.createdAtMs,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            money(widget.metric.amount(invoice)),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DailyBars extends CustomPainter {
  _DailyBars(this.values, this.color);
  final List<double> values;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final maximum = values.fold(0.0, (a, b) => math.max(a, b.abs()));
    final negative = values.any((v) => v < 0);
    final baseline = negative ? size.height / 2 : size.height - 1;
    final extent = negative ? size.height / 2 : size.height - 8;
    final line = Paint()
      ..color = color.withValues(alpha: .15)
      ..strokeWidth = 1;
    for (var i = 0; i <= 4; i++) {
      final y = i * size.height / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
    canvas.drawLine(
      Offset(0, baseline),
      Offset(size.width, baseline),
      Paint()..color = color,
    );
    if (maximum == 0) return;
    final step = size.width / values.length;
    for (var i = 0; i < values.length; i++) {
      final y = baseline - values[i] / maximum * extent;
      canvas.drawRect(
        Rect.fromLTRB(
          i * step + 1,
          math.min(y, baseline),
          (i + 1) * step - 1,
          math.max(y, baseline),
        ),
        Paint()..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_DailyBars old) =>
      old.values != values || old.color != color;
}
