import 'package:ezinvoice/services/ads/ads_manager.dart';
import 'package:ezinvoice/services/ads/banner_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Shell global para poner el banner UNA sola vez.
/// Envuelve cualquier pantalla.
/// - Free => muestra banner
/// - Pro  => no muestra nada
class AdsShell extends StatelessWidget {
  final Widget child;
  final Widget? bottomBar; // opcional: si quieres botones abajo (privacy, nav, etc.)

  const AdsShell({
    super.key,
    required this.child,
    this.bottomBar,
  });

  bool _isPro(String plan) {
    final p = plan.toLowerCase().trim();
    return p == 'pro' || p == 'premium' || p == 'paid';
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Si no hay usuario, no ads
      AdsManager.instance.setAdsEnabled(false);
      return Scaffold(body: child, bottomNavigationBar: bottomBar);
    }

    final ref = FirebaseFirestore.instance.collection('users').doc(user.uid);

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ref.snapshots(),
      builder: (context, snap) {
        final data = snap.data?.data() ?? {};
        final plan = (data['plan'] ?? 'free').toString();
        final isPro = _isPro(plan);

        // ✅ activar/desactivar Ads según plan
        // Free => true, Pro => false
        AdsManager.instance.init(); // safe (no-op si ya está)
        AdsManager.instance.setAdsEnabled(!isPro);

        return Scaffold(
          body: child,

          // ✅ Banner global + bottomBar (si tienes)
          bottomNavigationBar: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ✅ SOLO 1 BANNER EN TODA LA APP (aquí)
                const BannerAdWidget(),

                // ✅ tu barra/botones abajo si aplica
                if (bottomBar != null) bottomBar!,
              ],
            ),
          ),
        );
      },
    );
  }
}
