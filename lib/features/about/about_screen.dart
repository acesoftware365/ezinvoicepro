import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  static const _brandGreen = Color(0xFF1F7A64);
  static const _pageBackground = Color(0xFFF5F7F8);
  static const _website = 'https://liisgo.com/#/apps/EzInvoice';
  static const _iosStore =
      'https://apps.apple.com/us/app/ezinvoice-pro/id6757661737';
  static const _androidStore =
      'https://play.google.com/store/apps/details?id=com.liisgo.ezinvoice&pcampaignid=web_share';
  static const _supportEmail = 'sales@liisgo.com';

  late final Future<PackageInfo> _packageInfo = PackageInfo.fromPlatform();

  Future<void> _open(Uri uri) async {
    final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).couldNotOpenLink)),
      );
    }
  }

  Future<void> _shareApp() async {
    final t = AppLocalizations.of(context);
    final storeUrl = Theme.of(context).platform == TargetPlatform.iOS
        ? _iosStore
        : _androidStore;
    await Share.share(t.shareAppText(storeUrl), subject: 'EzInvoice Pro');
  }

  Future<void> _showFeedbackSheet() async {
    final t = AppLocalizations.of(context);
    final copy = _AboutCopy(t);
    final feedback = await showModalBottomSheet<_FeedbackSubmission>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _FeedbackSheet(copy: copy),
    );
    if (feedback == null || !mounted) return;

    final info = await _packageInfo;
    if (!mounted) return;
    final isIdea = feedback.kind == _FeedbackKind.idea;
    final subject = t.feedbackEmailSubject(
      isIdea ? t.feedbackIdea : t.feedbackBug,
    );
    final body =
        '${feedback.message}\n\n— EzInvoice ${info.version} (${info.buildNumber})';
    await _open(
      Uri(
        scheme: 'mailto',
        path: _supportEmail,
        queryParameters: {'subject': subject, 'body': body},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final copy = _AboutCopy(t);
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: _brandGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: _pageBackground,
        appBar: AppBar(title: Text(copy.title)),
        body: SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 700;
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(
                      wide ? 28 : 16,
                      20,
                      wide ? 28 : 16,
                      32,
                    ),
                    children: [
                      _BrandHero(copy: copy, packageInfo: _packageInfo),
                      const SizedBox(height: 16),
                      _AboutActions(
                        wide: wide,
                        shareLabel: copy.shareAction,
                        feedbackLabel: copy.feedbackAction,
                        onShare: _shareApp,
                        onFeedback: _showFeedbackSheet,
                      ),
                      const SizedBox(height: 16),
                      if (wide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _AboutCard(
                                icon: Icons.auto_awesome_outlined,
                                title: copy.appTitle,
                                body: copy.appBody,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _AboutCard(
                                icon: Icons.business_outlined,
                                title: copy.companyTitle,
                                body: copy.companyBody,
                              ),
                            ),
                          ],
                        )
                      else ...[
                        _AboutCard(
                          icon: Icons.auto_awesome_outlined,
                          title: copy.appTitle,
                          body: copy.appBody,
                        ),
                        const SizedBox(height: 12),
                        _AboutCard(
                          icon: Icons.business_outlined,
                          title: copy.companyTitle,
                          body: copy.companyBody,
                        ),
                      ],
                      const SizedBox(height: 16),
                      _AboutCard(
                        icon: Icons.favorite_outline_rounded,
                        title: copy.promiseTitle,
                        body: copy.promiseBody,
                        tint: const Color(0xFFE6F5F0),
                      ),
                      const SizedBox(height: 18),
                      if (wide)
                        Row(
                          children: [
                            Expanded(
                              child: _AboutAction(
                                icon: Icons.language_rounded,
                                title: copy.websiteAction,
                                subtitle: 'liisgo.com',
                                onTap: () => _open(Uri.parse(_website)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _AboutAction(
                                icon: Icons.mail_outline_rounded,
                                title: copy.supportAction,
                                subtitle: _supportEmail,
                                onTap: () => _open(
                                  Uri(
                                    scheme: 'mailto',
                                    path: _supportEmail,
                                    queryParameters: {
                                      'subject': t.supportEmailSubject,
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      else ...[
                        _AboutAction(
                          icon: Icons.language_rounded,
                          title: copy.websiteAction,
                          subtitle: 'liisgo.com',
                          onTap: () => _open(Uri.parse(_website)),
                        ),
                        const SizedBox(height: 12),
                        _AboutAction(
                          icon: Icons.mail_outline_rounded,
                          title: copy.supportAction,
                          subtitle: _supportEmail,
                          onTap: () => _open(
                            Uri(
                              scheme: 'mailto',
                              path: _supportEmail,
                              queryParameters: {
                                'subject': t.supportEmailSubject,
                              },
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AboutActions extends StatelessWidget {
  const _AboutActions({
    required this.wide,
    required this.shareLabel,
    required this.feedbackLabel,
    required this.onShare,
    required this.onFeedback,
  });

  final bool wide;
  final String shareLabel;
  final String feedbackLabel;
  final VoidCallback onShare;
  final VoidCallback onFeedback;

  @override
  Widget build(BuildContext context) {
    final share = FilledButton.icon(
      onPressed: onShare,
      icon: const Icon(Icons.ios_share_rounded),
      label: Text(shareLabel),
      style: FilledButton.styleFrom(
        backgroundColor: _AboutScreenState._brandGreen,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(52),
        textStyle: const TextStyle(fontWeight: FontWeight.w900),
      ),
    );
    final feedback = OutlinedButton.icon(
      onPressed: onFeedback,
      icon: const Icon(Icons.lightbulb_outline_rounded),
      label: Text(feedbackLabel),
      style: OutlinedButton.styleFrom(
        foregroundColor: _AboutScreenState._brandGreen,
        side: const BorderSide(color: _AboutScreenState._brandGreen),
        minimumSize: const Size.fromHeight(52),
        textStyle: const TextStyle(fontWeight: FontWeight.w900),
      ),
    );

    if (wide) {
      return Row(
        children: [
          Expanded(child: share),
          const SizedBox(width: 12),
          Expanded(child: feedback),
        ],
      );
    }
    return Column(
      children: [
        SizedBox(width: double.infinity, child: share),
        const SizedBox(height: 10),
        SizedBox(width: double.infinity, child: feedback),
      ],
    );
  }
}

enum _FeedbackKind { idea, bug }

class _FeedbackSubmission {
  const _FeedbackSubmission({required this.kind, required this.message});

  final _FeedbackKind kind;
  final String message;
}

class _FeedbackSheet extends StatefulWidget {
  const _FeedbackSheet({required this.copy});

  final _AboutCopy copy;

  @override
  State<_FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends State<_FeedbackSheet> {
  final _message = TextEditingController();
  _FeedbackKind _kind = _FeedbackKind.idea;

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final copy = widget.copy;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          12,
          12,
          12,
          MediaQuery.viewInsetsOf(context).bottom + 12,
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFF202124).withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  copy.feedbackTitle,
                  style: const TextStyle(
                    color: Color(0xFF202124),
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  copy.feedbackSubtitle,
                  style: const TextStyle(
                    color: Color(0xFF5F6368),
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SegmentedButton<_FeedbackKind>(
                  segments: [
                    ButtonSegment(
                      value: _FeedbackKind.idea,
                      label: Text(copy.ideaLabel),
                      icon: const Icon(Icons.lightbulb_outline_rounded),
                    ),
                    ButtonSegment(
                      value: _FeedbackKind.bug,
                      label: Text(copy.bugLabel),
                      icon: const Icon(Icons.bug_report_outlined),
                    ),
                  ],
                  selected: {_kind},
                  onSelectionChanged: (selected) =>
                      setState(() => _kind = selected.first),
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    foregroundColor: WidgetStatePropertyAll(
                      _AboutScreenState._brandGreen,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _message,
                  minLines: 4,
                  maxLines: 6,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: copy.feedbackHint,
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: const Color(0xFFF5F7F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: _AboutScreenState._brandGreen,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      final message = _message.text.trim();
                      if (message.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(copy.feedbackRequired)),
                        );
                        return;
                      }
                      Navigator.pop(
                        context,
                        _FeedbackSubmission(kind: _kind, message: message),
                      );
                    },
                    icon: const Icon(Icons.send_rounded),
                    label: Text(copy.sendAction),
                    style: FilledButton.styleFrom(
                      backgroundColor: _AboutScreenState._brandGreen,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(52),
                      textStyle: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandHero extends StatelessWidget {
  const _BrandHero({required this.copy, required this.packageInfo});

  final _AboutCopy copy;
  final Future<PackageInfo> packageInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _AboutScreenState._brandGreen,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: _AboutScreenState._brandGreen.withValues(alpha: 0.24),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final narrow = constraints.maxWidth < 410;
          final logo = Container(
            width: 62,
            height: 62,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: const Text(
              'EZ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
          );
          final words = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EzInvoice',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                copy.tagline,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.82),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (narrow)
                Row(
                  children: [
                    logo,
                    const SizedBox(width: 14),
                    Expanded(child: words),
                  ],
                )
              else
                Row(
                  children: [
                    logo,
                    const SizedBox(width: 16),
                    Expanded(child: words),
                    _VersionBadge(packageInfo: packageInfo),
                  ],
                ),
              if (narrow) ...[
                const SizedBox(height: 14),
                _VersionBadge(packageInfo: packageInfo),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _VersionBadge extends StatelessWidget {
  const _VersionBadge({required this.packageInfo});

  final Future<PackageInfo> packageInfo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: packageInfo,
      builder: (context, snapshot) {
        final info = snapshot.data;
        final t = AppLocalizations.of(context);
        final version = t.versionLabel(
          info == null ? '' : '${info.version} (${info.buildNumber})',
        );
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
          ),
          child: Text(
            version,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        );
      },
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({
    required this.icon,
    required this.title,
    required this.body,
    this.tint = Colors.white,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _AboutScreenState._brandGreen.withValues(alpha: 0.11),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: _AboutScreenState._brandGreen, size: 21),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF202124),
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            body,
            style: const TextStyle(
              color: Color(0xFF5F6368),
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutAction extends StatelessWidget {
  const _AboutAction({
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
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black.withValues(alpha: 0.07)),
          ),
          child: Row(
            children: [
              Icon(icon, color: _AboutScreenState._brandGreen),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF202124),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF74787D),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: _AboutScreenState._brandGreen,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutCopy {
  const _AboutCopy(this.t);

  final AppLocalizations t;

  String get title => t.aboutTitle;
  String get tagline => t.aboutTagline;
  String get appTitle => t.aboutAppTitle;
  String get appBody => t.aboutAppBody;
  String get companyTitle => t.aboutCompanyTitle;
  String get companyBody => t.aboutCompanyBody;
  String get promiseTitle => t.aboutPromiseTitle;
  String get promiseBody => t.aboutPromiseBody;
  String get websiteAction => t.visitLiisgo;
  String get supportAction => t.contactSupport;
  String get shareAction => t.shareEzInvoice;
  String get feedbackAction => t.sendIdeaOrBug;
  String get feedbackTitle => t.feedbackTitle;
  String get feedbackSubtitle => t.feedbackSubtitle;
  String get ideaLabel => t.feedbackIdea;
  String get bugLabel => t.feedbackBug;
  String get feedbackHint => t.feedbackHint;
  String get feedbackRequired => t.feedbackRequired;
  String get sendAction => t.continueToEmail;
}
