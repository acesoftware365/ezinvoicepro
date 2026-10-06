import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:flutter/material.dart';

import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/models/client.dart';
import 'package:ezinvoice/services/clients/clients_service.dart';
import 'package:ezinvoice/ui/clients/client_form_screen.dart';
import 'package:ezinvoice/services/invoices/invoices_service.dart';

import 'package:ezinvoice/services/plan/plan_guard.dart';

int? _toNullableInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is num) return v.toInt();
  try {
    if (v.runtimeType.toString().contains('Timestamp')) {
      return (v as dynamic).millisecondsSinceEpoch;
    }
  } catch (_) {}
  if (v is String) return int.tryParse(v);
  return null;
}

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
  bool _editingTaxRate = false;

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

  double _toDouble(String s) =>
      double.tryParse(s.trim().replaceAll(',', '')) ?? 0;

  double get _taxRateValue => _toDouble(_taxRate.text);
  double get _subtotalValue =>
      _items.fold(0.0, (sum, it) => sum + it.lineTotal);
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
    final t = AppLocalizations.of(context);
    final v = text.trim();
    if (v.isEmpty) return;
    if (_presets.any((preset) => preset.toLowerCase() == v.toLowerCase())) {
      _snack(t.savedServiceAlreadyExists(v));
      return;
    }
    try {
      await _bpRepo.addPreset(v);
      await _refreshPresets();
      _snack(t.savedService(v));
    } catch (e) {
      _snack(t.savePresetError(e));
    }
  }

  Future<void> _selectPresetForItem(int index) async {
    final t = AppLocalizations.of(context);
    if (_presets.isEmpty) {
      await _refreshPresets();
    }
    if (!mounted) return;

    if (_presets.isEmpty) {
      _snack(t.noSavedServicesToUse);
      return;
    }

    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ServicePresetPickerSheet(presets: _presets),
    );
    if (selected == null || selected.trim().isEmpty || !mounted) return;
    if (index < 0 || index >= _items.length) return;

    final current = _items[index];
    setState(() {
      _items[index] = InvoiceItem(
        description: selected.trim(),
        dateMs: current.dateMs ?? _createdAtMs,
        qty: current.qty,
        price: current.price,
      );
    });
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
          _dueAtMs = _toNullableInt((inv as dynamic).dueAtMs);
        } catch (_) {
          _dueAtMs = null;
        }

        _taxRate.text = inv.taxRate.toStringAsFixed(2);
        _message.text = inv.message;

        _items
          ..clear()
          ..addAll(
            inv.items.isNotEmpty
                ? inv.items
                : [
                    InvoiceItem(
                      description: AppLocalizations.of(context).service,
                      dateMs: _createdAtMs,
                      qty: 1,
                      price: 0,
                    ),
                  ],
          );

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
              description: AppLocalizations.of(context).service,
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
    _applyClient(picked);
  }

  void _applyClient(_PickedClient client) {
    setState(() {
      _clientId = client.clientId;
      _clientName.text = client.name;
      _clientEmail.text = client.email;
      _clientPhone.text = client.phone;
    });
  }

  void _clearClient() {
    setState(() {
      _clientId = '';
      _clientName.clear();
      _clientEmail.clear();
      _clientPhone.clear();
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

    final ms = DateTime(
      picked.year,
      picked.month,
      picked.day,
    ).millisecondsSinceEpoch;

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

    final ms = DateTime(
      picked.year,
      picked.month,
      picked.day,
    ).millisecondsSinceEpoch;
    setState(() => _dueAtMs = ms);
  }

  void _addItem() {
    setState(() {
      _items.add(
        InvoiceItem(description: '', dateMs: _createdAtMs, qty: 1, price: 0),
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
      _snack(AppLocalizations.of(context).invoiceMarkPaidError(e));
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
      _snack(AppLocalizations.of(context).invoiceMarkUnpaidError(e));
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
    if (_clientName.text.trim().isEmpty) {
      _snack(t.clientNameRequired);
      await _pickClient();
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
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEdit ? t.editInvoiceTitle : t.newInvoiceTitle),
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
              final textScale = MediaQuery.textScalerOf(context).scale(16) / 16;
              final amountTextScale = textScale.clamp(1.0, 1.7).toDouble();
              // The amount inputs can share a row as soon as their *usable*
              // width can keep the label, icon, and value comfortably legible.
              // Larger text returns to one column instead of squeezing controls.
              final itemContentWidth = w - (pad * 2) - 28;
              final minAmountFieldWidth = 108.0 * amountTextScale;
              final useTwoColumnLineAmounts =
                  itemContentWidth >= (minAmountFieldWidth * 2) + 12;
              final wideLayoutMinWidth =
                  840.0 * (textScale > 1 ? textScale * 0.9 : 1);
              final useWideInvoiceLayout = w >= wideLayoutMinWidth;

              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(pad, 12, pad, 24),
                  children: [
                    if (useWideInvoiceLayout)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: _invoiceDetailsCard(t, isPaid: isPaid),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _sectionTitle(t.pickClient),
                                const SizedBox(height: 8),
                                _clientCard(t),
                              ],
                            ),
                          ),
                        ],
                      )
                    else ...[
                      _invoiceDetailsCard(t, isPaid: isPaid),
                      const SizedBox(height: 12),
                      _sectionTitle(t.pickClient),
                      const SizedBox(height: 8),
                      _clientCard(t),
                    ],

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
                              _ItemDescriptionField(
                                label: t.descriptionLabel,
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
                                onSavePreset: item.description.trim().isEmpty
                                    ? null
                                    : () =>
                                          _savePresetFromText(item.description),
                              ),

                              const SizedBox(height: 12),

                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  key: ValueKey('choose-saved-service-$i'),
                                  onPressed: () => _selectPresetForItem(i),
                                  icon: const Icon(
                                    Icons.playlist_add_check_outlined,
                                    size: 18,
                                  ),
                                  label: Text(t.chooseSavedService),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(48),
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              InkWell(
                                onTap: () => _pickItemDate(i),
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: brandGreenSoft,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: brandGreen.withOpacity(0.18),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.event,
                                        size: 18,
                                        color: brandGreen,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          t.itemDateLabel(
                                            _formatDate(itemDateMs),
                                          ),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                        color: brandGreen,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              if (useTwoColumnLineAmounts) ...[
                                Row(
                                  children: [
                                    Expanded(
                                      child: _qtyField(i, item, itemDateMs, t),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _priceField(
                                        i,
                                        item,
                                        itemDateMs,
                                        t,
                                      ),
                                    ),
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
                                      t.lineTotalLabel(
                                        item.lineTotal.toStringAsFixed(2),
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: _items.length <= 1
                                        ? null
                                        : () => _removeItem(i),
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 8),
                    _sectionTitle(t.taxAndTip),
                    const SizedBox(height: 8),

                    _card(child: _taxAndTipControls(t)),

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
                    _sectionTitle(t.totals),
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
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.save_outlined),
                        label: Text(
                          _saving
                              ? t.saving
                              : (_isEdit ? t.updateInvoice : t.saveInvoice),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: brandGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
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

  Widget _invoiceDetailsCard(AppLocalizations t, {required bool isPaid}) {
    return _card(
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
                  const Icon(
                    Icons.event_available,
                    size: 18,
                    color: brandGreen,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      t.dueDate(
                        _dueAtMs == null ? '-' : _formatDate(_dueAtMs!),
                      ),
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
    );
  }

  Widget _clientCard(AppLocalizations t) {
    final hasClient = _clientName.text.trim().isNotEmpty;
    final detail = [
      _clientEmail.text.trim(),
      _clientPhone.text.trim(),
    ].where((value) => value.isNotEmpty).join(' • ');

    if (!hasClient) {
      return _card(
        child: FilledButton.icon(
          key: const ValueKey('choose-client'),
          onPressed: _saving ? null : _pickClient,
          icon: const Icon(Icons.person_add_alt_1_outlined),
          label: Text(t.pickClient),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(54),
            backgroundColor: brandGreen,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
      );
    }

    return _card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: brandGreenSoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.person_outline, color: brandGreen),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _clientName.text.trim(),
                  style: const TextStyle(fontWeight: FontWeight.w900),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (detail.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    detail,
                    style: TextStyle(color: Colors.black.withOpacity(0.62)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          PopupMenuButton<String>(
            tooltip: t.pickClient,
            onSelected: (value) {
              if (value == 'change') {
                _pickClient();
              } else {
                _clearClient();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'change', child: Text(t.pickClient)),
              PopupMenuItem(value: 'clear', child: Text(t.removeClient)),
            ],
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }

  String _paymentMethodLabel(AppLocalizations t, String method) {
    switch (method) {
      case PaymentMethod.cash:
        return t.cash;
      case PaymentMethod.zelle:
        return 'Zelle';
      case PaymentMethod.card:
        return t.card;
      case PaymentMethod.check:
        return t.check;
      default:
        return t.other;
    }
  }

  // ✅ Payment UI card
  Widget _paymentCard({required bool isPaid}) {
    final t = AppLocalizations.of(context);
    final paidDate = (_paidAtMs ?? 0) > 0 ? _formatDate(_paidAtMs!) : '-';

    Color badgeColor;
    String badgeText;

    if (isPaid) {
      badgeColor = Colors.green.shade700;
      badgeText = t.paidLabel;
    } else {
      badgeColor = Colors.orange.shade800;
      badgeText = t.unpaidLabel;
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
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
                  isPaid ? t.paidDate(paidDate) : t.notPaidYet,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.black.withOpacity(0.70),
                  ),
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
                    t.paymentMethodWithValue(
                      _paymentMethodLabel(t, _paymentMethod),
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black.withOpacity(0.70),
                    ),
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
                  t.paymentNoteWithValue(_paymentNoteCtrl.text.trim()),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.60),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _saving ? null : _markUnpaid,
                icon: const Icon(Icons.undo),
                label: Text(t.markAsUnpaid),
              ),
            ),
          ] else ...[
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _saving ? null : _markPaidFlow,
                icon: const Icon(Icons.check_circle_outline),
                label: Text(t.markAsPaid),
                style: FilledButton.styleFrom(
                  backgroundColor: brandGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _qtyField(
    int i,
    InvoiceItem item,
    int itemDateMs,
    AppLocalizations t,
  ) {
    return _OverwriteNumberField(
      value: item.qty.toString(),
      label: t.qtyLabel,
      icon: Icons.numbers,
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

  Widget _taxAndTipControls(AppLocalizations t) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textScale = MediaQuery.textScalerOf(context).scale(16) / 16;
        final useTwoColumns = constraints.maxWidth >= 760 * textScale;
        final tax = _taxRateControl(t);
        final tip = _tipEditor(t);

        if (useTwoColumns) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: tax),
              const SizedBox(width: 16),
              Expanded(flex: 2, child: tip),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [tax, const SizedBox(height: 12), tip],
        );
      },
    );
  }

  Widget _tipEditor(AppLocalizations t) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textScale = MediaQuery.textScalerOf(context).scale(16) / 16;
        // The amount stays left and the short Tip % / Tip $ selector stays
        // right as soon as both controls remain legible. This uses the local
        // card width rather than waiting for a device-wide "tablet" layout.
        final minimumInputWidth = 120.0 * textScale;
        final minimumSelectorWidth = 128.0 * textScale;
        final useInlineControls =
            constraints.maxWidth >=
            minimumInputWidth + minimumSelectorWidth + 10;
        final selector = _tipModeControl(t);
        final value = _tipValueInput(t);

        if (!useInlineControls) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [selector, const SizedBox(height: 10), value],
          );
        }

        final selectorWidth = (constraints.maxWidth * 0.42)
            .clamp(minimumSelectorWidth, 220.0 * textScale)
            .toDouble();
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: value),
            const SizedBox(width: 10),
            SizedBox(width: selectorWidth, child: selector),
          ],
        );
      },
    );
  }

  Widget _tipModeControl(AppLocalizations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.tipTitle,
          style: TextStyle(
            color: Colors.black.withValues(alpha: 0.62),
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: pageBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _tipModeButton(
                label: t.tipPercentChip,
                selected: _tipIsPercent,
                onTap: () => setState(() => _tipIsPercent = true),
              ),
              _tipModeButton(
                label: t.tipAmountChip,
                selected: !_tipIsPercent,
                onTap: () => setState(() => _tipIsPercent = false),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tipModeButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(9),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            decoration: BoxDecoration(
              color: selected
                  ? brandGreen.withValues(alpha: 0.14)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: selected
                    ? brandGreen.withValues(alpha: 0.36)
                    : Colors.transparent,
              ),
            ),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selected
                    ? brandGreen
                    : Colors.black.withValues(alpha: 0.62),
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tipValueInput(AppLocalizations t) {
    if (_tipIsPercent) {
      return _ClearOnFirstFocusField(
        key: const ValueKey('tip-percent-input'),
        controller: _tipPercent,
        label: t.tipPercentLabel,
        icon: Icons.percent,
        onChanged: () => setState(() {}),
      );
    }

    return _ClearOnFirstFocusField(
      key: const ValueKey('tip-amount-input'),
      controller: _tipAmount,
      label: t.tipAmountLabel,
      icon: Icons.attach_money,
      onChanged: () => setState(() {}),
    );
  }

  Widget _taxRateControl(AppLocalizations t) {
    final taxValue = '${_taxRateValue.toStringAsFixed(2)}%';

    if (!_editingTaxRate) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: t.taxDefaultOwnerLabel,
          prefixIcon: const Icon(Icons.percent),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                taxValue,
                style: const TextStyle(fontWeight: FontWeight.w800),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton.icon(
              key: const ValueKey('edit-tax-rate'),
              onPressed: () => setState(() => _editingTaxRate = true),
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: Text(t.editTax),
              style: TextButton.styleFrom(
                foregroundColor: brandGreen,
                textStyle: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final textScale = MediaQuery.textScalerOf(context).scale(16) / 16;
        final showInlineAction = constraints.maxWidth >= 270 * textScale;
        final editor = TextFormField(
          controller: _taxRate,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: t.taxDefaultOwnerLabel,
            prefixIcon: const Icon(Icons.percent),
          ),
          onChanged: (_) => setState(() {}),
        );
        final doneButton = OutlinedButton.icon(
          key: const ValueKey('done-editing-tax-rate'),
          onPressed: () => setState(() => _editingTaxRate = false),
          icon: const Icon(Icons.check, size: 18),
          label: Text(t.done),
          style: OutlinedButton.styleFrom(
            foregroundColor: brandGreen,
            minimumSize: const Size(0, 48),
            textStyle: const TextStyle(fontWeight: FontWeight.w800),
          ),
        );

        if (showInlineAction) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: editor),
              const SizedBox(width: 8),
              doneButton,
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            editor,
            const SizedBox(height: 8),
            Align(alignment: Alignment.centerRight, child: doneButton),
          ],
        );
      },
    );
  }

  Widget _priceField(
    int i,
    InvoiceItem item,
    int itemDateMs,
    AppLocalizations t,
  ) {
    return _OverwriteNumberField(
      value: item.price.toStringAsFixed(2),
      label: t.priceLabel,
      icon: Icons.attach_money,
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

/// Clears a numeric default on first tap so the next number replaces it.
class _OverwriteNumberField extends StatefulWidget {
  const _OverwriteNumberField({
    required this.value,
    required this.label,
    required this.icon,
    required this.onChanged,
  });

  final String value;
  final String label;
  final IconData icon;
  final ValueChanged<String> onChanged;

  @override
  State<_OverwriteNumberField> createState() => _OverwriteNumberFieldState();
}

class _OverwriteNumberFieldState extends State<_OverwriteNumberField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _clearedForThisFocus = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode()..addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant _OverwriteNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_focusNode.hasFocus &&
        oldWidget.value != widget.value &&
        _controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) _clearedForThisFocus = false;
  }

  void _clearOnFirstTap() {
    if (_clearedForThisFocus) return;
    _clearedForThisFocus = true;
    _controller.clear();
    widget.onChanged('');
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      onTap: _clearOnFirstTap,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon),
      ),
      onChanged: widget.onChanged,
    );
  }
}

class _ClearOnFirstFocusField extends StatefulWidget {
  const _ClearOnFirstFocusField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final VoidCallback onChanged;

  @override
  State<_ClearOnFirstFocusField> createState() =>
      _ClearOnFirstFocusFieldState();
}

class _ClearOnFirstFocusFieldState extends State<_ClearOnFirstFocusField> {
  late final FocusNode _focusNode;
  bool _clearedForThisFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChanged)
      ..dispose();
    super.dispose();
  }

  void _handleFocusChanged() {
    if (!_focusNode.hasFocus) _clearedForThisFocus = false;
  }

  void _clearOnFirstTap() {
    if (_clearedForThisFocus) return;
    _clearedForThisFocus = true;
    widget.controller.clear();
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon),
      ),
      onTap: _clearOnFirstTap,
      onChanged: (_) => widget.onChanged(),
    );
  }
}

class _ServicePresetPickerSheet extends StatefulWidget {
  const _ServicePresetPickerSheet({required this.presets});

  final List<String> presets;

  @override
  State<_ServicePresetPickerSheet> createState() =>
      _ServicePresetPickerSheetState();
}

class _ServicePresetPickerSheetState extends State<_ServicePresetPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.presets
        .where(
          (preset) =>
              _query.trim().isEmpty ||
              preset.toLowerCase().contains(_query.trim().toLowerCase()),
        )
        .toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.72,
      minChildSize: 0.45,
      maxChildSize: 0.92,
      builder: (context, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
              child: Column(
                children: [
                  Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.16),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: _InvoiceFormScreenState.brandGreenSoft,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.playlist_add_check_outlined,
                          color: _InvoiceFormScreenState.brandGreen,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context).chooseSavedService,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    onChanged: (value) => setState(() => _query = value),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        context,
                      ).searchSavedServices,
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: filtered.isEmpty
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context).noSavedServicesFound,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        : ListView.separated(
                            controller: controller,
                            itemCount: filtered.length,
                            separatorBuilder: (_, __) => Divider(
                              height: 0,
                              color: Colors.black.withOpacity(0.06),
                            ),
                            itemBuilder: (_, index) {
                              final preset = filtered[index];
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 4,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      _InvoiceFormScreenState.brandGreenSoft,
                                  foregroundColor:
                                      _InvoiceFormScreenState.brandGreen,
                                  child: const Icon(Icons.home_repair_service),
                                ),
                                title: Text(
                                  preset,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () => Navigator.pop(context, preset),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Free typing stays separate from choosing a saved service.
class _ItemDescriptionField extends StatefulWidget {
  final String label;
  final String initial;
  final ValueChanged<String> onChanged;
  final String validatorMsg;
  final VoidCallback? onSavePreset;

  const _ItemDescriptionField({
    required this.label,
    required this.initial,
    required this.onChanged,
    required this.validatorMsg,
    required this.onSavePreset,
  });

  @override
  State<_ItemDescriptionField> createState() => _ItemDescriptionFieldState();
}

class _ItemDescriptionFieldState extends State<_ItemDescriptionField> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initial);
    _ctrl.addListener(() => widget.onChanged(_ctrl.text));
  }

  @override
  void didUpdateWidget(covariant _ItemDescriptionField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initial != widget.initial && _ctrl.text != widget.initial) {
      _ctrl.text = widget.initial;
      _ctrl.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrl.text.length),
      );
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _ctrl,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: const Icon(Icons.subject_outlined),
        suffixIcon: IconButton(
          tooltip: AppLocalizations.of(context).saveServiceForLater,
          onPressed: widget.onSavePreset,
          icon: const Icon(Icons.bookmark_add_outlined),
        ),
      ),
      validator: (v) => (v ?? '').trim().isEmpty ? widget.validatorMsg : null,
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
  String _q = '';
  static const brandGreen = Color(0xFF1F6E5C);

  Future<void> _createClient() async {
    final created = await Navigator.of(
      context,
    ).push<Client>(MaterialPageRoute(builder: (_) => const NewClientScreen()));
    if (created == null || !mounted) return;
    Navigator.pop(context, _PickedClient.fromClient(created));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.80,
          minChildSize: 0.45,
          maxChildSize: 0.94,
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
                        t.addClient,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
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
                child: FilledButton.icon(
                  key: const ValueKey('new-client'),
                  onPressed: _createClient,
                  icon: const Icon(Icons.person_add_alt_1_outlined),
                  label: Text(t.newClientTitle),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    backgroundColor: brandGreen,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  onChanged: (v) => setState(() => _q = v),
                  decoration: InputDecoration(
                    hintText: t.searchSavedClients,
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
              const SizedBox(height: 8),
              Expanded(
                child: StreamBuilder<List<Client>>(
                  stream: ClientsService.streamClients(),
                  builder: (context, s) {
                    final clients = (s.data ?? [])
                        .where(
                          (client) =>
                              _q.trim().isEmpty ||
                              client.name.toLowerCase().contains(
                                _q.toLowerCase(),
                              ),
                        )
                        .toList();
                    if (clients.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            _q.trim().isEmpty
                                ? t.firstClientHint
                                : t.noResultsForFilters,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      controller: controller,
                      itemCount: clients.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 0,
                        color: Colors.black.withOpacity(0.06),
                      ),
                      itemBuilder: (_, index) {
                        final client = clients[index];
                        final detail = [
                          client.email,
                          client.phoneDisplay,
                        ].where((value) => value.trim().isNotEmpty).join(' • ');
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 4,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: brandGreen.withOpacity(0.10),
                            foregroundColor: brandGreen,
                            child: const Icon(Icons.person_outline),
                          ),
                          title: Text(
                            client.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: detail.isEmpty
                              ? null
                              : Text(
                                  detail,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                          onTap: () => Navigator.pop(
                            context,
                            _PickedClient.fromClient(client),
                          ),
                        );
                      },
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

  factory _PickedClient.fromClient(Client client) => _PickedClient(
    clientId: client.id,
    name: client.name,
    email: client.email,
    phone: client.phoneE164.trim().isNotEmpty
        ? client.phoneE164
        : client.phoneDisplay,
  );
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
      title: Text(AppLocalizations.of(context).markAsPaid),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            initialValue: _method,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).paymentMethod,
              prefixIcon: const Icon(Icons.payments_outlined),
            ),
            items: [
              DropdownMenuItem(
                value: PaymentMethod.cash,
                child: Text(AppLocalizations.of(context).cash),
              ),
              DropdownMenuItem(
                value: PaymentMethod.zelle,
                child: const Text('Zelle'),
              ),
              DropdownMenuItem(
                value: PaymentMethod.card,
                child: Text(AppLocalizations.of(context).card),
              ),
              DropdownMenuItem(
                value: PaymentMethod.check,
                child: Text(AppLocalizations.of(context).check),
              ),
              DropdownMenuItem(
                value: PaymentMethod.other,
                child: Text(AppLocalizations.of(context).other),
              ),
            ],
            onChanged: (v) =>
                setState(() => _method = v ?? PaymentMethod.other),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _note,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).noteOptional,
              prefixIcon: const Icon(Icons.edit_note_outlined),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(
              context,
              _PayResult(method: _method, note: _note.text.trim()),
            );
          },
          child: Text(AppLocalizations.of(context).confirm),
        ),
      ],
    );
  }
}
