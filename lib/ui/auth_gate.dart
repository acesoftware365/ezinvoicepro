import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezinvoice/services/ads/ads_manager.dart';
import 'package:ezinvoice/services/purchases/subscription_manager.dart';
import 'package:ezinvoice/ui/login_screen.dart';
import 'package:ezinvoice/ui/shell/responsive_main_shell.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _iapStarted = false;

  Future<void> _startIapOnce() async {
    if (_iapStarted) return;
    _iapStarted = true;

    try {
      await SubscriptionManager.instance.init();
      // init() loads products/listens to purchases. Restore runs only when the
      // user taps Restore Purchases so a store-level restore cannot unlock a
      // different Firebase account on this device.
    } catch (_) {
      // no rompas el login/home si IAP falla
    }
  }

  bool _isProFromUserDoc(Map<String, dynamic> data) {
    final plan = (data['plan'] ?? 'free').toString().toLowerCase().trim();
    return data['isPro'] == true ||
        plan == 'pro' ||
        plan == 'premium' ||
        plan == 'paid';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;
        if (user == null) return LoginScreen();

        SubscriptionManager.instance.setCurrentUserEmail(user.email);

        // ✅ Inicia IAP al entrar (una sola vez), sin restore automatico.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _startIapOnce();
        });

        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .snapshots(),
          builder: (context, userDoc) {
            final data = userDoc.data?.data() ?? const <String, dynamic>{};
            final isPro = _isProFromUserDoc(data);
            final proPlan = (data['proPlan'] ?? '').toString();

            // ✅ Usar post-frame para evitar setState durante build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SubscriptionManager.instance.syncFromBackend(
                isPro: isPro,
                proPlan: proPlan,
              );
              AdsManager.instance.setAdsEnabled(!isPro);
            });

            return const ResponsiveMainShell();
          },
        );
      },
    );
  }
}
