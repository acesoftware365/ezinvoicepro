import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/services/invoices/invoices_service.dart';
import 'package:ezinvoice/services/pdf/invoice_pdf_service.dart'
    show InvoicePdfService, PdfDocType, InvoiceData, InvoiceItemData;

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'invoice_form_screen.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  static const brandGreen = Color(0xFF1F6E5C);
  static const pageBg = Color(0xFFF6F7F9);
  static const ink = Color(0xFF202124);
  static const muted = Color(0xFF74787D);

  final _search = TextEditingController();
  final _searchFocus = FocusNode();
  String _query = '';
  _InvoiceFilter _filter = _InvoiceFilter.all;
  bool _deletingInvoice = false;

  @override
  void dispose() {
    _search.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  String _fmtMoney(double n) => n.toStringAsFixed(2);

  String _fmtDateMs(int ms) {
    final d = DateTime.fromMillisecondsSinceEpoch(ms);
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
  }

  bool _isOverdue(Invoice inv) {
    if (inv.isPaid) return false;
    if (!inv.isSent) return false;
    final due = inv.dueAtMs;
    if (due == null) return false;
    return due < DateTime.now().millisecondsSinceEpoch;
  }

  Color _statusColor(Invoice inv) {
    if (inv.isPaid) return Colors.green.shade700;
    if (_isOverdue(inv)) return Colors.redAccent;
    if (inv.isSent) return Colors.blue.shade700;
    return Colors.orange.shade800; // unsent/unpaid
  }

  String _statusLabel(AppLocalizations t, Invoice inv) {
    if (inv.isPaid) return t.paidLabel;
    if (_isOverdue(inv)) return t.overdueLabel;
    if (inv.isSent) return t.sentLabel;
    return t.unsentLabel;
  }

  bool _matchesFilter(Invoice inv) {
    return switch (_filter) {
      _InvoiceFilter.all => true,
      _InvoiceFilter.unsent => !inv.isPaid && !inv.isSent,
      _InvoiceFilter.sent => inv.isSent && !inv.isPaid && !_isOverdue(inv),
      _InvoiceFilter.paid => inv.isPaid,
      _InvoiceFilter.overdue => _isOverdue(inv),
    };
  }

  bool _matchesSearch(Invoice inv) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return true;
    final hay = [
      inv.invoiceNumber,
      inv.clientName,
      inv.clientEmail,
      inv.clientPhoneE164,
      _fmtDateMs(inv.createdAtMs),
      _fmtMoney(inv.total),
    ].join(' ').toLowerCase();
    return hay.contains(q);
  }

  Future<void> _openForm(BuildContext context, {Invoice? invoice}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => InvoiceFormScreen(invoice: invoice)),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Invoice inv) async {
    if (_deletingInvoice) return;
    final t = AppLocalizations.of(context);

    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(t.delete),
        content: Text('${t.delete} ${inv.invoiceNumber}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(t.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(t.delete),
          ),
        ],
      ),
    );

    if (ok != true) return;

    try {
      if (mounted) setState(() => _deletingInvoice = true);
      await InvoicesService.delete(inv.id);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${t.delete} ✅')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Delete error: $e')));
      }
    } finally {
      if (mounted) setState(() => _deletingInvoice = false);
    }
  }

  Future<void> _markSent(BuildContext context, Invoice inv) async {
    try {
      await InvoicesService.markAsSent(id: inv.id);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Marked as sent ✅')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Mark sent error: $e')));
      }
    }
  }

  Future<void> _markUnsent(BuildContext context, Invoice inv) async {
    try {
      await InvoicesService.markAsUnsent(id: inv.id);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Marked as unsent ✅')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Unsend error: $e')));
      }
    }
  }

  Future<void> _markPaid(BuildContext context, Invoice inv) async {
    final res = await showDialog<_PayResult>(
      context: context,
      builder: (_) => _MarkPaidDialog(
        initialMethod: inv.paymentMethod,
        initialNote: inv.paymentNote,
      ),
    );
    if (res == null) return;

    try {
      await InvoicesService.markAsPaid(
        id: inv.id,
        paymentMethod: res.method,
        paymentNote: res.note,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Marked as paid ✅')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Mark paid error: $e')));
      }
    }
  }

  Future<void> _markUnpaid(BuildContext context, Invoice inv) async {
    try {
      await InvoicesService.markAsUnpaid(id: inv.id);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Marked as unpaid ✅')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Mark unpaid error: $e')));
      }
    }
  }

  InvoiceData _toInvoiceData(Invoice inv) {
    return InvoiceData(
      invoiceNumber: inv.invoiceNumber,
      createdAt: DateTime.fromMillisecondsSinceEpoch(inv.createdAtMs),
      dueDate: inv.dueAtMs == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(inv.dueAtMs!),
      customerName: inv.clientName,
      customerPhone: inv.clientPhoneE164,
      customerEmail: inv.clientEmail,
      customerAddress: '',
      items: inv.items
          .map(
            (it) => InvoiceItemData(
              description: it.description,
              qty: it.qty,
              unitPrice: it.price,
              itemDate: it.dateMs == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(it.dateMs!),
            ),
          )
          .toList(),
      taxRatePercent: inv.taxRate,
      tipAmount: inv.tip,
      tipIsPercent: inv.tipIsPercent,
      tipPercent: inv.tipPercent,
      discount: 0,
      note: inv.message,
      isPaid: inv.isPaid,
      paidAt: inv.paidAtMs == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(inv.paidAtMs!),
      paymentMethod: inv.paymentMethod,
      paymentNote: inv.paymentNote,
    );
  }

  Rect _shareOriginFrom(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) {
      // fallback válido para iPad
      return const Rect.fromLTWH(0, 0, 1, 1);
    }
    return box.localToGlobal(Offset.zero) & box.size;
  }

  Future<void> _shareInvoicePdf(BuildContext context, Invoice inv) async {
    try {
      final origin = _shareOriginFrom(context);
      final data = _toInvoiceData(inv);
      final file = await InvoicePdfService.generateAndSavePdf(
        data,
        type: PdfDocType.invoice,
        context: context,
      );

      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'application/pdf')],
        text: 'Invoice ${inv.invoiceNumber}',
        sharePositionOrigin: origin, // ✅ FIX iPad/iOS
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Invoice PDF error: $e')));
      }
    }
  }

  Future<void> _shareReceiptPdf(BuildContext context, Invoice inv) async {
    if (!inv.isPaid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Receipt only available when PAID')),
      );
      return;
    }

    try {
      final origin = _shareOriginFrom(context);
      final data = _toInvoiceData(inv);
      final file = await InvoicePdfService.generateAndSavePdf(
        data,
        type: PdfDocType.receipt,
        context: context,
      );

      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'application/pdf')],
        text: 'Receipt ${inv.invoiceNumber}',
        sharePositionOrigin: origin, // ✅ FIX iPad/iOS
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Receipt PDF error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Theme(
      data: theme.copyWith(
        scaffoldBackgroundColor: pageBg,
        colorScheme: cs.copyWith(primary: brandGreen, secondary: brandGreen),
        appBarTheme: const AppBarTheme(
          backgroundColor: pageBg,
          foregroundColor: ink,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(color: ink),
          titleTextStyle: TextStyle(
            color: ink,
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: brandGreen,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          onPressed: () => _openForm(context),
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: StreamBuilder<List<Invoice>>(
            stream: InvoicesService.streamInvoices(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final all = snap.data ?? const <Invoice>[];
              final list = all
                  .where(_matchesSearch)
                  .where(_matchesFilter)
                  .toList();

              return CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  t.invoicesTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: ink,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0,
                                      ),
                                ),
                              ),
                              IconButton.filledTonal(
                                tooltip: 'Search',
                                onPressed: () => _searchFocus.requestFocus(),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: brandGreen,
                                ),
                                icon: const Icon(Icons.search),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          TextField(
                            controller: _search,
                            focusNode: _searchFocus,
                            onChanged: (value) =>
                                setState(() => _query = value),
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              hintText: 'Search invoices',
                              prefixIcon: const Icon(
                                Icons.search,
                                color: brandGreen,
                              ),
                              suffixIcon: _query.trim().isEmpty
                                  ? null
                                  : IconButton(
                                      tooltip: t.clear,
                                      onPressed: () {
                                        _search.clear();
                                        setState(() => _query = '');
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _StatusFilterBar(
                            selected: _filter,
                            onChanged: (next) => setState(() => _filter = next),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  if (list.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            all.isEmpty
                                ? t.noInvoicesYet
                                : 'No invoices match your filters.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: muted,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                      sliver: SliverList.separated(
                        itemCount: list.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) {
                          final inv = list[i];
                          return _InvoiceCompactCard(
                            invoice: inv,
                            statusText: _statusLabel(t, inv),
                            statusColor: _statusColor(inv),
                            dateText: _fmtDateMs(inv.createdAtMs),
                            amountText: '\$${_fmtMoney(inv.total)}',
                            onTap: () => _openForm(context, invoice: inv),
                            onViewPdf: () => _shareInvoicePdf(context, inv),
                            onSendInvoice: inv.isSent
                                ? () => _markUnsent(context, inv)
                                : () => _markSent(context, inv),
                            onMarkPaid: inv.isPaid
                                ? () => _markUnpaid(context, inv)
                                : () => _markPaid(context, inv),
                            onReceiptPdf: inv.isPaid
                                ? () => _shareReceiptPdf(context, inv)
                                : null,
                            onEdit: () => _openForm(context, invoice: inv),
                            onDelete: () => _confirmDelete(context, inv),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

enum _InvoiceFilter { all, unsent, sent, paid, overdue }

class _StatusFilterBar extends StatelessWidget {
  const _StatusFilterBar({required this.selected, required this.onChanged});

  final _InvoiceFilter selected;
  final ValueChanged<_InvoiceFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final items = [
      (_InvoiceFilter.all, 'All'),
      (_InvoiceFilter.unsent, t.unsentLabel),
      (_InvoiceFilter.sent, t.sentLabel),
      (_InvoiceFilter.paid, t.paidLabel),
      (_InvoiceFilter.overdue, t.overdueLabel),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final item in items) ...[
            _FilterChipPill(
              label: item.$2,
              selected: selected == item.$1,
              onTap: () => onChanged(item.$1),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _FilterChipPill extends StatelessWidget {
  const _FilterChipPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? _InvoicesScreenState.brandGreen : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected
                ? _InvoicesScreenState.brandGreen
                : Colors.black.withValues(alpha: 0.07),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: selected ? 16 : 10,
              offset: const Offset(0, 6),
              color: Colors.black.withValues(alpha: selected ? 0.08 : 0.035),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : _InvoicesScreenState.ink,
            fontSize: 13,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _InvoiceCompactCard extends StatelessWidget {
  const _InvoiceCompactCard({
    required this.invoice,
    required this.statusText,
    required this.statusColor,
    required this.dateText,
    required this.amountText,
    required this.onTap,
    required this.onViewPdf,
    required this.onSendInvoice,
    required this.onMarkPaid,
    required this.onEdit,
    required this.onDelete,
    this.onReceiptPdf,
  });

  final Invoice invoice;
  final String statusText;
  final Color statusColor;
  final String dateText;
  final String amountText;
  final VoidCallback onTap;
  final VoidCallback onViewPdf;
  final VoidCallback onSendInvoice;
  final VoidCallback onMarkPaid;
  final VoidCallback? onReceiptPdf;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final client = invoice.clientName.trim().isEmpty
        ? '-'
        : invoice.clientName.trim();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                offset: const Offset(0, 8),
                color: Colors.black.withValues(alpha: 0.045),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 13, 8, 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _StatusBadge(label: statusText, color: statusColor),
                    const Spacer(),
                    Text(
                      amountText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _InvoicesScreenState.ink,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 2),
                    PopupMenuButton<String>(
                      tooltip: 'Actions',
                      icon: const Icon(
                        Icons.more_vert,
                        color: _InvoicesScreenState.ink,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      onSelected: (value) {
                        if (value == 'view_pdf') onViewPdf();
                        if (value == 'send') onSendInvoice();
                        if (value == 'paid') onMarkPaid();
                        if (value == 'receipt') onReceiptPdf?.call();
                        if (value == 'edit') onEdit();
                        if (value == 'delete') onDelete();
                      },
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: 'view_pdf',
                          child: _InvoiceMenuRow(
                            icon: Icons.picture_as_pdf_outlined,
                            label: 'View PDF',
                          ),
                        ),
                        PopupMenuItem(
                          value: 'send',
                          child: _InvoiceMenuRow(
                            icon: invoice.isSent
                                ? Icons.undo_outlined
                                : Icons.send_outlined,
                            label: invoice.isSent
                                ? 'Unsend Invoice'
                                : 'Send Invoice',
                          ),
                        ),
                        PopupMenuItem(
                          value: 'paid',
                          child: _InvoiceMenuRow(
                            icon: invoice.isPaid
                                ? Icons.undo_outlined
                                : Icons.check_circle_outline,
                            label: invoice.isPaid
                                ? 'Mark as Unpaid'
                                : 'Mark as Paid',
                          ),
                        ),
                        PopupMenuItem(
                          value: 'receipt',
                          enabled: onReceiptPdf != null,
                          child: const _InvoiceMenuRow(
                            icon: Icons.receipt_long_outlined,
                            label: 'Receipt PDF',
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'edit',
                          child: _InvoiceMenuRow(
                            icon: Icons.edit_outlined,
                            label: 'Edit Invoice',
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: _InvoiceMenuRow(
                            icon: Icons.delete_outline,
                            label: 'Delete Invoice',
                            danger: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  invoice.invoiceNumber.trim().isEmpty
                      ? 'Invoice'
                      : invoice.invoiceNumber.trim(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _InvoicesScreenState.ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        client,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _InvoicesScreenState.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      dateText,
                      style: const TextStyle(
                        color: _InvoicesScreenState.muted,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _InvoiceMenuRow extends StatelessWidget {
  const _InvoiceMenuRow({
    required this.icon,
    required this.label,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? Colors.red : _InvoicesScreenState.ink;
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

// =========================
// Mark Paid Dialog
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
              DropdownMenuItem(
                value: PaymentMethod.zelle,
                child: Text('Zelle'),
              ),
              DropdownMenuItem(value: PaymentMethod.card, child: Text('Card')),
              DropdownMenuItem(
                value: PaymentMethod.check,
                child: Text('Check'),
              ),
              DropdownMenuItem(
                value: PaymentMethod.other,
                child: Text('Other'),
              ),
            ],
            onChanged: (v) =>
                setState(() => _method = v ?? PaymentMethod.other),
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
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(
              context,
              _PayResult(method: _method, note: _note.text.trim()),
            );
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
