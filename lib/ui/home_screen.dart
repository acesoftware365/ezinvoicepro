// lib/features/home/home_screen.dart

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezinvoice/features/privacy/delete_account_screen.dart';
import 'package:ezinvoice/features/paywall/paywall_screen.dart';
import 'package:ezinvoice/features/privacy/privacy_screen.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/settings/language_settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ezinvoice/ui/clients/clients_screen.dart';
import 'package:ezinvoice/features/invoices/invoices_screen.dart';
import 'package:ezinvoice/ui/business/business_profile_screen.dart';
import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/services/invoices/invoices_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ezinvoice/features/reports/reports_screen.dart';

// ✅ ADD: SubscriptionManager
import 'package:ezinvoice/services/purchases/subscription_manager.dart';

const String _androidAppUrl =
    'https://play.google.com/store/apps/details?id=com.liisgo.ezinvoice';

const String _iosAppUrl =
    'https://apps.apple.com/app/idXXXXXXXXXX'; // cuando lo tengas
const String _websiteUrl = 'https://liisgo.com/#/apps/EzInvoice';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _forcedVersionText = 'v1.0.0 (23)';
  // ---- Brand tokens ----
  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color pageBg = Color(0xFFF6F7F9);

  String _versionText = _forcedVersionText;

  @override
  void initState() {
    super.initState();

    // ✅ No duele llamarlo: si ya está inicializado, no hace nada
    SubscriptionManager.instance.init();

    // ✅ FIX: NO llames setCurrentUserEmail durante build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final u = FirebaseAuth.instance.currentUser;
      SubscriptionManager.instance.setCurrentUserEmail(u?.email);
    });

    _versionText = _forcedVersionText;
  }

  String get _storeUrl {
    if (Platform.isIOS) return _iosAppUrl;
    return _androidAppUrl;
  }

  Future<void> _shareApp(BuildContext context) async {
    final t = AppLocalizations.of(context);

    final text =
        '''
${t.shareAppTitle}

${t.shareAppBody}

$_storeUrl
''';

    await Share.share(text.trim());
  }

  Future<void> _openStorePage() async {
    final uri = Uri.parse(_storeUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openWebsite() async {
    if (Platform.isIOS) return;
    final uri = Uri.parse(_websiteUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  DateTime _monthStart(DateTime now) => DateTime(now.year, now.month, 1);
  DateTime _monthEnd(DateTime now) => DateTime(now.year, now.month + 1, 1);

  String _monthLabel(DateTime now) {
    final mm = now.month.toString().padLeft(2, '0');
    return '${now.year}-$mm';
  }

  int _asInt(dynamic v, {int fallback = 20}) {
    if (v == null) return fallback;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString()) ?? fallback;
  }

  // ✅ Robust: acepta plan="pro" O isPro=true
  bool _isProFromUserDoc(Map<String, dynamic> data) {
    final plan = (data['plan'] ?? 'free').toString().toLowerCase().trim();
    final isProFlag = data['isPro'];
    return plan == 'pro' || isProFlag == true;
  }

  void _openPaywall(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaywallScreen(onClose: () => Navigator.pop(context)),
      ),
    );
  }

  Widget _brandFooter() {
    final isNarrow = MediaQuery.of(context).size.width <= 390;
    final companyText = isNarrow
        ? 'Liisgo LLC'
        : (Platform.isIOS ? 'Liisgo LLC' : 'Liisgo LLC • www.liisgo.com');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 6),
        Text(
          '$companyText • $_versionText',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final user = FirebaseAuth.instance.currentUser!;
    final ref = FirebaseFirestore.instance.collection('users').doc(user.uid);

    final now = DateTime.now();
    final start = _monthStart(now);
    final end = _monthEnd(now);
    final monthLabel = _monthLabel(now);

    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Theme(
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
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.home),
          actions: [
            IconButton(
              tooltip: t.shareAppTooltip,
              icon: const Icon(Icons.share_outlined),
              onPressed: () => _shareApp(context),
            ),
            IconButton(
              tooltip: Platform.isIOS
                  ? t.openAppStoreTooltip
                  : t.openGooglePlayTooltip,
              icon: Platform.isIOS
                  ? const Icon(Icons.apple_sharp)
                  : const Icon(Icons.play_arrow),
              onPressed: _openStorePage,
            ),
            if (!Platform.isIOS)
              IconButton(
                tooltip: t.openWebsiteTooltip,
                icon: const Icon(Icons.public),
                onPressed: _openWebsite,
              ),
            IconButton(
              tooltip: t.settingsLanguage,
              icon: const Icon(Icons.language),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LanguageSettingsScreen(),
                  ),
                );
              },
            ),
            IconButton(
              tooltip: t.logout,
              icon: const Icon(Icons.logout),
              onPressed: () async => FirebaseAuth.instance.signOut(),
            ),
          ],
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: ref.snapshots(),
          builder: (context, sUser) {
            if (sUser.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = sUser.data?.data() ?? {};
            final email = (data['email'] ?? user.email ?? '').toString();
            final planValue = (data['plan'] ?? '')
                .toString()
                .toLowerCase()
                .trim();
            final proPlanValue = (data['proPlan'] ?? '').toString();
            final bool isProFromDoc = _isProFromUserDoc(data);

            // Sincroniza entitlement backend -> manager (necesario para PaywallGuard/FeatureGate).
            SubscriptionManager.instance.syncFromBackend(
              isPro: isProFromDoc,
              proPlan: proPlanValue.isNotEmpty
                  ? proPlanValue
                  : (planValue == 'pro' ? 'monthly' : 'none'),
            );

            final bool isProEffective =
                SubscriptionManager.instance.state.value.isPro || isProFromDoc;

            final freeLimitInt = _asInt(
              data['freeMonthlyInvoiceLimit'],
              fallback: 20,
            );

            return StreamBuilder<List<Invoice>>(
              stream: InvoicesService.streamInvoices(),
              builder: (context, sInv) {
                if (sInv.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final invoices = sInv.data ?? const <Invoice>[];

                final monthInvoices = invoices.where((inv) {
                  final d = DateTime.fromMillisecondsSinceEpoch(
                    inv.createdAtMs,
                  );
                  return d.isAfter(
                        start.subtract(const Duration(milliseconds: 1)),
                      ) &&
                      d.isBefore(end);
                }).toList();

                double monthSubtotal = 0;
                double monthTax = 0;
                double monthTip = 0;
                double monthTotal = 0;

                for (final inv in monthInvoices) {
                  monthSubtotal += inv.subtotal;
                  monthTax += inv.taxAmount;
                  monthTip += inv.tip;
                  monthTotal += inv.total;
                }

                final usedThisMonth = monthInvoices.length;

                final remaining = isProEffective
                    ? null
                    : (freeLimitInt - usedThisMonth) < 0
                    ? 0
                    : (freeLimitInt - usedThisMonth);

                final isFreeLimitReached =
                    !isProEffective && (remaining ?? 0) <= 0;

                return LayoutBuilder(
                  builder: (context, c) {
                    final w = c.maxWidth;
                    final isTablet = w >= 700;

                    final pad = 16.0;
                    final gap = 12.0;

                    final list = ListView(
                      padding: EdgeInsets.fromLTRB(pad, 14, pad, 18),
                      children: [
                        _HeaderCard(
                          title: t.dashboardTitle,
                          subtitle: '${t.monthWord} $monthLabel',
                          right: _PlanPill(
                            isPro: isProEffective,
                            proLabel: t.proBadge,
                          ),
                        ),
                        SizedBox(height: gap),

                        _InfoCard(
                          icon: Icons.email_outlined,
                          title: t.email,
                          value: email.isEmpty ? '-' : email,
                        ),
                        SizedBox(height: gap),

                        _InfoCard(
                          icon: isProEffective
                              ? Icons.workspace_premium_outlined
                              : Icons.lock_outline,
                          title: isProEffective
                              ? t.planLabel
                              : t.invoicesRemaining,
                          value: isProEffective
                              ? t.proUnlimitedLabel
                              : '${remaining ?? 0} / $freeLimitInt',
                          accent: isProEffective ? brandGreen : null,
                        ),
                        SizedBox(height: gap),

                        _PrimaryAction(
                          title: t.createNewInvoice,
                          subtitle: isProEffective
                              ? t.createInvoiceFastSubtitle
                              : (isFreeLimitReached
                                    ? t.limitReachedSubtitle
                                    : t.createInvoiceFastSubtitle),
                          icon: Icons.receipt_long_outlined,
                          onTap: () {
                            if (!isProEffective && isFreeLimitReached) {
                              _openPaywall(context);
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const InvoicesScreen(),
                              ),
                            );
                          },
                        ),

                        if (!isProEffective && isFreeLimitReached) ...[
                          SizedBox(height: gap),
                          _UpgradeBanner(
                            title: t.limitReachedTitle,
                            body: t.limitReachedBody,
                            cta: t.upgradeToPro,
                            onTap: () => _openPaywall(context),
                          ),
                        ],

                        const SizedBox(height: 16),

                        Text(
                          t.monthSummaryTitle,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 10),

                        _MetricCard(
                          title: t.salesTitle,
                          value: monthTotal.toStringAsFixed(2),
                          icon: Icons.attach_money,
                          subtitle: t.invoiceCount(monthInvoices.length),
                          strong: true,
                        ),
                        SizedBox(height: gap),
                        _MetricCard(
                          title: t.tipTitle,
                          value: monthTip.toStringAsFixed(2),
                          icon: Icons.volunteer_activism_outlined,
                          subtitle: '${t.monthWord} $monthLabel',
                        ),
                        SizedBox(height: gap),
                        _MetricCard(
                          title: t.subtotalTitle,
                          value: monthSubtotal.toStringAsFixed(2),
                          icon: Icons.receipt_outlined,
                          subtitle: t.beforeTaxTip,
                        ),
                        SizedBox(height: gap),
                        _MetricCard(
                          title: t.taxTitle,
                          value: monthTax.toStringAsFixed(2),
                          icon: Icons.percent,
                          subtitle: t.collectedThisMonth,
                        ),

                        const SizedBox(height: 16),

                        Text(
                          t.quickAccessTitle,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 10),

                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: gap,
                          crossAxisSpacing: gap,
                          childAspectRatio: 1.25,
                          children: [
                            _QuickTile(
                              icon: Icons.people_alt_outlined,
                              title: t.clients,
                              subtitle: t.clientsManageSubtitle,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ClientsScreen(),
                                ),
                              ),
                            ),
                            _QuickTile(
                              icon: Icons.receipt_long_outlined,
                              title: t.invoices,
                              subtitle: t.invoicesViewSendSubtitle,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const InvoicesScreen(),
                                ),
                              ),
                            ),
                            _QuickTile(
                              icon: Icons.bar_chart_outlined,
                              title: t.reports,
                              subtitle: t.monthlyYearlySubtitle,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ReportsScreen(),
                                ),
                              ),
                            ),
                            _QuickTile(
                              icon: Icons.business_outlined,
                              title: t.business,
                              subtitle: t.businessProfileSubtitle,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const BusinessProfileScreen(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    );

                    if (!isTablet) return list;

                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: list,
                      ),
                    );
                  },
                );
              },
            );
          },
        ),

        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          minimumSize: const Size.fromHeight(36),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                        ),
                        icon: const Icon(Icons.privacy_tip, size: 16),
                        label: Text(
                          t.privacyPolicy,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PrivacyScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          minimumSize: const Size.fromHeight(36),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                        ),
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                          size: 16,
                        ),
                        label: Text(
                          t.deleteAccountTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DeleteAccountScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                _brandFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --------------------
// UI widgets (sin cambios)
// --------------------

class _HeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? right;

  const _HeaderCard({required this.title, required this.subtitle, this.right});

  static const Color brandGreen = Color(0xFF1F6E5C);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: brandGreen.withOpacity(0.10),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: brandGreen.withOpacity(0.18)),
            ),
            child: const Icon(Icons.dashboard_outlined, color: brandGreen),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (right != null) right!,
        ],
      ),
    );
  }
}

class _PlanPill extends StatelessWidget {
  final bool isPro;
  final String proLabel;

  const _PlanPill({required this.isPro, required this.proLabel});

  static const Color brandGreen = Color(0xFF1F6E5C);

  @override
  Widget build(BuildContext context) {
    final text = isPro ? proLabel : 'FREE';
    final bg = isPro ? brandGreen : Colors.black87;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? accent;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final a = accent ?? Colors.black87;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: a),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String subtitle;
  final bool strong;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.subtitle,
    this.strong = false,
  });

  static const Color brandGreen = Color(0xFF1F6E5C);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: brandGreen.withOpacity(0.10),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: brandGreen.withOpacity(0.18)),
            ),
            child: Icon(icon, size: 20, color: brandGreen),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: strong ? FontWeight.w900 : FontWeight.w800,
                    fontSize: strong ? 18 : 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryAction extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _PrimaryAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  static const Color brandGreen = Color(0xFF1F6E5C);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: brandGreen,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              offset: const Offset(0, 10),
              color: Colors.black.withOpacity(0.14),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class _UpgradeBanner extends StatelessWidget {
  final String title;
  final String body;
  final String cta;
  final VoidCallback onTap;

  const _UpgradeBanner({
    required this.title,
    required this.body,
    required this.cta,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.14),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.amber.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.workspace_premium),
            label: Text(cta),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  static const Color brandGreen = Color(0xFF1F6E5C);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.black.withOpacity(0.06)),
          boxShadow: [
            BoxShadow(
              blurRadius: 18,
              offset: const Offset(0, 8),
              color: Colors.black.withOpacity(0.06),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: brandGreen.withOpacity(0.10),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: brandGreen.withOpacity(0.18)),
              ),
              child: Icon(icon, size: 22, color: brandGreen),
            ),
            const Spacer(),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
