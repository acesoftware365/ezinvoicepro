import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  LocaleController._();

  static final LocaleController instance = LocaleController._();

  static const _kPrefKey = 'app_locale'; // 'system' o 'en','es',...

  Locale? _locale;
  Locale? get locale => _locale;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_kPrefKey);

    if (code == null || code.isEmpty || code == 'system') {
      _locale = null; // sistema
    } else {
      _locale = Locale(code);
    }
    notifyListeners();
  }

  Future<void> setLocale(Locale? locale) async {
    _locale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.setString(_kPrefKey, 'system');
    } else {
      await prefs.setString(_kPrefKey, locale.languageCode);
    }
  }

  Future<void> setSystem() => setLocale(null);
}
