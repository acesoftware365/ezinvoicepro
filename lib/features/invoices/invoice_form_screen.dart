// lib/features/invoices/invoice_form_screen.dart

import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/models/client.dart';
import 'package:ezinvoice/services/clients/clients_service.dart';
import 'package:ezinvoice/services/invoices/invoices_service.dart' hide InvoiceItem, Invoice;

import 'package:ezinvoice/services/plan/plan_guard.dart';

class InvoiceFormScreen extends StatefulWidget {
  final Invoice? invoice;

  const InvoiceFormScreen({super.key, this.invoice});

  @override
  State<InvoiceFormScreen> createState() => _InvoiceFormScreenState();
}

class _InvoiceFormScreenState extends State<InvoiceFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _invoiceNumber = TextEditingController();
  final _clientName = TextEditingController();
  final _clientEmail = TextEditingController();
  final _clientPhone = TextEditingController();

  final _taxRate = TextEditingController(text: '6.35');

  // ✅ Presets
  final _bpRepo = BusinessProfileRepository();
  List<String> _presets = [];

  // ✅ Tip mode + values
  bool _tipIsPercent = true;
  final _tipPercent = TextEditingController(text: '0');
  final _tipAmount = TextEditingController(text: '0');

  final _message = TextEditingController();

  bool _saving = false;
  bool _loading = true;

  String _clientId = '';
  int _createdAtMs = DateTime.now().millisecondsSinceEpoch;

  // ✅ Due Date
  int? _dueAtMs;

  // ✅ Payment state (UI)
  String _status = InvoiceStatus.unpaid; // unpaid|paid
  int? _paidAtMs;
  String _paymentMethod = PaymentMethod.other;
  final _paymentNoteCtrl = TextEditingController();

  final List<InvoiceItem> _items = [];

  bool get _isEdit => widget.invoice != null;

  // 🎨 Brand
  static const brandGreen = Color(0xFF1F6E5C);
  static const brandGreenSoft = Color(0xFFE6F3EF);
  static const pageBg = Color(0xFFF6F7F9);

  double _toDouble(String s) => double.tryParse(s.trim().replaceAll(',', '')) ?? 0;

  double get _taxRateValue => _toDouble(_taxRate.text);
  double get _subtotalValue => _items.fold(0.0, (sum, it) => sum + it.lineTotal);
  double get _taxAmount => _subtotalValue * (_taxRateValue / 100.0);

  double get _tipPercentValue => _toDouble(_tipPercent.text);
  double get _tipAmountValue => _toDouble(_tipAmount.text);

  double get _tipFinal {
    if (_tipIsPercent) {
      final p = _tipPercentValue;
      if (p <= 0) return 0;
      return _subtotalValue * (p / 100.0);
    }
    final v = _tipAmountValue;
    return v < 0 ? 0 : v;
  }

  double get _totalValue => _subtotalValue + _taxAmount + _tipFinal;

  bool _isValidEmail(String v) {
    final value = v.trim();
    if (value.isEmpty) return true;
    final re = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');
    return re.hasMatch(value);
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _loadPresets() async {
    final p = await _bpRepo.load();
    if (!mounted) return;
    setState(() => _presets = (p.servicePresets));
  }

  Future<void> _refreshPresets() async {
    final list = await _bpRepo.loadPresets();
    if (!mounted) return;
    setState(() => _presets = list);
  }

  Future<void> _savePresetFromText(String text) async {
    final v = text.trim();
    if (v.isEmpty) return;
    try {
      await _bpRepo.addPreset(v);
      await _refreshPresets();
      _snack('Saved as preset: $v');
    } catch (e) {
      _snack('Error saving preset: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPresets();
    _boot();
  }

  Future<void> _boot() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      // ✅ GUARD GLOBAL: si es NEW invoice y es Free con límite → NO deja entrar
      if (!_isEdit) {
        final ok = await PlanGuard.ensureCanCreateInvoice(context);
        if (!ok) {
          if (mounted) Navigator.pop(context);
          return;
        }
      }

      await _initSafe();
    });
  }

  Future<void> _initSafe() async {
    try {
      if (_isEdit) {
        final inv = widget.invoice!;
        _invoiceNumber.text = inv.invoiceNumber;

        _clientId = inv.clientId;
        _clientName.text = inv.clientName;
        _clientEmail.text = inv.clientEmail;
        _clientPhone.text = inv.clientPhoneE164;

        _createdAtMs = inv.createdAtMs;

        // ✅ dueAtMs si existe
        try {
          _dueAtMs = (inv as dynamic).dueAtMs as int?;
        } catch (_) {
          _dueAtMs = null;
        }

        _taxRate.text = inv.taxRate.toStringAsFixed(2);
        _message.text = inv.message;

        _items
          ..clear()
          ..addAll(inv.items.isNotEmpty
              ? inv.items
              : [
            InvoiceItem(
              description: 'Service',
              dateMs: _createdAtMs,
              qty: 1,
              price: 0,
            )
          ]);

        _tipIsPercent = inv.tipIsPercent;

        if (_tipIsPercent) {
          _tipPercent.text = inv.tipPercent.toStringAsFixed(2);
          _tipAmount.text = '0';
        } else {
          _tipAmount.text = inv.tip.toStringAsFixed(2);
          _tipPercent.text = '0';
        }

        // ✅ Payment state
        _status = inv.status;
        _paidAtMs = inv.paidAtMs;
        _paymentMethod = inv.paymentMethod;
        _paymentNoteCtrl.text = inv.paymentNote;
      } else {
        _createdAtMs = DateTime.now().millisecondsSinceEpoch;

        String invNo;
        try {
          invNo = await InvoicesService.generateInvoiceNumber();
        } catch (_) {
          invNo = 'INV-${DateTime.now().millisecondsSinceEpoch}';
        }

        double tax;
        try {
          tax = await InvoicesService.getDefaultTaxRate();
        } catch (_) {
          tax = 6.35;
        }

        _invoiceNumber.text = invNo;
        _taxRate.text = tax.toStringAsFixed(2);

        _items
          ..clear()
          ..add(
            InvoiceItem(
              description: 'Service',
              dateMs: _createdAtMs,
              qty: 1,
              price: 0,
            ),
          );

        _tipIsPercent = true;
        _tipPercent.text = '0';
        _tipAmount.text = '0';

        // ✅ defaults payment for new
        _status = InvoiceStatus.unpaid;
        _paidAtMs = null;
        _paymentMethod = PaymentMethod.other;
        _paymentNoteCtrl.text = '';
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _formatDate(int ms) {
    final d = DateTime.fromMillisecondsSinceEpoch(ms);
    final mm = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    return '${d.year}-$mm-$dd';
  }

  Future<void> _pickClient() async {
    final picked = await showModalBottomSheet<_PickedClient>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _ClientPickerSheet(),
    );

    if (picked == null) return;

    setState(() {
      _clientId = picked.clientId;
      _clientName.text = picked.name;
      _clientEmail.text = picked.email;
      _clientPhone.text = picked.phone;
    });
  }

  Future<void> _pickItemDate(int index) async {
    final old = _items[index];
    final currentMs = old.dateMs ?? _createdAtMs;
    final current = DateTime.fromMillisecondsSinceEpoch(currentMs);

    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;

    final ms = DateTime(picked.year, picked.month, picked.day).millisecondsSinceEpoch;

    setState(() {
      _items[index] = InvoiceItem(
        description: old.description,
        dateMs: ms,
        qty: old.qty,
        price: old.price,
      );
    });
  }

  Future<void> _pickDueDate() async {
    final base = _dueAtMs != null
        ? DateTime.fromMillisecondsSinceEpoch(_dueAtMs!)
        : DateTime.fromMillisecondsSinceEpoch(_createdAtMs);

    final picked = await showDatePicker(
      context: context,
      initialDate: base,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;

    final ms = DateTime(picked.year, picked.month, picked.day).millisecondsSinceEpoch;
    setState(() => _dueAtMs = ms);
  }

  void _addItem() {
    setState(() {
      _items.add(
        InvoiceItem(
          description: '',
          dateMs: _createdAtMs,
          qty: 1,
          price: 0,
        ),
      );
    });
  }

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }

  // =========================
  // ✅ PAYMENT UI ACTIONS
  // =========================

  Future<void> _markPaidFlow() async {
    if (!_isEdit) return;
    final invId = widget.invoice!.id;

    final res = await showDialog<_PayResult>(
      context: context,
      builder: (_) => _MarkPaidDialog(
        initialMethod: _paymentMethod,
        initialNote: _paymentNoteCtrl.text,
      ),
    );

    if (res == null) return;

    setState(() => _saving = true);
    try {
      await InvoicesService.markAsPaid(
        id: invId,
        paymentMethod: res.method,
        paymentNote: res.note,
      );

      final nowMs = DateTime.now().millisecondsSinceEpoch;
      setState(() {
        _status = InvoiceStatus.paid;
        _paidAtMs = nowMs;
        _paymentMethod = res.method;
        _paymentNoteCtrl.text = res.note;
      });
    } catch (e) {
      _snack('Error marking paid: $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _markUnpaid() async {
    if (!_isEdit) return;
    final invId = widget.invoice!.id;

    setState(() => _saving = true);
    try {
      await InvoicesService.markAsUnpaid(id: invId);

      setState(() {
        _status = InvoiceStatus.unpaid;
        _paidAtMs = null;
        _paymentMethod = PaymentMethod.other;
        _paymentNoteCtrl.text = '';
      });
    } catch (e) {
      _snack('Error marking unpaid: $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _save() async {
    final t = AppLocalizations.of(context);

    if (_items.isEmpty) {
      _snack(t.addAtLeastOneItem);
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    // ✅ EXTRA SEGURIDAD: antes de guardar NEW invoice también valida
    if (!_isEdit) {
      final ok = await PlanGuard.ensureCanCreateInvoice(context);
      if (!ok) return;
    }

    setState(() => _saving = true);
    try {
      final storedTipPercent = _tipIsPercent ? _tipPercentValue : 0.0;

      final inv = Invoice(
        id: widget.invoice?.id ?? '',
        invoiceNumber: _invoiceNumber.text.trim(),
        clientId: _clientId,
        clientName: _clientName.text.trim(),
        clientEmail: _clientEmail.text.trim(),
        clientPhoneE164: _clientPhone.text.trim(),
        createdAtMs: _createdAtMs,
        items: List.of(_items),

        subtotal: _subtotalValue,
        taxRate: _taxRateValue,
        taxAmount: _taxAmount,
        tip: _tipFinal,
        tipIsPercent: _tipIsPercent,
        tipPercent: storedTipPercent,
        total: _totalValue,
        message: _message.text.trim(),

        status: _status,
        paidAtMs: _paidAtMs,
        paymentMethod: _paymentMethod,
        paymentNote: _paymentNoteCtrl.text.trim(),
      );

      if (_isEdit) {
        await InvoicesService.update(widget.invoice!.id, inv);

        // ✅ Guardar dueAtMs si tu schema lo usa
        try {
          await InvoicesService.updateDueAtMs(widget.invoice!.id, _dueAtMs);
        } catch (_) {
          // si no existe updateDueAtMs, ignora
        }
      } else {
        await InvoicesService.add(inv);
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      _snack(t.errorSavingInvoice(e.toString()));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _invoiceNumber.dispose();
    _clientName.dispose();
    _clientEmail.dispose();
    _clientPhone.dispose();
    _taxRate.dispose();
    _tipPercent.dispose();
    _tipAmount.dispose();
    _message.dispose();
    _paymentNoteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final isPaid = _status == InvoiceStatus.paid;

    return Theme(
      data: theme.copyWith(
        scaffoldBackgroundColor: pageBg,
        colorScheme: cs.copyWith(primary: brandGreen, secondary: brandGreen),
        appBarTheme: const AppBarTheme(
          backgroundColor: brandGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.black.withOpacity(0.10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.black.withOpacity(0.10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: brandGreen, width: 1.6),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEdit ? t.editInvoiceTitle : t.newInvoiceTitle),
          actions: [
            TextButton.icon(
              onPressed: _saving ? null : _pickClient,
              icon: const Icon(Icons.person_search, color: Colors.white, size: 18),
              label: Text(
                t.pickClient,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: 6),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: brandGreen,
          foregroundColor: Colors.white,
          onPressed: _addItem,
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;
              final isSmall = w < 360;
              final pad = isSmall ? 12.0 : 16.0;
              final twoCols = w >= 520;

              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(pad, 12, pad, 24),
                  children: [
                    _card(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _invoiceNumber,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: t.invoiceAutoNumberLabel,
                              prefixIcon: const Icon(Icons.receipt_long_outlined),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _infoRow(
                            icon: Icons.calendar_month_outlined,
                            title: t.invoiceDateLabel(_formatDate(_createdAtMs)),
                          ),
                          const SizedBox(height: 10),

                          InkWell(
                            onTap: _pickDueDate,
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                color: brandGreenSoft,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: brandGreen.withOpacity(0.18)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.event_available, size: 18, color: brandGreen),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Due Date: ${_dueAtMs == null ? '-' : _formatDate(_dueAtMs!)}',
                                      style: const TextStyle(fontWeight: FontWeight.w800),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right, color: brandGreen),
                                ],
                              ),
                            ),
                          ),

                          if (_isEdit) ...[
                            const SizedBox(height: 12),
                            _paymentCard(isPaid: isPaid),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),
                    _sectionTitle(t.pickClient),
                    const SizedBox(height: 8),

                    _card(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _clientName,
                            decoration: InputDecoration(
                              labelText: t.clientNameLabel,
                              prefixIcon: const Icon(Icons.person_outline),
                            ),
                            validator: (v) => (v ?? '').trim().isEmpty ? t.clientNameRequired : null,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _clientEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: t.clientEmailOptionalLabel,
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                            validator: (v) {
                              final value = (v ?? '').trim();
                              if (value.isEmpty) return null;
                              if (!_isValidEmail(value)) return t.invalidEmailFormat;
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _clientPhone,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: t.clientPhoneOptionalLabel,
                              prefixIcon: const Icon(Icons.phone_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),
                    _sectionTitle(t.itemsTitle),
                    const SizedBox(height: 8),

                    ...List.generate(_items.length, (i) {
                      final item = _items[i];
                      final itemDateMs = item.dateMs ?? _createdAtMs;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _card(
                          child: Column(
                            children: [
                              // ✅ Description + presets + typing
                              _PresetDescriptionField(
                                label: t.descriptionLabel,
                                presets: _presets,
                                initial: item.description,
                                onChanged: (v) {
                                  _items[i] = InvoiceItem(
                                    description: v,
                                    dateMs: itemDateMs,
                                    qty: item.qty,
                                    price: item.price,
                                  );
                                  setState(() {});
                                },
                                validatorMsg: t.requiredField,
                              ),

                              const SizedBox(height: 8),

                              // ✅ Save as preset (si tiene texto)
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: item.description.trim().isEmpty
                                      ? null
                                      : () => _savePresetFromText(item.description),
                                  icon: const Icon(Icons.bookmark_add_outlined, size: 18),
                                  label: const Text('Save as preset'),
                                ),
                              ),

                              const SizedBox(height: 6),

                              InkWell(
                                onTap: () => _pickItemDate(i),
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: brandGreenSoft,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: brandGreen.withOpacity(0.18)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.event, size: 18, color: brandGreen),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          t.itemDateLabel(_formatDate(itemDateMs)),
                                          style: const TextStyle(fontWeight: FontWeight.w800),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(Icons.chevron_right, color: brandGreen),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              if (twoCols) ...[
                                Row(
                                  children: [
                                    Expanded(child: _qtyField(i, item, itemDateMs, t)),
                                    const SizedBox(width: 12),
                                    Expanded(child: _priceField(i, item, itemDateMs, t)),
                                  ],
                                ),
                              ] else ...[
                                _qtyField(i, item, itemDateMs, t),
                                const SizedBox(height: 10),
                                _priceField(i, item, itemDateMs, t),
                              ],

                              const SizedBox(height: 10),

                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      t.lineTotalLabel(item.lineTotal.toStringAsFixed(2)),
                                      style: const TextStyle(fontWeight: FontWeight.w900),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: _items.length <= 1 ? null : () => _removeItem(i),
                                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 8),
                    _sectionTitle('Tax & Tip'),
                    const SizedBox(height: 8),

                    _card(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _taxRate,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: t.taxDefaultOwnerLabel,
                              prefixIcon: const Icon(Icons.percent),
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              Expanded(
                                child: ChoiceChip(
                                  label: Text(t.tipPercentChip),
                                  selected: _tipIsPercent,
                                  onSelected: (_) => setState(() => _tipIsPercent = true),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ChoiceChip(
                                  label: Text(t.tipAmountChip),
                                  selected: !_tipIsPercent,
                                  onSelected: (_) => setState(() => _tipIsPercent = false),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          if (_tipIsPercent)
                            TextFormField(
                              controller: _tipPercent,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                labelText: t.tipPercentLabel,
                                prefixIcon: const Icon(Icons.percent),
                              ),
                              onChanged: (_) => setState(() {}),
                            )
                          else
                            TextFormField(
                              controller: _tipAmount,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                labelText: t.tipAmountLabel,
                                prefixIcon: const Icon(Icons.attach_money),
                              ),
                              onChanged: (_) => setState(() {}),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),
                    _sectionTitle(t.messageOptionalLabel),
                    const SizedBox(height: 8),

                    _card(
                      child: TextFormField(
                        controller: _message,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: t.messageOptionalLabel,
                          prefixIcon: const Icon(Icons.chat_outlined),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    _sectionTitle('Totals'),
                    const SizedBox(height: 8),

                    _card(
                      child: Column(
                        children: [
                          _totalRow(t.subtotalTitle, _subtotalValue),
                          _totalRow(t.taxTitle, _taxAmount),
                          _totalRow(t.tipTitle, _tipFinal),
                          const Divider(height: 22),
                          _totalRow(t.totalTitle, _totalValue, strong: true),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _saving ? null : _save,
                        icon: _saving
                            ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                            : const Icon(Icons.save_outlined),
                        label: Text(_saving ? t.saving : (_isEdit ? t.updateInvoice : t.saveInvoice)),
                        style: FilledButton.styleFrom(
                          backgroundColor: brandGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ✅ Payment UI card
  Widget _paymentCard({required bool isPaid}) {
    final paidDate = (_paidAtMs ?? 0) > 0 ? _formatDate(_paidAtMs!) : '-';

    Color badgeColor;
    String badgeText;

    if (isPaid) {
      badgeColor = Colors.green.shade700;
      badgeText = 'PAID';
    } else {
      badgeColor = Colors.orange.shade800;
      badgeText = 'UNPAID';
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: badgeColor.withOpacity(0.35)),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: badgeColor,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  isPaid ? 'Paid date: $paidDate' : 'Not paid yet',
                  style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black.withOpacity(0.70)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          if (isPaid) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Method: ${_paymentMethod.toUpperCase()}',
                    style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black.withOpacity(0.70)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (_paymentNoteCtrl.text.trim().isNotEmpty) ...[
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Note: ${_paymentNoteCtrl.text.trim()}',
                  style: TextStyle(color: Colors.black.withOpacity(0.60), fontWeight: FontWeight.w600),
                ),
              ),
            ],
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _saving ? null : _markUnpaid,
                icon: const Icon(Icons.undo),
                label: const Text('Mark as Unpaid'),
              ),
            ),
          ] else ...[
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _saving ? null : _markPaidFlow,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Mark as Paid'),
                style: FilledButton.styleFrom(
                  backgroundColor: brandGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  textStyle: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _qtyField(int i, InvoiceItem item, int itemDateMs, AppLocalizations t) {
    return TextFormField(
      initialValue: item.qty.toString(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: t.qtyLabel,
        prefixIcon: const Icon(Icons.numbers),
      ),
      onChanged: (v) {
        final qty = _toDouble(v);
        _items[i] = InvoiceItem(
          description: item.description,
          dateMs: itemDateMs,
          qty: qty <= 0 ? 1 : qty,
          price: item.price,
        );
        setState(() {});
      },
    );
  }

  Widget _priceField(int i, InvoiceItem item, int itemDateMs, AppLocalizations t) {
    return TextFormField(
      initialValue: item.price.toStringAsFixed(2),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: t.priceLabel,
        prefixIcon: const Icon(Icons.attach_money),
      ),
      onChanged: (v) {
        final price = _toDouble(v);
        _items[i] = InvoiceItem(
          description: item.description,
          dateMs: itemDateMs,
          qty: item.qty,
          price: price < 0 ? 0 : price,
        );
        setState(() {});
      },
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: child,
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 13,
        letterSpacing: 0.2,
        color: Colors.black.withOpacity(0.72),
      ),
    );
  }

  Widget _infoRow({required IconData icon, required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: brandGreenSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: brandGreen.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: brandGreen),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w800),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalRow(String label, double value, {bool strong = false}) {
    final txt = value.toStringAsFixed(2);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: strong ? FontWeight.w900 : FontWeight.w700,
                color: Colors.black.withOpacity(0.70),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            txt,
            style: TextStyle(
              fontWeight: strong ? FontWeight.w900 : FontWeight.w800,
              color: strong ? brandGreen : Colors.black.withOpacity(0.88),
            ),
          ),
        ],
      ),
    );
  }
}

/// ✅ Autocomplete + free typing
class _PresetDescriptionField extends StatefulWidget {
  final String label;
  final List<String> presets;
  final String initial;
  final ValueChanged<String> onChanged;
  final String validatorMsg;

  const _PresetDescriptionField({
    required this.label,
    required this.presets,
    required this.initial,
    required this.onChanged,
    required this.validatorMsg,
  });

  @override
  State<_PresetDescriptionField> createState() => _PresetDescriptionFieldState();
}

class _PresetDescriptionFieldState extends State<_PresetDescriptionField> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initial);
    _ctrl.addListener(() => widget.onChanged(_ctrl.text));
  }

  @override
  void didUpdateWidget(covariant _PresetDescriptionField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initial != widget.initial && _ctrl.text != widget.initial) {
      _ctrl.text = widget.initial;
      _ctrl.selection = TextSelection.fromPosition(TextPosition(offset: _ctrl.text.length));
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (text) {
        final q = text.text.trim().toLowerCase();
        if (q.isEmpty) return widget.presets;
        return widget.presets.where((s) => s.toLowerCase().contains(q));
      },
      onSelected: (v) {
        _ctrl.text = v;
        _ctrl.selection = TextSelection.fromPosition(TextPosition(offset: _ctrl.text.length));
      },
      fieldViewBuilder: (context, textCtrl, focusNode, onFieldSubmitted) {
        // mantén el controller principal
        textCtrl.value = _ctrl.value;

        textCtrl.addListener(() {
          if (_ctrl.text != textCtrl.text) _ctrl.value = textCtrl.value;
        });

        return TextFormField(
          controller: textCtrl,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: widget.label,
            prefixIcon: const Icon(Icons.subject_outlined),
          ),
          validator: (v) => (v ?? '').trim().isEmpty ? widget.validatorMsg : null,
        );
      },
    );
  }
}

// =========================
// ✅ Bottom sheet picker
// =========================
class _ClientPickerSheet extends StatefulWidget {
  const _ClientPickerSheet();

  @override
  State<_ClientPickerSheet> createState() => _ClientPickerSheetState();
}

class _ClientPickerSheetState extends State<_ClientPickerSheet> {
  int _tab = 0;

  bool _contactsLoading = false;
  List<Contact> _contacts = [];

  String _q = '';

  static const brandGreen = Color(0xFF1F6E5C);

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _loadContacts() async {
    setState(() => _contactsLoading = true);
    try {
      final ok = await FlutterContacts.requestPermission(readonly: true);
      if (!ok) {
        _snack(context, AppLocalizations.of(context).permissionDeniedContacts);
        return;
      }

      final list = await FlutterContacts.getContacts(withProperties: true);

      if (list.isEmpty) {
        _snack(context, AppLocalizations.of(context).noContactsFound);
      }

      setState(() => _contacts = list);
    } catch (e) {
      _snack(context, AppLocalizations.of(context).contactsError(e.toString()));
    } finally {
      if (mounted) setState(() => _contactsLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final filteredContacts = _contacts.where((c) {
      if (_q.trim().isEmpty) return true;
      final name = c.displayName.toLowerCase();
      final q = _q.toLowerCase();
      return name.contains(q);
    }).toList();

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.90,
          builder: (_, controller) => Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        t.pickClient,
                        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
                child: TextField(
                  onChanged: (v) => setState(() => _q = v),
                  decoration: InputDecoration(
                    hintText: 'Search…',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.04),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _tabBtn(
                          text: t.savedTab,
                          selected: _tab == 0,
                          onTap: () => setState(() => _tab = 0),
                        ),
                      ),
                      Expanded(
                        child: _tabBtn(
                          text: t.contactsTab,
                          selected: _tab == 1,
                          onTap: () async {
                            setState(() => _tab = 1);
                            if (_contacts.isEmpty && !_contactsLoading) {
                              await _loadContacts();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: _tab == 0
                    ? StreamBuilder<List<Client>>(
                  stream: ClientsService.streamClients(),
                  builder: (context, s) {
                    final items = (s.data ?? [])
                        .where((c) => _q.trim().isEmpty ? true : c.name.toLowerCase().contains(_q.toLowerCase()))
                        .toList();

                    if (items.isEmpty) {
                      return Center(child: Text(t.noSavedClients));
                    }

                    return ListView.separated(
                      controller: controller,
                      itemCount: items.length,
                      separatorBuilder: (_, __) => Divider(height: 0, color: Colors.black.withOpacity(0.06)),
                      itemBuilder: (_, i) {
                        final c = items[i];
                        final sub = [c.email, c.phoneDisplay].where((e) => e.trim().isNotEmpty).join(' • ');

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: brandGreen.withOpacity(0.10),
                            foregroundColor: brandGreen,
                            child: const Icon(Icons.person_outline),
                          ),
                          title: Text(c.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                          subtitle: sub.isEmpty ? null : Text(sub, maxLines: 1, overflow: TextOverflow.ellipsis),
                          onTap: () => Navigator.pop(
                            context,
                            _PickedClient(
                              clientId: c.id,
                              name: c.name,
                              email: c.email,
                              phone: c.phoneE164,
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
                    : _contactsLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                  controller: controller,
                  itemCount: filteredContacts.length,
                  separatorBuilder: (_, __) => Divider(height: 0, color: Colors.black.withOpacity(0.06)),
                  itemBuilder: (_, i) {
                    final c = filteredContacts[i];

                    final name = c.displayName.trim();
                    final email = c.emails.isNotEmpty ? c.emails.first.address : '';
                    final phone = c.phones.isNotEmpty ? c.phones.first.number : '';

                    final title = name.isEmpty ? t.noName : name;
                    final sub = [email, phone].where((e) => e.trim().isNotEmpty).join(' • ');

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: brandGreen.withOpacity(0.10),
                        foregroundColor: brandGreen,
                        child: const Icon(Icons.contact_phone_outlined),
                      ),
                      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: sub.isEmpty ? null : Text(sub, maxLines: 1, overflow: TextOverflow.ellipsis),
                      onTap: () => Navigator.pop(
                        context,
                        _PickedClient(
                          clientId: '',
                          name: title == t.noName ? '' : title,
                          email: email,
                          phone: phone,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabBtn({required String text, required bool selected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? brandGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black.withOpacity(0.70),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

class _PickedClient {
  final String clientId;
  final String name;
  final String email;
  final String phone;

  _PickedClient({
    required this.clientId,
    required this.name,
    required this.email,
    required this.phone,
  });
}

// =========================
// ✅ Mark Paid Dialog
// =========================

class _PayResult {
  final String method;
  final String note;
  _PayResult({required this.method, required this.note});
}

class _MarkPaidDialog extends StatefulWidget {
  final String initialMethod;
  final String initialNote;

  const _MarkPaidDialog({
    required this.initialMethod,
    required this.initialNote,
  });

  @override
  State<_MarkPaidDialog> createState() => _MarkPaidDialogState();
}

class _MarkPaidDialogState extends State<_MarkPaidDialog> {
  late String _method;
  late TextEditingController _note;

  @override
  void initState() {
    super.initState();
    _method = widget.initialMethod;
    _note = TextEditingController(text: widget.initialNote);
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Mark as Paid'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            initialValue: _method,
            decoration: const InputDecoration(
              labelText: 'Payment method',
              prefixIcon: Icon(Icons.payments_outlined),
            ),
            items: const [
              DropdownMenuItem(value: PaymentMethod.cash, child: Text('Cash')),
              DropdownMenuItem(value: PaymentMethod.zelle, child: Text('Zelle')),
              DropdownMenuItem(value: PaymentMethod.card, child: Text('Card')),
              DropdownMenuItem(value: PaymentMethod.check, child: Text('Check')),
              DropdownMenuItem(value: PaymentMethod.other, child: Text('Other')),
            ],
            onChanged: (v) => setState(() => _method = v ?? PaymentMethod.other),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _note,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Note (optional)',
              prefixIcon: Icon(Icons.edit_note_outlined),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            Navigator.pop(context, _PayResult(method: _method, note: _note.text.trim()));
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
