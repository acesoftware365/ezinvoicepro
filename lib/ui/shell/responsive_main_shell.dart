import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezinvoice/features/invoices/invoices_screen.dart';
import 'package:ezinvoice/features/paywall/paywall_screen.dart';
import 'package:ezinvoice/features/privacy/delete_account_screen.dart';
import 'package:ezinvoice/features/privacy/privacy_screen.dart';
import 'package:ezinvoice/features/reports/reports_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width >= 900;

    return StreamBuilder<BusinessProfile>(
      stream: _businessRepo.stream(),
      builder: (context, businessSnap) {
        final businessProfile = businessSnap.data ?? const BusinessProfile();
        final businessIncomplete = _isBusinessIncomplete(businessProfile);
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
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.people_alt_outlined),
                  selectedIcon: Icon(Icons.people_alt),
                  label: 'Clients',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.receipt_long_outlined),
                  selectedIcon: Icon(Icons.receipt_long),
                  label: 'Invoices',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart),
                  label: 'Reports',
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
                  label: 'Business',
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
    if (!incomplete || _index == 4 || _businessReminderScheduled) return;
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
      if (!mounted || _index == 4) {
        _businessReminderScheduled = false;
        return;
      }

      final isEs = Localizations.localeOf(context).languageCode == 'es';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEs
                ? 'Completa tu Business Profile para que tus facturas se vean profesionales.'
                : 'Complete your Business Profile so your invoices look professional.',
          ),
          action: SnackBarAction(
            label: isEs ? 'Abrir' : 'Open',
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
    final items = const [
      (Icons.home_outlined, 'Home'),
      (Icons.people_alt_outlined, 'Clients'),
      (Icons.receipt_long_outlined, 'Invoices'),
      (Icons.bar_chart_outlined, 'Reports'),
      (Icons.business_center_outlined, 'Business'),
      (Icons.settings_outlined, 'Settings'),
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
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
                        sub.isPro
                            ? Icons.workspace_premium_outlined
                            : Icons.workspace_premium_outlined,
                        size: 18,
                        color: sub.isPro ? _brandGreen : Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        sub.isPro ? 'Pro Plan' : 'Free Plan',
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    sub.isPro ? 'Unlimited invoices' : '20 / 20 invoices',
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  const LinearProgressIndicator(
                    value: 1,
                    minHeight: 4,
                    color: _brandGreen,
                    backgroundColor: Color(0xFFDDE8E4),
                  ),
                ],
              ),
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

class _DashboardScreen extends StatelessWidget {
  const _DashboardScreen({required this.onNavigate});

  final ValueChanged<int> onNavigate;

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
        final limit = _asInt(userData['freeMonthlyInvoiceLimit'], fallback: 20);

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
            final now = DateTime.now();
            final monthInvoices = invoices.where((inv) {
              final d = DateTime.fromMillisecondsSinceEpoch(inv.createdAtMs);
              return d.year == now.year && d.month == now.month;
            }).toList();

            final totals = _DashboardTotals.from(monthInvoices);
            final paidCount = monthInvoices.where((i) => i.isPaid).length;
            final collectionRate = monthInvoices.isEmpty
                ? 0
                : ((paidCount / monthInvoices.length) * 100).round();

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
                    invoices: invoices,
                    collectionRate: collectionRate,
                    onNavigate: onNavigate,
                  );
                }

                return _MobileDashboard(
                  email: user.email ?? '',
                  isPro: isPro,
                  limit: limit,
                  used: monthInvoices.length,
                  totals: totals,
                  invoices: invoices,
                  onNavigate: onNavigate,
                );
              },
            );
          },
        );
      },
    );
  }

  int _asInt(dynamic value, {required int fallback}) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? fallback;
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
    final validInvoices = invoices.where((inv) => inv.invoiceNumber != 'ERROR').toList();
    
    return _DashboardTotals(
      sales: validInvoices.fold(0.0, (total, inv) => total + inv.total),
      tip: validInvoices.fold(0.0, (total, inv) => total + inv.tip),
      subtotal: validInvoices.fold(0.0, (total, inv) => total + inv.subtotal),
      tax: validInvoices.fold(0.0, (total, inv) => total + inv.taxAmount),
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
    required this.invoices,
    required this.collectionRate,
    required this.onNavigate,
  });

  final String email;
  final bool isPro;
  final int limit;
  final int used;
  final _DashboardTotals totals;
  final List<Invoice> invoices;
  final int collectionRate;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    final monthLabel = _monthLabel(DateTime.now());
    final recent = invoices.take(5).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DashboardHeader(
              title: 'Dashboard',
              subtitle: monthLabel,
              email: email,
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
                                label: 'Sales',
                                value: _money(totals.sales),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _MetricTile(
                                icon: Icons.volunteer_activism_outlined,
                                label: 'Tip',
                                value: _money(totals.tip),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _MetricTile(
                                icon: Icons.receipt_outlined,
                                label: 'Subtotal',
                                value: _money(totals.subtotal),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _MetricTile(
                                icon: Icons.percent,
                                label: 'Tax',
                                value: _money(totals.tax),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        const _SectionTitle('Quick actions'),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _ActionTile(
                                icon: Icons.people_alt_outlined,
                                title: 'Clients',
                                subtitle: 'Create / edit clients',
                                onTap: () => onNavigate(1),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _ActionTile(
                                icon: Icons.receipt_long_outlined,
                                title: 'Invoices',
                                subtitle: 'View and send invoices',
                                onTap: () => onNavigate(2),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _ActionTile(
                                icon: Icons.bar_chart_outlined,
                                title: 'Reports',
                                subtitle: 'View detailed reports',
                                onTap: () => onNavigate(3),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _ActionTile(
                                icon: Icons.business_center_outlined,
                                title: 'Business',
                                subtitle: 'Profile, logo & tax',
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
}

class _MobileDashboard extends StatelessWidget {
  const _MobileDashboard({
    required this.email,
    required this.isPro,
    required this.limit,
    required this.used,
    required this.totals,
    required this.invoices,
    required this.onNavigate,
  });

  final String email;
  final bool isPro;
  final int limit;
  final int used;
  final _DashboardTotals totals;
  final List<Invoice> invoices;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        children: [
          _DashboardHeader(
            title: 'Dashboard',
            subtitle: _monthLabel(DateTime.now()),
            email: email,
          ),
          const SizedBox(height: 16),
          _MetricTile(
            icon: Icons.attach_money,
            label: 'Sales',
            value: _money(totals.sales),
          ),
          const SizedBox(height: 12),
          _MetricTile(
            icon: Icons.volunteer_activism_outlined,
            label: 'Tip',
            value: _money(totals.tip),
          ),
          const SizedBox(height: 12),
          _MetricTile(
            icon: Icons.receipt_outlined,
            label: 'Subtotal',
            value: _money(totals.subtotal),
          ),
          const SizedBox(height: 12),
          _MetricTile(
            icon: Icons.percent,
            label: 'Tax',
            value: _money(totals.tax),
          ),
          const SizedBox(height: 22),
          const _SectionTitle('Quick Actions'),
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
                title: 'Clients',
                subtitle: '',
                onTap: () => onNavigate(1),
              ),
              _ActionTile(
                icon: Icons.receipt_long_outlined,
                title: 'Invoices',
                subtitle: '',
                onTap: () => onNavigate(2),
              ),
              _ActionTile(
                icon: Icons.bar_chart_outlined,
                title: 'Reports',
                subtitle: '',
                onTap: () => onNavigate(3),
              ),
              _ActionTile(
                icon: Icons.business_center_outlined,
                title: 'Business',
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
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({
    required this.title,
    required this.subtitle,
    required this.email,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final String title;
  final String subtitle;
  final String email;

  @override
  Widget build(BuildContext context) {
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
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Notifications',
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'settings') {
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
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'settings', child: Text('Settings')),
            PopupMenuItem(value: 'privacy', child: Text('Privacy Policy')),
            PopupMenuItem(value: 'delete', child: Text('Delete Account')),
            PopupMenuDivider(),
            PopupMenuItem(value: 'logout', child: Text('Log out')),
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
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
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
          CustomPaint(size: const Size(72, 28), painter: _SparklinePainter()),
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
    return _SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Recent invoices'),
          const SizedBox(height: 14),
          _TableHeader(),
          const Divider(height: 20),
          if (invoices.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Text(
                'No invoices yet.',
                style: TextStyle(color: Colors.black54),
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
    const style = TextStyle(
      color: Colors.black54,
      fontSize: 12,
      fontWeight: FontWeight.w800,
    );
    return const Row(
      children: [
        Expanded(flex: 2, child: Text('Invoice #', style: style)),
        Expanded(flex: 3, child: Text('Client', style: style)),
        Expanded(flex: 2, child: Text('Date', style: style)),
        Expanded(flex: 2, child: Text('Status', style: style)),
        Expanded(
          flex: 2,
          child: Text('Amount', textAlign: TextAlign.end, style: style),
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
    final status = invoice.isPaid
        ? 'Paid'
        : invoice.isSent
        ? 'Sent'
        : 'Pending';
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
    return _SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Recent Invoices'),
          const SizedBox(height: 12),
          if (invoices.isEmpty)
            const Text(
              'No invoices yet.',
              style: TextStyle(color: Colors.black54),
            )
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
    required this.invoices,
  });

  static const _brandGreen = Color(0xFF1F7A64);

  final int invoiceCount;
  final int collectionRate;
  final bool isPro;
  final int limit;
  final List<Invoice> invoices;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Expanded(child: _SectionTitle('Monthly overview')),
                  Icon(Icons.more_horiz),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 130,
                width: double.infinity,
                child: CustomPaint(painter: _AreaChartPainter()),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SideStat(
          label: 'Total invoices',
          value: '$invoiceCount',
          icon: Icons.receipt_long,
        ),
        const SizedBox(height: 10),
        _SideStat(
          label: 'Collection rate',
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
              const _SectionTitle('Recent activity'),
              const SizedBox(height: 12),
              if (invoices.isEmpty)
                const Text(
                  'No recent activity.',
                  style: TextStyle(color: Colors.black54),
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
                            '${inv.invoiceNumber} ${inv.isPaid ? 'paid' : 'created'}',
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
    final progress = isPro ? 1.0 : (used / limit).clamp(0.0, 1.0);
    return _SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isPro ? 'Pro Plan' : 'Free Plan',
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          Text(
            isPro ? 'Unlimited invoices' : '$used / $limit invoices',
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            color: const Color(0xFF1F7A64),
            backgroundColor: const Color(0xFFDDE8E4),
          ),
        ],
      ),
    );
  }
}

class _SettingsHubScreen extends StatelessWidget {
  const _SettingsHubScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(28),
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 20),
          _SettingsTile(
            icon: Icons.language,
            title: 'Language',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LanguageSettingsScreen()),
            ),
          ),
          _SettingsTile(
            icon: Icons.workspace_premium_outlined,
            title: 'Subscription',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PaywallScreen()),
            ),
          ),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PrivacyScreen()),
            ),
          ),
          _SettingsTile(
            icon: Icons.delete_outline,
            title: 'Delete Account',
            danger: true,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DeleteAccountScreen()),
            ),
          ),
          _SettingsTile(
            icon: Icons.logout,
            title: 'Log out',
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

class _SparklinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1F7A64)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = Path();
    final points = [0.7, 0.52, 0.6, 0.38, 0.46, 0.32, 0.2];
    for (var i = 0; i < points.length; i++) {
      final x = size.width * (i / (points.length - 1));
      final y = size.height * points[i];
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AreaChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
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

    final points = [0.85, 0.7, 0.42, 0.58, 0.35, 0.48, 0.28, 0.18];
    final path = Path();
    final area = Path();
    for (var i = 0; i < points.length; i++) {
      final x = size.width * (i / (points.length - 1));
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
    area.lineTo(size.width, size.height);
    area.close();
    canvas.drawPath(area, fill);
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

String _money(double value) => '\$${value.toStringAsFixed(2)}';

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
