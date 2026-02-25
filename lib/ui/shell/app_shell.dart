import 'package:flutter/material.dart';
import 'package:ezinvoice/services/ads/ads_manager.dart';
import 'package:ezinvoice/services/ads/banner_ad_widget.dart';
import 'package:ezinvoice/services/purchases/subscription_manager.dart';

class AppShell extends StatelessWidget {
  final Widget home;

  const AppShell({
    super.key,
    required this.home,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SubscriptionState>(
      valueListenable: SubscriptionManager.instance.state,
      builder: (context, subState, _) {
        // ✅ si es Pro, no mostramos ads
        // (AdsManager.adsEnabled debe estar sincronizado con tu lógica actual)
        final adsEnabled = AdsManager.instance.adsEnabled && !subState.isPro;

        return Scaffold(
          body: Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => home,
              );
            },
          ),
          bottomNavigationBar: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (adsEnabled) const BannerAdWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
