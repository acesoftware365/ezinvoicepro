import 'package:ezinvoice/ui/dashboard/dashboard_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final size in [
    const Size(320, 568),
    const Size(390, 844),
    const Size(844, 390),
    const Size(466, 678),
    const Size(678, 466),
    const Size(871, 669),
    const Size(1024, 1366),
  ]) {
    for (final scale in [1.0, 2.0]) {
      testWidgets('dashboard cards fit $size at $scale', (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        var taps = 0;
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: MediaQueryData(
                size: size,
                textScaler: TextScaler.linear(scale),
              ),
              child: Scaffold(
                body: ListView(
                  padding: const EdgeInsets.all(18),
                  children: [
                    DashboardGrid(
                      children: [
                        for (final label in ['Sales', 'Tip', 'Subtotal', 'Tax'])
                          DashboardMetricCard(
                            icon: Icons.payments,
                            label: label,
                            value: 'CAD 1,234,567.89',
                            onTap: () => taps++,
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    DashboardGrid(
                      minItemWidth: 180,
                      children: [
                        for (final label in [
                          'Clients',
                          'Invoices',
                          'Reports',
                          'Business',
                        ])
                          DashboardActionCard(
                            icon: Icons.receipt,
                            title: label,
                            subtitle:
                                'Long translated description for accessibility',
                            onTap: () => taps++,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        final metric = find.byType(DashboardMetricCard).first;
        await tester.tap(metric);
        expect(taps, 1);
        final action = find.text('Business');
        await tester.scrollUntilVisible(action, 200);
        await tester.pumpAndSettle();
        await tester.tap(action);
        expect(taps, 2);
        expect(tester.takeException(), isNull);
        if (size.width >= 560 && scale == 1) {
          final rect = tester.getRect(find.byType(DashboardActionCard).last);
          expect(rect.height, lessThan(160));
        }
      });
    }
  }
}
