import 'dart:async';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/models/business_profile.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:ezinvoice/ui/business/business_profile_screen.dart';
import 'package:ezinvoice/ui/business/profile_autosave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MemoryProfileRepository extends BusinessProfileRepository {
  Map<String, dynamic> data = const BusinessProfile(
    businessName: 'Testing Company with a long business name',
    ownerName: 'Test Owner',
    email: 'long.email.address@example.test',
    address: '123 Example Street, Long City Name, 00001',
    servicePresets: [
      'A long service name that must wrap instead of hiding its actions',
    ],
  ).toMap();
  final writes = <Map<String, dynamic>>[];
  bool fail = false;
  @override
  Future<BusinessProfile> load() async => BusinessProfile.fromMap(data);
  @override
  Future<void> updateFields(Map<String, dynamic> fields) async {
    writes.add(Map.of(fields));
    if (fail) throw StateError('offline');
    data.addAll(fields);
  }
}

Widget harness(
  MemoryProfileRepository repo, {
  double scale = 1,
  double keyboard = 0,
}) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(
      textScaler: TextScaler.linear(scale),
      viewInsets: EdgeInsets.only(bottom: keyboard),
    ),
    child: child!,
  ),
  home: BusinessProfileScreen(repository: repo),
);

void main() {
  test(
    'older acknowledgements cannot erase newer edits and failed writes retry',
    () async {
      final requests = <Completer<void>>[];
      final values = <Map<String, dynamic>>[];
      final save = ProfileAutosave((fields) {
        values.add(fields);
        final c = Completer<void>();
        requests.add(c);
        return c.future;
      }, delay: const Duration(days: 1));
      save.change({'businessName': 'First'});
      final first = save.flush();
      save.change({'businessName': 'Latest', 'phone': '123'});
      final second = save.flush();
      requests[0].complete();
      await first;
      expect(save.hasPending, isTrue);
      requests[1].completeError(StateError('offline'));
      await second;
      expect(save.hasError, isTrue);
      expect(save.hasPending, isTrue);
      final retry = save.flush();
      expect(values.last['businessName'], 'Latest');
      requests[2].complete();
      await retry;
      expect(save.hasPending, isFalse);
      save.dispose();
    },
  );

  test(
    'disposal flushes the final edit without waiting for debounce',
    () async {
      final writes = <Map<String, dynamic>>[];
      final save = ProfileAutosave((fields) async => writes.add(fields));
      save.change({'footerNote': 'Last character'});
      save.dispose();
      await Future<void>.delayed(Duration.zero);
      expect(writes.single['footerNote'], 'Last character');
    },
  );

  for (final size in [
    const Size(320, 568),
    const Size(390, 844),
    const Size(844, 390),
    const Size(466, 678),
    const Size(678, 466),
    const Size(951, 669),
    const Size(1024, 1366),
  ]) {
    for (final scale in [1.0, 2.0]) {
      testWidgets('layout $size at $scale text scale', (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = size;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final repo = MemoryProfileRepository();
        await tester.pumpWidget(harness(repo, scale: scale));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.ensureVisible(find.byKey(const ValueKey('edit-business')));
        await tester.tap(find.byKey(const ValueKey('edit-business')));
        await tester.pumpAndSettle();
        await tester.pumpWidget(
          harness(repo, scale: scale, keyboard: size.height * .4),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        final close = tester.getRect(
          find.byKey(const ValueKey('close-editor')),
        );
        expect(close.bottom, lessThanOrEqualTo(size.height * .6));
        await tester.tap(find.byKey(const ValueKey('close-editor')));
        await tester.pumpAndSettle();
        await tester.pumpWidget(harness(repo, scale: scale));
        await tester.pumpAndSettle();
        await tester.drag(
          find.byKey(const PageStorageKey('business-profile-scroll')),
          const Offset(0, -2400),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.byType(FloatingActionButton), findsNothing);
      });
    }
  }

  testWidgets(
    'autosaves fields, preserves edits across resize and close, and reloads',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(466, 678);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final repo = MemoryProfileRepository();
      await tester.pumpWidget(harness(repo));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const ValueKey('edit-business')));
      await tester.tap(find.byKey(const ValueKey('edit-business')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('field-businessName')),
        'Automatically saved',
      );
      tester.view.physicalSize = const Size(951, 669);
      await tester.pumpAndSettle();
      expect(find.text('Automatically saved'), findsWidgets);
      await tester.tap(find.byKey(const ValueKey('close-editor')));
      await tester.pumpAndSettle();
      expect(repo.data['businessName'], 'Automatically saved');
      expect(repo.writes.last.keys, ['businessName']);
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      await tester.pumpWidget(harness(repo));
      await tester.pumpAndSettle();
      expect(find.text('Automatically saved'), findsOneWidget);
    },
  );

  testWidgets(
    'service editor keeps live changes on dismissal and deletion autosaves',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1024, 1366);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final repo = MemoryProfileRepository();
      await tester.pumpWidget(harness(repo));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('add-service')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('service-editor')),
        'New service',
      );
      await tester.tap(find.byKey(const ValueKey('close-editor')));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 500));
      expect(repo.data['servicePresets'], contains('New service'));
      expect(find.text('New service'), findsOneWidget);
      await tester.tap(find.byTooltip('Delete').last);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 600));
      expect(repo.data['servicePresets'], isNot(contains('New service')));
    },
  );

  testWidgets('new currency selection autosaves and survives reopening', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1024, 1366);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final repo = MemoryProfileRepository();
    await tester.pumpWidget(harness(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('edit-defaults')));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CAD').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('close-editor')));
    await tester.pumpAndSettle();
    expect(repo.data['currencyCode'], 'CAD');
    await tester.tap(find.byKey(const ValueKey('edit-defaults')));
    await tester.pumpAndSettle();
    expect(find.text('CAD'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'invalid tax is not silently saved as zero; other edits still save',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1024, 1366);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final repo = MemoryProfileRepository();
      repo.data['defaultTaxRate'] = 8.36;
      await tester.pumpWidget(harness(repo));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('edit-defaults')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('field-defaultTaxRate')),
        'invalid',
      );
      await tester.pump(const Duration(milliseconds: 600));
      expect(repo.data['defaultTaxRate'], 8.36);
      expect(repo.writes, isEmpty);
      await tester.enterText(
        find.byKey(const ValueKey('field-defaultTaxRate')),
        '9,25',
      );
      await tester.pump(const Duration(milliseconds: 600));
      expect(repo.data['defaultTaxRate'], 9.25);
      await tester.tap(find.byKey(const ValueKey('close-editor')));
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'failed saves stay editable and retry persists the latest value',
    (tester) async {
      final repo = MemoryProfileRepository()..fail = true;
      await tester.pumpWidget(harness(repo));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('edit-business')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('field-businessName')),
        'Retained edit',
      );
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('close-editor')));
      await tester.pumpAndSettle();
      expect(find.text('Retained edit'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      repo.fail = false;
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(repo.data['businessName'], 'Retained edit');
      expect(find.text('Saved automatically'), findsOneWidget);
    },
  );

  testWidgets('logo removal and footer edits persist without a save button', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1024, 1366);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final repo = MemoryProfileRepository();
    // Malformed legacy image still permits removing its persisted metadata.
    repo.data['logoDataBase64'] = 'bad legacy image';
    repo.data['logoFilePath'] = '/old/logo.png';
    await tester.pumpWidget(harness(repo));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(repo.data['logoFilePath'], isNull);
    expect(repo.data['logoDataBase64'], isNull);
    await tester.ensureVisible(find.byKey(const ValueKey('edit-footer')));
    await tester.tap(find.byKey(const ValueKey('edit-footer')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('field-footerNote')),
      'Thank you!',
    );
    await tester.tap(find.byKey(const ValueKey('close-editor')));
    await tester.pumpAndSettle();
    expect(repo.data['footerNote'], 'Thank you!');
    expect(repo.data['invoicePaletteId'], 'minimal');
  });
}
