import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:ezinvoice/settings/locale_controller.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  // Verde EzInvoice (igual que Business Profile)
  static const Color _brandGreen = Color(0xFF1F6E5C);
  static const Color _pageBg = Color(0xFFF6F7F9);

  String _nativeName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'pt':
        return 'Português';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      case 'ar':
        return 'العربية';
      case 'hi':
        return 'हिन्दी';
      case 'ja':
        return '日本語';
      case 'ru':
        return 'Русский';
      case 'zh':
        return '中文';
      default:
        return code;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    // Todos los idiomas soportados (según gen-l10n)
    final codes = AppLocalizations.supportedLocales
        .map((l) => l.languageCode)
        .toSet()
        .toList()
      ..sort((a, b) {
        const preferred = ['en', 'es', 'pt', 'fr', 'de', 'ar', 'hi', 'ja', 'ru', 'zh'];
        final ia = preferred.indexOf(a);
        final ib = preferred.indexOf(b);
        if (ia == -1 && ib == -1) return a.compareTo(b);
        if (ia == -1) return 1;
        if (ib == -1) return -1;
        return ia.compareTo(ib);
      });

    final current = LocaleController.instance.locale?.languageCode; // null => system

    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Theme(
      data: theme.copyWith(
        scaffoldBackgroundColor: _pageBg,
        colorScheme: cs.copyWith(primary: _brandGreen, secondary: _brandGreen),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _brandGreen,
          foregroundColor: Colors.white,
          title: Text(
            t.settingsLanguage,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            Text(
              t.settingsLanguageDescription,
              style: const TextStyle(color: Colors.black54, height: 1.3),
            ),
            const SizedBox(height: 12),

            // ✅ System default
            _LangCard(
              icon: Icons.settings_suggest_outlined,
              title: t.systemDefault,
              subtitle: t.usePhoneLanguage,
              selected: current == null,
              onTap: () async => LocaleController.instance.setSystem(),
            ),

            const SizedBox(height: 10),
            Text(
              t.availableLanguages,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: Colors.black.withOpacity(0.65),
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 8),

            ...codes.map((code) {
              final selected = current == code;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _LangCard(
                  icon: Icons.language,
                  title: _nativeName(code),
                  subtitle: code.toUpperCase(),
                  selected: selected,
                  onTap: () async => LocaleController.instance.setLocale(Locale(code)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _LangCard extends StatelessWidget {
  const _LangCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  static const Color _brandGreen = Color(0xFF1F6E5C);

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? _brandGreen.withOpacity(0.35) : Colors.black.withOpacity(0.08),
            width: selected ? 1.4 : 1,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              offset: const Offset(0, 8),
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: selected ? _brandGreen.withOpacity(0.10) : Colors.black.withOpacity(0.04),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: selected ? _brandGreen : Colors.black54,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: _brandGreen)
            else
              const Icon(Icons.chevron_right, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
