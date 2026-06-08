import 'dart:async';

import 'package:ezinvoice/services/ads/ads_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Anchored adaptive banner ready to drop into existing screens.
///
/// The widget asks AdMob for the best height for the current screen width and
/// only takes space in the UI after the ad has loaded successfully.
class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  AdSize? _adSize;
  Timer? _retryTimer;
  int? _loadedForWidth;
  bool _isLoading = false;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadForCurrentWidth();
  }

  Future<void> _loadForCurrentWidth() async {
    if (!AdsManager.instance.adsEnabled || _isLoading) return;

    final width = MediaQuery.sizeOf(context).width.truncate();
    if (width <= 0 || (_loadedForWidth == width && _bannerAd != null)) return;

    _isLoading = true;
    _retryTimer?.cancel();
    _disposeCurrentBanner();

    await AdsManager.instance.init();
    if (!mounted || !AdsManager.instance.adsEnabled) {
      _isLoading = false;
      return;
    }

    final adaptiveSize =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width);
    if (!mounted) {
      _isLoading = false;
      return;
    }

    if (adaptiveSize == null) {
      _isLoading = false;
      _scheduleRetry();
      return;
    }

    final banner = BannerAd(
      adUnitId: AdsManager.instance.bannerAdUnitId,
      size: adaptiveSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }

          setState(() {
            _bannerAd = ad as BannerAd;
            _adSize = adaptiveSize;
            _loadedForWidth = width;
            _isLoaded = true;
            _isLoading = false;
          });

          if (kDebugMode) {
            debugPrint(
              'Adaptive banner loaded: ${adaptiveSize.width}x${adaptiveSize.height}',
            );
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();

          if (mounted) {
            setState(() {
              _bannerAd = null;
              _adSize = null;
              _isLoaded = false;
              _isLoading = false;
            });
            _scheduleRetry();
          }

          if (kDebugMode) {
            debugPrint('Adaptive banner failed to load: $error');
          }
        },
      ),
    );

    await banner.load();
  }

  void _scheduleRetry() {
    _retryTimer?.cancel();
    _retryTimer = Timer(const Duration(seconds: 30), () {
      if (mounted) _loadForCurrentWidth();
    });
  }

  void _disposeCurrentBanner() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _adSize = null;
    _isLoaded = false;
    _loadedForWidth = null;
  }

  @override
  Widget build(BuildContext context) {
    final banner = _bannerAd;
    final size = _adSize;

    if (!AdsManager.instance.adsEnabled ||
        !_isLoaded ||
        banner == null ||
        size == null) {
      return const SizedBox.shrink();
    }

    return SafeArea(
      top: false,
      child: SizedBox(
        width: size.width.toDouble(),
        height: size.height.toDouble(),
        child: AdWidget(ad: banner),
      ),
    );
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    _disposeCurrentBanner();
    super.dispose();
  }
}
