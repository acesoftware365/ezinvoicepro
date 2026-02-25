import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ✅ ADD: SubscriptionManager
import 'package:ezinvoice/services/purchases/subscription_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String _forcedVersionText = 'v1.0.0 (23)';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLogin = true;
  bool _loading = false;
  String _versionText = _forcedVersionText;

  // ✅ Brand color (EzInvoice green)
  static const Color brandGreen = Color(0xFF1F6E5C);
  static const String _reviewDemoEmail = 'demo.review@liisgo.com';
  static const String _legacyReviewDemoEmail = 'demo@invoiceapp.test';
  static const String _reviewDemoPassword = 'Demo1234!';

  @override
  void initState() {
    super.initState();
    _versionText = _forcedVersionText;
  }

  // 🔹 helper YYYY-MM
  String _monthKey(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    return '$y-$m';
  }

  void _showMessage(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // 🔹 create / ensure user doc
  Future<void> _ensureUserDoc(User user) async {
    final ref = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final existing = await ref.get();
    final isDemoReview = _isDemoReviewEmail(user.email ?? '');

    if (!existing.exists) {
      await ref.set({
        'createdAt': FieldValue.serverTimestamp(),
        'email': user.email,
        'plan': isDemoReview ? 'pro' : 'free',
        'isPro': isDemoReview,
        'proPlan': isDemoReview ? 'monthly' : 'none',
        'planUpdatedAt': FieldValue.serverTimestamp(),
        'freeMonthlyInvoiceLimit': 20,
        'freeInvoicesCreatedThisMonth': 0,
        'freeMonthKey': _monthKey(DateTime.now()),
        'business': {
          'name': '',
          'phone': '',
          'email': user.email ?? '',
          'address': '',
          'logoUrl': '',
        },
        'defaults': {'currency': 'USD', 'taxRate': 6.35, 'tipEnabled': true},
        'invoiceStyle': {
          'templateId': 'minimal',
          'primaryColor': '#1F6E5C',
          'accentColor': '#1F6E5C',
        },
      }, SetOptions(merge: true));
      return;
    }

    // Usuario existente: no pisar plan/isPro/proPlan.
    await ref.set({
      'email': user.email,
      'lastLoginAt': FieldValue.serverTimestamp(),
      if (isDemoReview) ...{
        'plan': 'pro',
        'isPro': true,
        'proPlan': 'monthly',
        'planUpdatedAt': FieldValue.serverTimestamp(),
      },
    }, SetOptions(merge: true));
  }

  Future<void> _submit() async {
    final t = AppLocalizations.of(context);
    final emailInput = _emailController.text.trim();
    final email = _normalizeDemoEmail(emailInput);
    final pass = _passwordController.text.trim();

    if (email.isEmpty || pass.length < 6) {
      _showMessage(t.invalidCredentials);
      return;
    }

    setState(() => _loading = true);

    try {
      final cred = await _authenticate(
        email: email,
        pass: pass,
        isLogin: _isLogin,
      );

      // ✅ Ensure user doc
      await _ensureUserDoc(cred.user!);

      // ✅ Vincula usuario actual al manager y prepara IAP/restore.
      SubscriptionManager.instance.setCurrentUserEmail(cred.user?.email);
      await SubscriptionManager.instance.init();

      // ✅ No navego aquí porque normalmente tu app usa authStateChanges wrapper
      // Si tú navegas manualmente, aquí sería el lugar para Navigator.pushReplacement(...)
    } on FirebaseAuthException catch (e) {
      _showMessage(e.message ?? t.authError);
    } catch (e) {
      _showMessage('Error: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _normalizeDemoEmail(String email) {
    final lower = email.trim().toLowerCase();
    if (lower == _legacyReviewDemoEmail) return _reviewDemoEmail;
    return lower;
  }

  bool _isDemoReviewEmail(String email) {
    final lower = email.trim().toLowerCase();
    return lower == _reviewDemoEmail || lower == _legacyReviewDemoEmail;
  }

  bool _isReviewDemoCredential(String email, String pass) {
    return email.toLowerCase() == _reviewDemoEmail &&
        pass == _reviewDemoPassword;
  }

  Future<UserCredential> _authenticate({
    required String email,
    required String pass,
    required bool isLogin,
  }) async {
    if (!isLogin) {
      return FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
    }

    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException {
      final isDemo = _isReviewDemoCredential(email, pass);
      if (!isDemo) rethrow;

      try {
        return await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );
      } on FirebaseAuthException catch (createError) {
        if (createError.code == 'email-already-in-use') {
          return FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: pass,
          );
        }
        rethrow;
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),

                  // ✅ LOGO
                  Center(
                    child: Image.asset(
                      'assets/EzInvoice Icon.png',
                      height: 72,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ✅ APP NAME (GREEN)
                  Text(
                    t.appName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: brandGreen,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ✅ SUBTITLE
                  Text(
                    t.loginSubtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),

                  const SizedBox(height: 28),

                  // 🔹 Email
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: t.email,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 🔹 Password
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: t.password,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // 🔹 Button
                  ElevatedButton(
                    onPressed: _loading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brandGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      _loading
                          ? t.processing
                          : (_isLogin ? t.login : t.register),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // 🔹 Switch login/register
                  TextButton(
                    onPressed: _loading
                        ? null
                        : () => setState(() => _isLogin = !_isLogin),
                    child: Text(
                      _isLogin
                          ? '${t.dontHaveAccount} → ${t.signUp}'
                          : '${t.alreadyHaveAccount} → ${t.signIn}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    _versionText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
