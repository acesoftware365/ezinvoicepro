import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/client.dart';
import '../../services/clients/clients_service.dart';
import 'client_form_screen.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  static const Color brandGreen = Color(0xFF1E6F5C);
  static const Color brandGreenSoft = Color(0xFFE8F3EF);
  static const Color pageBg = Color(0xFFF6F7F9);
  static const Color ink = Color(0xFF202124);
  static const Color muted = Color(0xFF74787D);

  final _search = TextEditingController();
  String _q = '';
  String? _selectedClientId;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  String _digitsOnlyFromE164(String e164) {
    return e164.replaceAll('+', '').replaceAll(RegExp(r'[^0-9]'), '');
  }

  String _message(BuildContext context, String clientName) {
    final t = AppLocalizations.of(context);
    final name = clientName.trim().isEmpty ? '' : clientName.trim();
    return t.clientMessageTemplateMultiline(name);
  }

  Future<void> _openTel(BuildContext context, String e164) async {
    final t = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    if (e164.trim().isEmpty) return;
    final uri = Uri(scheme: 'tel', path: e164);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      messenger.showSnackBar(SnackBar(content: Text(t.cannotOpenDialer)));
    }
  }

  Future<void> _openSms(BuildContext context, Client c) async {
    final t = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    if (c.phoneE164.trim().isEmpty) return;

    final digits = _digitsOnlyFromE164(c.phoneE164);
    final body = _message(context, c.name);
    final uri = Uri(
      scheme: 'sms',
      path: digits,
      queryParameters: {'body': body},
    );

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      messenger.showSnackBar(SnackBar(content: Text(t.cannotOpenSms)));
    }
  }

  Future<void> _openWhatsApp(BuildContext context, Client c) async {
    final t = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    if (c.phoneE164.trim().isEmpty) return;

    final digits = _digitsOnlyFromE164(c.phoneE164);
    final msg = Uri.encodeComponent(_message(context, c.name));
    final uri = Uri.parse('https://wa.me/$digits?text=$msg');

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      messenger.showSnackBar(SnackBar(content: Text(t.whatsAppNotAvailable)));
    }
  }

  Future<void> _openEmail(BuildContext context, Client c) async {
    final t = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    if (c.email.trim().isEmpty) return;

    final subject = Uri.encodeComponent(t.invoiceEmailSubject);
    final body = Uri.encodeComponent(_message(context, c.name));
    final uri = Uri.parse('mailto:${c.email}?subject=$subject&body=$body');

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      messenger.showSnackBar(SnackBar(content: Text(t.cannotOpenEmail)));
    }
  }

  Future<void> _confirmDelete(BuildContext context, Client c) async {
    final t = AppLocalizations.of(context);

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.deleteClientTitle),
        content: Text(t.deleteClientBody(c.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.delete),
          ),
        ],
      ),
    );

    if (ok == true) {
      await ClientsService.delete(c.id);
      if (_selectedClientId == c.id && mounted) {
        setState(() => _selectedClientId = null);
      }
    }
  }

  bool _matches(Client c) {
    final q = _q.trim().toLowerCase();
    if (q.isEmpty) return true;

    final hay = [
      c.name,
      c.email,
      c.phoneDisplay,
      c.phoneE164,
      c.notes,
    ].join(' ').toLowerCase();

    return hay.contains(q);
  }

  Future<void> _showShareSheet(BuildContext context, Client c) async {
    final t = AppLocalizations.of(context);

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Share Client',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 14),
                _SheetAction(
                  icon: Icons.sms_outlined,
                  title: t.sms,
                  enabled: c.phoneE164.trim().isNotEmpty,
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _openSms(context, c);
                  },
                ),
                _SheetAction(
                  icon: Icons.chat_bubble_outline,
                  title: t.whatsapp,
                  enabled: c.phoneE164.trim().isNotEmpty,
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _openWhatsApp(context, c);
                  },
                ),
                _SheetAction(
                  icon: Icons.email_outlined,
                  title: t.emailAction,
                  enabled: c.email.trim().isNotEmpty,
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _openEmail(context, c);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openEditor(BuildContext context, Client? client) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ClientFormScreen(client: client)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        scaffoldBackgroundColor: pageBg,
        colorScheme: theme.colorScheme.copyWith(
          primary: brandGreen,
          secondary: brandGreen,
          surface: Colors.white,
        ),
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          hintStyle: const TextStyle(color: muted, fontWeight: FontWeight.w600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.07)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: brandGreen, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: brandGreen,
          shape: const CircleBorder(),
          onPressed: () => _openEditor(context, null),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: SafeArea(
          child: StreamBuilder<List<Client>>(
            stream: ClientsService.streamClients(),
            builder: (context, s) {
              if (s.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final all = [...(s.data ?? const <Client>[])];
              all.sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
              );
              final items = all.where(_matches).toList();
              final selected = _selectedClient(items);

              return LayoutBuilder(
                builder: (context, constraints) {
                  final isTablet = constraints.maxWidth >= 760;
                  if (isTablet) {
                    return _TabletClientsLayout(
                      title: t.clientsTitle,
                      search: _search,
                      query: _q,
                      clients: items,
                      allClients: all,
                      selectedClient: selected,
                      onSearchChanged: (v) => setState(() => _q = v),
                      onClearSearch: _clearSearch,
                      onSelectClient: (client) =>
                          setState(() => _selectedClientId = client.id),
                      onAddClient: () => _openEditor(context, null),
                      onEdit: (client) => _openEditor(context, client),
                      onDelete: (client) => _confirmDelete(context, client),
                      onCall: (client) => _openTel(context, client.phoneE164),
                      onShare: (client) => _showShareSheet(context, client),
                    );
                  }

                  return _MobileClientsLayout(
                    title: t.clientsTitle,
                    search: _search,
                    query: _q,
                    clients: items,
                    allClients: all,
                    onSearchChanged: (v) => setState(() => _q = v),
                    onClearSearch: _clearSearch,
                    onEdit: (client) => _openEditor(context, client),
                    onDelete: (client) => _confirmDelete(context, client),
                    onCall: (client) => _openTel(context, client.phoneE164),
                    onMessage: (client) => _openSms(context, client),
                    onShare: (client) => _showShareSheet(context, client),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Client? _selectedClient(List<Client> items) {
    if (items.isEmpty) return null;
    final selectedId = _selectedClientId;
    if (selectedId != null) {
      for (final client in items) {
        if (client.id == selectedId) return client;
      }
    }
    return items.first;
  }

  void _clearSearch() {
    _search.clear();
    setState(() => _q = '');
  }
}

class _MobileClientsLayout extends StatelessWidget {
  const _MobileClientsLayout({
    required this.title,
    required this.search,
    required this.query,
    required this.clients,
    required this.allClients,
    required this.onSearchChanged,
    required this.onClearSearch,
    required this.onEdit,
    required this.onDelete,
    required this.onCall,
    required this.onMessage,
    required this.onShare,
  });

  final String title;
  final TextEditingController search;
  final String query;
  final List<Client> clients;
  final List<Client> allClients;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final ValueChanged<Client> onEdit;
  final ValueChanged<Client> onDelete;
  final ValueChanged<Client> onCall;
  final ValueChanged<Client> onMessage;
  final ValueChanged<Client> onShare;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: _ClientsScreenState.ink,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 16),
                _SearchField(
                  controller: search,
                  query: query,
                  onChanged: onSearchChanged,
                  onClear: onClearSearch,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        if (clients.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: _EmptyState(
              message: allClients.isEmpty
                  ? t.noClientsYet
                  : t.noClientsForSearch,
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 96),
            sliver: SliverList.separated(
              itemCount: clients.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final client = clients[index];
                return _MobileClientCard(
                  client: client,
                  onTap: () => onEdit(client),
                  onEdit: () => onEdit(client),
                  onDelete: () => onDelete(client),
                  onCall: client.phoneE164.trim().isEmpty
                      ? null
                      : () => onCall(client),
                  onMessage: client.phoneE164.trim().isEmpty
                      ? null
                      : () => onMessage(client),
                  onShare: () => onShare(client),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _TabletClientsLayout extends StatelessWidget {
  const _TabletClientsLayout({
    required this.title,
    required this.search,
    required this.query,
    required this.clients,
    required this.allClients,
    required this.selectedClient,
    required this.onSearchChanged,
    required this.onClearSearch,
    required this.onSelectClient,
    required this.onAddClient,
    required this.onEdit,
    required this.onDelete,
    required this.onCall,
    required this.onShare,
  });

  final String title;
  final TextEditingController search;
  final String query;
  final List<Client> clients;
  final List<Client> allClients;
  final Client? selectedClient;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final ValueChanged<Client> onSelectClient;
  final VoidCallback onAddClient;
  final ValueChanged<Client> onEdit;
  final ValueChanged<Client> onDelete;
  final ValueChanged<Client> onCall;
  final ValueChanged<Client> onShare;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 350,
            child: _GlassCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: _ClientsScreenState.ink,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: _ClientsScreenState.brandGreen,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: onAddClient,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _SearchField(
                    controller: search,
                    query: query,
                    onChanged: onSearchChanged,
                    onClear: onClearSearch,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t.clientsCount(clients.length.toString()),
                    style: const TextStyle(
                      color: _ClientsScreenState.muted,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: clients.isEmpty
                        ? _EmptyState(
                            message: allClients.isEmpty
                                ? t.noClientsYet
                                : t.noClientsForSearch,
                          )
                        : ListView.separated(
                            itemCount: clients.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final client = clients[index];
                              return _TabletClientRow(
                                client: client,
                                selected: selectedClient?.id == client.id,
                                onTap: () => onSelectClient(client),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: selectedClient == null
                ? _GlassCard(child: _EmptyState(message: t.noClientsYet))
                : _ClientDetailPanel(
                    client: selectedClient!,
                    onCall: selectedClient!.phoneE164.trim().isEmpty
                        ? null
                        : () => onCall(selectedClient!),
                    onShare: () => onShare(selectedClient!),
                    onEdit: () => onEdit(selectedClient!),
                    onDelete: () => onDelete(selectedClient!),
                  ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.query,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final String query;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: t.searchClientsLabel,
        prefixIcon: const Icon(
          Icons.search,
          color: _ClientsScreenState.brandGreen,
        ),
        suffixIcon: query.trim().isEmpty
            ? null
            : IconButton(
                tooltip: t.clear,
                icon: const Icon(Icons.close),
                onPressed: onClear,
              ),
      ),
    );
  }
}

class _MobileClientCard extends StatelessWidget {
  const _MobileClientCard({
    required this.client,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onShare,
    this.onCall,
    this.onMessage,
  });

  final Client client;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onShare;
  final VoidCallback? onCall;
  final VoidCallback? onMessage;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final name = _displayName(context, client);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: _cardDecoration(20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 10, 14),
            child: Row(
              children: [
                _AvatarLetter(name: name, size: 46, radius: 15),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _ClientsScreenState.ink,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        client.phoneDisplay.trim().isEmpty
                            ? '-'
                            : client.phoneDisplay.trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _ClientsScreenState.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        client.email.trim().isEmpty
                            ? 'no@email.com'
                            : client.email.trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _ClientsScreenState.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  tooltip: 'Actions',
                  icon: const Icon(
                    Icons.more_vert,
                    color: _ClientsScreenState.ink,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onSelected: (value) {
                    if (value == 'call') onCall?.call();
                    if (value == 'message') onMessage?.call();
                    if (value == 'share') onShare();
                    if (value == 'edit') onEdit();
                    if (value == 'delete') onDelete();
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'call',
                      enabled: onCall != null,
                      child: _MenuRow(
                        icon: Icons.phone_outlined,
                        label: t.call,
                      ),
                    ),
                    PopupMenuItem(
                      value: 'message',
                      enabled: onMessage != null,
                      child: const _MenuRow(
                        icon: Icons.sms_outlined,
                        label: 'Message',
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'share',
                      child: _MenuRow(
                        icon: Icons.ios_share_outlined,
                        label: 'Share',
                      ),
                    ),
                    PopupMenuItem(
                      value: 'edit',
                      child: _MenuRow(icon: Icons.edit_outlined, label: t.edit),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: _MenuRow(
                        icon: Icons.delete_outline,
                        label: '',
                        dangerLabel: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabletClientRow extends StatelessWidget {
  const _TabletClientRow({
    required this.client,
    required this.selected,
    required this.onTap,
  });

  final Client client;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final name = _displayName(context, client);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? _ClientsScreenState.brandGreenSoft
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? _ClientsScreenState.brandGreen.withValues(alpha: 0.25)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            _AvatarLetter(name: name, size: 40, radius: 14),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _ClientsScreenState.ink,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    client.email.trim().isEmpty
                        ? client.phoneDisplay.trim()
                        : client.email.trim(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _ClientsScreenState.muted,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
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

class _ClientDetailPanel extends StatelessWidget {
  const _ClientDetailPanel({
    required this.client,
    required this.onShare,
    required this.onEdit,
    required this.onDelete,
    this.onCall,
  });

  final Client client;
  final VoidCallback? onCall;
  final VoidCallback onShare;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final name = _displayName(context, client);

    return _GlassCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AvatarLetter(name: name, size: 76, radius: 24),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: _ClientsScreenState.ink,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Client profile',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _ClientsScreenState.muted,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _PillButton(
                icon: Icons.phone_outlined,
                label: t.call,
                enabled: onCall != null,
                onTap: onCall,
              ),
              _PillButton(
                icon: Icons.ios_share_outlined,
                label: 'Share',
                onTap: onShare,
              ),
              _PillButton(
                icon: Icons.edit_outlined,
                label: t.edit,
                onTap: onEdit,
              ),
              _PillButton(
                icon: Icons.delete_outline,
                label: t.delete,
                danger: true,
                onTap: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 32),
          _DetailRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: client.phoneDisplay.trim().isEmpty
                ? '-'
                : client.phoneDisplay.trim(),
          ),
          _DetailRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: client.email.trim().isEmpty ? '-' : client.email.trim(),
          ),
          _DetailRow(
            icon: Icons.notes_outlined,
            label: t.notesLabel,
            value: client.notes.trim().isEmpty ? '-' : client.notes.trim(),
            multiline: true,
          ),
        ],
      ),
    );
  }
}

class _SheetAction extends StatelessWidget {
  const _SheetAction({
    required this.icon,
    required this.title,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      minLeadingWidth: 24,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: _ClientsScreenState.brandGreen),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      onTap: enabled ? onTap : null,
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.icon,
    required this.label,
    this.dangerLabel = false,
  });

  final IconData icon;
  final String label;
  final bool dangerLabel;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final color = dangerLabel ? Colors.red : _ClientsScreenState.ink;
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Text(
          dangerLabel ? t.delete : label,
          style: TextStyle(color: color, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.multiline = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool multiline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: multiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: _ClientsScreenState.brandGreenSoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.circle, color: Colors.transparent, size: 1),
          ),
          Transform.translate(
            offset: const Offset(-31, 0),
            child: Icon(icon, size: 20, color: _ClientsScreenState.brandGreen),
          ),
          const SizedBox(width: 0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: _ClientsScreenState.muted,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: _ClientsScreenState.ink,
                    fontWeight: FontWeight.w800,
                    height: 1.35,
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

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.enabled = true,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool enabled;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final fg = danger ? Colors.red : _ClientsScreenState.brandGreen;
    final bg = danger
        ? Colors.red.withValues(alpha: 0.08)
        : _ClientsScreenState.brandGreenSoft;
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        elevation: 0,
        backgroundColor: bg,
        foregroundColor: fg,
        disabledBackgroundColor: bg.withValues(alpha: 0.5),
        disabledForegroundColor: fg.withValues(alpha: 0.4),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      onPressed: enabled ? onTap : null,
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
    );
  }
}

class _AvatarLetter extends StatelessWidget {
  const _AvatarLetter({
    required this.name,
    required this.size,
    required this.radius,
  });

  final String name;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final letter = name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase();

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _ClientsScreenState.brandGreenSoft,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: _ClientsScreenState.brandGreen.withValues(alpha: 0.18),
        ),
      ),
      child: Text(
        letter,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: size * 0.35,
          color: _ClientsScreenState.brandGreen,
        ),
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child, this.padding = EdgeInsets.zero});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: _cardDecoration(22),
      child: child,
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _ClientsScreenState.muted,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

BoxDecoration _cardDecoration(double radius) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
    boxShadow: [
      BoxShadow(
        blurRadius: 26,
        offset: const Offset(0, 12),
        color: Colors.black.withValues(alpha: 0.055),
      ),
    ],
  );
}

String _displayName(BuildContext context, Client client) {
  final t = AppLocalizations.of(context);
  final name = client.name.trim();
  return name.isEmpty ? t.noName : name;
}
