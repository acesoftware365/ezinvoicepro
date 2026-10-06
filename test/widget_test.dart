import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('the visible catalog changes with the selected locale', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const _LocalizedProbe(locale: Locale('en')));
    await tester.pumpAndSettle();

    expect(find.text('Invoices'), findsOneWidget);
    expect(find.text('Reports'), findsOneWidget);

    await tester.pumpWidget(const _LocalizedProbe(locale: Locale('es')));
    await tester.pumpAndSettle();

    expect(find.text('Facturas'), findsOneWidget);
    expect(find.text('Reportes'), findsOneWidget);

    await tester.pumpWidget(const _LocalizedProbe(locale: Locale('de')));
    await tester.pumpAndSettle();

    expect(find.text('Rechnungen'), findsOneWidget);
    expect(find.text('Berichte'), findsOneWidget);
  });
}

class _LocalizedProbe extends StatelessWidget {
  const _LocalizedProbe({required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Builder(
        builder: (context) {
          final t = AppLocalizations.of(context);
          return Scaffold(
            body: Column(children: [Text(t.invoices), Text(t.reports)]),
          );
        },
      ),
    );
  }
}
