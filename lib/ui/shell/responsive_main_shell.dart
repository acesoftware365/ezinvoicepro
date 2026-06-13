import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezinvoice/features/invoices/invoices_screen.dart';
import 'package:ezinvoice/features/paywall/paywall_screen.dart';
import 'package:ezinvoice/features/privacy/delete_account_screen.dart';
import 'package:ezinvoice/features/privacy/privacy_screen.dart';
import 'package:ezinvoice/features/reports/reports_screen.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/models/business_profile.dart';
import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:ezinvoice/services/invoices/invoices_service.dart';
import 'package:ezinvoice/services/purchases/subscription_manager.dart';
import 'package:ezinvoice/settings/language_settings_screen.dart';
import 'package:ezinvoice/ui/business/business_profile_screen.dart';
import 'package:ezinvoice/ui/clients/clients_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResponsiveMainShell extends StatefulWidget {
  const ResponsiveMainShell({super.key});

  @override
  State<ResponsiveMainShell> createState() => _ResponsiveMainShellState();
}

class _ResponsiveMainShellState extends State<ResponsiveMainShell> {
  static const _brandGreen = Color(0xFF1F7A64);
  static const _pageBg = Color(0xFFF5F7F8);
  static const _businessReminderPref = 'business_profile_reminder_day';

  int _index = 0;
  final _businessRepo = BusinessProfileRepository();
  bool _businessReminderScheduled = false;
  bool _businessIncomplete = false;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width >= 900;
    final t = AppLocalizations.of(context);

    return StreamBuilder<BusinessProfile>(
      stream: _businessRepo.stream(),
      builder: (context, businessSnap) {
        final businessProfile = businessSnap.data ?? const BusinessProfile();
        final businessIncomplete = _isBusinessIncomplete(businessProfile);
        _businessIncomplete = businessIncomplete;
        _maybeShowBusinessReminder(businessIncomplete);

        if (isTablet) {
          return Theme(
            data: _theme(context),
            child: Scaffold(
              backgroundColor: _pageBg,
              body: Row(
                children: [
                  _Sidebar(
                    selectedIndex: _index,
                    businessIncomplete: businessIncomplete,
                    onSelected: (i) => setState(() => _index = i),
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _index,
                      children: [
                        _DashboardScreen(onNavigate: _go),
                        const ClientsScreen(),
                        const InvoicesScreen(),
                        const ReportsScreen(),
                        const BusinessProfileScreen(),
                        const _SettingsHubScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Theme(
          data: _theme(context),
          child: Scaffold(
            backgroundColor: _pageBg,
            body: IndexedStack(
              index: _index.clamp(0, 4),
              children: [
                _DashboardScreen(onNavigate: _go),
                const ClientsScreen(),
                const InvoicesScreen(),
                const ReportsScreen(),
                const BusinessProfileScreen(),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: _index.clamp(0, 4),
              onDestinationSelected: (i) => setState(() => _index = i),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: t.home,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.people_alt_outlined),
                  selectedIcon: const Icon(Icons.people_alt),
                  label: t.clients,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.receipt_long_outlined),
                  selectedIcon: const Icon(Icons.receipt_long),
                  label: t.invoices,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.bar_chart_outlined),
                  selectedIcon: const Icon(Icons.bar_chart),
                  label: t.reports,
                ),
                NavigationDestination(
                  icon: _BusinessNavIcon(
                    icon: Icons.business_center_outlined,
                    showBadge: businessIncomplete,
                  ),
                  selectedIcon: _BusinessNavIcon(
                    icon: Icons.business_center,
                    showBadge: businessIncomplete,
                  ),
                  label: t.business,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ThemeData _theme(BuildContext context) {
    final base = Theme.of(context);
    return base.copyWith(
      scaffoldBackgroundColor: _pageBg,
      colorScheme: base.colorScheme.copyWith(
        primary: _brandGreen,
        secondary: _brandGreen,
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  void _go(int index) {
    setState(() => _index = index);
  }

  bool _isBusinessIncomplete(BusinessProfile profile) {
    final required = [
      profile.businessName,
      profile.ownerName,
      profile.phone,
      profile.email,
      profile.address,
    ];
    return required.any((value) => value.trim().isEmpty);
  }

  void _maybeShowBusinessReminder(bool incomplete) {
    if (!incomplete) {
      _businessReminderScheduled = false;
      return;
    }
    if (_index == 4 || _businessReminderScheduled) return;
    _businessReminderScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) {
        _businessReminderScheduled = false;
        return;
      }
      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.now();
      final today = '${now.year}-${now.month}-${now.day}';
      if (prefs.getString(_businessReminderPref) == today) {
        _businessReminderScheduled = false;
        return;
      }
      await prefs.setString(_businessReminderPref, today);
      if (!mounted || _index == 4 || !_businessIncomplete) {
        _businessReminderScheduled = false;
        return;
      }

      final t = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_businessReminderText(t)),
          action: SnackBarAction(
            label: _openLabel(t),
            onPressed: () => setState(() => _index = 4),
          ),
        ),
      );
      _businessReminderScheduled = false;
    });
  }
}

class _BusinessNavIcon extends StatelessWidget {
  const _BusinessNavIcon({
    required this.icon,
    required this.showBadge,
    this.color,
  });

  final IconData icon;
  final bool showBadge;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(icon, color: color);
    if (!showBadge) return iconWidget;
    return ExcludeSemantics(
      child: SizedBox(
        width: 28,
        height: 28,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            iconWidget,
            Positioned(
              right: 1,
              top: 1,
              child: IgnorePointer(
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade700,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.selectedIndex,
    required this.businessIncomplete,
    required this.onSelected,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final int selectedIndex;
  final bool businessIncomplete;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final t = AppLocalizations.of(context);
    final items = [
      (Icons.home_outlined, t.home),
      (Icons.people_alt_outlined, t.clients),
      (Icons.receipt_long_outlined, t.invoices),
      (Icons.bar_chart_outlined, t.reports),
      (Icons.business_center_outlined, t.business),
      (Icons.settings_outlined, t.settings),
    ];

    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFE8ECEF))),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/EzInvoice Icon.png',
                      width: 34,
                      height: 34,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'EzInvoice',
                    style: TextStyle(
                      color: _brandGreen,
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              for (var i = 0; i < items.length; i++)
                _SidebarItem(
                  icon: items[i].$1,
                  label: items[i].$2,
                  selected: selectedIndex == i,
                  showBadge: i == 4 && businessIncomplete,
                  onTap: () => onSelected(i),
                ),
              const Spacer(),
              _PlanFooter(userEmail: user?.email ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.showBadge,
    required this.onTap,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final IconData icon;
  final String label;
  final bool selected;
  final bool showBadge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEAF5F1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _BusinessNavIcon(
                icon: icon,
                showBadge: showBadge,
                color: selected ? _brandGreen : Colors.black87,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: selected ? _brandGreen : Colors.black87,
                  fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlanFooter extends StatelessWidget {
  const _PlanFooter({required this.userEmail});

  static const _brandGreen = Color(0xFF1F7A64);

  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SubscriptionState>(
      valueListenable: SubscriptionManager.instance.state,
      builder: (context, sub, _) {
        final user = FirebaseAuth.instance.currentUser;
        final userDocStream = user == null
            ? null
            : FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .snapshots();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: userDocStream,
              builder: (context, userSnap) {
                final data = userSnap.data?.data() ?? const {};
                final limit = _asIntValue(
                  data['freeMonthlyInvoiceLimit'],
                  fallback: 20,
                );
                return StreamBuilder<List<Invoice>>(
                  stream: user == null
                      ? null
                      : InvoicesService.streamInvoices(),
                  builder: (context, invoiceSnap) {
                    final used = _countCurrentMonth(
                      invoiceSnap.data ?? const [],
                    );
                    return _PlanSummaryCard(
                      isPro: sub.isPro,
                      limit: limit,
                      used: used,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: _brandGreen,
                  child: Text(
                    _initials(userEmail),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    userEmail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String _initials(String email) {
    if (email.trim().isEmpty) return 'JP';
    final name = email.split('@').first;
    final parts = name.split(RegExp(r'[._-]')).where((p) => p.isNotEmpty);
    final initials = parts.take(2).map((p) => p[0].toUpperCase()).join();
    return initials.isEmpty ? email[0].toUpperCase() : initials;
  }
}

class _PlanSummaryCard extends StatelessWidget {
  const _PlanSummaryCard({
    required this.isPro,
    required this.limit,
    required this.used,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final bool isPro;
  final int limit;
  final int used;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final safeLimit = limit <= 0 ? 20 : limit;
    final remaining = (safeLimit - used).clamp(0, safeLimit);
    final progress = isPro ? 1.0 : (remaining / safeLimit).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAF9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E8E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.workspace_premium_outlined,
                size: 18,
                color: isPro ? _brandGreen : Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                isPro ? _proPlanLabel(t) : _freePlanLabel(t),
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isPro
                ? t.proUnlimitedLabel
                : '$remaining / $safeLimit ${t.invoices.toLowerCase()}',
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            color: _brandGreen,
            backgroundColor: const Color(0xFFDDE8E4),
          ),
          if (!isPro) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaywallScreen()),
                ),
                icon: const Icon(Icons.workspace_premium_outlined),
                label: Text(t.upgradeToPro),
                style: FilledButton.styleFrom(
                  backgroundColor: _brandGreen,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DashboardScreen extends StatefulWidget {
  const _DashboardScreen({required this.onNavigate});

  final ValueChanged<int> onNavigate;

  @override
  State<_DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<_DashboardScreen> {
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const SizedBox.shrink();

    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: userRef.snapshots(),
      builder: (context, userSnap) {
        final userData = userSnap.data?.data() ?? const <String, dynamic>{};
        final plan = (userData['plan'] ?? 'free').toString();
        final isPro = plan.toLowerCase() == 'pro' || userData['isPro'] == true;
        final limit = _asIntValue(
          userData['freeMonthlyInvoiceLimit'],
          fallback: 20,
        );

        return StreamBuilder<List<Invoice>>(
          stream: InvoicesService.streamInvoices(),
          builder: (context, invoiceSnap) {
            if (invoiceSnap.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Error: ${invoiceSnap.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }
            final invoices = invoiceSnap.data ?? const <Invoice>[];
            final monthInvoices = invoices.where((inv) {
              final d = DateTime.fromMillisecondsSinceEpoch(inv.createdAtMs);
              return d.year == _selectedMonth.year &&
                  d.month == _selectedMonth.month;
            }).toList();
            monthInvoices.sort(
              (a, b) => b.createdAtMs.compareTo(a.createdAtMs),
            );

            final totals = _DashboardTotals.from(monthInvoices);
            final trends = _DashboardTrends.from(invoices, _selectedMonth);
            final paidCount = monthInvoices.where((i) => i.isPaid).length;
            final collectionRate = monthInvoices.isEmpty
                ? 0
                : ((paidCount / monthInvoices.length) * 100).round();
            final alerts = _DashboardAlerts.from(
              invoices: invoices,
              used: monthInvoices.length,
              limit: limit,
              isPro: isPro,
            );

            return LayoutBuilder(
              builder: (context, constraints) {
                final isTablet = constraints.maxWidth >= 900;
                if (isTablet) {
                  return _TabletDashboard(
                    email: user.email ?? '',
                    isPro: isPro,
                    limit: limit,
                    used: monthInvoices.length,
                    totals: totals,
                    trends: trends,
                    invoices: monthInvoices,
                    collectionRate: collectionRate,
                    selectedMonth: _selectedMonth,
                    alerts: alerts,
                    onNavigate: widget.onNavigate,
                    onPickMonth: () => _pickMonth(context),
                  );
                }

                return _MobileDashboard(
                  email: user.email ?? '',
                  isPro: isPro,
                  limit: limit,
                  used: monthInvoices.length,
                  totals: totals,
                  trends: trends,
                  invoices: monthInvoices,
                  selectedMonth: _selectedMonth,
                  alerts: alerts,
                  onNavigate: widget.onNavigate,
                  onPickMonth: () => _pickMonth(context),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _pickMonth(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime(DateTime.now().year + 2, 12, 31),
      helpText: 'Select report month',
    );
    if (picked == null) return;
    setState(() => _selectedMonth = DateTime(picked.year, picked.month));
  }
}

class _DashboardTotals {
  final double sales;
  final double tip;
  final double subtotal;
  final double tax;

  const _DashboardTotals({
    required this.sales,
    required this.tip,
    required this.subtotal,
    required this.tax,
  });

  factory _DashboardTotals.from(List<Invoice> invoices) {
    // Filtramos facturas que tengan errores de parseo (marcadas con id 'ERROR' o similar si aplicara)
    // para evitar que datos corruptos rompan los totales.
    final validInvoices = invoices.where((inv) => inv.invoiceNumber != 'ERROR');

    return _DashboardTotals(
      sales: validInvoices.fold(0.0, (total, inv) => total + inv.total),
      tip: validInvoices.fold(0.0, (total, inv) => total + inv.tip),
      subtotal: validInvoices.fold(0.0, (total, inv) => total + inv.subtotal),
      tax: validInvoices.fold(0.0, (total, inv) => total + inv.taxAmount),
    );
  }
}

class _DashboardTrends {
  final List<double> sales;
  final List<double> tip;
  final List<double> subtotal;
  final List<double> tax;
  final List<String> compactLabels;
  final List<String> fullLabels;

  const _DashboardTrends({
    required this.sales,
    required this.tip,
    required this.subtotal,
    required this.tax,
    required this.compactLabels,
    required this.fullLabels,
  });

  factory _DashboardTrends.from(
    List<Invoice> invoices,
    DateTime selectedMonth,
  ) {
    final sales = List<double>.filled(12, 0);
    final tip = List<double>.filled(12, 0);
    final subtotal = List<double>.filled(12, 0);
    final tax = List<double>.filled(12, 0);

    for (final inv in invoices) {
      if (inv.invoiceNumber == 'ERROR') continue;
      final date = DateTime.fromMillisecondsSinceEpoch(inv.createdAtMs);
      if (date.year != selectedMonth.year) continue;
      final index = (date.month - 1).clamp(0, 11);
      sales[index] += inv.total;
      tip[index] += inv.tip;
      subtotal[index] += inv.subtotal;
      tax[index] += inv.taxAmount;
    }

    const compactLabels = [
      'J',
      'F',
      'M',
      'A',
      'M',
      'J',
      'J',
      'A',
      'S',
      'O',
      'N',
      'D',
    ];
    const fullLabels = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return _DashboardTrends(
      sales: sales,
      tip: tip,
      subtotal: subtotal,
      tax: tax,
      compactLabels: compactLabels,
      fullLabels: fullLabels,
    );
  }
}

class _DashboardAlerts {
  final int overdue;
  final int unsent;
  final int unpaid;
  final bool nearFreeLimit;

  const _DashboardAlerts({
    required this.overdue,
    required this.unsent,
    required this.unpaid,
    required this.nearFreeLimit,
  });

  int get count => overdue + unsent + unpaid + (nearFreeLimit ? 1 : 0);

  factory _DashboardAlerts.from({
    required List<Invoice> invoices,
    required int used,
    required int limit,
    required bool isPro,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final overdue = invoices
        .where(
          (inv) =>
              !inv.isPaid &&
              inv.isSent &&
              inv.dueAtMs != null &&
              inv.dueAtMs! < now,
        )
        .length;
    final unsent = invoices.where((inv) => !inv.isPaid && !inv.isSent).length;
    final unpaid = invoices.where((inv) => !inv.isPaid).length;
    final nearFreeLimit = !isPro && limit > 0 && used >= (limit * 0.8).ceil();
    return _DashboardAlerts(
      overdue: overdue,
      unsent: unsent,
      unpaid: unpaid,
      nearFreeLimit: nearFreeLimit,
    );
  }
}

class _TabletDashboard extends StatelessWidget {
  const _TabletDashboard({
    required this.email,
    required this.isPro,
    required this.limit,
    required this.used,
    required this.totals,
    required this.trends,
    required this.invoices,
    required this.collectionRate,
    required this.selectedMonth,
    required this.alerts,
    required this.onNavigate,
    required this.onPickMonth,
  });

  final String email;
  final bool isPro;
  final int limit;
  final int used;
  final _DashboardTotals totals;
  final _DashboardTrends trends;
  final List<Invoice> invoices;
  final int collectionRate;
  final DateTime selectedMonth;
  final _DashboardAlerts alerts;
  final ValueChanged<int> onNavigate;
  final VoidCallback onPickMonth;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final monthLabel = _monthLabel(selectedMonth);
    final recent = invoices.take(5).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DashboardHeader(
              title: t.dashboardTitle,
              subtitle: monthLabel,
              email: email,
              alerts: alerts,
              onPickMonth: onPickMonth,
              onNavigate: onNavigate,
            ),
            const SizedBox(height: 22),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _MetricTile(
                                icon: Icons.attach_money,
                                label: t.salesTitle,
                                value: _money(totals.sales),
                                amount: totals.sales,
                                trend: trends.sales,
                                compactLabels: trends.compactLabels,
                                fullLabels: trends.fullLabels,
                                onTap: () => _openMetric(context, t.salesTitle),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _MetricTile(
                                icon: Icons.volunteer_activism_outlined,
                                label: t.tipTitle,
                                value: _money(totals.tip),
                                amount: totals.tip,
                                trend: trends.tip,
                                compactLabels: trends.compactLabels,
                                fullLabels: trends.fullLabels,
                                onTap: () => _openMetric(context, t.tipTitle),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _MetricTile(
                                icon: Icons.receipt_outlined,
                                label: t.subtotalTitle,
                                value: _money(totals.subtotal),
                                amount: totals.subtotal,
                                trend: trends.subtotal,
                                compactLabels: trends.compactLabels,
                                fullLabels: trends.fullLabels,
                                onTap: () =>
                                    _openMetric(context, t.subtotalTitle),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _MetricTile(
                                icon: Icons.percent,
                                label: t.taxTitle,
                                value: _money(totals.tax),
                                amount: totals.tax,
                                trend: trends.tax,
                                compactLabels: trends.compactLabels,
                                fullLabels: trends.fullLabels,
                                onTap: () => _openMetric(context, t.taxTitle),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        _SectionTitle(t.quickAccessTitle),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _ActionTile(
                                icon: Icons.people_alt_outlined,
                                title: t.clients,
                                subtitle: t.clientsManageSubtitle,
                                onTap: () => onNavigate(1),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _ActionTile(
                                icon: Icons.receipt_long_outlined,
                                title: t.invoices,
                                subtitle: t.invoicesViewSendSubtitle,
                                onTap: () => onNavigate(2),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _ActionTile(
                                icon: Icons.bar_chart_outlined,
                                title: t.reports,
                                subtitle: t.monthlyYearlySubtitle,
                                onTap: () => onNavigate(3),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _ActionTile(
                                icon: Icons.business_center_outlined,
                                title: t.business,
                                subtitle: t.businessProfileSubtitle,
                                onTap: () => onNavigate(4),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        _RecentInvoicesTable(invoices: recent),
                      ],
                    ),
                  ),
                  const SizedBox(width: 22),
                  SizedBox(
                    width: 300,
                    child: _AnalyticsPanel(
                      invoiceCount: used,
                      collectionRate: collectionRate,
                      isPro: isPro,
                      limit: limit,
                      trend: trends.sales,
                      compactLabels: trends.compactLabels,
                      fullLabels: trends.fullLabels,
                      invoices: recent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openMetric(BuildContext context, String metric) {
    onNavigate(3);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$metric report opened for ${_monthLabel(selectedMonth)}',
        ),
      ),
    );
  }
}

class _MobileDashboard extends StatelessWidget {
  const _MobileDashboard({
    required this.email,
    required this.isPro,
    required this.limit,
    required this.used,
    required this.totals,
    required this.trends,
    required this.invoices,
    required this.selectedMonth,
    required this.alerts,
    required this.onNavigate,
    required this.onPickMonth,
  });

  final String email;
  final bool isPro;
  final int limit;
  final int used;
  final _DashboardTotals totals;
  final _DashboardTrends trends;
  final List<Invoice> invoices;
  final DateTime selectedMonth;
  final _DashboardAlerts alerts;
  final ValueChanged<int> onNavigate;
  final VoidCallback onPickMonth;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        children: [
          _DashboardHeader(
            title: t.dashboardTitle,
            subtitle: _monthLabel(selectedMonth),
            email: email,
            alerts: alerts,
            onPickMonth: onPickMonth,
            onNavigate: onNavigate,
          ),
          const SizedBox(height: 16),
          _MetricTile(
            icon: Icons.attach_money,
            label: t.salesTitle,
            value: _money(totals.sales),
            amount: totals.sales,
            trend: trends.sales,
            compactLabels: trends.compactLabels,
            fullLabels: trends.fullLabels,
            onTap: () => _openMetric(context, t.salesTitle),
          ),
          const SizedBox(height: 12),
          _MetricTile(
            icon: Icons.volunteer_activism_outlined,
            label: t.tipTitle,
            value: _money(totals.tip),
            amount: totals.tip,
            trend: trends.tip,
            compactLabels: trends.compactLabels,
            fullLabels: trends.fullLabels,
            onTap: () => _openMetric(context, t.tipTitle),
          ),
          const SizedBox(height: 12),
          _MetricTile(
            icon: Icons.receipt_outlined,
            label: t.subtotalTitle,
            value: _money(totals.subtotal),
            amount: totals.subtotal,
            trend: trends.subtotal,
            compactLabels: trends.compactLabels,
            fullLabels: trends.fullLabels,
            onTap: () => _openMetric(context, t.subtotalTitle),
          ),
          const SizedBox(height: 12),
          _MetricTile(
            icon: Icons.percent,
            label: t.taxTitle,
            value: _money(totals.tax),
            amount: totals.tax,
            trend: trends.tax,
            compactLabels: trends.compactLabels,
            fullLabels: trends.fullLabels,
            onTap: () => _openMetric(context, t.taxTitle),
          ),
          const SizedBox(height: 22),
          _SectionTitle(t.quickAccessTitle),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.45,
            children: [
              _ActionTile(
                icon: Icons.people_alt_outlined,
                title: t.clients,
                subtitle: '',
                onTap: () => onNavigate(1),
              ),
              _ActionTile(
                icon: Icons.receipt_long_outlined,
                title: t.invoices,
                subtitle: '',
                onTap: () => onNavigate(2),
              ),
              _ActionTile(
                icon: Icons.bar_chart_outlined,
                title: t.reports,
                subtitle: '',
                onTap: () => onNavigate(3),
              ),
              _ActionTile(
                icon: Icons.business_center_outlined,
                title: t.business,
                subtitle: '',
                onTap: () => onNavigate(4),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _RecentInvoicesList(invoices: invoices.take(5).toList()),
          const SizedBox(height: 12),
          _PlanStatus(isPro: isPro, limit: limit, used: used),
        ],
      ),
    );
  }

  void _openMetric(BuildContext context, String metric) {
    onNavigate(3);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$metric report opened for ${_monthLabel(selectedMonth)}',
        ),
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({
    required this.title,
    required this.subtitle,
    required this.email,
    required this.alerts,
    required this.onPickMonth,
    required this.onNavigate,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final String title;
  final String subtitle;
  final String email;
  final _DashboardAlerts alerts;
  final VoidCallback onPickMonth;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: onPickMonth,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.expand_more,
                        size: 18,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              tooltip: _notificationsLabel(t),
              onPressed: () => _showAlerts(context, alerts, onNavigate),
              icon: const Icon(Icons.notifications_none),
            ),
            if (alerts.count > 0)
              Positioned(
                top: 8,
                right: 8,
                child: IgnorePointer(
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade700,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
          ],
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'business') {
              onNavigate(4);
            } else if (value == 'subscription') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaywallScreen()),
              );
            } else if (value == 'settings') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LanguageSettingsScreen(),
                ),
              );
            } else if (value == 'privacy') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrivacyScreen()),
              );
            } else if (value == 'delete') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DeleteAccountScreen()),
              );
            } else if (value == 'logout') {
              FirebaseAuth.instance.signOut();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'business',
              child: Text(t.businessProfileTitle),
            ),
            PopupMenuItem(value: 'subscription', child: Text(t.proBadge)),
            PopupMenuItem(value: 'settings', child: Text(t.settings)),
            PopupMenuItem(value: 'privacy', child: Text(t.privacyPolicy)),
            PopupMenuItem(value: 'delete', child: Text(_deleteAccountLabel(t))),
            const PopupMenuDivider(),
            PopupMenuItem(value: 'logout', child: Text(t.logout)),
          ],
          child: CircleAvatar(
            backgroundColor: _brandGreen,
            child: Text(
              _avatarText(email),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static String _avatarText(String email) {
    if (email.isEmpty) return 'JP';
    final name = email.split('@').first;
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  static void _showAlerts(
    BuildContext context,
    _DashboardAlerts alerts,
    ValueChanged<int> onNavigate,
  ) {
    final t = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _notificationsLabel(t),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            if (alerts.count == 0)
              _AlertRow(
                icon: Icons.check_circle_outline,
                title: _allGoodLabel(t),
                subtitle: _noAlertsLabel(t),
              )
            else ...[
              if (alerts.overdue > 0)
                _AlertRow(
                  icon: Icons.warning_amber_rounded,
                  title: '${alerts.overdue} ${t.overdueLabel}',
                  subtitle: _openInvoicesLabel(t),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    onNavigate(2);
                  },
                ),
              if (alerts.unsent > 0)
                _AlertRow(
                  icon: Icons.outgoing_mail,
                  title: '${alerts.unsent} ${t.unsentLabel}',
                  subtitle: _openInvoicesLabel(t),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    onNavigate(2);
                  },
                ),
              if (alerts.unpaid > 0)
                _AlertRow(
                  icon: Icons.payments_outlined,
                  title: '${alerts.unpaid} ${_unpaidLabel(t)}',
                  subtitle: _reviewBalanceLabel(t),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    onNavigate(2);
                  },
                ),
              if (alerts.nearFreeLimit)
                _AlertRow(
                  icon: Icons.workspace_premium_outlined,
                  title: _limitAlmostFullLabel(t),
                  subtitle: t.upgradeToPro,
                  onTap: () {
                    Navigator.pop(sheetContext);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PaywallScreen()),
                    );
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AlertRow extends StatelessWidget {
  const _AlertRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: _SoftCard(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF1F7A64)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null) const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.amount,
    required this.trend,
    required this.compactLabels,
    required this.fullLabels,
    this.onTap,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final IconData icon;
  final String label;
  final String value;
  final double amount;
  final List<double> trend;
  final List<String> compactLabels;
  final List<String> fullLabels;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF5F1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: _brandGreen),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          _TrendChart(
            title: label,
            values: trend,
            maxValue: _chartMax(amount, trend),
            currentValue: amount,
            compactLabels: compactLabels,
            fullLabels: fullLabels,
            compact: true,
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _brandGreen, size: 28),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RecentInvoicesTable extends StatelessWidget {
  const _RecentInvoicesTable({required this.invoices});

  final List<Invoice> invoices;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return _SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(_recentInvoicesLabel(t)),
          const SizedBox(height: 14),
          _TableHeader(),
          const Divider(height: 20),
          if (invoices.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Text(
                t.noInvoicesYet,
                style: const TextStyle(color: Colors.black54),
              ),
            )
          else
            for (final inv in invoices) _InvoiceTableRow(invoice: inv),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    const style = TextStyle(
      color: Colors.black54,
      fontSize: 12,
      fontWeight: FontWeight.w800,
    );
    return Row(
      children: [
        Expanded(flex: 2, child: Text(t.invoiceAutoNumberLabel, style: style)),
        Expanded(flex: 3, child: Text(t.clientLabel, style: style)),
        Expanded(flex: 2, child: Text(t.dateLabel, style: style)),
        Expanded(flex: 2, child: Text(_statusLabel(t), style: style)),
        Expanded(
          flex: 2,
          child: Text(t.totalTitle, textAlign: TextAlign.end, style: style),
        ),
      ],
    );
  }
}

class _InvoiceTableRow extends StatelessWidget {
  const _InvoiceTableRow({required this.invoice});

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final status = invoice.isPaid
        ? t.paidLabel
        : invoice.isSent
        ? t.sentLabel
        : t.unsentLabel;
    final color = invoice.isPaid
        ? Colors.green
        : invoice.isSent
        ? Colors.blueGrey
        : Colors.orange;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              invoice.invoiceNumber,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(invoice.clientName.isEmpty ? '-' : invoice.clientName),
          ),
          Expanded(flex: 2, child: Text(_shortDate(invoice.createdAtMs))),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _StatusBadge(label: status, color: color),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _money(invoice.total),
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentInvoicesList extends StatelessWidget {
  const _RecentInvoicesList({required this.invoices});

  final List<Invoice> invoices;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return _SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(_recentInvoicesLabel(t)),
          const SizedBox(height: 12),
          if (invoices.isEmpty)
            Text(t.noInvoicesYet, style: const TextStyle(color: Colors.black54))
          else
            for (final inv in invoices)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            inv.invoiceNumber,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                          Text(
                            inv.clientName,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _money(inv.total),
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

class _AnalyticsPanel extends StatelessWidget {
  const _AnalyticsPanel({
    required this.invoiceCount,
    required this.collectionRate,
    required this.isPro,
    required this.limit,
    required this.trend,
    required this.compactLabels,
    required this.fullLabels,
    required this.invoices,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final int invoiceCount;
  final int collectionRate;
  final bool isPro;
  final int limit;
  final List<double> trend;
  final List<String> compactLabels;
  final List<String> fullLabels;
  final List<Invoice> invoices;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Column(
      children: [
        _SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: _SectionTitle(t.monthSummaryTitle)),
                  const Icon(Icons.more_horiz),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 130,
                width: double.infinity,
                child: _TrendChart(
                  title: t.salesTitle,
                  values: trend,
                  maxValue: _chartMax(0, trend),
                  currentValue: trend.fold(
                    0.0,
                    (total, value) => total + value,
                  ),
                  compactLabels: compactLabels,
                  fullLabels: fullLabels,
                  compact: false,
                  filled: true,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SideStat(
          label: t.invoices,
          value: '$invoiceCount',
          icon: Icons.receipt_long,
        ),
        const SizedBox(height: 10),
        _SideStat(
          label: _collectionRateLabel(t),
          value: '$collectionRate%',
          icon: Icons.check_circle_outline,
        ),
        const SizedBox(height: 10),
        _PlanStatus(isPro: isPro, limit: limit, used: invoiceCount),
        const SizedBox(height: 14),
        _SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(_recentActivityLabel(t)),
              const SizedBox(height: 12),
              if (invoices.isEmpty)
                Text(
                  _noActivityLabel(t),
                  style: const TextStyle(color: Colors.black54),
                )
              else
                for (final inv in invoices.take(3))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 14,
                          backgroundColor: Color(0xFFEAF5F1),
                          child: Icon(
                            Icons.check,
                            size: 14,
                            color: _brandGreen,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${inv.invoiceNumber} ${inv.isPaid ? t.paidLabel : _createdLabel(t)}',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SideStat extends StatelessWidget {
  const _SideStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1F7A64)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _PlanStatus extends StatelessWidget {
  const _PlanStatus({
    required this.isPro,
    required this.limit,
    required this.used,
  });

  final bool isPro;
  final int limit;
  final int used;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      child: _PlanSummaryCard(isPro: isPro, limit: limit, used: used),
    );
  }
}

class _SettingsHubScreen extends StatelessWidget {
  const _SettingsHubScreen();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(28),
        children: [
          Text(
            t.settings,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 20),
          _SettingsTile(
            icon: Icons.language,
            title: t.settingsLanguage,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LanguageSettingsScreen()),
            ),
          ),
          _SettingsTile(
            icon: Icons.workspace_premium_outlined,
            title: t.proBadge,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PaywallScreen()),
            ),
          ),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: t.privacyPolicy,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PrivacyScreen()),
            ),
          ),
          _SettingsTile(
            icon: Icons.delete_outline,
            title: _deleteAccountLabel(t),
            danger: true,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DeleteAccountScreen()),
            ),
          ),
          _SettingsTile(
            icon: Icons.logout,
            title: t.logout,
            onTap: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? Colors.red : const Color(0xFF1F7A64);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _SoftCard(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: color, fontWeight: FontWeight.w900),
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _SoftCard extends StatelessWidget {
  const _SoftCard({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE8ECEF)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _TrendChart extends StatelessWidget {
  const _TrendChart({
    required this.title,
    required this.values,
    required this.maxValue,
    required this.currentValue,
    required this.compactLabels,
    required this.fullLabels,
    required this.compact,
    this.filled = false,
  });

  final String title;
  final List<double> values;
  final double maxValue;
  final double currentValue;
  final List<String> compactLabels;
  final List<String> fullLabels;
  final bool compact;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final height = compact ? 58.0 : 130.0;
    final width = compact ? 128.0 : double.infinity;
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        onTap: () => _handleChartTap(context),
        borderRadius: BorderRadius.circular(8),
        child: _ChartCanvas(
          values: values,
          maxValue: maxValue,
          labels: compactLabels,
          filled: filled,
          labelStyle: TextStyle(
            color: Colors.black.withValues(alpha: 0.55),
            fontSize: compact ? 8 : 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  void _handleChartTap(BuildContext context) {
    if (SubscriptionManager.instance.state.value.isPro) {
      _showChartDialog(context);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PaywallScreen()),
    );
  }

  void _showChartDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: AppLocalizations.of(context).close,
                    onPressed: () => Navigator.pop(dialogContext),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${_selectedLabel(AppLocalizations.of(context))}: ${_money(currentValue)}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 280,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE1E8E5)),
                ),
                child: _ChartCanvas(
                  values: values,
                  maxValue: maxValue,
                  labels: fullLabels,
                  filled: true,
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 11,
                    height: 1.15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartCanvas extends StatelessWidget {
  const _ChartCanvas({
    required this.values,
    required this.maxValue,
    required this.labels,
    required this.filled,
    required this.labelStyle,
  });

  final List<double> values;
  final double maxValue;
  final List<String> labels;
  final bool filled;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    final axisWidth = labelStyle.fontSize! <= 8 ? 30.0 : 50.0;
    final middleValue = maxValue / 2;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: axisWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(_axisMoney(maxValue), style: labelStyle),
              const Spacer(),
              Text(
                _axisMoney(middleValue),
                style: labelStyle.copyWith(
                  fontSize: (labelStyle.fontSize ?? 11) * 0.92,
                ),
              ),
              const Spacer(),
              Text('0', style: labelStyle),
            ],
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: CustomPaint(
                  painter: filled
                      ? _AreaChartPainter(values: values, maxValue: maxValue)
                      : _SparklinePainter(values: values, maxValue: maxValue),
                ),
              ),
              const SizedBox(height: 3),
              _TimeAxisLabels(labels: labels, style: labelStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimeAxisLabels extends StatelessWidget {
  const _TimeAxisLabels({required this.labels, required this.style});

  final List<String> labels;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    if (labels.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        for (var i = 0; i < labels.length; i++)
          Expanded(
            child: Text(
              labels[i],
              textAlign: i == 0
                  ? TextAlign.start
                  : i == labels.length - 1
                  ? TextAlign.end
                  : TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
          ),
      ],
    );
  }
}

class _SparklinePainter extends CustomPainter {
  const _SparklinePainter({required this.values, required this.maxValue});

  final List<double> values;
  final double maxValue;

  @override
  void paint(Canvas canvas, Size size) {
    _paintGrid(canvas, size);
    final points = _normaliseTrend(values, maxValue);
    if (_paintSingleValueBar(canvas, size, values, points, radius: 2.2)) {
      return;
    }
    final paint = Paint()
      ..color = const Color(0xFF1F7A64)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final x = _chartX(size, i, points.length);
      final y = size.height * points[i];
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
    _paintPoints(canvas, size, points, radius: 2.2);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) =>
      oldDelegate.values != values || oldDelegate.maxValue != maxValue;
}

class _AreaChartPainter extends CustomPainter {
  const _AreaChartPainter({required this.values, required this.maxValue});

  final List<double> values;
  final double maxValue;

  @override
  void paint(Canvas canvas, Size size) {
    _paintGrid(canvas, size);
    final points = _normaliseTrend(values, maxValue);
    if (_paintSingleValueBar(canvas, size, values, points, radius: 3.5)) {
      return;
    }
    final line = Paint()
      ..color = const Color(0xFF1F7A64)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final fill = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x5536A37F), Color(0x0036A37F)],
      ).createShader(Offset.zero & size);

    final path = Path();
    final area = Path();
    for (var i = 0; i < points.length; i++) {
      final x = _chartX(size, i, points.length);
      final y = size.height * points[i];
      if (i == 0) {
        path.moveTo(x, y);
        area.moveTo(x, size.height);
        area.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        area.lineTo(x, y);
      }
    }
    area.lineTo(_chartX(size, points.length - 1, points.length), size.height);
    area.lineTo(_chartX(size, 0, points.length), size.height);
    area.close();
    canvas.drawPath(area, fill);
    canvas.drawPath(path, line);
    _paintPoints(canvas, size, points, radius: 3.5);
  }

  @override
  bool shouldRepaint(covariant _AreaChartPainter oldDelegate) =>
      oldDelegate.values != values || oldDelegate.maxValue != maxValue;
}

void _paintGrid(Canvas canvas, Size size) {
  final grid = Paint()
    ..color = const Color(0xFFE1E8E5)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  for (final y in [0.0, size.height / 2, size.height]) {
    canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
  }
}

void _paintPoints(
  Canvas canvas,
  Size size,
  List<double> points, {
  required double radius,
}) {
  final fill = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  final stroke = Paint()
    ..color = const Color(0xFF1F7A64)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
  for (var i = 0; i < points.length; i++) {
    final x = _chartX(size, i, points.length);
    final y = size.height * points[i];
    canvas.drawCircle(Offset(x, y), radius, fill);
    canvas.drawCircle(Offset(x, y), radius, stroke);
  }
}

bool _paintSingleValueBar(
  Canvas canvas,
  Size size,
  List<double> values,
  List<double> points, {
  required double radius,
}) {
  final activeIndexes = <int>[
    for (var i = 0; i < values.length; i++)
      if (values[i] > 0) i,
  ];
  if (activeIndexes.length != 1) return false;

  final index = activeIndexes.single;
  final x = _chartX(size, index, points.length);
  final topY = size.height * points[index];
  final bottomY = size.height * 0.88;
  final line = Paint()
    ..color = const Color(0xFF1F7A64)
    ..style = PaintingStyle.stroke
    ..strokeWidth = radius > 3 ? 4 : 3
    ..strokeCap = StrokeCap.round;
  canvas.drawLine(Offset(x, bottomY), Offset(x, topY), line);

  final fill = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  final stroke = Paint()
    ..color = const Color(0xFF1F7A64)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
  canvas.drawCircle(Offset(x, topY), radius, fill);
  canvas.drawCircle(Offset(x, topY), radius, stroke);
  canvas.drawCircle(Offset(x, bottomY), radius, fill);
  canvas.drawCircle(Offset(x, bottomY), radius, stroke);
  return true;
}

double _chartX(Size size, int index, int pointCount) {
  if (pointCount <= 1) return size.width / 2;
  return size.width * ((index + 0.5) / pointCount);
}

List<double> _normaliseTrend(List<double> values, double maxValue) {
  final safeValues = values.isEmpty ? List<double>.filled(8, 0) : values;
  final chartMax = maxValue <= 0
      ? safeValues.fold<double>(0, (max, value) => value > max ? value : max)
      : maxValue;
  if (chartMax <= 0) {
    return const [0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7];
  }
  return safeValues
      .map((value) => 0.9 - ((value / chartMax).clamp(0.0, 1.0) * 0.8))
      .toList();
}

String _money(double value) => '\$${value.toStringAsFixed(2)}';

double _chartMax(double currentValue, List<double> values) {
  final maxTrend = values.fold<double>(
    0,
    (max, value) => value > max ? value : max,
  );
  return currentValue > maxTrend ? currentValue : maxTrend;
}

String _axisMoney(double value) {
  if (value.abs() >= 1000) return '\$${(value / 1000).toStringAsFixed(1)}k';
  if (value.abs() >= 100) return '\$${value.round()}';
  if (value == 0) return '\$0';
  return '\$${value.toStringAsFixed(value.abs() < 10 ? 2 : 1)}';
}

int _asIntValue(dynamic value, {required int fallback}) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}

int _countCurrentMonth(List<Invoice> invoices) {
  final now = DateTime.now();
  return invoices.where((inv) {
    if (inv.invoiceNumber == 'ERROR') return false;
    final date = DateTime.fromMillisecondsSinceEpoch(inv.createdAtMs);
    return date.year == now.year && date.month == now.month;
  }).length;
}

String _lang(AppLocalizations t) => t.localeName.split('_').first;

String _shortByLang(AppLocalizations t, Map<String, String> values, String en) {
  return values[_lang(t)] ?? en;
}

String _freePlanLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Gratis',
  'pt': 'Grátis',
  'fr': 'Gratuit',
  'de': 'Gratis',
  'ar': 'مجاني',
  'hi': 'फ्री',
  'ja': '無料',
  'ru': 'Бесплатно',
  'zh': '免费',
}, 'Free');

String _proPlanLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Pro',
  'pt': 'Pro',
  'fr': 'Pro',
  'de': 'Pro',
  'ar': 'Pro',
  'hi': 'Pro',
  'ja': 'Pro',
  'ru': 'Pro',
  'zh': 'Pro',
}, 'Pro');

String _openLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Abrir',
  'pt': 'Abrir',
  'fr': 'Ouvrir',
  'de': 'Öffnen',
  'ar': 'فتح',
  'hi': 'खोलें',
  'ja': '開く',
  'ru': 'Открыть',
  'zh': '打开',
}, 'Open');

String _businessReminderText(AppLocalizations t) => _shortByLang(t, {
  'es': 'Completa tu perfil para facturas pro.',
  'pt': 'Complete seu perfil para faturas pro.',
  'fr': 'Complétez le profil pour des factures pro.',
  'de': 'Profil für Pro-Rechnungen ausfüllen.',
  'ar': 'أكمل ملف العمل لفواتير احترافية.',
  'hi': 'प्रो इनवॉइस के लिए प्रोफाइल पूरा करें.',
  'ja': 'プロ請求書用にプロフィールを完成。',
  'ru': 'Заполните профиль для проф. счетов.',
  'zh': '完善资料，生成专业发票。',
}, 'Complete your profile for pro invoices.');

String _deleteAccountLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Borrar cuenta',
  'pt': 'Excluir conta',
  'fr': 'Supprimer compte',
  'de': 'Konto löschen',
  'ar': 'حذف الحساب',
  'hi': 'खाता हटाएं',
  'ja': 'アカウント削除',
  'ru': 'Удалить аккаунт',
  'zh': '删除账户',
}, 'Delete account');

String _notificationsLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Avisos',
  'pt': 'Avisos',
  'fr': 'Alertes',
  'de': 'Hinweise',
  'ar': 'تنبيهات',
  'hi': 'अलर्ट',
  'ja': '通知',
  'ru': 'Уведомления',
  'zh': '通知',
}, 'Alerts');

String _allGoodLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Todo al día',
  'pt': 'Tudo em dia',
  'fr': 'Tout est à jour',
  'de': 'Alles aktuell',
  'ar': 'كل شيء محدث',
  'hi': 'सब ठीक है',
  'ja': 'すべて最新',
  'ru': 'Все актуально',
  'zh': '一切正常',
}, 'All clear');

String _noAlertsLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Sin alertas pendientes.',
  'pt': 'Sem alertas pendentes.',
  'fr': 'Aucune alerte.',
  'de': 'Keine Hinweise.',
  'ar': 'لا توجد تنبيهات.',
  'hi': 'कोई अलर्ट नहीं.',
  'ja': '通知はありません。',
  'ru': 'Нет уведомлений.',
  'zh': '没有通知。',
}, 'No alerts.');

String _openInvoicesLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Abre Facturas.',
  'pt': 'Abra Faturas.',
  'fr': 'Ouvrir Factures.',
  'de': 'Rechnungen öffnen.',
  'ar': 'افتح الفواتير.',
  'hi': 'इनवॉइस खोलें.',
  'ja': '請求書を開く。',
  'ru': 'Откройте счета.',
  'zh': '打开发票。',
}, 'Open invoices.');

String _unpaidLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'sin pagar',
  'pt': 'não pagas',
  'fr': 'impayées',
  'de': 'offen',
  'ar': 'غير مدفوعة',
  'hi': 'बकाया',
  'ja': '未払い',
  'ru': 'не оплачено',
  'zh': '未付款',
}, 'unpaid');

String _reviewBalanceLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Revisa balances.',
  'pt': 'Revise saldos.',
  'fr': 'Vérifiez soldes.',
  'de': 'Salden prüfen.',
  'ar': 'راجع الأرصدة.',
  'hi': 'बैलेंस देखें.',
  'ja': '残高を確認。',
  'ru': 'Проверьте баланс.',
  'zh': '查看余额。',
}, 'Review balances.');

String _limitAlmostFullLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Límite casi lleno',
  'pt': 'Limite quase cheio',
  'fr': 'Limite presque pleine',
  'de': 'Limit fast voll',
  'ar': 'الحد شبه ممتلئ',
  'hi': 'सीमा लगभग पूरी',
  'ja': '上限間近',
  'ru': 'Лимит почти полон',
  'zh': '额度快满',
}, 'Limit almost full');

String _recentInvoicesLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Facturas recientes',
  'pt': 'Faturas recentes',
  'fr': 'Factures récentes',
  'de': 'Neue Rechnungen',
  'ar': 'فواتير حديثة',
  'hi': 'हाल की इनवॉइस',
  'ja': '最近の請求書',
  'ru': 'Новые счета',
  'zh': '最近发票',
}, 'Recent invoices');

String _statusLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Estado',
  'pt': 'Status',
  'fr': 'Statut',
  'de': 'Status',
  'ar': 'الحالة',
  'hi': 'स्थिति',
  'ja': '状態',
  'ru': 'Статус',
  'zh': '状态',
}, 'Status');

String _collectionRateLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Cobro',
  'pt': 'Cobrança',
  'fr': 'Paiement',
  'de': 'Zahlung',
  'ar': 'التحصيل',
  'hi': 'कलेक्शन',
  'ja': '回収率',
  'ru': 'Оплата',
  'zh': '收款',
}, 'Paid rate');

String _recentActivityLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Actividad',
  'pt': 'Atividade',
  'fr': 'Activité',
  'de': 'Aktivität',
  'ar': 'النشاط',
  'hi': 'गतिविधि',
  'ja': '履歴',
  'ru': 'Активность',
  'zh': '活动',
}, 'Activity');

String _noActivityLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Sin actividad.',
  'pt': 'Sem atividade.',
  'fr': 'Aucune activité.',
  'de': 'Keine Aktivität.',
  'ar': 'لا يوجد نشاط.',
  'hi': 'कोई गतिविधि नहीं.',
  'ja': '履歴なし。',
  'ru': 'Нет активности.',
  'zh': '没有活动。',
}, 'No activity.');

String _createdLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'creada',
  'pt': 'criada',
  'fr': 'créée',
  'de': 'erstellt',
  'ar': 'تم الإنشاء',
  'hi': 'बनाई',
  'ja': '作成',
  'ru': 'создан',
  'zh': '已创建',
}, 'created');

String _selectedLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Actual',
  'pt': 'Atual',
  'fr': 'Actuel',
  'de': 'Aktuell',
  'ar': 'الحالي',
  'hi': 'वर्तमान',
  'ja': '現在',
  'ru': 'Текущий',
  'zh': '当前',
}, 'Current');

String _shortDate(int ms) {
  final d = DateTime.fromMillisecondsSinceEpoch(ms);
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[d.month - 1]} ${d.day}';
}

String _monthLabel(DateTime date) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return '${months[date.month - 1]} ${date.year}';
}
