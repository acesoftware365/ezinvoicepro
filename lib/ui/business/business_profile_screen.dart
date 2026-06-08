// lib/ui/business/business_profile_screen.dart

import 'dart:io';

import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/models/business_profile.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:ezinvoice/utils/logo_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  static const brandGreen = Color(0xFF1F7A63);
  static const brandGreenSoft = Color(0xFFE7F3EF);
  static const pageBg = Color(0xFFF5F6F8);
  static const ink = Color(0xFF202124);
  static const muted = Color(0xFF74787D);

  final _repo = BusinessProfileRepository();
  final _formKey = GlobalKey<FormState>();

  bool _loading = true;
  BusinessProfile _profile = const BusinessProfile();

  final _businessName = TextEditingController();
  final _ownerName = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _taxRate = TextEditingController();
  final _footer = TextEditingController();
  final _presetCtrl = TextEditingController();

  List<String> _presets = [];
  String _currencyCode = 'USD';

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _businessName.dispose();
    _ownerName.dispose();
    _phone.dispose();
    _email.dispose();
    _address.dispose();
    _taxRate.dispose();
    _footer.dispose();
    _presetCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final p = await _repo.load();
    _profile = p;

    _businessName.text = p.businessName;
    _ownerName.text = p.ownerName;
    _phone.text = p.phone;
    _email.text = p.email;
    _address.text = p.address;
    _taxRate.text = p.defaultTaxRate.toStringAsFixed(2);
    _currencyCode = p.currencyCode;
    _footer.text = p.footerNote;
    _presets = p.servicePresets.toList();

    if (!mounted) return;
    setState(() => _loading = false);
  }

  double _parseTax(String v) {
    final raw = v.trim().replaceAll('%', '');
    final n = double.tryParse(raw) ?? 0.0;
    if (n < 0) return 0.0;
    if (n > 100) return 100.0;
    return n;
  }

  Future<void> _pickLogo() async {
    final picker = ImagePicker();
    final x = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (x == null) return;

    final savedPath = await LogoStorage.saveLogoFile(File(x.path));

    if (_profile.logoFilePath != null && _profile.logoFilePath != savedPath) {
      await LogoStorage.deleteLogoIfExists(_profile.logoFilePath);
    }

    if (!mounted) return;
    setState(() {
      _profile = _profile.copyWith(logoFilePath: savedPath);
    });
  }

  Future<void> _removeLogo() async {
    await LogoStorage.deleteLogoIfExists(_profile.logoFilePath);
    if (!mounted) return;
    setState(() {
      _profile = _profile.copyWith(logoFilePath: null);
    });
  }

  Future<void> _showPresetDialog({String? current}) async {
    var draft = current ?? '';
    final value = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(current == null ? 'Add service' : 'Edit service'),
        content: TextFormField(
          initialValue: draft,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Service name',
            prefixIcon: Icon(Icons.design_services_outlined),
          ),
          onChanged: (value) => draft = value,
          onFieldSubmitted: (v) => Navigator.of(dialogContext).pop(v.trim()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(draft.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (value == null || value.trim().isEmpty) return;

    final next = _presets
        .where((p) => current == null || p != current)
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toSet();
    next.add(value.trim());
    final sorted = next.toList()..sort((a, b) => a.compareTo(b));

    final previous = _presets.toList();
    setState(() => _presets = sorted);

    try {
      await _repo.setPresets(sorted);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(current == null ? 'Service added' : 'Service updated'),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _presets = previous);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).genericError)),
      );
    }
  }

  Future<void> _removePreset(String text) async {
    final prev = _presets.toList();
    setState(() {
      _presets = _presets
          .where((e) => e.trim().toLowerCase() != text.trim().toLowerCase())
          .toList();
    });

    try {
      await _repo.setPresets(_presets);
    } catch (_) {
      if (!mounted) return;
      setState(() => _presets = prev);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).genericError)),
      );
    }
  }

  Future<void> _save() async {
    final t = AppLocalizations.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final p = _profile.copyWith(
      businessName: _businessName.text.trim(),
      ownerName: _ownerName.text.trim(),
      phone: _phone.text.trim(),
      email: _email.text.trim(),
      address: _address.text.trim(),
      currencyCode: _currencyCode,
      defaultTaxRate: _parseTax(_taxRate.text),
      footerNote: _footer.text.trim(),
      servicePresets: _presets,
    );

    setState(() => _loading = true);
    await _repo.save(p);

    if (!mounted) return;
    setState(() {
      _profile = p;
      _loading = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(t.businessSavedSuccess)));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final logoPath = _profile.logoFilePath;
    final hasLogo =
        logoPath != null && logoPath.isNotEmpty && File(logoPath).existsSync();
    final isTablet = MediaQuery.sizeOf(context).width >= 760;

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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.07)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: brandGreen, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: pageBg,
          foregroundColor: ink,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          title: Text(
            t.businessProfileTitle,
            style: const TextStyle(color: ink, fontWeight: FontWeight.w900),
          ),
          actions: [
            IconButton.filledTonal(
              tooltip: t.save,
              onPressed: _loading ? null : _save,
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: brandGreen,
              ),
              icon: _loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
            ),
            const SizedBox(width: 12),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: brandGreen,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          onPressed: _loading ? null : () => _showPresetDialog(),
          child: const Icon(Icons.add),
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Form(
                  key: _formKey,
                  child: CustomScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          isTablet ? 24 : 16,
                          8,
                          isTablet ? 24 : 16,
                          96,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: isTablet
                              ? _tabletLayout(t, hasLogo, logoPath)
                              : _phoneLayout(t, hasLogo, logoPath),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _phoneLayout(AppLocalizations t, bool hasLogo, String? logoPath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _logoCard(t, hasLogo, logoPath, large: true),
        const SizedBox(height: 16),
        _businessInfoCard(t),
        const SizedBox(height: 16),
        _phoneSettingsLayout(t),
        const SizedBox(height: 16),
        _footerCard(t),
        const SizedBox(height: 16),
        _presetsCard(t),
      ],
    );
  }

  Widget _phoneSettingsLayout(AppLocalizations t) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final canUseTwoColumns = constraints.maxWidth >= 430;
        if (!canUseTwoColumns) {
          return Column(
            children: [
              _settingsCard(t, currencyOnly: true),
              const SizedBox(height: 12),
              _settingsCard(t, taxOnly: true),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _settingsCard(t, currencyOnly: true)),
            const SizedBox(width: 12),
            Expanded(child: _settingsCard(t, taxOnly: true)),
          ],
        );
      },
    );
  }

  Widget _tabletLayout(AppLocalizations t, bool hasLogo, String? logoPath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 320, child: _logoCard(t, hasLogo, logoPath)),
            const SizedBox(width: 20),
            Expanded(child: _businessInfoCard(t)),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _settingsCard(t, currencyOnly: true)),
            const SizedBox(width: 16),
            Expanded(child: _settingsCard(t, taxOnly: true)),
          ],
        ),
        const SizedBox(height: 18),
        _footerCard(t),
        const SizedBox(height: 18),
        _presetsCard(t),
      ],
    );
  }

  Widget _logoCard(
    AppLocalizations t,
    bool hasLogo,
    String? logoPath, {
    bool large = false,
  }) {
    return _card(
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: _CardTitle('Business Logo')),
              if (hasLogo)
                PopupMenuButton<String>(
                  tooltip: 'Logo options',
                  icon: const Icon(Icons.more_horiz),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onSelected: (value) {
                    if (value == 'change') _pickLogo();
                    if (value == 'remove') _removeLogo();
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: 'change',
                      child: _MenuRow(
                        icon: Icons.image_outlined,
                        label: 'Change Logo',
                      ),
                    ),
                    PopupMenuItem(
                      value: 'remove',
                      child: _MenuRow(
                        icon: Icons.delete_outline,
                        label: 'Remove Logo',
                        danger: true,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            width: large ? 128 : 118,
            height: large ? 128 : 118,
            decoration: BoxDecoration(
              color: brandGreenSoft,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: brandGreen.withValues(alpha: 0.18)),
            ),
            clipBehavior: Clip.antiAlias,
            child: hasLogo
                ? Image.file(File(logoPath!), fit: BoxFit.cover)
                : const Icon(
                    Icons.storefront_outlined,
                    color: brandGreen,
                    size: 52,
                  ),
          ),
          const SizedBox(height: 18),
          FilledButton.tonalIcon(
            onPressed: _pickLogo,
            icon: const Icon(Icons.upload_outlined),
            label: Text(t.uploadLogo),
            style: FilledButton.styleFrom(
              backgroundColor: brandGreenSoft,
              foregroundColor: brandGreen,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _businessInfoCard(AppLocalizations t) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(t.businessInfoSection),
          const SizedBox(height: 16),
          _field(
            controller: _businessName,
            label: t.businessNameLabel,
            icon: Icons.business_outlined,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? t.requiredField : null,
          ),
          _field(
            controller: _ownerName,
            label: t.ownerNameLabel,
            icon: Icons.person_outline,
          ),
          _field(
            controller: _phone,
            label: t.phoneLabel,
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          _field(
            controller: _email,
            label: t.email,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          _field(
            controller: _address,
            label: t.addressLabel,
            icon: Icons.location_on_outlined,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _settingsCard(
    AppLocalizations t, {
    bool currencyOnly = false,
    bool taxOnly = false,
  }) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(currencyOnly ? t.currencyLabel : t.taxDefaultLabel),
          const SizedBox(height: 14),
          if (!taxOnly) _currencyDropdown(t),
          if (!currencyOnly) _taxField(t),
        ],
      ),
    );
  }

  Widget _footerCard(AppLocalizations t) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(t.footerNoteLabel),
          const SizedBox(height: 14),
          _field(
            controller: _footer,
            label: 'Thank you for your business.',
            icon: Icons.notes_outlined,
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  Widget _presetsCard(AppLocalizations t) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _CardTitle(t.servicePresetsTitle)),
              IconButton.filledTonal(
                tooltip: t.servicePresetsAddButton,
                onPressed: () => _showPresetDialog(),
                style: IconButton.styleFrom(
                  backgroundColor: brandGreenSoft,
                  foregroundColor: brandGreen,
                ),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            t.servicePresetsHint,
            style: const TextStyle(color: muted, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          if (_presets.isEmpty)
            Text(
              t.noPresetsYet,
              style: const TextStyle(color: muted, fontWeight: FontWeight.w700),
            )
          else
            Column(
              children: [
                for (final preset in _presets)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    minLeadingWidth: 0,
                    leading: const Icon(
                      Icons.design_services_outlined,
                      color: brandGreen,
                    ),
                    title: Text(
                      preset,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: t.edit,
                          onPressed: () => _showPresetDialog(current: preset),
                          icon: const Icon(Icons.edit_outlined),
                        ),
                        IconButton(
                          tooltip: t.delete,
                          onPressed: () => _removePreset(preset),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: const Offset(0, 10),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _currencyDropdown(AppLocalizations t) {
    return DropdownButtonFormField<String>(
      key: ValueKey('currency_$_currencyCode'),
      initialValue: _currencyCode,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: t.currencyLabel,
        prefixIcon: const Icon(Icons.attach_money, color: brandGreen),
      ),
      selectedItemBuilder: (_) => const [
        Text('USD', overflow: TextOverflow.ellipsis),
        Text('DOP', overflow: TextOverflow.ellipsis),
        Text('EUR', overflow: TextOverflow.ellipsis),
      ],
      items: const [
        DropdownMenuItem(value: 'USD', child: Text('USD - \$')),
        DropdownMenuItem(value: 'DOP', child: Text('DOP - RD\$')),
        DropdownMenuItem(value: 'EUR', child: Text('EUR - €')),
      ],
      onChanged: (v) => setState(() => _currencyCode = v ?? 'USD'),
    );
  }

  Widget _taxField(AppLocalizations t) {
    return _field(
      controller: _taxRate,
      label: t.taxDefaultLabel,
      icon: Icons.percent,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (v) {
        final raw = (v ?? '').replaceAll('%', '').trim();
        final n = double.tryParse(raw);
        if (n == null) return t.invalidNumber;
        if (n < 0 || n > 100) return t.range0to100;
        return null;
      },
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _BusinessProfileScreenState.ink,
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.icon,
    required this.label,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? Colors.red : _BusinessProfileScreenState.ink;
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
