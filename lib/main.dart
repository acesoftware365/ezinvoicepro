import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'package:ezinvoice/ui/auth_gate.dart';
import 'package:ezinvoice/ui/shell/app_shell.dart';

import 'services/ads/ads_manager.dart';
import 'services/purchases/subscription_manager.dart';

import 'settings/locale_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 0) Locale
  await LocaleController.instance.load();

  // 1) Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: LocaleController.instance,
      builder: (context, _) {
        debugPrint('APP LOCALE => ${LocaleController.instance.locale}');
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: LocaleController.instance.locale,

          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          home: const AppShell(
            home: AuthGate(),
          ),
        );
      },
    );
  }
}
