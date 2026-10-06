import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/ui/dashboard/metric_detail_screen.dart';

Invoice invoice(String id, DateTime date, double amount) => Invoice(
  id: id,
  invoiceNumber: id,
  clientId: 'client',
  clientName: 'Long customer name that should wrap across narrow screens',
  clientEmail: '',
  clientPhoneE164: '',
  createdAtMs: date.millisecondsSinceEpoch,
  status: 'unpaid',
  paymentMethod: '',
  paymentNote: '',
  items: [],
  subtotal: amount,
  taxRate: 10,
  taxAmount: amount * .1,
  tip: amount * .2,
  tipIsPercent: false,
  tipPercent: 0,
  total: amount * 1.3,
  message: '',
);
void main() {
  final data = [
    invoice('A', DateTime(2026, 1, 1), 100),
    invoice('B', DateTime(2026, 1, 1), 50),
    invoice('C', DateTime(2025, 12, 31), 10),
  ];
  test('sales exclude tip and tax while billed total includes both', () {
    final date = DateTime(2026, 1);
    double total(DashboardMetric metric) =>
        MetricMonthSummary(data, date, metric).total;
    expect(total(DashboardMetric.sales), 150);
    expect(total(DashboardMetric.tip), 30);
    expect(total(DashboardMetric.tax), 15);
    expect(total(DashboardMetric.billedTotal), 195);
    expect(
      total(DashboardMetric.billedTotal),
      total(DashboardMetric.sales) +
          total(DashboardMetric.tip) +
          total(DashboardMetric.tax),
    );
  });
  test('all metrics aggregate only the selected month and correct day', () {
    for (final metric in DashboardMetric.values) {
      final summary = MetricMonthSummary(data, DateTime(2026, 1), metric);
      expect(summary.invoices.length, 2);
      expect(summary.daily.length, 31);
      expect(summary.total, metric.amount(data[0]) + metric.amount(data[1]));
      expect(summary.daily[0], summary.total);
      expect(summary.daily.skip(1).every((n) => n == 0), isTrue);
    }
    expect(
      MetricMonthSummary(
        data,
        DateTime(2024, 2),
        DashboardMetric.tax,
      ).daily.length,
      29,
    );
  });
  for (final size in [
    const Size(320, 568),
    const Size(844, 390),
    const Size(951, 669),
  ]) {
    for (final scale in [1.0, 2.0]) {
      testWidgets('detail fits $size with text $scale and changes year', (
        tester,
      ) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = size;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(scale)),
              child: child!,
            ),
            home: MetricDetailScreen(
              metric: DashboardMetric.tip,
              initialMonth: DateTime(2026, 1),
              invoices: Stream.value(data),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('\$30.00'), findsWidgets);
        expect(tester.takeException(), isNull);
        await tester.tap(find.byKey(const ValueKey('previous-month')));
        await tester.pumpAndSettle();
        expect(find.text('December 2025'), findsOneWidget);
        expect(find.text('\$2.00'), findsWidgets);
        await tester.scrollUntilVisible(find.text('C'), 180);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.scrollUntilVisible(
          find.byKey(const ValueKey('choose-period')),
          -200,
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('choose-period')));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.tap(find.byKey(const ValueKey('period-year')));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2026').last);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('choose-month-1')));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('close-period')));
        await tester.pumpAndSettle();
        expect(find.text('January 2026'), findsOneWidget);
        expect(find.text('\$30.00'), findsWidgets);
        expect(tester.takeException(), isNull);
      });
    }
  }
}
