import 'dart:convert';
import 'dart:io';

import 'package:ezinvoice/features/privacy/legal_content.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const locales = ['ar', 'de', 'en', 'es', 'fr', 'hi', 'ja', 'pt', 'ru', 'zh'];
  const l10nDirectory = 'lib/l10n/app';

  Map<String, dynamic> readArb(String locale) {
    final source = File('$l10nDirectory/app_$locale.arb').readAsStringSync();
    return jsonDecode(source) as Map<String, dynamic>;
  }

  test('every supported locale has the full localized message catalog', () {
    final english = readArb('en');
    final expectedKeys = english.keys.where((key) => key != '@@locale').toSet();

    for (final locale in locales.where((locale) => locale != 'en')) {
      final catalog = readArb(locale);
      final keys = catalog.keys.where((key) => key != '@@locale').toSet();

      expect(
        keys,
        expectedKeys,
        reason: '$locale must include every English localization key.',
      );

      for (final key in expectedKeys.where((key) => !key.startsWith('@'))) {
        final value = catalog[key];
        expect(
          value,
          isA<String>(),
          reason: '$locale:$key must be a localized string.',
        );
        expect(
          (value as String).trim(),
          isNotEmpty,
          reason: '$locale:$key must not be empty.',
        );
      }
    }
  });

  test('privacy and terms content is available for every supported locale', () {
    for (final languageCode in locales) {
      final content = LegalContent.forLocale(Locale(languageCode));
      expect(content.privacy.title.trim(), isNotEmpty);
      expect(content.terms.title.trim(), isNotEmpty);
      expect(content.privacy.sections, hasLength(13));
      expect(content.terms.sections, hasLength(8));
      for (final section in [
        ...content.privacy.sections,
        ...content.terms.sections,
      ]) {
        expect(section.title.trim(), isNotEmpty);
        expect(section.body.trim(), isNotEmpty);
      }
    }
  });
}
