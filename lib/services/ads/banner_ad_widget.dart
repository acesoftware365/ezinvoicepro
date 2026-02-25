import 'package:ezinvoice/services/ads/ads_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  bool _startedTick = false;

  @override
  void initState() {
    super.initState();

    // Asegura init + load banner (solo Free)
    _safeInitAndLoad();
  }

  Future<void> _safeInitAndLoad() async {
    await AdsManager.instance.init();
    AdsManager.instance.loadBanner();
    _tickUntilReady();
  }

  void _tickUntilReady() async {
    if (_startedTick) return;
    _startedTick = true;

    // Espera hasta que el banner esté listo o se apaguen ads
    while (mounted &&
        AdsManager.instance.adsEnabled &&
        !AdsManager.instance.bannerReady) {
      await Future.delayed(const Duration(milliseconds: 250));
    }

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ads = AdsManager.instance;

    if (!ads.adsEnabled) return const SizedBox.shrink();

    final BannerAd? banner = ads.bannerAd;
    if (!ads.bannerReady || banner == null) return const SizedBox.shrink();

    return SafeArea(
      top: false,
      child: SizedBox(
        width: banner.size.width.toDouble(),
        height: banner.size.height.toDouble(),
        child: AdWidget(ad: banner),
      ),
    );
  }

  @override
  void dispose() {
    // NO hacemos dispose del banner aquí porque es GLOBAL (lo maneja AdsManager)
    super.dispose();
  }
}
