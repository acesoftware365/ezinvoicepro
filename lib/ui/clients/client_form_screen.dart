import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


import '../../models/client.dart';
import '../../services/clients/clients_service.dart';

class ClientFormScreen extends StatefulWidget {
  final Client? client;
  const ClientFormScreen({super.key, this.client});

  @override
  State<ClientFormScreen> createState() => _ClientFormScreenState();
}

class _ClientFormScreenState extends State<ClientFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _notes = TextEditingController();

  final _phoneText = TextEditingController();
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'US');
  String _phoneE164 = '';
  String _phoneIso = 'US';
  String _phoneDisplay = '';

  bool _saving = false;

  // UI tokens
  static const Color brandGreen = Color(0xFF1F6E5C);
  static const Color brandGreenSoft = Color(0xFFE6F3EF);
  static const Color pageBg = Color(0xFFF6F7F9);

  bool _isValidEmail(String v) {
    final value = v.trim();
    if (value.isEmpty) return true; // email opcional
    final re = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');
    return re.hasMatch(value);
  }

  @override
  void initState() {
    super.initState();
    final c = widget.client;
    if (c != null) {
      _name.text = c.name;
      _email.text = c.email;
      _notes.text = c.notes;

      _phoneE164 = c.phoneE164;
      _phoneIso = (c.phoneIso.isNotEmpty) ? c.phoneIso : 'US';
      _phoneDisplay = c.phoneDisplay;

      _phoneText.text = _phoneDisplay;

      _phoneNumber = PhoneNumber(
        isoCode: _phoneIso,
        phoneNumber: _phoneE164.isNotEmpty ? _phoneE164 : null,
      );
    }
  }

  Future<void> _save() async {
    final t = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) return;

    final name = _name.text.trim();
    if (name.isEmpty) return;

    setState(() => _saving = true);

    try {
      final client = Client(
        id: widget.client?.id ?? '',
        name: name,
        email: _email.text.trim(),
        notes: _notes.text.trim(),
        phoneE164: _phoneE164.trim(),
        phoneIso: _phoneIso.trim(),
        phoneDisplay: _phoneDisplay.trim(),
      );

      if (widget.client == null) {
        await ClientsService.add(client);
      } else {
        await ClientsService.update(client);
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.errorSavingClient(e.toString()))),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _notes.dispose();
    _phoneText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isEdit = widget.client != null;

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
          title: Text(isEdit ? t.editClientTitle : t.newClientTitle),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton.icon(
                onPressed: _saving ? null : _save,
                icon: _saving
                    ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
                    : const Icon(Icons.save_outlined, color: Colors.white),
                label: Text(
                  t.save,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;
              final isSmall = w < 360;
              final pad = isSmall ? 12.0 : 16.0;

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(pad, 12, pad, 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(t.clientInfoSection),
                      const SizedBox(height: 10),

                      _field(
                        controller: _name,
                        label: t.clientNameLabel,
                        icon: Icons.person_outline,
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          if ((v ?? '').trim().isEmpty) return t.clientNameRequired;
                          return null;
                        },
                      ),

                      _field(
                        controller: _email,
                        label: t.clientEmailOptionalLabel,
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          final value = (v ?? '').trim();
                          if (value.isEmpty) return null;
                          if (!_isValidEmail(value)) return t.invalidEmailFormat;
                          return null;
                        },
                      ),

                      const SizedBox(height: 2),
                      _phoneField(t),

                      const SizedBox(height: 12),

                      _sectionTitle(t.notesLabel),
                      const SizedBox(height: 10),

                      _field(
                        controller: _notes,
                        label: t.notesHint,
                        icon: Icons.notes_outlined,
                        maxLines: 3,
                        textInputAction: TextInputAction.newline,
                      ),

                      const SizedBox(height: 18),

                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _saving ? null : _save,
                          icon: const Icon(Icons.check_circle_outline),
                          label: Text(_saving ? t.saving : t.saveChanges),
                          style: FilledButton.styleFrom(
                            backgroundColor: brandGreen,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: isSmall ? 12 : 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      _hintCard(
                        icon: Icons.lock_outline,
                        text: isEdit ? t.clientEditHint : t.clientCreateHint,
                      ),
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

  Widget _phoneField(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.10)),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            offset: const Offset(0, 8),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: InternationalPhoneNumberInput(
        initialValue: _phoneNumber,
        textFieldController: _phoneText,
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.DROPDOWN,
        ),
        formatInput: true,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
        inputDecoration: InputDecoration(
          labelText: t.clientPhoneOptionalLabel,
          prefixIcon: const Icon(Icons.phone_outlined, color: brandGreen),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onInputChanged: (PhoneNumber number) {
          _phoneE164 = number.phoneNumber ?? '';
          _phoneIso = number.isoCode ?? 'US';
          _phoneDisplay = _phoneText.text;
        },
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 13,
        letterSpacing: 0.2,
        color: Colors.black.withOpacity(0.70),
      ),
    );
  }

  Widget _hintCard({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: brandGreenSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: brandGreen.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Icon(icon, color: brandGreen),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, height: 1.3, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: brandGreen),
        ),
      ),
    );
  }
}
