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
  // UI tokens
  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color brandGreenSoft = Color(0xFFE6F3EF);
  static const Color pageBg = Color(0xFFF6F7F9);

  final _search = TextEditingController();
  String _q = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  String _digitsOnlyFromE164(String e164) {
    return e164.replaceAll('+', '').replaceAll(RegExp(r'[^0-9]'), '');
  }

  String _message(BuildContext context, String clientName) {
    final t = AppLocalizations.of(context)!;
    final name = clientName.trim().isEmpty ? '' : clientName.trim();
    return t.clientMessageTemplateMultiline(name);
  }

  Future<void> _openTel(BuildContext context, String e164) async {
    final t = AppLocalizations.of(context)!;
    if (e164.trim().isEmpty) return;
    final uri = Uri(scheme: 'tel', path: e164);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _snack(context, t.cannotOpenDialer);
    }
  }

  Future<void> _openSms(BuildContext context, Client c) async {
    final t = AppLocalizations.of(context)!;
    if (c.phoneE164.trim().isEmpty) return;

    final digits = _digitsOnlyFromE164(c.phoneE164);
    final body = _message(context, c.name);

    final uri = Uri(scheme: 'sms', path: digits, queryParameters: {'body': body});
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _snack(context, t.cannotOpenSms);
    }
  }

  Future<void> _openWhatsApp(BuildContext context, Client c) async {
    final t = AppLocalizations.of(context)!;
    if (c.phoneE164.trim().isEmpty) return;

    final digits = _digitsOnlyFromE164(c.phoneE164);
    final msg = Uri.encodeComponent(_message(context, c.name));
    final uri = Uri.parse('https://wa.me/$digits?text=$msg');

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _snack(context, t.whatsAppNotAvailable);
    }
  }

  Future<void> _openEmail(BuildContext context, Client c) async {
    final t = AppLocalizations.of(context)!;
    if (c.email.trim().isEmpty) return;

    final subject = Uri.encodeComponent(t.invoiceEmailSubject);
    final body = Uri.encodeComponent(_message(context, c.name));
    final uri = Uri.parse('mailto:${c.email}?subject=$subject&body=$body');

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _snack(context, t.cannotOpenEmail);
    }
  }

  Future<void> _confirmDelete(BuildContext context, Client c) async {
    final t = AppLocalizations.of(context)!;

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
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.delete),
          ),
        ],
      ),
    );

    if (ok == true) {
      await ClientsService.delete(c.id);
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

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
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
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.black.withOpacity(0.08)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.black.withOpacity(0.10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: brandGreen, width: 1.6),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.clientsTitle),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: brandGreen,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ClientFormScreen()),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: SafeArea(
          child: StreamBuilder<List<Client>>(
            stream: ClientsService.streamClients(),
            builder: (context, s) {
              if (s.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final all = (s.data ?? const <Client>[]);
              all.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

              final items = all.where(_matches).toList();

              return LayoutBuilder(
                builder: (context, c) {
                  final w = c.maxWidth;
                  final isSmall = w < 360;
                  final pad = isSmall ? 12.0 : 16.0;

                  return Column(
                    children: [
                      // Search bar
                      Padding(
                        padding: EdgeInsets.fromLTRB(pad, 12, pad, 10),
                        child: TextField(
                          controller: _search,
                          onChanged: (v) => setState(() => _q = v),
                          decoration: InputDecoration(
                            labelText: t.searchClientsLabel,
                            prefixIcon: const Icon(Icons.search, color: brandGreen),
                            suffixIcon: _q.trim().isEmpty
                                ? null
                                : IconButton(
                              tooltip: t.clear,
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _search.clear();
                                setState(() => _q = '');
                              },
                            ),
                          ),
                        ),
                      ),

                      // Count
                      Padding(
                        padding: EdgeInsets.fromLTRB(pad, 0, pad, 10),
                        child: Row(
                          children: [
                            Text(
                              t.clientsCount(items.length.toString()),
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black.withOpacity(0.70),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: items.isEmpty
                            ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              all.isEmpty ? t.noClientsYet : t.noClientsForSearch,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ),
                        )
                            : ListView.builder(
                          padding: EdgeInsets.fromLTRB(pad, 0, pad, 16),
                          itemCount: items.length,
                          itemBuilder: (context, i) {
                            final c = items[i];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _ClientCard(
                                client: c,
                                onEdit: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => ClientFormScreen(client: c)),
                                ),
                                onCall: c.phoneE164.isEmpty ? null : () => _openTel(context, c.phoneE164),
                                onSms: c.phoneE164.isEmpty ? null : () => _openSms(context, c),
                                onWhatsApp: c.phoneE164.isEmpty ? null : () => _openWhatsApp(context, c),
                                onEmail: c.email.isEmpty ? null : () => _openEmail(context, c),
                                onDelete: () => _confirmDelete(context, c),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ClientCard extends StatelessWidget {
  const _ClientCard({
    required this.client,
    required this.onEdit,
    required this.onDelete,
    this.onCall,
    this.onSms,
    this.onWhatsApp,
    this.onEmail,
  });

  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color brandGreenSoft = Color(0xFFE6F3EF);

  final Client client;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  final VoidCallback? onCall;
  final VoidCallback? onSms;
  final VoidCallback? onWhatsApp;
  final VoidCallback? onEmail;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final name = client.name.trim().isEmpty ? t.noName : client.name.trim();

    final subtitleParts = <String>[];
    if (client.email.trim().isNotEmpty) subtitleParts.add(client.email.trim());
    if (client.phoneDisplay.trim().isNotEmpty) subtitleParts.add(client.phoneDisplay.trim());

    return InkWell(
      onTap: onEdit,
      borderRadius: BorderRadius.circular(18),
      child: Ink(
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
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: avatar + name + menu
              Row(
                children: [
                  _AvatarLetter(name: name),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                        if (subtitleParts.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitleParts.join(' • '),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (v) {
                      if (v == 'edit') onEdit();
                      if (v == 'delete') onDelete();
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(value: 'edit', child: Text(t.edit)),
                      PopupMenuItem(value: 'delete', child: Text(t.delete)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Action chips (no overflow)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _ActionChip(
                    enabled: onCall != null,
                    icon: Icons.phone_outlined,
                    label: t.call,
                    onTap: onCall,
                  ),
                  _ActionChip(
                    enabled: onSms != null,
                    icon: Icons.sms_outlined,
                    label: t.sms,
                    onTap: onSms,
                  ),
                  _ActionChip(
                    enabled: onWhatsApp != null,
                    icon: Icons.chat_bubble_outline,
                    label: t.whatsapp,
                    onTap: onWhatsApp,
                  ),
                  _ActionChip(
                    enabled: onEmail != null,
                    icon: Icons.email_outlined,
                    label: t.emailAction,
                    onTap: onEmail,
                  ),
                  _ActionChip(
                    enabled: true,
                    icon: Icons.delete_outline,
                    label: t.delete,
                    onTap: onDelete,
                    danger: true,
                  ),
                ],
              ),

              if (client.notes.trim().isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: brandGreenSoft,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: brandGreen.withOpacity(0.18)),
                  ),
                  child: Text(
                    client.notes.trim(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, height: 1.35, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarLetter extends StatelessWidget {
  const _AvatarLetter({required this.name});

  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color brandGreenSoft = Color(0xFFE6F3EF);

  final String name;

  @override
  Widget build(BuildContext context) {
    final letter = name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase();

    return Container(
      width: 46,
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: brandGreenSoft,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: brandGreen.withOpacity(0.18)),
      ),
      child: Text(
        letter,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 16,
          color: brandGreen,
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.enabled,
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  static const Color brandGreen = Color(0xFF1F6E5C);

  final bool enabled;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final fg = danger ? Colors.red : brandGreen;
    final bg = danger ? Colors.red.withOpacity(0.10) : brandGreen.withOpacity(0.10);
    final border = danger ? Colors.red.withOpacity(0.25) : brandGreen.withOpacity(0.18);

    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(999),
      child: Opacity(
        opacity: enabled ? 1 : 0.40,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: fg),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w800, color: fg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
