import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Razones (momentos) en los que SÍ permitimos interstitial.
/// Evita poner interstitial cuando el usuario está creando/editando una factura.
enum InterstitialReason {
  afterInvoiceSent,
  afterPdfPreviewClosed,
  afterReportClosed,
}

enum RewardType {
  removePdfBrandingOnce,
  unlockPremiumTemplateOnce,
  exportReportOnce,
  exportCsvOnce,
  viewMonthlyTaxReportDetailedOnce,
  proMessageTemplateOnce,
}

/// IDs de prueba oficiales de Google (Android/iOS).
/// Cambia a IDs reales antes de publicar.
class AdUnitIds {
  // -----------------
  // TEST (Google oficial)
  // -----------------
  // Android test
  static const _androidBannerTest = 'ca-app-pub-3940256099942544/6300978111';
  static const _androidInterstitialTest =
      'ca-app-pub-3940256099942544/1033173712';
  static const _androidRewardedTest = 'ca-app-pub-3940256099942544/5224354917';

  // iOS test
  static const _iosBannerTest = 'ca-app-pub-3940256099942544/2934735716';
  static const _iosInterstitialTest = 'ca-app-pub-3940256099942544/4411468910';
  static const _iosRewardedTest = 'ca-app-pub-3940256099942544/1712485313';

  // -----------------
  // PRODUCCIÓN (Tus IDs reales)
  // -----------------
  // ✅ ANDROID PROD (reales)
  static const _androidBannerProd = 'ca-app-pub-8588489900323524/6208483338';
  static const _androidInterstitialProd =
      'ca-app-pub-8588489900323524/8144381530';
  static const _androidRewardedProd = 'ca-app-pub-8588489900323524/2016605814';

  // ✅ iOS PROD (reales)  ✅✅✅ (CAMBIADOS)
  static const _iosBannerProd = 'ca-app-pub-8588489900323524/4776778326';
  static const _iosInterstitialProd = 'ca-app-pub-8588489900323524/4732546298';
  static const _iosRewardedProd = 'ca-app-pub-8588489900323524/1228415557';

  // -----------------
  // GETTERS (auto debug/release)
  // -----------------
  static String get banner => kDebugMode
      ? (Platform.isIOS ? _iosBannerTest : _androidBannerTest)
      : (Platform.isIOS ? _iosBannerProd : _androidBannerProd);

  static String get interstitial => kDebugMode
      ? (Platform.isIOS ? _iosInterstitialTest : _androidInterstitialTest)
      : (Platform.isIOS ? _iosInterstitialProd : _androidInterstitialProd);

  static String get rewarded => kDebugMode
      ? (Platform.isIOS ? _iosRewardedTest : _androidRewardedTest)
      : (Platform.isIOS ? _iosRewardedProd : _androidRewardedProd);

  // (Opcional) si todavía quieres tener acceso explícito a test:
  static String get bannerTest =>
      Platform.isIOS ? _iosBannerTest : _androidBannerTest;
  static String get interstitialTest =>
      Platform.isIOS ? _iosInterstitialTest : _androidInterstitialTest;
  static String get rewardedTest =>
      Platform.isIOS ? _iosRewardedTest : _androidRewardedTest;
}

/// Configuración central de Ads.
/// - Banner: en pantallas pasivas (home/listas/settings)
/// - Interstitial: SOLO después de acciones (post-event), con cooldown
/// - Rewarded: para desbloqueos 1-uso
class AdsManager {
  AdsManager._();
  static final AdsManager instance = AdsManager._();

  bool _initialized = false;

  /// Si es PRO, pon esto en false desde fuera.
  bool _adsEnabled = true;
  bool get adsEnabled => _adsEnabled;

  void setAdsEnabled(bool enabled) {
    _adsEnabled = enabled;
    if (!enabled) {
      disposeBanner();
      _disposeInterstitial();
      _disposeRewarded();
    } else {
      // si se vuelven a activar (ej. usuario pierde pro / expira),
      // precargamos nuevamente
      if (_initialized) {
        loadInterstitial();
        loadRewarded();
      }
    }
  }

  /// ✅ FIX: IDs auto por modo (debug -> TEST, release -> PROD)
  String bannerAdUnitId = AdUnitIds.banner;
  String interstitialAdUnitId = AdUnitIds.interstitial;
  String rewardedAdUnitId = AdUnitIds.rewarded;

  // -------------------------
  // BANNER (GLOBAL)
  // -------------------------
  BannerAd? _bannerAd;
  bool _bannerReady = false;
  bool get bannerReady => _bannerReady;
  BannerAd? get bannerAd => _bannerAd;

  // -------------------------
  // INTERSTITIAL
  // -------------------------
  InterstitialAd? _interstitialAd;
  bool _interstitialReady = false;

  // -------------------------
  // REWARDED
  // -------------------------
  RewardedAd? _rewardedAd;
  bool _rewardedReady = false;

  // -------------------------
  // COOLDOWNS (para no molestar)
  // -------------------------
  DateTime? _lastInterstitialShownAt;
  DateTime? _lastInterstitialAttemptAt;

  /// Ajusta a tu gusto
  Duration interstitialCooldown = const Duration(seconds: 120); // 2 min
  Duration interstitialMinAttemptGap = const Duration(
    seconds: 20,
  ); // evita spam attempts

  /// Frecuencia por “razón”: ej. mostrar 1 de cada 3 envíos
  final Map<InterstitialReason, int> _reasonCounters = {
    InterstitialReason.afterInvoiceSent: 0,
    InterstitialReason.afterPdfPreviewClosed: 0,
    InterstitialReason.afterReportClosed: 0,
  };

  final Map<InterstitialReason, int> interstitialEveryN = {
    InterstitialReason.afterInvoiceSent: 3,
    InterstitialReason.afterPdfPreviewClosed: 3,
    InterstitialReason.afterReportClosed: 2,
  };

  Future<void> init() async {
    if (_initialized) return;
    await MobileAds.instance.initialize();
    _initialized = true;

    if (_adsEnabled) {
      // Precarga
      loadInterstitial();
      loadRewarded();
    }
  }

  // -------------------------
  // BANNER
  // -------------------------
  void loadBanner({AdSize size = AdSize.banner}) {
    if (!_initialized || !_adsEnabled) return;

    // Si ya existe, no recrear
    if (_bannerAd != null) return;

    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _bannerReady = true;
          if (kDebugMode) debugPrint('✅ Banner cargado');
        },
        onAdFailedToLoad: (ad, err) {
          _bannerReady = false;
          if (kDebugMode) debugPrint('❌ Banner falló: $err');
          ad.dispose();
          _bannerAd = null;

          // Reintento suave
          Future.delayed(const Duration(seconds: 30), () {
            if (_adsEnabled) loadBanner(size: size);
          });
        },
      ),
    );

    _bannerAd!.load();
  }

  void disposeBanner() {
    _bannerReady = false;
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  // -------------------------
  // INTERSTITIAL
  // -------------------------
  void loadInterstitial() {
    if (!_initialized || !_adsEnabled) return;
    if (_interstitialReady || _interstitialAd != null) return;

    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialReady = true;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (_) {
              _lastInterstitialShownAt = DateTime.now();
              if (kDebugMode) debugPrint('📺 Interstitial mostrado');
            },
            onAdDismissedFullScreenContent: (ad) {
              if (kDebugMode) debugPrint('✅ Interstitial cerrado');
              ad.dispose();
              _disposeInterstitial();
              Future.delayed(const Duration(seconds: 2), loadInterstitial);
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              if (kDebugMode) debugPrint('❌ Interstitial no mostró: $err');
              ad.dispose();
              _disposeInterstitial();
              Future.delayed(const Duration(seconds: 10), loadInterstitial);
            },
          );
        },
        onAdFailedToLoad: (err) {
          if (kDebugMode) debugPrint('❌ Interstitial falló: $err');
          _disposeInterstitial();
          Future.delayed(const Duration(seconds: 30), loadInterstitial);
        },
      ),
    );
  }

  void _disposeInterstitial() {
    _interstitialReady = false;
    _interstitialAd?.dispose();
    _interstitialAd = null;
  }

  bool _cooldownOk() {
    if (_lastInterstitialShownAt == null) return true;
    return DateTime.now().difference(_lastInterstitialShownAt!) >=
        interstitialCooldown;
  }

  bool _attemptGapOk() {
    if (_lastInterstitialAttemptAt == null) return true;
    return DateTime.now().difference(_lastInterstitialAttemptAt!) >=
        interstitialMinAttemptGap;
  }

  bool _frequencyOk(InterstitialReason reason) {
    _reasonCounters[reason] = (_reasonCounters[reason] ?? 0) + 1;
    final n = interstitialEveryN[reason] ?? 3;
    return (_reasonCounters[reason]! % n) == 0;
  }

  /// Llama esto SOLO después de una acción (ej. envío completado).
  Future<bool> tryShowInterstitial(InterstitialReason reason) async {
    if (!_initialized || !_adsEnabled) return false;

    // No spamear intentos
    if (!_attemptGapOk()) return false;
    _lastInterstitialAttemptAt = DateTime.now();

    // Cooldown global
    if (!_cooldownOk()) return false;

    // Frecuencia por razón (1 de cada N)
    if (!_frequencyOk(reason)) return false;

    // Asegurar que está cargado
    if (!_interstitialReady || _interstitialAd == null) {
      loadInterstitial();
      return false;
    }

    await _interstitialAd!.show();
    return true;
  }

  // -------------------------
  // REWARDED
  // -------------------------
  void loadRewarded() {
    if (!_initialized || !_adsEnabled) return;
    if (_rewardedReady || _rewardedAd != null) return;

    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _rewardedReady = true;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              if (kDebugMode) debugPrint('✅ Rewarded cerrado');
              ad.dispose();
              _disposeRewarded();
              Future.delayed(const Duration(seconds: 2), loadRewarded);
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              if (kDebugMode) debugPrint('❌ Rewarded no mostró: $err');
              ad.dispose();
              _disposeRewarded();
              Future.delayed(const Duration(seconds: 10), loadRewarded);
            },
          );
        },
        onAdFailedToLoad: (err) {
          if (kDebugMode) debugPrint('❌ Rewarded falló: $err');
          _disposeRewarded();
          Future.delayed(const Duration(seconds: 30), loadRewarded);
        },
      ),
    );
  }

  void _disposeRewarded() {
    _rewardedReady = false;
    _rewardedAd?.dispose();
    _rewardedAd = null;
  }

  /// Muestra rewarded y llama onReward cuando el usuario gana la recompensa.
  Future<bool> showRewarded({
    required RewardType rewardType,
    required VoidCallback onReward,
  }) async {
    if (!_initialized || !_adsEnabled) return false;

    if (!_rewardedReady || _rewardedAd == null) {
      loadRewarded();
      return false;
    }

    final ad = _rewardedAd!;
    _rewardedAd = null;
    _rewardedReady = false;
    var rewardEarned = false;
    final completed = Completer<bool>();

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        if (kDebugMode) debugPrint('✅ Rewarded cerrado');
        ad.dispose();
        _disposeRewarded();
        Future.delayed(const Duration(seconds: 2), loadRewarded);
        if (!completed.isCompleted) completed.complete(rewardEarned);
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        if (kDebugMode) debugPrint('❌ Rewarded no mostró: $err');
        ad.dispose();
        _disposeRewarded();
        Future.delayed(const Duration(seconds: 10), loadRewarded);
        if (!completed.isCompleted) completed.complete(false);
      },
    );

    await ad.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        rewardEarned = true;
        if (kDebugMode) {
          debugPrint(
            '🎁 Reward ganado: ${rewardType.name} | ${rewardItem.amount} ${rewardItem.type}',
          );
        }
        onReward();
      },
    );

    return completed.future;
  }
}
