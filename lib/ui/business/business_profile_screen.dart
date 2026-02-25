// lib/ui/business/business_profile_screen.dart

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezinvoice/features/paywall/paywall_screen.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/models/business_profile.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:ezinvoice/services/purchases/subscription_manager.dart';
import 'package:ezinvoice/services/style/app_theme_presets.dart';
import 'package:ezinvoice/utils/logo_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
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

  // ✅ NEW: presets
  final _presetCtrl = TextEditingController();
  List<String> _presets = [];

  String _currencyCode = 'USD';
  String _paletteId = AppThemePresets.paletteMinimal;
  String _invoiceLayoutId = AppThemePresets.layoutMinimal;
  String _reportLayoutId = AppThemePresets.layoutMinimal;
  bool _isProUser = false;

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
    _isProUser = await _resolveProStatus();
    _profile = p;

    _businessName.text = p.businessName;
    _ownerName.text = p.ownerName;
    _phone.text = p.phone;
    _email.text = p.email;
    _address.text = p.address;
    _taxRate.text = p.defaultTaxRate.toStringAsFixed(2);
    _currencyCode = p.currencyCode;
    _footer.text = p.footerNote;
    _paletteId = AppThemePresets.normalizePalette(p.paletteId);
    _invoiceLayoutId = AppThemePresets.normalizeLayout(p.invoiceLayoutId);
    _reportLayoutId = AppThemePresets.normalizeLayout(p.reportLayoutId);

    // ✅ NEW
    _presets = (p.servicePresets).toList();

    if (!mounted) return;
    setState(() => _loading = false);
  }

  Future<bool> _resolveProStatus() async {
    final managerIsPro = SubscriptionManager.instance.state.value.isPro;
    if (managerIsPro) return true;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    try {
      final snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = snap.data() ?? {};
      final plan = (data['plan'] ?? '').toString().toLowerCase().trim();
      final isPro = data['isPro'] == true || plan == 'pro';
      return isPro;
    } catch (_) {
      return managerIsPro;
    }
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

  // ✅ NEW: add preset
  Future<void> _addPreset() async {
    final t = AppLocalizations.of(context);
    final v = _presetCtrl.text.trim();
    if (v.isEmpty) return;

    // UI first
    final next = {..._presets, v}.toList()..sort((a, b) => a.compareTo(b));
    setState(() {
      _presets = next;
      _presetCtrl.clear();
    });

    try {
      await _repo.setPresets(next);
    } catch (_) {
      // rollback simple
      if (!mounted) return;
      setState(() => _presets = _presets.where((e) => e != v).toList());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.genericError)));
    }
  }

  // ✅ NEW: remove preset
  Future<void> _removePreset(String text) async {
    final t = AppLocalizations.of(context);
    final v = text.trim();
    if (v.isEmpty) return;

    final prev = _presets.toList();
    setState(() {
      _presets = _presets
          .where((e) => e.trim().toLowerCase() != v.toLowerCase())
          .toList();
    });

    try {
      await _repo.setPresets(_presets);
    } catch (_) {
      if (!mounted) return;
      setState(() => _presets = prev);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.genericError)));
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
      paletteId: _paletteId,
      invoiceLayoutId: _invoiceLayoutId,
      reportLayoutId: _reportLayoutId,
      // ✅ NEW
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

  Future<void> _saveDesignSettingsOnly() async {
    if (!_isProUser) return;

    final next = _profile.copyWith(
      paletteId: _paletteId,
      invoiceLayoutId: _invoiceLayoutId,
      reportLayoutId: _reportLayoutId,
    );

    try {
      await _repo.save(next);
      if (!mounted) return;
      setState(() => _profile = next);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _paletteId = AppThemePresets.normalizePalette(_profile.paletteId);
        _invoiceLayoutId = AppThemePresets.normalizeLayout(
          _profile.invoiceLayoutId,
        );
        _reportLayoutId = AppThemePresets.normalizeLayout(
          _profile.reportLayoutId,
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save design settings.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    // Brand
    const brandGreen = Color(0xFF1F6E5C);
    const brandGreenSoft = Color(0xFFE6F3EF);
    const pageBg = Color(0xFFF6F7F9);

    final logoPath = _profile.logoFilePath;
    final hasLogo =
        logoPath != null && logoPath.isNotEmpty && File(logoPath).existsSync();

    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Theme(
      data: theme.copyWith(
        scaffoldBackgroundColor: pageBg,
        colorScheme: cs.copyWith(primary: brandGreen, secondary: brandGreen),
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          filled: true,
          fillColor: Colors.white,
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: brandGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            t.businessProfileTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton.icon(
                onPressed: _loading ? null : _save,
                icon: _loading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save_outlined, color: Colors.white),
                label: Text(
                  t.save,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _card(
                          child: Row(
                            children: [
                              _logoAvatar(
                                hasLogo: hasLogo,
                                logoPath: logoPath,
                                brandGreen: brandGreen,
                                brandGreenSoft: brandGreenSoft,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    FilledButton.tonalIcon(
                                      onPressed: _pickLogo,
                                      icon: const Icon(Icons.image_outlined),
                                      label: Text(t.uploadLogo),
                                      style: FilledButton.styleFrom(
                                        backgroundColor: brandGreenSoft,
                                        foregroundColor: brandGreen,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    OutlinedButton.icon(
                                      onPressed: hasLogo ? _removeLogo : null,
                                      icon: const Icon(Icons.delete_outline),
                                      label: Text(t.remove),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        foregroundColor: Colors.redAccent,
                                        side: BorderSide(
                                          color: Colors.redAccent.withOpacity(
                                            0.35,
                                          ),
                                        ),
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        _sectionTitle(t.businessInfoSection),
                        const SizedBox(height: 10),

                        _field(
                          controller: _businessName,
                          label: t.businessNameLabel,
                          icon: Icons.business_outlined,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? t.requiredField
                              : null,
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

                        const SizedBox(height: 14),
                        _sectionTitle(t.settingsSection),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(child: _currencyDropdown(t, brandGreen)),
                            const SizedBox(width: 12),
                            Expanded(child: _taxField(t)),
                          ],
                        ),

                        const SizedBox(height: 14),
                        _sectionTitle(t.footerSection),
                        const SizedBox(height: 10),

                        _field(
                          controller: _footer,
                          label: t.footerNoteLabel,
                          icon: Icons.notes_outlined,
                          maxLines: 2,
                        ),

                        const SizedBox(height: 14),
                        _sectionTitle('Pro design'),
                        const SizedBox(height: 10),
                        _card(
                          child: _isProUser
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Choose palette and layouts for Invoice + Reports.',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.65),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    DropdownButtonFormField<String>(
                                      initialValue: _paletteId,
                                      decoration: const InputDecoration(
                                        labelText: 'Palette',
                                        prefixIcon: Icon(
                                          Icons.palette_outlined,
                                        ),
                                      ),
                                      items: AppThemePresets.palettes
                                          .map(
                                            (p) => DropdownMenuItem(
                                              value: p.id,
                                              child: Row(
                                                children: [
                                                  _paletteDot(p.primary),
                                                  const SizedBox(width: 6),
                                                  _paletteDot(p.accent),
                                                  const SizedBox(width: 8),
                                                  Text(p.label),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (v) async {
                                        setState(
                                          () => _paletteId =
                                              AppThemePresets.normalizePalette(
                                                v,
                                              ),
                                        );
                                        await _saveDesignSettingsOnly();
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    DropdownButtonFormField<String>(
                                      initialValue: _invoiceLayoutId,
                                      decoration: const InputDecoration(
                                        labelText: 'Invoice layout',
                                        prefixIcon: Icon(
                                          Icons.description_outlined,
                                        ),
                                      ),
                                      items: AppThemePresets.layouts
                                          .map(
                                            (p) => DropdownMenuItem(
                                              value: p.id,
                                              child: Text(p.label),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (v) async {
                                        setState(
                                          () => _invoiceLayoutId =
                                              AppThemePresets.normalizeLayout(
                                                v,
                                              ),
                                        );
                                        await _saveDesignSettingsOnly();
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    DropdownButtonFormField<String>(
                                      initialValue: _reportLayoutId,
                                      decoration: const InputDecoration(
                                        labelText: 'Report layout',
                                        prefixIcon: Icon(
                                          Icons.dashboard_outlined,
                                        ),
                                      ),
                                      items: AppThemePresets.layouts
                                          .map(
                                            (p) => DropdownMenuItem(
                                              value: p.id,
                                              child: Text(p.label),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (v) async {
                                        setState(
                                          () => _reportLayoutId =
                                              AppThemePresets.normalizeLayout(
                                                v,
                                              ),
                                        );
                                        await _saveDesignSettingsOnly();
                                      },
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Palette and layout customization are Pro features.',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    FilledButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const PaywallScreen(),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.workspace_premium_outlined,
                                      ),
                                      label: const Text('Upgrade to Pro'),
                                    ),
                                  ],
                                ),
                        ),

                        const SizedBox(height: 14),

                        // ✅ NEW: Service Presets
                        _sectionTitle('Service presets'),
                        const SizedBox(height: 10),
                        _card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Guarda descripciones frecuentes (ej: “Haircut”, “Car Wash”, “Consulting”).',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.65),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _presetCtrl,
                                      decoration: const InputDecoration(
                                        labelText: 'Add a service',
                                        prefixIcon: Icon(Icons.playlist_add),
                                      ),
                                      onSubmitted: (_) => _addPreset(),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  FilledButton(
                                    onPressed: _addPreset,
                                    style: FilledButton.styleFrom(
                                      backgroundColor: brandGreen,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Add'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              if (_presets.isEmpty)
                                Text(
                                  'No presets yet.',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.55),
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              else
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: _presets.map((p) {
                                    return Chip(
                                      label: Text(p),
                                      onDeleted: () => _removePreset(p),
                                      deleteIcon: const Icon(
                                        Icons.close,
                                        size: 18,
                                      ),
                                    );
                                  }).toList(),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: _loading ? null : _save,
                            icon: const Icon(Icons.save_outlined),
                            label: Text(t.saveChanges),
                            style: FilledButton.styleFrom(
                              backgroundColor: brandGreen,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
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
      padding: const EdgeInsets.all(14),
      child: child,
    );
  }

  Widget _logoAvatar({
    required bool hasLogo,
    required String? logoPath,
    required Color brandGreen,
    required Color brandGreenSoft,
  }) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: brandGreenSoft,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: brandGreen.withOpacity(0.20)),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasLogo
          ? Image.file(File(logoPath!), fit: BoxFit.cover)
          : Icon(Icons.storefront_outlined, color: brandGreen, size: 30),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 13,
        letterSpacing: 0.2,
        color: Colors.black.withOpacity(0.70),
      ),
    );
  }

  Widget _currencyDropdown(AppLocalizations t, Color brandGreen) {
    return DropdownButtonFormField<String>(
      key: ValueKey('currency_$_currencyCode'),
      initialValue: _currencyCode,
      decoration: InputDecoration(
        labelText: t.currencyLabel,
        prefixIcon: Icon(Icons.attach_money, color: brandGreen),
      ),
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

  Widget _paletteDot(int colorValue) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Color(colorValue),
        shape: BoxShape.circle,
      ),
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
