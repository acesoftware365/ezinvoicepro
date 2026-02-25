// lib/features/paywall/paywall_screen.dart

import 'dart:io';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../services/purchases/subscription_manager.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({
    super.key,
    this.onClose,
  });

  final VoidCallback? onClose;

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  final _sub = SubscriptionManager.instance;

  bool _busy = false;

  // ✅ Brand color (EzInvoice green)
  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color pageBg = Color(0xFFF6F7F9);
  static const Color cardBorder = Color(0xFFE6EAF0);

  @override
  void initState() {
    super.initState();

    // ✅ Asegura init + restore + productos (sin duplicar llamadas)
    _safeInit();

    // ✅ Auto-cierra cuando se activa Pro
    _sub.state.addListener(_onStateChanged);
  }

  void _onStateChanged() {
    final s = _sub.state.value;

    if (s.isPro) {
      if (mounted && _busy) setState(() => _busy = false);

      if (widget.onClose != null) {
        widget.onClose!.call();
      } else {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    }
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
        final t = AppLocalizations.of(context)!;
        _showSnack(t.authError); // fallback simple
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  String _platformStoreName() {
    if (Platform.isIOS) return 'App Store';
    if (Platform.isAndroid) return 'Google Play';
    return 'Store';
  }

  @override
  void dispose() {
    // ✅ Limpieza listener
    _sub.state.removeListener(_onStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: brandGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      child: ValueListenableBuilder<SubscriptionState>(
        valueListenable: _sub.state,
        builder: (context, state, _) {
          if (state.isPro) {
            return _AlreadyProView(onClose: widget.onClose);
          }

          final monthlyPrice = state.priceMonthly ?? '...';
          final yearlyPrice = state.priceYearly ?? '...';

          return Scaffold(
            appBar: AppBar(
              title: Text(t.paywallTitle),
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: _busy ? null : (widget.onClose ?? () => Navigator.pop(context)),
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

                    // Beneficios (lista)
                    const _BenefitsList(),

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
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              const SizedBox(width: 10),
                              Text(t.processing),
                            ],
                          ),
                        ),
                      ),
                    ],

                    // Planes
                    _PlanCard(
                      title: t.proYearly,
                      price: yearlyPrice,
                      tag: t.bestValueStar,
                      description: t.saveMoreYearly,
                      emphasized: true,
                      enabled: !_busy,
                      onPressed: () => _runBusy(() async {
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
                      enabled: !_busy,
                      onPressed: () => _runBusy(() async {
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
                      onPressed: _busy ? null : (widget.onClose ?? () => Navigator.pop(context)),
                      child: Text(
                        t.continueFreeWithAds,
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

class _AlreadyProView extends StatelessWidget {
  const _AlreadyProView({this.onClose});

  final VoidCallback? onClose;

  static const Color brandGreen = Color(0xFF1F6E5C);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Theme(
      data: theme.copyWith(
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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: brandGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: onClose ?? () => Navigator.pop(context),
            tooltip: t.close,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified, size: 54, color: brandGreen),
                  const SizedBox(height: 10),
                  Text(
                    t.alreadyProTitle,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.alreadyProBody,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: onClose ?? () => Navigator.pop(context),
                    child: Text(t.continueText),
                  ),
                ],
              ),
            ),
          ),
        ),
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
            color: Colors.black.withOpacity(0.05),
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

class _BenefitsList extends StatelessWidget {
  const _BenefitsList();

  static const Color cardBorder = Color(0xFFE6EAF0);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final items = <_BenefitItem>[
      _BenefitItem(icon: Icons.do_not_disturb_on, text: t.benefitNoAds),
      _BenefitItem(icon: Icons.receipt_long, text: t.benefitUnlimitedInvoices),
      _BenefitItem(icon: Icons.palette, text: t.benefitPremiumTemplates),
      _BenefitItem(icon: Icons.picture_as_pdf, text: t.benefitNoWatermarkPdf),
      _BenefitItem(icon: Icons.bar_chart, text: t.benefitTaxReports),
      _BenefitItem(icon: Icons.table_view, text: t.benefitExport),
      _BenefitItem(icon: Icons.cloud_done, text: t.benefitCloudBackup),
    ];

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
          Text(
            t.includesInPro,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          ...items.map(
                (e) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(e.icon, size: 20, color: Colors.black87),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      e.text,
                      style: const TextStyle(fontSize: 14, height: 1.25),
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

class _BenefitItem {
  final IconData icon;
  final String text;
  const _BenefitItem({required this.icon, required this.text});
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.tag,
    required this.description,
    required this.emphasized,
    required this.enabled,
    required this.onPressed,
  });

  final String title;
  final String price;
  final String tag;
  final String description;
  final bool emphasized;
  final bool enabled;
  final VoidCallback onPressed;

  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color cardBorder = Color(0xFFE6EAF0);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

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
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
              )
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(t.continueWithPlan(title)),
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
    final t = AppLocalizations.of(context)!;

    return Text(
      t.paywallFinePrint(storeName),
      style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.35),
      textAlign: TextAlign.center,
    );
  }
}
