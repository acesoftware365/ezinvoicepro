import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'legal_content.dart';

const _brandGreen = Color(0xFF1F6E5C);
const _supportEmail = 'sales@liisgo.com';
const _website = 'https://liisgo.com/#/apps/EzInvoice';
final _policyUpdatedAt = DateTime(2026, 6, 16);

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LegalDocumentScreen(document: _LegalDocument.privacy);
  }
}

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LegalDocumentScreen(document: _LegalDocument.terms);
  }
}

enum _LegalDocument { privacy, terms }

class _LegalDocumentScreen extends StatefulWidget {
  const _LegalDocumentScreen({required this.document});

  final _LegalDocument document;

  @override
  State<_LegalDocumentScreen> createState() => _LegalDocumentScreenState();
}

class _LegalDocumentScreenState extends State<_LegalDocumentScreen> {
  bool get _isPrivacy => widget.document == _LegalDocument.privacy;

  Future<void> _openUrl(String url, LegalContent copy) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(
      uri,
      mode: uri.scheme == 'mailto'
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication,
    );
    if (launched || !mounted) return;

    if (uri.scheme == 'mailto') {
      await _showEmailFallbackDialog(copy);
      return;
    }
    _showSnack(copy.couldNotOpenLink);
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _showEmailFallbackDialog(LegalContent copy) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(copy.emailSupportTitle),
        content: Text('${copy.emailFallback}\n\n$_supportEmail'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(copy.close),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await Clipboard.setData(const ClipboardData(text: _supportEmail));
              _showSnack(copy.emailCopied);
            },
            child: Text(copy.copyEmail),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final copy = LegalContent.forLocale(Localizations.localeOf(context));
    final document = _isPrivacy ? copy.privacy : copy.terms;
    final updated = DateFormat.yMMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(_policyUpdatedAt);

    return Theme(
      data: theme.copyWith(
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: _brandGreen,
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
        backgroundColor: const Color(0xFFF5F7F8),
        appBar: AppBar(title: Text(document.title)),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              Text(
                document.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${copy.lastUpdated}: $updated',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              for (final section in document.sections)
                _Section(title: section.title, body: section.body),
              const SizedBox(height: 10),
              if (_isPrivacy)
                _ContactCard(
                  copy: copy,
                  onWebsite: () => _openUrl(_website, copy),
                  onEmail: () => _openUrl(
                    'mailto:$_supportEmail?subject=${Uri.encodeComponent(copy.privacyEmailSubject)}',
                    copy,
                  ),
                )
              else
                OutlinedButton.icon(
                  onPressed: () => _openUrl(
                    'mailto:$_supportEmail?subject=${Uri.encodeComponent(copy.termsEmailSubject)}',
                    copy,
                  ),
                  icon: const Icon(Icons.email_outlined),
                  label: Text(copy.contactSupport),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(fontSize: 13.5, height: 1.35)),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.copy,
    required this.onWebsite,
    required this.onEmail,
  });

  final LegalContent copy;
  final VoidCallback onWebsite;
  final VoidCallback onEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6EAF0)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            copy.contact,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: onWebsite,
            icon: const Icon(Icons.public),
            label: Text(copy.visitWebsite),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: onEmail,
            icon: const Icon(Icons.email_outlined),
            label: Text(copy.emailSupport),
          ),
          const SizedBox(height: 6),
          Text(
            copy.contactFooter,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
