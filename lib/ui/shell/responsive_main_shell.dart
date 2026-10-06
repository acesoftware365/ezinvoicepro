import 'dart:math' as math;
import 'package:ezinvoice/ui/dashboard/metric_detail_screen.dart';
import 'package:ezinvoice/ui/dashboard/dashboard_cards.dart';
import 'package:ezinvoice/features/invoices/invoice_form_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezinvoice/features/invoices/invoices_screen.dart';
import 'package:ezinvoice/features/paywall/paywall_screen.dart';
import 'package:ezinvoice/features/about/about_screen.dart';
import 'package:ezinvoice/features/privacy/delete_account_screen.dart';
import 'package:ezinvoice/features/privacy/privacy_screen.dart';
import 'package:ezinvoice/features/reports/reports_screen.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/models/business_profile.dart';
import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:ezinvoice/services/invoices/invoices_service.dart';
import 'package:ezinvoice/services/navigation/quick_access_service.dart';
import 'package:ezinvoice/services/purchases/subscription_manager.dart';
import 'package:ezinvoice/settings/language_settings_screen.dart';
import 'package:ezinvoice/ui/business/business_profile_screen.dart';
import 'package:ezinvoice/ui/clients/clients_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
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

  final _businessProfileKey = GlobalKey();
  int _index = 0;
  final _businessRepo = BusinessProfileRepository();
  bool _businessReminderScheduled = false;
  bool _businessIncomplete = false;
  List<int> _quickAccess = List<int>.from(QuickAccessService.defaultOrder);
  InvoiceListFilter _invoiceFilter = InvoiceListFilter.all;
  int _invoiceFilterRequestId = 0;

  @override
  void initState() {
    super.initState();
    _loadQuickAccess();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.shortestSide >= 700;
    final isPhoneLandscape = !isTablet && size.width > size.height;
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
              resizeToAvoidBottomInset: false,
              backgroundColor: _pageBg,
              body: Row(
                children: [
                  _Sidebar(
                    selectedIndex: _index,
                    businessIncomplete: businessIncomplete,
                    onSelected: _go,
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _index,
                      children: [
                        _DashboardScreen(
                          onNavigate: _go,
                          onOpenInvoicesWithFilter: _openInvoicesWithFilter,
                          onActionUsed: _recordUsage,
                          quickAccess: _quickAccess,
                        ),
                        const ClientsScreen(),
                        _buildInvoicesScreen(),
                        const ReportsScreen(),
                        BusinessProfileScreen(key: _businessProfileKey),
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
            resizeToAvoidBottomInset: false,
            backgroundColor: _pageBg,
            body: isPhoneLandscape
                ? Row(
                    children: [
                      _PhoneLandscapeRail(
                        selectedIndex: _index.clamp(0, 4),
                        businessIncomplete: businessIncomplete,
                        onSelected: _go,
                      ),
                      Expanded(
                        child: IndexedStack(
                          index: _index.clamp(0, 4),
                          children: [
                            _DashboardScreen(
                              onNavigate: _go,
                              onOpenInvoicesWithFilter: _openInvoicesWithFilter,
                              onActionUsed: _recordUsage,
                              quickAccess: _quickAccess,
                            ),
                            const ClientsScreen(),
                            _buildInvoicesScreen(),
                            const ReportsScreen(),
                            BusinessProfileScreen(key: _businessProfileKey),
                          ],
                        ),
                      ),
                    ],
                  )
                : IndexedStack(
                    index: _index.clamp(0, 4),
                    children: [
                      _DashboardScreen(
                        onNavigate: _go,
                        onOpenInvoicesWithFilter: _openInvoicesWithFilter,
                        onActionUsed: _recordUsage,
                        quickAccess: _quickAccess,
                      ),
                      const ClientsScreen(),
                      _buildInvoicesScreen(),
                      const ReportsScreen(),
                      BusinessProfileScreen(key: _businessProfileKey),
                    ],
                  ),
            bottomNavigationBar: isPhoneLandscape
                ? null
                : NavigationBar(
                    selectedIndex: _index.clamp(0, 4),
                    onDestinationSelected: _go,
                    destinations: [
                      NavigationDestination(
                        icon: const Icon(Icons.home_outlined, size: 32),
                        selectedIcon: const Icon(Icons.home, size: 32),
                        label: t.home,
                      ),
                      NavigationDestination(
                        icon: const Icon(Icons.people_alt_outlined, size: 32),
                        selectedIcon: const Icon(Icons.people_alt, size: 32),
                        label: t.clients,
                      ),
                      NavigationDestination(
                        icon: const Icon(Icons.receipt_long_outlined, size: 32),
                        selectedIcon: const Icon(Icons.receipt_long, size: 32),
                        label: t.invoices,
                      ),
                      NavigationDestination(
                        icon: const Icon(Icons.bar_chart_outlined, size: 32),
                        selectedIcon: const Icon(Icons.bar_chart, size: 32),
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
        surfaceContainerLowest: Colors.white,
        surfaceContainerLow: Colors.white,
        surfaceContainer: Colors.white,
        surfaceContainerHigh: Colors.white,
        surfaceContainerHighest: Colors.white,
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
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFFCFFFD),
        surfaceTintColor: Colors.transparent,
        indicatorColor: const Color(0xFFDDF3EA),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? _brandGreen
                : const Color(0xFF52756C),
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            color: states.contains(WidgetState.selected)
                ? _brandGreen
                : const Color(0xFF52756C),
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w900
                : FontWeight.w700,
          ),
        ),
      ),
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: Colors.white,
        indicatorColor: Color(0xFFDDF3EA),
        selectedIconTheme: IconThemeData(color: _brandGreen),
        unselectedIconTheme: IconThemeData(color: Color(0xFF52756C)),
        selectedLabelTextStyle: TextStyle(
          color: _brandGreen,
          fontWeight: FontWeight.w900,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: Color(0xFF52756C),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Future<void> _loadQuickAccess() async {
    final order = await QuickAccessService.load(
      userId: FirebaseAuth.instance.currentUser?.uid,
    );
    if (!mounted) return;
    setState(() => _quickAccess = order);
  }

  void _recordUsage(int destination) {
    if (destination < 1 || destination > 4) return;
    QuickAccessService.record(
      destination: destination,
      userId: FirebaseAuth.instance.currentUser?.uid,
    ).then((order) {
      if (mounted) setState(() => _quickAccess = order);
    });
  }

  void _go(int index) {
    setState(() => _index = index);
    _recordUsage(index);
  }

  void _openInvoicesWithFilter(InvoiceListFilter filter) {
    setState(() {
      _invoiceFilter = filter;
      _invoiceFilterRequestId++;
      _index = 2;
    });
    _recordUsage(2);
  }

  InvoicesScreen _buildInvoicesScreen() => InvoicesScreen(
    initialFilter: _invoiceFilter,
    filterRequestId: _invoiceFilterRequestId,
  );

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
    this.size = 32,
  });

  final IconData icon;
  final bool showBadge;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(icon, color: color, size: size);
    if (!showBadge) return iconWidget;
    return ExcludeSemantics(
      child: SizedBox(
        width: size + 4,
        height: size + 4,
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

class _PhoneLandscapeRail extends StatelessWidget {
  const _PhoneLandscapeRail({
    required this.selectedIndex,
    required this.businessIncomplete,
    required this.onSelected,
  });

  final int selectedIndex;
  final bool businessIncomplete;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: SizedBox(
            height: math.max(
              constraints.maxHeight,
              540 * (MediaQuery.textScalerOf(context).scale(14) / 14),
            ),
            child: NavigationRail(
              minWidth: 112,
              selectedLabelTextStyle: const TextStyle(
                color: Color(0xFF1F7A64),
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
              unselectedLabelTextStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFF44434A),
              ),
              selectedIndex: selectedIndex,
              onDestinationSelected: onSelected,
              labelType: NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: const Icon(Icons.home_outlined, size: 36),
                  selectedIcon: const Icon(Icons.home, size: 36),
                  label: Text(t.home),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.people_alt_outlined, size: 36),
                  selectedIcon: const Icon(Icons.people_alt, size: 36),
                  label: Text(t.clients),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.receipt_long_outlined, size: 36),
                  selectedIcon: const Icon(Icons.receipt_long, size: 36),
                  label: Text(t.invoices),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.bar_chart_outlined, size: 36),
                  selectedIcon: const Icon(Icons.bar_chart, size: 36),
                  label: Text(t.reports),
                ),
                NavigationRailDestination(
                  icon: _BusinessNavIcon(
                    size: 36,
                    icon: Icons.business_center_outlined,
                    showBadge: businessIncomplete,
                  ),
                  selectedIcon: _BusinessNavIcon(
                    size: 36,
                    icon: Icons.business_center,
                    showBadge: businessIncomplete,
                  ),
                  label: Text(t.business),
                ),
              ],
            ),
          ),
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
          height: 56,
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
  const _DashboardScreen({
    required this.onNavigate,
    required this.onOpenInvoicesWithFilter,
    required this.onActionUsed,
    required this.quickAccess,
  });

  final ValueChanged<int> onNavigate;
  final ValueChanged<InvoiceListFilter> onOpenInvoicesWithFilter;
  final ValueChanged<int> onActionUsed;
  final List<int> quickAccess;

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
                    AppLocalizations.of(
                      context,
                    ).errorWithDetails(invoiceSnap.error ?? ''),
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
                final isTablet =
                    constraints.maxWidth >= 1100 &&
                    constraints.maxHeight >= 600 &&
                    MediaQuery.textScalerOf(context).scale(16) <= 20;
                final dashboard = isTablet
                    ? _TabletDashboard(
                        email: user.email ?? '',
                        isPro: isPro,
                        limit: limit,
                        used: monthInvoices.length,
                        totals: totals,
                        trends: trends,
                        invoices: monthInvoices,
                        allInvoices: invoices,
                        collectionRate: collectionRate,
                        selectedMonth: _selectedMonth,
                        alerts: alerts,
                        onNavigate: widget.onNavigate,
                        onOpenInvoicesWithFilter:
                            widget.onOpenInvoicesWithFilter,
                        quickAccess: widget.quickAccess,
                        onPickMonth: () => _pickMonth(context),
                      )
                    : _MobileDashboard(
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
                        onOpenInvoicesWithFilter:
                            widget.onOpenInvoicesWithFilter,
                        quickAccess: widget.quickAccess,
                        onPickMonth: () => _pickMonth(context),
                      );

                return Stack(
                  children: [
                    Positioned.fill(child: dashboard),
                    _DashboardNewInvoiceFab(
                      onOpen: () => widget.onActionUsed(2),
                    ),
                  ],
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
      helpText: AppLocalizations.of(context).selectReportMonth,
    );
    if (picked == null) return;
    setState(() => _selectedMonth = DateTime(picked.year, picked.month));
  }
}

class _DashboardTotals {
  final double sales;
  final double tip;
  final double billedTotal;
  final double tax;

  const _DashboardTotals({
    required this.sales,
    required this.tip,
    required this.billedTotal,
    required this.tax,
  });

  factory _DashboardTotals.from(List<Invoice> invoices) {
    // Filtramos facturas que tengan errores de parseo (marcadas con id 'ERROR' o similar si aplicara)
    // para evitar que datos corruptos rompan los totales.
    final validInvoices = invoices.where((inv) => inv.invoiceNumber != 'ERROR');

    return _DashboardTotals(
      sales: validInvoices.fold(0.0, (total, inv) => total + inv.subtotal),
      tip: validInvoices.fold(0.0, (total, inv) => total + inv.tip),
      billedTotal: validInvoices.fold(0.0, (total, inv) => total + inv.total),
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
      sales[index] += inv.subtotal;
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

  // Overdue and unsent invoices are already part of the unpaid total. Count
  // each invoice once so the badge and sheet do not exaggerate the workload.
  int get count => unpaid + (nearFreeLimit ? 1 : 0);

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
    required this.allInvoices,
    required this.collectionRate,
    required this.selectedMonth,
    required this.alerts,
    required this.onNavigate,
    required this.onOpenInvoicesWithFilter,
    required this.quickAccess,
    required this.onPickMonth,
  });

  final String email;
  final bool isPro;
  final int limit;
  final int used;
  final _DashboardTotals totals;
  final _DashboardTrends trends;
  final List<Invoice> invoices;
  final List<Invoice> allInvoices;
  final int collectionRate;
  final DateTime selectedMonth;
  final _DashboardAlerts alerts;
  final ValueChanged<int> onNavigate;
  final ValueChanged<InvoiceListFilter> onOpenInvoicesWithFilter;
  final List<int> quickAccess;
  final VoidCallback onPickMonth;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final monthLabel = _monthLabel(selectedMonth);
    final recent = invoices.take(5).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 24, 28, 100),
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
              onOpenInvoicesWithFilter: onOpenInvoicesWithFilter,
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
                        DashboardGrid(
                          children: [
                            _MetricTile(
                              icon: Icons.attach_money,
                              label: t.salesTitle,
                              value: _money(totals.sales),
                              amount: totals.sales,
                              selectedMonth: selectedMonth,
                              compactLabels: trends.compactLabels,
                              fullLabels: trends.fullLabels,
                              onTap: () =>
                                  _openMetric(context, DashboardMetric.sales),
                            ),
                            _MetricTile(
                              icon: Icons.volunteer_activism_outlined,
                              label: t.tipTitle,
                              value: _money(totals.tip),
                              amount: totals.tip,
                              selectedMonth: selectedMonth,
                              compactLabels: trends.compactLabels,
                              fullLabels: trends.fullLabels,
                              onTap: () =>
                                  _openMetric(context, DashboardMetric.tip),
                            ),
                            _MetricTile(
                              icon: Icons.percent,
                              label: t.taxTitle,
                              value: _money(totals.tax),
                              amount: totals.tax,
                              selectedMonth: selectedMonth,
                              compactLabels: trends.compactLabels,
                              fullLabels: trends.fullLabels,
                              onTap: () =>
                                  _openMetric(context, DashboardMetric.tax),
                            ),
                            _MetricTile(
                              icon: Icons.receipt_outlined,
                              label: t.totalInvoicedTitle,
                              value: _money(totals.billedTotal),
                              amount: totals.billedTotal,
                              selectedMonth: selectedMonth,
                              compactLabels: trends.compactLabels,
                              fullLabels: trends.fullLabels,
                              onTap: () => _openMetric(
                                context,
                                DashboardMetric.billedTotal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        _SectionTitle(t.quickAccessTitle),
                        const SizedBox(height: 12),
                        DashboardGrid(
                          children: _quickAccessTiles(
                            t: t,
                            destinations: quickAccess,
                            onNavigate: onNavigate,
                            includeSubtitles: true,
                          ),
                        ),
                        const SizedBox(height: 22),
                        _RecentInvoicesTable(invoices: recent),
                      ],
                    ),
                  ),
                  const SizedBox(width: 22),
                  SizedBox(
                    width: 300,
                    child: SingleChildScrollView(
                      child: _AnalyticsPanel(
                        invoiceCount: used,
                        collectionRate: collectionRate,
                        trend: trends.sales,
                        compactLabels: trends.compactLabels,
                        fullLabels: trends.fullLabels,
                        allInvoices: allInvoices,
                        selectedMonth: selectedMonth,
                      ),
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

  void _openMetric(BuildContext context, DashboardMetric metric) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MetricDetailScreen(metric: metric)),
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
    required this.onOpenInvoicesWithFilter,
    required this.quickAccess,
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
  final ValueChanged<InvoiceListFilter> onOpenInvoicesWithFilter;
  final List<int> quickAccess;
  final VoidCallback onPickMonth;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 108),
        children: [
          _DashboardHeader(
            title: t.dashboardTitle,
            subtitle: _monthLabel(selectedMonth),
            email: email,
            alerts: alerts,
            onPickMonth: onPickMonth,
            onNavigate: onNavigate,
            onOpenInvoicesWithFilter: onOpenInvoicesWithFilter,
          ),
          DashboardGrid(
            children: [
              _MetricTile(
                icon: Icons.attach_money,
                label: t.salesTitle,
                value: _money(totals.sales),
                amount: totals.sales,
                selectedMonth: selectedMonth,
                compactLabels: trends.compactLabels,
                fullLabels: trends.fullLabels,
                onTap: () => _openMetric(context, DashboardMetric.sales),
              ),
              _MetricTile(
                icon: Icons.volunteer_activism_outlined,
                label: t.tipTitle,
                value: _money(totals.tip),
                amount: totals.tip,
                selectedMonth: selectedMonth,
                compactLabels: trends.compactLabels,
                fullLabels: trends.fullLabels,
                onTap: () => _openMetric(context, DashboardMetric.tip),
              ),
              _MetricTile(
                icon: Icons.percent,
                label: t.taxTitle,
                value: _money(totals.tax),
                amount: totals.tax,
                selectedMonth: selectedMonth,
                compactLabels: trends.compactLabels,
                fullLabels: trends.fullLabels,
                onTap: () => _openMetric(context, DashboardMetric.tax),
              ),
              _MetricTile(
                icon: Icons.receipt_outlined,
                label: t.totalInvoicedTitle,
                value: _money(totals.billedTotal),
                amount: totals.billedTotal,
                selectedMonth: selectedMonth,
                compactLabels: trends.compactLabels,
                fullLabels: trends.fullLabels,
                onTap: () => _openMetric(context, DashboardMetric.billedTotal),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _SectionTitle(t.quickAccessTitle),
          const SizedBox(height: 12),
          DashboardGrid(
            minItemWidth: 180,
            children: _quickAccessTiles(
              t: t,
              destinations: quickAccess,
              onNavigate: onNavigate,
              includeSubtitles: false,
            ),
          ),
          const SizedBox(height: 22),
          _RecentInvoicesList(invoices: invoices.take(5).toList()),
          const SizedBox(height: 12),
          _PlanStatus(isPro: isPro, limit: limit, used: used),
        ],
      ),
    );
  }

  void _openMetric(BuildContext context, DashboardMetric metric) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MetricDetailScreen(metric: metric)),
    );
  }
}

class _DashboardNewInvoiceFab extends StatelessWidget {
  const _DashboardNewInvoiceFab({required this.onOpen});

  static const _brandGreen = Color(0xFF1F7A64);

  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final textScale = MediaQuery.textScalerOf(context).scale(16) / 16;
          final showExtendedAction =
              constraints.maxWidth >= 680 &&
              constraints.maxHeight >= 520 &&
              textScale <= 1.4;
          void openInvoice() {
            onOpen();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const InvoiceFormScreen()),
            );
          }

          final action = showExtendedAction
              ? FloatingActionButton.extended(
                  heroTag: 'dashboard-new-invoice',
                  tooltip: t.newInvoiceTitle,
                  backgroundColor: _brandGreen,
                  foregroundColor: Colors.white,
                  onPressed: openInvoice,
                  icon: const Icon(Icons.add, size: 24),
                  label: Text(t.newInvoiceTitle),
                )
              : FloatingActionButton(
                  heroTag: 'dashboard-new-invoice',
                  tooltip: t.newInvoiceTitle,
                  backgroundColor: _brandGreen,
                  foregroundColor: Colors.white,
                  onPressed: openInvoice,
                  child: const Icon(Icons.add, size: 28),
                );

          return SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 18, bottom: 18),
              child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: action,
              ),
            ),
          );
        },
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
    required this.onOpenInvoicesWithFilter,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final String title;
  final String subtitle;
  final String email;
  final _DashboardAlerts alerts;
  final VoidCallback onPickMonth;
  final ValueChanged<int> onNavigate;
  final ValueChanged<InvoiceListFilter> onOpenInvoicesWithFilter;

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
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                          ),
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
        LayoutBuilder(
          builder: (context, _) => _AlertsButton(
            count: alerts.count,
            label: _notificationsLabel(t),
            // Device Hub can translate a short portrait click into a tiny
            // drag. Respond at pointer-down in that layout, just as search
            // does, while retaining the regular accessible action elsewhere.
            useRawPointer: MediaQuery.sizeOf(context).width < 560,
            onPressed: () => _showAlerts(
              context,
              alerts,
              onNavigate,
              onOpenInvoicesWithFilter,
            ),
          ),
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
                MaterialPageRoute(builder: (_) => const _SettingsHubScreen()),
              );
            } else if (value == 'about') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
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
            PopupMenuItem(value: 'about', child: Text(_aboutLabel(t))),
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
    ValueChanged<InvoiceListFilter> onOpenInvoicesWithFilter,
  ) {
    final t = AppLocalizations.of(context);
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.54),
      transitionDuration: const Duration(milliseconds: 220),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curve = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(curve),
            child: child,
          ),
        );
      },
      pageBuilder: (sheetContext, _, __) => _DismissibleAlertsOverlay(
        onDismiss: () => Navigator.of(sheetContext).pop(),
        child: _AlertsSheet(
          title: _notificationsLabel(t),
          count: alerts.count,
          onClose: () => Navigator.of(sheetContext).pop(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (alerts.count == 0)
                _AlertRow(
                  icon: Icons.check_circle_outline_rounded,
                  title: _allGoodLabel(t),
                  subtitle: _noAlertsLabel(t),
                  tone: _brandGreen,
                )
              else ...[
                _AlertRow(
                  icon: Icons.warning_amber_rounded,
                  title: '${alerts.overdue} ${t.overdueLabel}',
                  subtitle: alerts.overdue == 0
                      ? _noOverdueLabel(t)
                      : _openInvoicesLabel(t),
                  tone: alerts.overdue == 0
                      ? const Color(0xFF75817D)
                      : const Color(0xFFE77916),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    onOpenInvoicesWithFilter(InvoiceListFilter.overdue);
                  },
                ),
                if (alerts.unsent > 0)
                  _AlertRow(
                    icon: Icons.outgoing_mail,
                    title: '${alerts.unsent} ${t.unsentLabel}',
                    subtitle: _openInvoicesLabel(t),
                    tone: _brandGreen,
                    onTap: () {
                      Navigator.pop(sheetContext);
                      onOpenInvoicesWithFilter(InvoiceListFilter.unsent);
                    },
                  ),
                if (alerts.unpaid > 0)
                  _AlertRow(
                    icon: Icons.payments_outlined,
                    title: '${alerts.unpaid} ${_unpaidLabel(t)}',
                    subtitle: _reviewBalanceLabel(t),
                    tone: const Color(0xFF3971B8),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      onOpenInvoicesWithFilter(InvoiceListFilter.unpaid);
                    },
                  ),
                if (alerts.nearFreeLimit)
                  _AlertRow(
                    icon: Icons.workspace_premium_outlined,
                    title: _limitAlmostFullLabel(t),
                    subtitle: t.upgradeToPro,
                    tone: const Color(0xFF7D59A5),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PaywallScreen(),
                        ),
                      );
                    },
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AlertsButton extends StatelessWidget {
  const _AlertsButton({
    required this.count,
    required this.label,
    required this.useRawPointer,
    required this.onPressed,
  });

  final int count;
  final String label;
  final bool useRawPointer;
  final VoidCallback onPressed;

  static const _brandGreen = Color(0xFF1F7A64);

  @override
  Widget build(BuildContext context) {
    final button = Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: count > 0
                ? _brandGreen.withValues(alpha: 0.11)
                : const Color(0xFFF0F5F3),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            count > 0
                ? Icons.notifications_active_rounded
                : Icons.notifications_none_rounded,
            size: 23,
            color: _brandGreen,
          ),
        ),
        if (count > 0)
          Positioned(
            top: 4,
            right: 3,
            child: IgnorePointer(
              child: Container(
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFE77916),
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  count > 9 ? '9+' : '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    height: 1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
      ],
    );

    if (!useRawPointer) {
      return IconButton(
        tooltip: label,
        onPressed: onPressed,
        style: IconButton.styleFrom(
          minimumSize: const Size(56, 56),
          padding: EdgeInsets.zero,
        ),
        icon: button,
      );
    }

    return Semantics(
      button: true,
      label: label,
      onTap: onPressed,
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) => onPressed(),
        child: SizedBox(width: 64, height: 56, child: Center(child: button)),
      ),
    );
  }
}

class _AlertsSheet extends StatelessWidget {
  const _AlertsSheet({
    required this.title,
    required this.count,
    required this.onClose,
    required this.child,
  });

  final String title;
  final int count;
  final VoidCallback onClose;
  final Widget child;

  static const _brandGreen = Color(0xFF1F7A64);

  @override
  Widget build(BuildContext context) {
    final isClear = count == 0;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 540,
        maxHeight: MediaQuery.sizeOf(context).height * 0.76,
      ),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 38,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF658079),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (isClear ? _brandGreen : const Color(0xFFE77916))
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        isClear
                            ? Icons.notifications_none_rounded
                            : Icons.notifications_active_rounded,
                        size: 21,
                        color: isClear ? _brandGreen : const Color(0xFFE77916),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            textScaler: TextScaler.noScaling,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF1D2927),
                              backgroundColor: Colors.transparent,
                              decoration: TextDecoration.none,
                              fontSize: 18,
                              height: 1.15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  (isClear
                                          ? _brandGreen
                                          : const Color(0xFFE77916))
                                      .withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              isClear
                                  ? AppLocalizations.of(context).allCaughtUp
                                  : AppLocalizations.of(
                                      context,
                                    ).itemsToReview(count),
                              textScaler: TextScaler.noScaling,
                              maxLines: 1,
                              style: TextStyle(
                                color: isClear
                                    ? _brandGreen
                                    : const Color(0xFFC65F08),
                                backgroundColor: Colors.transparent,
                                decoration: TextDecoration.none,
                                fontSize: 11,
                                height: 1,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    _AlertsCloseButton(onPressed: onClose),
                  ],
                ),
                const SizedBox(height: 16),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DismissibleAlertsOverlay extends StatefulWidget {
  const _DismissibleAlertsOverlay({
    required this.onDismiss,
    required this.child,
  });

  final VoidCallback onDismiss;
  final Widget child;

  @override
  State<_DismissibleAlertsOverlay> createState() =>
      _DismissibleAlertsOverlayState();
}

class _DismissibleAlertsOverlayState extends State<_DismissibleAlertsOverlay> {
  final _sheetKey = GlobalKey();

  void _dismissOutsideSheet(PointerDownEvent event) {
    final renderObject = _sheetKey.currentContext?.findRenderObject();
    if (renderObject is! RenderBox) return;

    final tapPosition = renderObject.globalToLocal(event.position);
    if (!(Offset.zero & renderObject.size).contains(tapPosition)) {
      widget.onDismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _dismissOutsideSheet,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: KeyedSubtree(key: _sheetKey, child: widget.child),
          ),
        ],
      ),
    );
  }
}

class _AlertsCloseButton extends StatelessWidget {
  const _AlertsCloseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final icon = Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        color: Color(0xFFF0F5F3),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.close_rounded,
        color: Color(0xFF245F52),
        size: 21,
      ),
    );
    final narrow = MediaQuery.sizeOf(context).width < 560;
    if (!narrow) {
      return IconButton(
        tooltip: AppLocalizations.of(context).close,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints.tightFor(width: 48, height: 48),
        icon: icon,
      );
    }

    return Semantics(
      button: true,
      label: AppLocalizations.of(context).close,
      onTap: onPressed,
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) => onPressed(),
        child: SizedBox(width: 48, height: 48, child: Center(child: icon)),
      ),
    );
  }
}

class _AlertRow extends StatelessWidget {
  const _AlertRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tone,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color tone;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: const Color(0xFFF9FBFA),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            constraints: const BoxConstraints(minHeight: 74),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE3ECE8)),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: tone.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(icon, color: tone, size: 21),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                          color: Color(0xFF68726F),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(Icons.arrow_forward_ios_rounded, color: tone, size: 16),
              ],
            ),
          ),
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
    required this.selectedMonth,
    required this.compactLabels,
    required this.fullLabels,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final double amount;
  final DateTime selectedMonth;
  final List<String> compactLabels;
  final List<String> fullLabels;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) =>
      DashboardMetricCard(icon: icon, label: label, value: value, onTap: onTap);
}

List<Widget> _quickAccessTiles({
  required AppLocalizations t,
  required List<int> destinations,
  required ValueChanged<int> onNavigate,
  required bool includeSubtitles,
}) {
  final items = <int, (IconData, String, String)>{
    1: (Icons.people_alt_outlined, t.clients, t.clientsManageSubtitle),
    2: (Icons.receipt_long_outlined, t.invoices, t.invoicesViewSendSubtitle),
    3: (Icons.bar_chart_outlined, t.reports, t.monthlyYearlySubtitle),
    4: (Icons.business_center_outlined, t.business, t.businessProfileSubtitle),
  };

  return destinations
      .map((destination) {
        final item = items[destination];
        if (item == null) return null;
        return _ActionTile(
          icon: item.$1,
          title: item.$2,
          subtitle: includeSubtitles ? item.$3 : '',
          onTap: () => onNavigate(destination),
        );
      })
      .whereType<Widget>()
      .toList();
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => DashboardActionCard(
    icon: icon,
    title: title,
    subtitle: subtitle,
    onTap: onTap,
  );
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
    required this.trend,
    required this.compactLabels,
    required this.fullLabels,
    required this.allInvoices,
    required this.selectedMonth,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final int invoiceCount;
  final int collectionRate;
  final List<double> trend;
  final List<String> compactLabels;
  final List<String> fullLabels;
  final List<Invoice> allInvoices;
  final DateTime selectedMonth;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return ListView(
      padding: EdgeInsets.zero,
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
        const SizedBox(height: 14),
        _SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(_performanceLabel(t)),
              const SizedBox(height: 12),
              _ComparisonRow(
                icon: Icons.calendar_month_outlined,
                label: _monthVsLastMonthLabel(t),
                summary: _compareMonth(allInvoices, selectedMonth),
              ),
              const SizedBox(height: 12),
              _ComparisonRow(
                icon: Icons.stacked_line_chart,
                label: _yearVsLastYearLabel(t),
                summary: _compareYear(allInvoices, selectedMonth.year),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ComparisonSummary {
  const _ComparisonSummary({
    required this.current,
    required this.previous,
    required this.changePercent,
  });

  final double current;
  final double previous;
  final double changePercent;

  bool get isUp => changePercent >= 0;
}

class _ComparisonRow extends StatelessWidget {
  const _ComparisonRow({
    required this.icon,
    required this.label,
    required this.summary,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final IconData icon;
  final String label;
  final _ComparisonSummary summary;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final color = summary.isUp ? _brandGreen : Colors.red.shade600;
    final percent = summary.changePercent;
    final percentText =
        '${summary.isUp ? '+' : ''}${percent.toStringAsFixed(0)}%';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAF9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE1E8E5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: const Color(0xFFEAF5F1),
            child: Icon(icon, size: 18, color: _brandGreen),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _money(summary.current),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '${_previousLabel(t)} ${_money(summary.previous)}',
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              percentText,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
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
    return _PlanSummaryCard(isPro: isPro, limit: limit, used: used);
  }
}

class _SettingsHubScreen extends StatefulWidget {
  const _SettingsHubScreen();

  @override
  State<_SettingsHubScreen> createState() => _SettingsHubScreenState();
}

class _SettingsHubScreenState extends State<_SettingsHubScreen> {
  late final Future<PackageInfo> _packageInfo = PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(28),
        children: [
          if (Navigator.canPop(context)) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton.filledTonal(
                tooltip: t.close,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            const SizedBox(height: 12),
          ],
          Text(
            t.settings,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          _AppVersionCard(packageInfo: _packageInfo),
          const SizedBox(height: 12),
          const _SettingsPlanComparisonCard(),
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
            icon: Icons.info_outline_rounded,
            title: _aboutLabel(t),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutScreen()),
            ),
          ),
          _SettingsTile(
            icon: Icons.description_outlined,
            title: t.termsConditions,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TermsScreen()),
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

class _AppVersionCard extends StatelessWidget {
  const _AppVersionCard({required this.packageInfo});

  final Future<PackageInfo> packageInfo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: packageInfo,
      builder: (context, snapshot) {
        final info = snapshot.data;
        final version = AppLocalizations.of(context).versionLabel(
          info == null ? '' : '${info.version} (${info.buildNumber})',
        );

        return _SoftCard(
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Color(0xFF1F7A64)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  version,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SettingsPlanComparisonCard extends StatelessWidget {
  const _SettingsPlanComparisonCard();

  static const _brandGreen = Color(0xFF1F7A64);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return ValueListenableBuilder<SubscriptionState>(
      valueListenable: SubscriptionManager.instance.state,
      builder: (context, sub, _) {
        final current = sub.isPro ? t.proBadge : t.free;

        return _SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.workspace_premium_outlined,
                    color: _brandGreen,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      t.freeVsPro(t.proBadge),
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
                        color: _brandGreen,
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
                  final freeColumn = _PlanColumn(
                    title: t.free,
                    items: [
                      t.adsIncluded,
                      t.limitedInvoicesPerMonth,
                      t.basicInvoiceStyle,
                      t.basicReports,
                      t.pdfIncludesBranding,
                    ],
                  );
                  final proColumn = _PlanColumn(
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
                      children: [
                        freeColumn,
                        const SizedBox(height: 12),
                        proColumn,
                      ],
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
      },
    );
  }
}

class _PlanColumn extends StatelessWidget {
  const _PlanColumn({
    required this.title,
    required this.items,
    this.accent = false,
  });

  final String title;
  final List<String> items;
  final bool accent;

  static const _brandGreen = Color(0xFF1F7A64);

  @override
  Widget build(BuildContext context) {
    final titleColor = accent ? _brandGreen : Colors.black87;

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
                Icon(Icons.check_circle, size: 15, color: _brandGreen),
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

_ComparisonSummary _compareMonth(List<Invoice> invoices, DateTime month) {
  final previousMonth = month.month == 1
      ? DateTime(month.year - 1, 12)
      : DateTime(month.year, month.month - 1);
  final current = _salesForMonth(invoices, month);
  final previous = _salesForMonth(invoices, previousMonth);
  return _ComparisonSummary(
    current: current,
    previous: previous,
    changePercent: _percentChange(current, previous),
  );
}

_ComparisonSummary _compareYear(List<Invoice> invoices, int year) {
  final current = _salesForYear(invoices, year);
  final previous = _salesForYear(invoices, year - 1);
  return _ComparisonSummary(
    current: current,
    previous: previous,
    changePercent: _percentChange(current, previous),
  );
}

double _salesForMonth(List<Invoice> invoices, DateTime month) {
  return invoices.fold<double>(0, (total, inv) {
    if (inv.invoiceNumber == 'ERROR') return total;
    final date = DateTime.fromMillisecondsSinceEpoch(inv.createdAtMs);
    if (date.year != month.year || date.month != month.month) return total;
    return total + inv.subtotal;
  });
}

double _salesForYear(List<Invoice> invoices, int year) {
  return invoices.fold<double>(0, (total, inv) {
    if (inv.invoiceNumber == 'ERROR') return total;
    final date = DateTime.fromMillisecondsSinceEpoch(inv.createdAtMs);
    if (date.year != year) return total;
    return total + inv.subtotal;
  });
}

double _percentChange(double current, double previous) {
  if (previous <= 0) return current > 0 ? 100 : 0;
  return ((current - previous) / previous) * 100;
}

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

String _aboutLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Acerca de EzInvoice',
  'pt': 'Sobre EzInvoice',
  'fr': 'À propos d’EzInvoice',
  'de': 'Über EzInvoice',
  'ar': 'حول EzInvoice',
  'hi': 'EzInvoice के बारे में',
  'ja': 'EzInvoice について',
  'ru': 'О EzInvoice',
  'zh': '关于 EzInvoice',
}, 'About EzInvoice');

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

String _noOverdueLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'No hay facturas vencidas.',
  'pt': 'Sem faturas vencidas.',
  'fr': 'Aucune facture en retard.',
  'de': 'Keine überfälligen Rechnungen.',
  'ar': 'لا توجد فواتير متأخرة.',
  'hi': 'कोई अतिदेय इनवॉइस नहीं।',
  'ja': '期限超過の請求書はありません。',
  'ru': 'Нет просроченных счетов.',
  'zh': '没有逾期发票。',
}, 'No overdue invoices.');

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

String _performanceLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Rendimiento',
  'pt': 'Desempenho',
  'fr': 'Performance',
  'de': 'Leistung',
  'ar': 'الأداء',
  'hi': 'प्रदर्शन',
  'ja': '実績',
  'ru': 'Показатели',
  'zh': '表现',
}, 'Performance');

String _monthVsLastMonthLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Este mes vs mes pasado',
  'pt': 'Este mês vs mês passado',
  'fr': 'Ce mois vs mois dernier',
  'de': 'Dieser Monat vs letzter',
  'ar': 'هذا الشهر مقابل السابق',
  'hi': 'यह महीना बनाम पिछला',
  'ja': '今月と先月',
  'ru': 'Месяц к прошлому',
  'zh': '本月对比上月',
}, 'This month vs last month');

String _yearVsLastYearLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Este año vs año pasado',
  'pt': 'Este ano vs ano passado',
  'fr': 'Cette année vs l’an dernier',
  'de': 'Dieses Jahr vs letztes',
  'ar': 'هذا العام مقابل السابق',
  'hi': 'यह साल बनाम पिछला',
  'ja': '今年と昨年',
  'ru': 'Год к прошлому',
  'zh': '今年对比去年',
}, 'This year vs last year');

String _previousLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Antes',
  'pt': 'Antes',
  'fr': 'Avant',
  'de': 'Vorher',
  'ar': 'السابق',
  'hi': 'पहले',
  'ja': '前回',
  'ru': 'Ранее',
  'zh': '之前',
}, 'Previous');

String _notEnoughDataLabel(AppLocalizations t) => _shortByLang(t, {
  'es': 'Nuevo',
  'pt': 'Novo',
  'fr': 'Nouveau',
  'de': 'Neu',
  'ar': 'جديد',
  'hi': 'नया',
  'ja': '新規',
  'ru': 'Новое',
  'zh': '新增',
}, 'New');

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
