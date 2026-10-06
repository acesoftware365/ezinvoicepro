// lib/features/paywall/paywall_screen.dart

import 'dart:io';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/features/privacy/privacy_screen.dart';
import 'package:flutter/material.dart';
import '../../services/purchases/subscription_manager.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key, this.onClose});

  final VoidCallback? onClose;

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  final _sub = SubscriptionManager.instance;

  bool _busy = false;
  bool _acceptedLegal = false;

  // ✅ Brand color (EzInvoice green)
  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color pageBg = Color(0xFFF6F7F9);
  static const Color cardBorder = Color(0xFFE6EAF0);

  @override
  void initState() {
    super.initState();

    // ✅ Asegura init + productos (sin restore automatico)
    _safeInit();
  }

  Future<void> _safeInit() async {
    try {
      await _sub.init();
      await _sub.loadProducts();
    } catch (_) {
      // Silencioso
    }
    if (mounted) setState(() {});
  }

  Future<void> _runBusy(Future<void> Function() fn) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await fn();
    } catch (_) {
      if (mounted) {
        final t = AppLocalizations.of(context);
        _showSnack(t.authError); // fallback simple
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  bool _requireLegalAgreement() {
    if (_acceptedLegal) return true;
    _showSnack(
      'Please agree to the Terms & Conditions and Privacy Policy first.',
    );
    return false;
  }

  String _platformStoreName() {
    if (Platform.isIOS) return 'App Store';
    if (Platform.isAndroid) return 'Google Play';
    return 'Store';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Theme(
      // ✅ SOLO UI: tema verde para esta pantalla
      data: theme.copyWith(
        scaffoldBackgroundColor: pageBg,
        colorScheme: cs.copyWith(primary: brandGreen, secondary: brandGreen),
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: brandGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: brandGreen,
            side: const BorderSide(color: cardBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: brandGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      child: ValueListenableBuilder<SubscriptionState>(
        valueListenable: _sub.state,
        builder: (context, state, _) {
          final monthlyReady = _sub.monthlyProduct != null;
          final yearlyReady = _sub.yearlyProduct != null;
          final productsReady = monthlyReady || yearlyReady;
          final currentPlan = state.plan;
          final isCurrentMonthly =
              state.isPro && currentPlan == ProPlan.monthly;
          final isCurrentYearly = state.isPro && currentPlan == ProPlan.yearly;
          final monthlyPrice = monthlyReady
              ? (state.priceMonthly ?? r'$3.99')
              : 'Loading...';
          final yearlyPrice = yearlyReady
              ? (state.priceYearly ?? r'$29.99')
              : 'Loading...';

          return Scaffold(
            appBar: AppBar(
              title: Text(t.paywallTitle),
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: _busy
                    ? null
                    : (widget.onClose ?? () => Navigator.pop(context)),
                tooltip: t.close,
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HeaderCard(
                      title: t.paywallHeaderTitle,
                      subtitle: t.paywallHeaderSubtitle,
                      badgeText: t.bestValue,
                    ),
                    const SizedBox(height: 16),

                    _PlanStatusCard(state: state),
                    const SizedBox(height: 16),

                    _PlanComparisonCard(state: state),

                    const SizedBox(height: 16),

                    // ✅ Mensaje de estado si está procesando
                    if (_busy) ...[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(t.processing),
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (!productsReady || !monthlyReady || !yearlyReady) ...[
                      _StoreProductsNotice(
                        monthlyReady: monthlyReady,
                        yearlyReady: yearlyReady,
                      ),
                      const SizedBox(height: 12),
                    ],

                    _LegalAgreementCard(
                      accepted: _acceptedLegal,
                      onChanged: _busy
                          ? null
                          : (value) =>
                                setState(() => _acceptedLegal = value ?? false),
                    ),
                    const SizedBox(height: 12),

                    // Planes
                    _PlanCard(
                      title: t.proYearly,
                      price: yearlyPrice,
                      tag: t.bestValueStar,
                      description: t.saveMoreYearly,
                      emphasized: true,
                      enabled:
                          !_busy &&
                          yearlyReady &&
                          !isCurrentYearly &&
                          _acceptedLegal,
                      buttonText: isCurrentYearly
                          ? 'Current plan'
                          : t.continueWithPlan(t.proYearly),
                      onPressed: () => _runBusy(() async {
                        if (!_requireLegalAgreement()) return;
                        await _sub.buyYearly();
                        _showSnack(t.processingPurchase);
                      }),
                    ),
                    const SizedBox(height: 12),
                    _PlanCard(
                      title: t.proMonthly,
                      price: monthlyPrice,
                      tag: t.flexible,
                      description: t.cancelAnytime,
                      emphasized: false,
                      enabled:
                          !_busy &&
                          monthlyReady &&
                          !isCurrentMonthly &&
                          _acceptedLegal,
                      buttonText: isCurrentMonthly
                          ? 'Current plan'
                          : t.continueWithPlan(t.proMonthly),
                      onPressed: () => _runBusy(() async {
                        if (!_requireLegalAgreement()) return;
                        await _sub.buyMonthly();
                        _showSnack(t.processingPurchase);
                      }),
                    ),

                    const SizedBox(height: 16),

                    // Restaurar
                    OutlinedButton.icon(
                      onPressed: _busy
                          ? null
                          : () => _runBusy(() async {
                              await _sub.restorePurchases();
                              _showSnack(t.restoringPurchases);
                            }),
                      icon: const Icon(Icons.restore),
                      label: Text(t.restorePurchases),
                    ),

                    const SizedBox(height: 10),

                    // Seguir gratis
                    TextButton(
                      onPressed: _busy
                          ? null
                          : (widget.onClose ?? () => Navigator.pop(context)),
                      child: Text(
                        state.isPro ? t.continueText : t.continueFreeWithAds,
                        style: const TextStyle(
                          color: brandGreen,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Legal / info
                    _FinePrint(storeName: _platformStoreName()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StoreProductsNotice extends StatelessWidget {
  const _StoreProductsNotice({
    required this.monthlyReady,
    required this.yearlyReady,
  });

  final bool monthlyReady;
  final bool yearlyReady;

  static const Color cardBorder = Color(0xFFE6EAF0);

  @override
  Widget build(BuildContext context) {
    final loadedAny = monthlyReady || yearlyReady;
    final message = loadedAny
        ? 'One subscription product is still loading. You can continue with the available plan while App Store Connect finishes returning the other product.'
        : 'Connecting to App Store subscription products. If this does not finish loading, confirm the subscriptions are Ready to Submit in App Store Connect.';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 13,
                height: 1.3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegalAgreementCard extends StatelessWidget {
  const _LegalAgreementCard({required this.accepted, required this.onChanged});

  final bool accepted;
  final ValueChanged<bool?>? onChanged;

  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color cardBorder = Color(0xFFE6EAF0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: accepted,
            onChanged: onChanged,
            activeColor: brandGreen,
            visualDensity: VisualDensity.compact,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    'I agree to the ',
                    style: TextStyle(
                      color: Colors.black87,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  _InlineLegalButton(
                    label: 'Terms & Conditions',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TermsScreen()),
                    ),
                  ),
                  const Text(
                    ' and ',
                    style: TextStyle(
                      color: Colors.black87,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  _InlineLegalButton(
                    label: 'Privacy Policy',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PrivacyScreen()),
                    ),
                  ),
                  const Text(
                    '.',
                    style: TextStyle(
                      color: Colors.black87,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InlineLegalButton extends StatelessWidget {
  const _InlineLegalButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF1F6E5C),
          height: 1.3,
          fontWeight: FontWeight.w900,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class _PlanStatusCard extends StatelessWidget {
  const _PlanStatusCard({required this.state});

  final SubscriptionState state;

  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color cardBorder = Color(0xFFE6EAF0);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final title = state.isPro ? 'Current plan' : 'Current plan: Free';
    final body = state.isPro
        ? 'You already have Ez Invoice Pro. You can review both subscription options below.'
        : 'Free includes ads and limited usage. Pro removes ads and unlocks unlimited invoices, reports, premium templates, exports, and cloud backup.';
    final planLabel = switch (state.plan) {
      ProPlan.yearly => t.proYearly,
      ProPlan.monthly => t.proMonthly,
      ProPlan.none => 'Free',
    };

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            state.isPro ? Icons.verified_outlined : Icons.lock_open_outlined,
            color: state.isPro ? brandGreen : Colors.black54,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title • $planLabel',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: Colors.black54,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.title,
    required this.subtitle,
    required this.badgeText,
  });

  final String title;
  final String subtitle;
  final String badgeText;

  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color cardBorder = Color(0xFFE6EAF0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            offset: const Offset(0, 8),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: brandGreen,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                badgeText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              height: 1.1,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              height: 1.35,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanComparisonCard extends StatelessWidget {
  const _PlanComparisonCard({required this.state});

  final SubscriptionState state;

  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color cardBorder = Color(0xFFE6EAF0);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final current = state.isPro ? t.proBadge : 'FREE';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.workspace_premium_outlined, color: brandGreen),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Free vs ${t.proBadge}',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF5F1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  current,
                  style: const TextStyle(
                    color: brandGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final freeColumn = _ComparisonColumn(
                title: 'FREE',
                items: const [
                  'Ads included',
                  'Limited invoices each month',
                  'Basic invoice style',
                  'Basic reports',
                  'PDF includes EzInvoice branding',
                ],
              );
              final proColumn = _ComparisonColumn(
                title: t.proBadge,
                accent: true,
                items: [
                  t.benefitNoAds,
                  t.benefitUnlimitedInvoices,
                  t.benefitTaxReports,
                  t.benefitPremiumTemplates,
                  t.benefitNoWatermarkPdf,
                  t.benefitExport,
                  t.benefitCloudBackup,
                ],
              );

              if (constraints.maxWidth < 360) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [freeColumn, const SizedBox(height: 12), proColumn],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: freeColumn),
                  const SizedBox(width: 12),
                  Expanded(child: proColumn),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ComparisonColumn extends StatelessWidget {
  const _ComparisonColumn({
    required this.title,
    required this.items,
    this.accent = false,
  });

  final String title;
  final List<String> items;
  final bool accent;

  static const Color brandGreen = Color(0xFF1F6E5C);

  @override
  Widget build(BuildContext context) {
    final titleColor = accent ? brandGreen : Colors.black87;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 13,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, size: 15, color: brandGreen),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      height: 1.25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.tag,
    required this.description,
    required this.emphasized,
    required this.enabled,
    required this.buttonText,
    required this.onPressed,
  });

  final String title;
  final String price;
  final String tag;
  final String description;
  final bool emphasized;
  final bool enabled;
  final String buttonText;
  final VoidCallback onPressed;

  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color cardBorder = Color(0xFFE6EAF0);

  @override
  Widget build(BuildContext context) {
    final borderColor = emphasized ? brandGreen : cardBorder;
    final bg = emphasized ? const Color(0xFFE6F3EF) : Colors.white;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: emphasized ? 1.6 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: emphasized ? brandGreen : const Color(0xFFEFF2F6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: emphasized ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 2),
          Text(description, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: enabled ? onPressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: brandGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}

class _FinePrint extends StatelessWidget {
  const _FinePrint({required this.storeName});

  final String storeName;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Text(
      t.paywallFinePrint(storeName),
      style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.35),
      textAlign: TextAlign.center,
    );
  }
}
