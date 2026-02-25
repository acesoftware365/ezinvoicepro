import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionService {
  static const _kIsProKey = 'is_pro';

  static bool _isPro = false;
  static bool get isPro => _isPro;

  /// Cargar estado al iniciar la app
  static Future<void> loadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isPro = prefs.getBool(_kIsProKey) ?? false;
  }

  /// Simula compra (por ahora). Luego aquí conectas RevenueCat / Billing.
  static Future<void> unlockPro() async {
    final prefs = await SharedPreferences.getInstance();
    _isPro = true;
    await prefs.setBool(_kIsProKey, true);
  }

  /// Para pruebas (reset)
  static Future<void> lockFree() async {
    final prefs = await SharedPreferences.getInstance();
    _isPro = false;
    await prefs.setBool(_kIsProKey, false);
  }
}
