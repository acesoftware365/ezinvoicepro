import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../models/client.dart';
import '../../services/clients/clients_service.dart';

class ClientFormScreen extends NewClientScreen {
  const ClientFormScreen({super.key, super.client});
}

class NewClientScreen extends StatefulWidget {
  const NewClientScreen({super.key, this.client});

  final Client? client;

  @override
  State<NewClientScreen> createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
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
  bool _contactsLoading = false;
  List<Contact> _contacts = [];
  String _contactQuery = '';

  static const Color _primaryGreen = Color(0xFF1F7A63);
  static const Color _pageBg = Color(0xFFF5F6F8);
  static const Color _cardBorder = Color(0xFFE5EAF0);
  static const double _tabletBreakpoint = 720;

  bool get _isEdit => widget.client != null;

  @override
  void initState() {
    super.initState();
    final client = widget.client;
    if (client == null) return;

    _name.text = client.name;
    _email.text = client.email;
    _notes.text = client.notes;
    _phoneE164 = client.phoneE164;
    _phoneIso = client.phoneIso.isNotEmpty ? client.phoneIso : 'US';
    _phoneDisplay = client.phoneDisplay;
    _phoneText.text = _phoneDisplay;
    _phoneNumber = PhoneNumber(
      isoCode: _phoneIso,
      phoneNumber: _phoneE164.isNotEmpty ? _phoneE164 : null,
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _notes.dispose();
    _phoneText.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final t = AppLocalizations.of(context);
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    final name = _name.text.trim();
    if (name.isEmpty) return;

    setState(() => _saving = true);
    try {
      final client = Client(
        id: widget.client?.id ?? '',
        name: name,
        email: _email.text.trim(),
        phoneE164: _phoneE164.trim(),
        phoneDisplay:
            (_phoneDisplay.trim().isNotEmpty ? _phoneDisplay : _phoneText.text)
                .trim(),
        phoneIso: _phoneIso.trim().isNotEmpty ? _phoneIso.trim() : 'US',
        notes: _notes.text.trim(),
      );

      if (_isEdit) {
        await ClientsService.update(client);
      } else {
        await ClientsService.add(client);
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

  bool _isValidEmail(String value) {
    final email = value.trim();
    if (email.isEmpty) return true;
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$').hasMatch(email);
  }

  Future<bool> _loadContacts() async {
    if (_contactsLoading) return false;
    setState(() => _contactsLoading = true);

    try {
      // Contact import flow:
      // 1. Ask for read-only contacts permission only after the user taps Import.
      // 2. Load contacts with phone/email properties.
      // 3. Keep data local and use the selected contact only to prefill this form.
      final allowed = await FlutterContacts.requestPermission(readonly: true);
      if (!allowed) {
        if (!mounted) return false;
        _showSnack(AppLocalizations.of(context).permissionDeniedContacts);
        return false;
      }

      final contacts = await FlutterContacts.getContacts(withProperties: true);
      if (!mounted) return false;
      setState(() => _contacts = contacts);

      if (contacts.isEmpty) {
        _showSnack(AppLocalizations.of(context).noContactsFound);
      }
      return true;
    } catch (e) {
      if (!mounted) return false;
      _showSnack(AppLocalizations.of(context).contactsError(e.toString()));
      return false;
    } finally {
      if (mounted) setState(() => _contactsLoading = false);
    }
  }

  Future<void> _openContactPicker() async {
    final loaded = await _loadContacts();
    if (!mounted) return;
    if (!loaded) return;

    final picked = await showModalBottomSheet<PickedContact>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ContactPickerBottomSheet(
        contacts: _contacts,
        loading: _contactsLoading,
        onRefresh: () async {
          await _loadContacts();
        },
      ),
    );

    if (picked != null) _applyContact(picked);
  }

  void _applyContact(PickedContact contact) {
    final phone = _formatImportedPhone(contact.phone);
    setState(() {
      if (contact.name.trim().isNotEmpty) _name.text = contact.name.trim();
      if (contact.email.trim().isNotEmpty) _email.text = contact.email.trim();
      if (phone.isNotEmpty) {
        _phoneText.text = phone;
        _phoneDisplay = phone;
        _phoneE164 = '';
        _phoneIso = 'US';
      }
    });
  }

  String _formatImportedPhone(String raw) {
    var digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 11 && digits.startsWith('1')) {
      digits = digits.substring(1);
    }

    if (digits.length == 10) {
      return '${digits.substring(0, 3)}-${digits.substring(3, 6)}-${digits.substring(6)}';
    }

    if (digits.length == 9) {
      return '${digits.substring(0, 3)}-${digits.substring(3, 5)}-${digits.substring(5)}';
    }

    return digits;
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  List<Contact> get _filteredContacts {
    final query = _contactQuery.trim().toLowerCase();
    if (query.isEmpty) return _contacts;
    return _contacts.where((contact) {
      final name = contact.displayName.toLowerCase();
      final phones = contact.phones
          .map((p) => p.number.toLowerCase())
          .join(' ');
      final emails = contact.emails
          .map((e) => e.address.toLowerCase())
          .join(' ');
      return name.contains(query) ||
          phones.contains(query) ||
          emails.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        scaffoldBackgroundColor: _pageBg,
        colorScheme: theme.colorScheme.copyWith(
          primary: _primaryGreen,
          secondary: _primaryGreen,
          surface: Colors.white,
        ),
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: _pageBg,
          foregroundColor: const Color(0xFF17201C),
          elevation: 0,
          centerTitle: false,
          titleTextStyle: const TextStyle(
            color: Color(0xFF17201C),
            fontSize: 21,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
        inputDecorationTheme: _inputTheme(),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= _tabletBreakpoint;

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: _saving ? null : () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              ),
              title: Text(_isEdit ? t.editClientTitle : 'New Client'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: TextButton.icon(
                    onPressed: _saving ? null : _save,
                    icon: _saving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save_outlined),
                    label: Text(t.save),
                    style: TextButton.styleFrom(
                      foregroundColor: _primaryGreen,
                      textStyle: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: isTablet ? _tabletBody() : _phoneBody(),
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecorationTheme _inputTheme() {
    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFFBFCFD),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: border(_cardBorder),
      enabledBorder: border(_cardBorder),
      focusedBorder: border(_primaryGreen, 1.5),
      errorBorder: border(const Color(0xFFB3261E)),
      focusedErrorBorder: border(const Color(0xFFB3261E), 1.5),
      labelStyle: const TextStyle(
        color: Color(0xFF65726C),
        fontWeight: FontWeight.w600,
      ),
      floatingLabelStyle: const TextStyle(
        color: _primaryGreen,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _phoneBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ImportFromContactsButton(onPressed: _openContactPicker),
          const SizedBox(height: 16),
          ClientFormCard(
            nameController: _name,
            emailController: _email,
            notesController: _notes,
            phoneTextController: _phoneText,
            phoneNumber: _phoneNumber,
            saving: _saving,
            isEdit: _isEdit,
            onPhoneChanged: _onPhoneChanged,
            emailValidator: _isValidEmail,
          ),
          const SizedBox(height: 16),
          ClientSaveButton(
            label: _saving
                ? AppLocalizations.of(context).saving
                : 'Save Client',
            saving: _saving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }

  Widget _tabletBody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 360,
            child: _TabletContactsPanel(
              contacts: _filteredContacts,
              loading: _contactsLoading,
              query: _contactQuery,
              onQueryChanged: (value) => setState(() => _contactQuery = value),
              onLoadContacts: () async {
                await _loadContacts();
              },
              onSelected: _applyContact,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClientFormCard(
                      nameController: _name,
                      emailController: _email,
                      notesController: _notes,
                      phoneTextController: _phoneText,
                      phoneNumber: _phoneNumber,
                      saving: _saving,
                      isEdit: _isEdit,
                      onPhoneChanged: _onPhoneChanged,
                      emailValidator: _isValidEmail,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 220,
                        child: ClientSaveButton(
                          label: _saving
                              ? AppLocalizations.of(context).saving
                              : 'Save Client',
                          saving: _saving,
                          onPressed: _save,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPhoneChanged(PhoneNumber number) {
    _phoneE164 = number.phoneNumber ?? '';
    _phoneIso = number.isoCode ?? 'US';
    _phoneDisplay = _phoneText.text;
  }
}

class ClientFormCard extends StatelessWidget {
  const ClientFormCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.notesController,
    required this.phoneTextController,
    required this.phoneNumber,
    required this.saving,
    required this.isEdit,
    required this.onPhoneChanged,
    required this.emailValidator,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController notesController;
  final TextEditingController phoneTextController;
  final PhoneNumber phoneNumber;
  final bool saving;
  final bool isEdit;
  final ValueChanged<PhoneNumber> onPhoneChanged;
  final bool Function(String value) emailValidator;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return _PremiumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            icon: Icons.badge_outlined,
            title: 'Client Information',
          ),
          const SizedBox(height: 18),
          _Field(
            controller: nameController,
            label: 'Client Name',
            icon: Icons.person_outline_rounded,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if ((value ?? '').trim().isEmpty) return t.clientNameRequired;
              return null;
            },
          ),
          const SizedBox(height: 12),
          _Field(
            controller: emailController,
            label: 'Client Email (optional)',
            icon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              final email = (value ?? '').trim();
              if (email.isEmpty || emailValidator(email)) return null;
              return t.invalidEmailFormat;
            },
          ),
          const SizedBox(height: 12),
          _PhoneField(
            controller: phoneTextController,
            initialValue: phoneNumber,
            onChanged: onPhoneChanged,
          ),
          const SizedBox(height: 12),
          _Field(
            controller: notesController,
            label: 'Notes (optional)',
            icon: Icons.sticky_note_2_outlined,
            minLines: 3,
            maxLines: 5,
            textInputAction: TextInputAction.newline,
          ),
          const SizedBox(height: 14),
          const _TipCard(),
        ],
      ),
    );
  }
}

class ImportFromContactsButton extends StatelessWidget {
  const ImportFromContactsButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  static const Color _primaryGreen = Color(0xFF1F7A63);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFDCEFE8)),
            boxShadow: const [
              BoxShadow(
                blurRadius: 18,
                offset: Offset(0, 8),
                color: Color(0x12000000),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F5F0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.contacts_outlined,
                  color: _primaryGreen,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Import From Contacts',
                      style: TextStyle(
                        color: Color(0xFF17201C),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Fill name, phone, and email instantly.',
                      style: TextStyle(
                        color: Color(0xFF65726C),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: _primaryGreen),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactPickerBottomSheet extends StatefulWidget {
  const ContactPickerBottomSheet({
    super.key,
    required this.contacts,
    required this.loading,
    required this.onRefresh,
  });

  final List<Contact> contacts;
  final bool loading;
  final Future<void> Function() onRefresh;

  @override
  State<ContactPickerBottomSheet> createState() =>
      _ContactPickerBottomSheetState();
}

class _ContactPickerBottomSheetState extends State<ContactPickerBottomSheet> {
  String _query = '';

  List<Contact> get _filtered {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return widget.contacts;
    return widget.contacts.where((contact) {
      final name = contact.displayName.toLowerCase();
      final phones = contact.phones
          .map((p) => p.number.toLowerCase())
          .join(' ');
      final emails = contact.emails
          .map((e) => e.address.toLowerCase())
          .join(' ');
      return name.contains(query) ||
          phones.contains(query) ||
          emails.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.86,
      minChildSize: 0.55,
      maxChildSize: 0.96,
      expand: false,
      builder: (context, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF5F6F8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFD0D7DE),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 10, 8),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Import From Contacts',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
                child: _ContactSearchField(
                  onChanged: (value) => setState(() => _query = value),
                ),
              ),
              Expanded(
                child: widget.loading
                    ? const Center(child: CircularProgressIndicator())
                    : _ContactList(
                        controller: controller,
                        contacts: _filtered,
                        onRefresh: widget.onRefresh,
                        onSelected: (contact) =>
                            Navigator.pop(context, contact),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ContactListTile extends StatelessWidget {
  const ContactListTile({
    super.key,
    required this.contact,
    required this.onTap,
  });

  final PickedContact contact;
  final VoidCallback onTap;

  static const Color _primaryGreen = Color(0xFF1F7A63);

  @override
  Widget build(BuildContext context) {
    final subtitle = [
      contact.phone,
      contact.email,
    ].where((value) => value.trim().isNotEmpty).join('  •  ');

    return ListTile(
      minVerticalPadding: 12,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: const Color(0xFFE7F5F0),
        foregroundColor: _primaryGreen,
        child: const Icon(Icons.person_outline_rounded),
      ),
      title: Text(
        contact.name.isEmpty
            ? AppLocalizations.of(context).noName
            : contact.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
      subtitle: subtitle.isEmpty
          ? null
          : Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF65726C)),
            ),
      trailing: const Icon(
        Icons.add_circle_outline_rounded,
        color: _primaryGreen,
      ),
      onTap: onTap,
    );
  }
}

class ClientSaveButton extends StatelessWidget {
  const ClientSaveButton({
    super.key,
    required this.label,
    required this.saving,
    required this.onPressed,
  });

  final String label;
  final bool saving;
  final VoidCallback onPressed;

  static const Color _primaryGreen = Color(0xFF1F7A63);

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: saving ? null : onPressed,
      icon: saving
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Icon(Icons.check_rounded),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: _primaryGreen,
        foregroundColor: Colors.white,
        disabledBackgroundColor: _primaryGreen.withValues(alpha: 0.55),
        disabledForegroundColor: Colors.white,
        minimumSize: const Size.fromHeight(54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _TabletContactsPanel extends StatelessWidget {
  const _TabletContactsPanel({
    required this.contacts,
    required this.loading,
    required this.query,
    required this.onQueryChanged,
    required this.onLoadContacts,
    required this.onSelected,
  });

  final List<Contact> contacts;
  final bool loading;
  final String query;
  final ValueChanged<String> onQueryChanged;
  final Future<void> Function() onLoadContacts;
  final ValueChanged<PickedContact> onSelected;

  @override
  Widget build(BuildContext context) {
    return _PremiumCard(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height - 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImportFromContactsButton(onPressed: onLoadContacts),
            const SizedBox(height: 16),
            _ContactSearchField(onChanged: onQueryChanged),
            const SizedBox(height: 12),
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : _ContactList(
                      contacts: contacts,
                      onRefresh: onLoadContacts,
                      onSelected: onSelected,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactList extends StatelessWidget {
  const _ContactList({
    required this.contacts,
    required this.onRefresh,
    required this.onSelected,
    this.controller,
  });

  final List<Contact> contacts;
  final Future<void> Function() onRefresh;
  final ValueChanged<PickedContact> onSelected;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.contacts_outlined,
                size: 40,
                color: Color(0xFF1F7A63),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context).noContactsFound,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF65726C),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Load Contacts'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      controller: controller,
      itemCount: contacts.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, color: Color(0xFFE9EEF2)),
      itemBuilder: (context, index) {
        final picked = PickedContact.fromContact(contacts[index]);
        return ContactListTile(
          contact: picked,
          onTap: () => onSelected(picked),
        );
      },
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.minLines,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF1F7A63)),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({
    required this.controller,
    required this.initialValue,
    required this.onChanged,
  });

  final TextEditingController controller;
  final PhoneNumber initialValue;
  final ValueChanged<PhoneNumber> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFCFD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EAF0)),
      ),
      child: InternationalPhoneNumberInput(
        initialValue: initialValue,
        textFieldController: controller,
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.DROPDOWN,
          setSelectorButtonAsPrefixIcon: true,
          leadingPadding: 0,
        ),
        formatInput: true,
        autoValidateMode: AutovalidateMode.disabled,
        keyboardType: const TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        inputDecoration: const InputDecoration(
          labelText: 'Client Phone',
          prefixIcon: Icon(Icons.phone_outlined, color: Color(0xFF1F7A63)),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
        onInputChanged: onChanged,
      ),
    );
  }
}

class _ContactSearchField extends StatelessWidget {
  const _ContactSearchField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search contacts',
        prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF1F7A63)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE5EAF0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE5EAF0)),
        ),
      ),
    );
  }
}

class _PremiumCard extends StatelessWidget {
  const _PremiumCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5EAF0)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 22,
            offset: Offset(0, 10),
            color: Color(0x10000000),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFE7F5F0),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: const Color(0xFF1F7A63), size: 21),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF17201C),
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8F4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD6ECE4)),
      ),
      child: const Row(
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: Color(0xFF1F7A63)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Tip: Add email or phone to send invoices faster.',
              style: TextStyle(
                color: Color(0xFF315247),
                fontSize: 13,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PickedContact {
  const PickedContact({
    required this.name,
    required this.email,
    required this.phone,
  });

  final String name;
  final String email;
  final String phone;

  factory PickedContact.fromContact(Contact contact) {
    return PickedContact(
      name: contact.displayName.trim(),
      email: contact.emails.isNotEmpty
          ? contact.emails.first.address.trim()
          : '',
      phone: contact.phones.isNotEmpty
          ? contact.phones.first.number.trim()
          : '',
    );
  }
}
