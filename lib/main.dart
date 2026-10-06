import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'package:ezinvoice/ui/auth_gate.dart';
import 'package:ezinvoice/ui/shell/app_shell.dart';

import 'services/ads/ads_manager.dart';
import 'services/app_update/force_update_gate.dart';
import 'services/purchases/subscription_manager.dart';

import 'settings/locale_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 0) Locale
  await LocaleController.instance.load();

  // 1) Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAnalytics.instance.logAppOpen();

  // 2) Ads
  await AdsManager.instance.init();

  // 3) Subs
  await SubscriptionManager.instance.init();

  // 4) Pro ↔ Ads
  SubscriptionManager.instance.state.addListener(() {
    final isPro = SubscriptionManager.instance.state.value.isPro;
    AdsManager.instance.setAdsEnabled(!isPro);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const _brandGreen = Color(0xFF1F7A64);
  static const _pageBackground = Color(0xFFF5F7F8);

  ThemeData _theme() {
    final colors =
        ColorScheme.fromSeed(
          seedColor: _brandGreen,
          brightness: Brightness.light,
        ).copyWith(
          primary: _brandGreen,
          secondary: _brandGreen,
          surface: Colors.white,
          surfaceContainerLowest: Colors.white,
          surfaceContainerLow: Colors.white,
          surfaceContainer: Colors.white,
          surfaceContainerHigh: Colors.white,
          surfaceContainerHighest: Colors.white,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colors,
      scaffoldBackgroundColor: _pageBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: LocaleController.instance,
      builder: (context, _) {
        debugPrint('APP LOCALE => ${LocaleController.instance.locale}');
        final navigatorObservers = Firebase.apps.isEmpty
            ? <NavigatorObserver>[]
            : <NavigatorObserver>[
                FirebaseAnalyticsObserver(
                  analytics: FirebaseAnalytics.instance,
                ),
              ];
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _theme(),
          locale: LocaleController.instance.locale,
          navigatorObservers: navigatorObservers,

          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          home: const ForceUpdateGate(child: AppShell(home: AuthGate())),
        );
      },
    );
  }
}
