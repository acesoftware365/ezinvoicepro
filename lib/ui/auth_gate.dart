import 'package:ezinvoice/services/purchases/subscription_manager.dart';
import 'package:ezinvoice/ui/home_screen.dart';
import 'package:ezinvoice/ui/login_screen.dart';
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
      // init() ya hace loadProducts + restorePurchases en tu manager
    } catch (_) {
      // no rompas el login/home si IAP falla
    }
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

        // ✅ Inicia IAP al entrar (una sola vez)
        _startIapOnce();

        return const HomeScreen();
      },
    );
  }
}
