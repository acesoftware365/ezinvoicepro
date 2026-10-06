import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:ezinvoice/utils/logo_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_autosave.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key, this.repository});
  final BusinessProfileRepository? repository;

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen>
    with WidgetsBindingObserver {
  static const green = Color(0xFF1F7A63);
  late final BusinessProfileRepository _repo;
  late final ProfileAutosave _autosave;
  final Map<String, TextEditingController> _fields = {
    for (final key in [
      'businessName',
      'ownerName',
      'phone',
      'email',
      'address',
      'footerNote',
      'defaultTaxRate',
    ])
      key: TextEditingController(),
  };
  final _editorTick = ValueNotifier<int>(0);
  bool _loading = true;
  bool _loadFailed = false;
  bool _logoBusy = false;
  bool _invalidTax = false;
  String _currency = 'USD';
  String? _logoData;
  List<String> _presets = [];

  @override
  void initState() {
    super.initState();
    _repo = widget.repository ?? BusinessProfileRepository();
    _autosave = ProfileAutosave(_repo.updateFields)..addListener(_refresh);
    WidgetsBinding.instance.addObserver(this);
    unawaited(_load());
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
      _editorTick.value++;
    }
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _loadFailed = false;
    });
    try {
      final profile = await _repo.load();
      if (!mounted) return;
      final map = profile.toMap();
      for (final entry in _fields.entries) {
        entry.value.text = entry.key == 'defaultTaxRate'
            ? profile.defaultTaxRate.toStringAsFixed(2)
            : (map[entry.key] ?? '').toString();
      }
      _currency = profile.currencyCode;
      _presets = profile.servicePresets.toList();
      _logoData = profile.logoDataBase64;
      if ((_logoData ?? '').isEmpty && profile.logoFilePath != null) {
        final file = File(profile.logoFilePath!);
        if (await file.exists()) {
          _logoData = base64Encode(await file.readAsBytes());
        }
      }
      if (!mounted) return;
      setState(() => _loading = false);
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          _loadFailed = true;
        });
      }
    }
  }

  void _changed(String key, String value) {
    if (key == 'defaultTaxRate') {
      final number = double.tryParse(
        value.trim().replaceAll(',', '.').replaceAll('%', ''),
      );
      _invalidTax =
          number == null || !number.isFinite || number < 0 || number > 100;
      if (_invalidTax) {
        _refresh();
        return;
      }
      _autosave.change({key: number});
    } else {
      _autosave.change({key: value});
    }
    _refresh();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) unawaited(_autosave.flush());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _autosave.removeListener(_refresh);
    _autosave.dispose();
    _editorTick.dispose();
    for (final controller in _fields.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickLogo() async {
    setState(() => _logoBusy = true);
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );
      if (image == null || !mounted) return;
      final bytes = await File(image.path).readAsBytes();
      final path = await LogoStorage.saveLogoBytes(bytes);
      if (!mounted) return;
      setState(() => _logoData = base64Encode(bytes));
      _autosave.change({'logoFilePath': path, 'logoDataBase64': _logoData});
      unawaited(_autosave.flush());
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).genericError)),
        );
      }
    } finally {
      if (mounted) setState(() => _logoBusy = false);
    }
  }

  void _removeLogo() {
    setState(() => _logoData = null);
    _autosave.change({'logoFilePath': null, 'logoDataBase64': null});
    unawaited(_autosave.flush());
  }

  void _savePresets() {
    final values = _presets
        .map((v) => v.trim())
        .where((v) => v.isNotEmpty)
        .toSet()
        .toList();
    _autosave.change({'servicePresets': values});
    _refresh();
  }

  Future<void> _editService([int? index]) async {
    final t = AppLocalizations.of(context);
    int? target = index;
    final controller = TextEditingController(
      text: index == null ? '' : _presets[index],
    );
    await _edit(
      t.servicePresetsTitle,
      (context) => TextField(
        key: const ValueKey('service-editor'),
        controller: controller,
        minLines: 1,
        maxLines: 4,
        decoration: InputDecoration(labelText: t.addServiceLabel),
        onChanged: (value) {
          if (target == null) {
            if (value.trim().isEmpty) return;
            target = _presets.length;
            _presets.add(value);
          } else {
            _presets[target!] = value;
          }
          _savePresets();
        },
      ),
    );
    // Dispose only after the closing route's animation releases the field.
    Future<void>.delayed(const Duration(milliseconds: 400), controller.dispose);
    if (mounted) setState(() => _presets.removeWhere((s) => s.trim().isEmpty));
  }

  Future<void> _edit(String title, WidgetBuilder content) async {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      constraints: const BoxConstraints(maxWidth: 640),
      builder: (sheetContext) => AnimatedBuilder(
        animation: Listenable.merge([_autosave, _editorTick]),
        builder: (context, _) {
          final t = AppLocalizations.of(context);
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, limits) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: limits.maxHeight * .94,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              IconButton(
                                iconSize: 28,
                                constraints: const BoxConstraints(
                                  minWidth: 52,
                                  minHeight: 52,
                                ),
                                key: const ValueKey('close-editor'),
                                tooltip: t.close,
                                onPressed: () => Navigator.pop(sheetContext),
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  t.profileAutosaveHint,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 16),
                                content(context),
                                const SizedBox(height: 12),
                                _status(t),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
    unawaited(_autosave.flush());
    _refresh();
  }

  Widget _status(AppLocalizations t) {
    final error = _autosave.hasError;
    final label = _invalidTax
        ? t.profileTaxInvalid
        : error
        ? t.profileSaveError
        : _autosave.hasPending
        ? t.saving
        : t.profileSaved;
    return Semantics(
      liveRegion: true,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 4,
        children: [
          Icon(
            _invalidTax || error
                ? Icons.error_outline
                : _autosave.hasPending
                ? Icons.cloud_upload_outlined
                : Icons.cloud_done_outlined,
            size: 20,
            color: _invalidTax || error ? Colors.deepOrange : green,
          ),
          Text(label, key: const ValueKey('save-status')),
          if (error)
            TextButton(onPressed: _autosave.flush, child: Text(t.profileRetry)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 8,
                children: [
                  Text(
                    t.businessProfileTitle,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (!_loading && !_loadFailed) _status(t),
                ],
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _loadFailed
                  ? Center(
                      child: FilledButton.icon(
                        onPressed: _load,
                        icon: const Icon(Icons.refresh),
                        label: Text(t.profileRetry),
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final scaled =
                            MediaQuery.textScalerOf(context).scale(16) / 16;
                        final twoColumns =
                            constraints.maxWidth >= 760 && scaled <= 1.3;
                        final main = Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _businessCard(t),
                            const SizedBox(height: 16),
                            _presetsCard(t),
                          ],
                        );
                        final secondary = Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _logoCard(t),
                            const SizedBox(height: 16),
                            _defaultsCard(t),
                            const SizedBox(height: 16),
                            _footerCard(t),
                          ],
                        );
                        return SingleChildScrollView(
                          key: const PageStorageKey('business-profile-scroll'),
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1120),
                              child: twoColumns
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(flex: 3, child: main),
                                        const SizedBox(width: 20),
                                        Expanded(flex: 2, child: secondary),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        _businessCard(t),
                                        const SizedBox(height: 16),
                                        _logoCard(t),
                                        const SizedBox(height: 16),
                                        _defaultsCard(t),
                                        const SizedBox(height: 16),
                                        _footerCard(t),
                                        const SizedBox(height: 16),
                                        _presetsCard(t),
                                      ],
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(
    String title,
    Widget child, {
    VoidCallback? edit,
    String? editLabel,
    String? id,
  }) {
    final t = AppLocalizations.of(context);
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (edit != null)
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(52, 52),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      iconSize: 28,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: green.withValues(alpha: .08),
                    ),
                    key: id == null ? null : ValueKey<String>(id),
                    onPressed: edit,
                    icon: Icon(
                      editLabel == null ? Icons.edit_outlined : Icons.add,
                      size: 28,
                    ),
                    label: Text(editLabel ?? t.edit),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _value(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 3),
        Text(
          value.trim().isEmpty ? '—' : value,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    ),
  );

  Widget _businessCard(AppLocalizations t) => _card(
    t.businessInfoSection,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _value(t.businessNameLabel, _fields['businessName']!.text),
        _value(t.ownerNameLabel, _fields['ownerName']!.text),
        _value(t.phoneLabel, _fields['phone']!.text),
        _value(t.email, _fields['email']!.text),
        _value(t.addressLabel, _fields['address']!.text),
      ],
    ),
    id: 'edit-business',
    edit: () => _edit(
      t.businessInfoSection,
      (_) => Column(
        children: [
          _field('businessName', t.businessNameLabel),
          _field('ownerName', t.ownerNameLabel),
          _field('phone', t.phoneLabel, type: TextInputType.phone),
          _field('email', t.email, type: TextInputType.emailAddress),
          _field('address', t.addressLabel, multiline: true),
        ],
      ),
    ),
  );

  Widget _logoCard(AppLocalizations t) {
    Widget preview = const Icon(
      Icons.storefront_outlined,
      size: 40,
      color: green,
    );
    if ((_logoData ?? '').isNotEmpty) {
      try {
        preview = Image.memory(
          base64Decode(_logoData!),
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => const Icon(Icons.broken_image_outlined),
        );
      } catch (_) {
        /* Placeholder for a malformed stored image. */
      }
    }
    return _card(
      t.profileLogo,
      Wrap(
        spacing: 16,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: green.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: preview,
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  minimumSize: const Size(52, 52),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  iconSize: 28,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor: green.withValues(alpha: .08),
                ),
                onPressed: _logoBusy ? null : _pickLogo,
                icon: const Icon(Icons.upload_outlined),
                label: Text(t.uploadLogo),
              ),
              if ((_logoData ?? '').isNotEmpty)
                TextButton.icon(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(52, 52),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    iconSize: 28,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: green.withValues(alpha: .08),
                  ),
                  onPressed: _logoBusy ? null : _removeLogo,
                  icon: const Icon(Icons.delete_outline),
                  label: Text(t.delete),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _defaultsCard(AppLocalizations t) => _card(
    t.profileDefaults,
    Wrap(
      spacing: 32,
      runSpacing: 8,
      children: [
        _value(t.currencyLabel, _currency),
        _value(t.taxDefaultLabel, '${_fields['defaultTaxRate']!.text}%'),
      ],
    ),
    id: 'edit-defaults',
    edit: () => _edit(
      t.profileDefaults,
      (context) => Column(
        children: [
          DropdownButtonFormField<String>(
            initialValue: _currency,
            isExpanded: true,
            decoration: InputDecoration(labelText: t.currencyLabel),
            items: {
              // Common choices first; remaining currencies ordered by code.
              ...['USD', 'EUR', 'DOP', 'CAD', 'MXN', 'GBP'],
              ...[
                'AED',
                'ARS',
                'AUD',
                'BDT',
                'BGN',
                'BHD',
                'BOB',
                'BRL',
                'CHF',
                'CLP',
                'CNY',
                'COP',
                'CRC',
                'CZK',
                'DKK',
                'EGP',
                'GTQ',
                'HKD',
                'HNL',
                'HUF',
                'IDR',
                'ILS',
                'INR',
                'ISK',
                'JMD',
                'JPY',
                'KES',
                'KRW',
                'KWD',
                'MAD',
                'MYR',
                'NGN',
                'NIO',
                'NOK',
                'NZD',
                'PAB',
                'PEN',
                'PHP',
                'PKR',
                'PLN',
                'PYG',
                'QAR',
                'RON',
                'SAR',
                'SEK',
                'SGD',
                'THB',
                'TRY',
                'TTD',
                'TWD',
                'UAH',
                'UYU',
                'VND',
                'ZAR',
              ],
              _currency,
            }.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: (value) {
              if (value != null) {
                _currency = value;
                _autosave.change({'currencyCode': value});
              }
            },
          ),
          const SizedBox(height: 16),
          _field(
            'defaultTaxRate',
            t.taxDefaultLabel,
            type: const TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
    ),
  );

  Widget _footerCard(AppLocalizations t) => _card(
    t.footerNoteLabel,
    Text(
      _fields['footerNote']!.text.isEmpty ? '—' : _fields['footerNote']!.text,
    ),
    id: 'edit-footer',
    edit: () => _edit(
      t.footerNoteLabel,
      (_) => _field('footerNote', t.footerNoteLabel, multiline: true),
    ),
  );

  Widget _presetsCard(AppLocalizations t) => _card(
    t.servicePresetsTitle,
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_presets.isEmpty) Text(t.noPresetsYet),
        for (var i = 0; i < _presets.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 4,
              children: [
                Text(_presets[i], style: Theme.of(context).textTheme.bodyLarge),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      iconSize: 28,
                      constraints: const BoxConstraints(
                        minWidth: 52,
                        minHeight: 52,
                      ),
                      tooltip: t.edit,
                      onPressed: () => _editService(i),
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      iconSize: 28,
                      constraints: const BoxConstraints(
                        minWidth: 52,
                        minHeight: 52,
                      ),
                      tooltip: t.delete,
                      onPressed: () {
                        _presets.removeAt(i);
                        _savePresets();
                      },
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    ),
    id: 'add-service',
    editLabel: t.servicePresetsAddButton,
    edit: () => _editService(),
  );

  Widget _field(
    String key,
    String label, {
    TextInputType? type,
    bool multiline = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextField(
      key: ValueKey('field-$key'),
      controller: _fields[key],
      keyboardType:
          type ?? (multiline ? TextInputType.multiline : TextInputType.text),
      minLines: 1,
      maxLines: multiline ? 6 : 1,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        errorText: key == 'defaultTaxRate' && _invalidTax
            ? AppLocalizations.of(context).range0to100
            : null,
      ),
      onChanged: (value) => _changed(key, value),
    ),
  );
}
