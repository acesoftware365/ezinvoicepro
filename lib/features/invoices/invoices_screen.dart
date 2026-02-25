import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/models/business_profile.dart';
import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:ezinvoice/services/invoices/invoices_service.dart';
import 'package:ezinvoice/services/pdf/invoice_pdf_service.dart'
    show InvoicePdfService, PdfDocType, InvoiceData, InvoiceItemData;
import 'package:ezinvoice/services/purchases/subscription_manager.dart';
import 'package:ezinvoice/services/style/app_theme_presets.dart';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../paywall/paywall_screen.dart';
import '../reports/reports_screen.dart';
import 'invoice_form_screen.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  static const brandGreen = Color(0xFF1F6E5C);
  static const pageBg = Color(0xFFF6F7F9);

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
    if (inv.isSent) return Colors.blueGrey;
    return Colors.orange.shade800; // unsent/unpaid
  }

  String _statusLabel(AppLocalizations t, Invoice inv) {
    if (inv.isPaid) return t.paidLabel;
    if (_isOverdue(inv)) return t.overdueLabel;
    if (inv.isSent) return t.sentLabel;
    return t.unsentLabel;
  }

  Future<void> _openForm(BuildContext context, {Invoice? invoice}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => InvoiceFormScreen(invoice: invoice)),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Invoice inv) async {
    final t = AppLocalizations.of(context);

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.delete),
        content: Text('${t.delete} ${inv.invoiceNumber}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.delete),
          ),
        ],
      ),
    );

    if (ok != true) return;

    try {
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
      final data = _toInvoiceData(inv);
      final file = await InvoicePdfService.generateAndSavePdf(
        data,
        type: PdfDocType.invoice,
        context: context,
      );

      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'application/pdf')],
        text: 'Invoice ${inv.invoiceNumber}',
        sharePositionOrigin: _shareOriginFrom(context), // ✅ FIX iPad/iOS
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
      final data = _toInvoiceData(inv);
      final file = await InvoicePdfService.generateAndSavePdf(
        data,
        type: PdfDocType.receipt,
        context: context,
      );

      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'application/pdf')],
        text: 'Receipt ${inv.invoiceNumber}',
        sharePositionOrigin: _shareOriginFrom(context), // ✅ FIX iPad/iOS
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
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.invoicesTitle),
          actions: [
            IconButton(
              tooltip: t.reports,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReportsScreen()),
                );
              },
              icon: const Icon(Icons.bar_chart_rounded),
            ),
            const SizedBox(width: 6),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: brandGreen,
          foregroundColor: Colors.white,
          onPressed: () => _openForm(context),
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            const _InvoiceDesignBar(),
            Expanded(
              child: StreamBuilder<List<Invoice>>(
                stream: InvoicesService.streamInvoices(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final list = snap.data ?? [];

                  if (list.isEmpty) {
                    return Center(
                      child: Text(
                        t.noInvoicesYet,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.55),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) {
                      final inv = list[i];

                      final statusColor = _statusColor(inv);
                      final statusText = _statusLabel(t, inv);

                      final date = _fmtDateMs(inv.createdAtMs);

                      final amount = _fmtMoney(inv.total);
                      final subtitle = [
                        if (inv.clientName.trim().isNotEmpty)
                          inv.clientName.trim(),
                        date,
                        if (inv.dueAtMs != null)
                          'Due: ${_fmtDateMs(inv.dueAtMs!)}',
                      ].join(' • ');

                      return _card(
                        child: InkWell(
                          onTap: () => _openForm(context, invoice: inv),
                          borderRadius: BorderRadius.circular(18),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                        border: Border.all(
                                          color: statusColor.withOpacity(0.35),
                                        ),
                                      ),
                                      child: Text(
                                        statusText,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 12,
                                          color: statusColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        inv.invoiceNumber,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      amount,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.55),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    Builder(
                                      builder: (btnCtx) => OutlinedButton.icon(
                                        onPressed: () =>
                                            _shareInvoicePdf(btnCtx, inv),
                                        icon: const Icon(Icons.picture_as_pdf),
                                        label: const Text('Invoice PDF'),
                                      ),
                                    ),
                                    Builder(
                                      builder: (btnCtx) => OutlinedButton.icon(
                                        onPressed: inv.isPaid
                                            ? () =>
                                                  _shareReceiptPdf(btnCtx, inv)
                                            : null,
                                        icon: const Icon(Icons.receipt_long),
                                        label: const Text('Receipt PDF'),
                                      ),
                                    ),
                                    if (!inv.isSent)
                                      FilledButton.icon(
                                        onPressed: () =>
                                            _markSent(context, inv),
                                        icon: const Icon(Icons.send),
                                        label: const Text('Send'),
                                        style: FilledButton.styleFrom(
                                          backgroundColor: brandGreen,
                                        ),
                                      )
                                    else
                                      OutlinedButton.icon(
                                        onPressed: () =>
                                            _markUnsent(context, inv),
                                        icon: const Icon(Icons.undo),
                                        label: const Text('Unsend'),
                                      ),
                                    if (!inv.isPaid)
                                      FilledButton.tonalIcon(
                                        onPressed: () =>
                                            _markPaid(context, inv),
                                        icon: const Icon(
                                          Icons.check_circle_outline,
                                        ),
                                        label: const Text('Mark Paid'),
                                      )
                                    else
                                      OutlinedButton.icon(
                                        onPressed: () =>
                                            _markUnpaid(context, inv),
                                        icon: const Icon(Icons.undo),
                                        label: const Text('Mark Unpaid'),
                                      ),
                                    OutlinedButton.icon(
                                      onPressed: () =>
                                          _confirmDelete(context, inv),
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.redAccent,
                                      ),
                                      label: const Text('Delete'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.redAccent,
                                        side: BorderSide(
                                          color: Colors.redAccent.withOpacity(
                                            0.35,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
      child: child,
    );
  }
}

class _InvoiceDesignBar extends StatelessWidget {
  const _InvoiceDesignBar();

  static const brandGreen = Color(0xFF1F6E5C);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final repo = BusinessProfileRepository();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: StreamBuilder<BusinessProfile>(
        stream: repo.stream(),
        builder: (context, snap) {
          final p = snap.data ?? const BusinessProfile();
          final paletteId = AppThemePresets.normalizePalette(
            p.invoicePaletteId,
          );
          final layoutId = AppThemePresets.normalizeLayout(p.invoiceLayoutId);

          return ValueListenableBuilder<SubscriptionState>(
            valueListenable: SubscriptionManager.instance.state,
            builder: (context, sub, _) {
              final isPro = sub.isPro;
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black.withOpacity(0.06)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.invoiceStyleTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black.withOpacity(0.78),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (!isPro) ...[
                      Text(
                        t.invoiceFreeStyleHint,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.62),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FilledButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PaywallScreen(),
                            ),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: brandGreen,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.workspace_premium_outlined),
                        label: Text(t.upgradeToPro),
                      ),
                    ] else ...[
                      DropdownButtonFormField<String>(
                        key: ValueKey('invoice_palette_$paletteId'),
                        initialValue: paletteId,
                        decoration: InputDecoration(
                          labelText: t.invoicePaletteLabel,
                          prefixIcon: const Icon(Icons.palette_outlined),
                        ),
                        items: AppThemePresets.palettes
                            .map(
                              (x) => DropdownMenuItem(
                                value: x.id,
                                child: Row(
                                  children: [
                                    _paletteDot(x.primary),
                                    const SizedBox(width: 6),
                                    _paletteDot(x.accent),
                                    const SizedBox(width: 8),
                                    Text(x.label),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) async {
                          final next = AppThemePresets.normalizePalette(v);
                          try {
                            await repo.save(
                              p.copyWith(
                                invoicePaletteId: next,
                                paletteId: next,
                              ),
                            );
                          } catch (_) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(t.saveInvoicePaletteError),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        key: ValueKey('invoice_layout_$layoutId'),
                        initialValue: layoutId,
                        decoration: InputDecoration(
                          labelText: t.invoiceLayoutLabel,
                          prefixIcon: const Icon(Icons.description_outlined),
                        ),
                        items: AppThemePresets.layouts
                            .map(
                              (x) => DropdownMenuItem(
                                value: x.id,
                                child: Text(x.label),
                              ),
                            )
                            .toList(),
                        onChanged: (v) async {
                          final next = AppThemePresets.normalizeLayout(v);
                          try {
                            await repo.save(p.copyWith(invoiceLayoutId: next));
                          } catch (_) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(t.saveInvoiceLayoutError)),
                            );
                          }
                        },
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
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
