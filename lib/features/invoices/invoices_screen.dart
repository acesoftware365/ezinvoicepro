import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:ezinvoice/models/invoice.dart';
import 'package:ezinvoice/services/invoices/invoices_service.dart';
import 'package:ezinvoice/services/pdf/invoice_pdf_service.dart'
    show InvoicePdfService, PdfDocType, InvoiceData, InvoiceItemData;

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'invoice_form_screen.dart';

enum InvoiceListFilter { all, unsent, unpaid, sent, paid, overdue }

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({
    super.key,
    this.initialFilter = InvoiceListFilter.all,
    this.filterRequestId = 0,
  });

  /// The dashboard uses this value when an alert needs to open a meaningful
  /// subset of invoices. A changed request id reapplies even the same filter.
  final InvoiceListFilter initialFilter;
  final int filterRequestId;

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
  late final Stream<List<Invoice>> _invoicesStream;
  String _query = '';
  bool _searchOpen = false;
  InvoiceListFilter _filter = InvoiceListFilter.all;
  bool _deletingInvoice = false;

  @override
  void initState() {
    super.initState();
    // Keep one subscription for the screen. Replacing the stream on every
    // keystroke briefly rebuilt the loader and removed the search field.
    _invoicesStream = InvoicesService.streamInvoices();
    _filter = widget.initialFilter;
  }

  @override
  void didUpdateWidget(covariant InvoicesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filterRequestId == widget.filterRequestId) return;

    _search.clear();
    _searchFocus.unfocus();
    setState(() {
      _query = '';
      _searchOpen = false;
      _filter = widget.initialFilter;
    });
  }

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
      InvoiceListFilter.all => true,
      InvoiceListFilter.unsent => !inv.isPaid && !inv.isSent,
      InvoiceListFilter.unpaid => !inv.isPaid,
      InvoiceListFilter.sent => inv.isSent && !inv.isPaid && !_isOverdue(inv),
      InvoiceListFilter.paid => inv.isPaid,
      InvoiceListFilter.overdue => _isOverdue(inv),
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

  void _toggleSearch() {
    if (_searchOpen) {
      _closeSearch();
    } else {
      _openSearch();
    }
  }

  void _openSearch() {
    if (_searchOpen) return;
    setState(() => _searchOpen = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _searchOpen) _searchFocus.requestFocus();
    });
  }

  void _closeSearch() {
    if (!_searchOpen) return;
    _search.clear();
    _searchFocus.unfocus();
    setState(() {
      _query = '';
      _searchOpen = false;
    });
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
    final renderObject = context.findRenderObject();
    final box = renderObject is RenderBox ? renderObject : null;
    if (box == null || !box.hasSize) {
      // Fallback valido para iPad/iOS when the callback context belongs to a sliver.
      return const Rect.fromLTWH(0, 0, 1, 1);
    }
    final rect = box.localToGlobal(Offset.zero) & box.size;
    if (rect.width <= 0 || rect.height <= 0) {
      return const Rect.fromLTWH(0, 0, 1, 1);
    }
    return rect;
  }

  Future<void> _shareInvoicePdf(BuildContext context, Invoice inv) async {
    final t = AppLocalizations.of(context);
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
        text: t.shareInvoiceText(inv.invoiceNumber, inv.clientName),
        sharePositionOrigin: origin, // ✅ FIX iPad/iOS
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(t.pdfSendError(e.toString()))));
      }
    }
  }

  Future<void> _shareReceiptPdf(BuildContext context, Invoice inv) async {
    final t = AppLocalizations.of(context);
    if (!inv.isPaid) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_receiptPaidOnlyLabel(t))));
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
        text: t.shareReceiptText(inv.invoiceNumber, inv.clientName),
        sharePositionOrigin: origin, // ✅ FIX iPad/iOS
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(t.pdfSendError(e.toString()))));
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 10,
          backgroundColor: brandGreen,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add_rounded),
          label: Text(
            t.newInvoiceTitle,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          onPressed: () => _openForm(context),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final useWideRows = constraints.maxWidth >= 560;
              final showInlineNarrowSearch = _searchOpen && !useWideRows;
              return StreamBuilder<List<Invoice>>(
                stream: _invoicesStream,
                builder: (context, snap) {
                  if (snap.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 48,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Error loading invoices',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              snap.error.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final all = snap.data ?? const <Invoice>[];
                  final list = all
                      .where(_matchesSearch)
                      .where(_matchesFilter)
                      .toList();
                  final totalInvoiced = all.fold<double>(
                    0,
                    (total, invoice) => total + invoice.total,
                  );
                  final outstanding = all
                      .where((invoice) => !invoice.isPaid)
                      .fold<double>(
                        0,
                        (total, invoice) => total + invoice.total,
                      );
                  final paid = all
                      .where((invoice) => invoice.isPaid)
                      .fold<double>(
                        0,
                        (total, invoice) => total + invoice.total,
                      );

                  return CustomScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Listener(
                                behavior: HitTestBehavior.translucent,
                                // Device Hub can offset a portrait mouse click by a
                                // few pixels. The title and summary form one generous
                                // raw-pointer target, without intercepting filters.
                                onPointerDown: !useWideRows && !_searchOpen
                                    ? (_) => _openSearch()
                                    : null,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: showInlineNarrowSearch
                                                ? _buildSearchField(
                                                    t,
                                                    showQueryClear: false,
                                                  )
                                                : Text(
                                                    t.invoicesTitle,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium
                                                        ?.copyWith(
                                                          color: ink,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          letterSpacing: 0,
                                                        ),
                                                  ),
                                          ),
                                          _buildSearchAction(
                                            t,
                                            useWideRows: useWideRows,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 14),
                                      _InvoiceSummaryBar(
                                        invoiceCount: all.length,
                                        totalInvoiced: totalInvoiced,
                                        outstanding: outstanding,
                                        paid: paid,
                                        money: _fmtMoney,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (_searchOpen && useWideRows) ...[
                                const SizedBox(height: 14),
                                _buildSearchField(t, showQueryClear: true),
                              ],
                              const SizedBox(height: 14),
                              _StatusFilterBar(
                                selected: _filter,
                                onChanged: (next) =>
                                    setState(() => _filter = next),
                              ),
                              const SizedBox(height: 14),
                            ],
                          ),
                        ),
                      ),
                      if (list.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: _InvoicesEmptyState(
                            message: all.isEmpty
                                ? t.noInvoicesYet
                                : t.noResultsForFilters,
                          ),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 112),
                          sliver: SliverList.separated(
                            itemCount: list.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, i) {
                              final inv = list[i];
                              return _InvoiceCompactCard(
                                invoice: inv,
                                statusText: _statusLabel(t, inv),
                                statusColor: _statusColor(inv),
                                dateText: _fmtDateMs(inv.createdAtMs),
                                amountText: '\$${_fmtMoney(inv.total)}',
                                wide: useWideRows,
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
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAction(AppLocalizations t, {required bool useWideRows}) {
    final isClosing = _searchOpen;
    final tooltip = isClosing ? t.clear : _invoiceSearchLabel(t);
    final icon = Icon(
      isClosing ? Icons.close_rounded : Icons.search_rounded,
      color: brandGreen,
    );

    if (useWideRows) {
      return IconButton.filledTonal(
        tooltip: tooltip,
        onPressed: _toggleSearch,
        style: IconButton.styleFrom(
          minimumSize: const Size(56, 56),
          backgroundColor: brandGreen.withValues(alpha: 0.1),
          foregroundColor: brandGreen,
        ),
        icon: icon,
      );
    }

    return Semantics(
      button: true,
      label: tooltip,
      onTap: _toggleSearch,
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) {
          if (isClosing) {
            _closeSearch();
          } else {
            _openSearch();
          }
        },
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: brandGreen.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: icon,
        ),
      ),
    );
  }

  Widget _buildSearchField(AppLocalizations t, {required bool showQueryClear}) {
    return TextField(
      controller: _search,
      focusNode: _searchFocus,
      onChanged: (value) => setState(() => _query = value),
      textInputAction: TextInputAction.search,
      decoration: _searchDecoration(t, showQueryClear: showQueryClear),
    );
  }

  InputDecoration _searchDecoration(
    AppLocalizations t, {
    required bool showQueryClear,
  }) {
    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecoration(
      hintText: _invoiceSearchLabel(t),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      prefixIcon: const Icon(Icons.search_rounded, color: brandGreen),
      suffixIcon: showQueryClear && _query.trim().isNotEmpty
          ? IconButton(
              tooltip: t.clear,
              onPressed: () {
                _search.clear();
                setState(() => _query = '');
              },
              icon: const Icon(Icons.close_rounded),
            )
          : null,
      border: border(Colors.black.withValues(alpha: 0.08)),
      enabledBorder: border(Colors.black.withValues(alpha: 0.08)),
      focusedBorder: border(brandGreen, 1.5),
    );
  }
}

class _InvoiceSummaryBar extends StatelessWidget {
  const _InvoiceSummaryBar({
    required this.invoiceCount,
    required this.totalInvoiced,
    required this.outstanding,
    required this.paid,
    required this.money,
  });

  final int invoiceCount;
  final double totalInvoiced;
  final double outstanding;
  final double paid;
  final String Function(double) money;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            blurRadius: 22,
            offset: const Offset(0, 8),
            color: Colors.black.withValues(alpha: 0.035),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _InvoiceSummaryMetric(
              icon: Icons.receipt_long_outlined,
              label: t.invoicesTitle,
              value: '$invoiceCount',
              color: _InvoicesScreenState.brandGreen,
            ),
          ),
          _SummaryDivider(),
          Expanded(
            child: _InvoiceSummaryMetric(
              icon: Icons.schedule_outlined,
              label: _openTotalLabel(t),
              value: '\$${money(outstanding)}',
              color: Colors.orange.shade800,
            ),
          ),
          _SummaryDivider(),
          Expanded(
            child: _InvoiceSummaryMetric(
              icon: Icons.check_circle_outline_rounded,
              label: t.paidLabel,
              value: '\$${money(paid)}',
              color: Colors.green.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: 1,
      color: Colors.black.withValues(alpha: 0.07),
    );
  }
}

class _InvoiceSummaryMetric extends StatelessWidget {
  const _InvoiceSummaryMetric({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _InvoicesScreenState.muted,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _InvoicesScreenState.ink,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoicesEmptyState extends StatelessWidget {
  const _InvoicesEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 12, 32, 112),
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: _InvoicesScreenState.brandGreen.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.receipt_long_outlined,
                  color: _InvoicesScreenState.brandGreen,
                  size: 28,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: _InvoicesScreenState.ink,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusFilterBar extends StatelessWidget {
  const _StatusFilterBar({required this.selected, required this.onChanged});

  final InvoiceListFilter selected;
  final ValueChanged<InvoiceListFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final items = [
      (InvoiceListFilter.all, _allLabel(t)),
      (InvoiceListFilter.unsent, t.unsentLabel),
      (InvoiceListFilter.unpaid, _unpaidFilterLabel(t)),
      (InvoiceListFilter.sent, t.sentLabel),
      (InvoiceListFilter.paid, t.paidLabel),
      (InvoiceListFilter.overdue, t.overdueLabel),
    ];

    return Wrap(
      spacing: 6,
      runSpacing: 8,
      children: [
        for (final item in items)
          _FilterChipPill(
            label: item.$2,
            selected: selected == item.$1,
            onTap: () => onChanged(item.$1),
          ),
      ],
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              blurRadius: selected ? 14 : 8,
              offset: const Offset(0, 4),
              color: Colors.black.withValues(alpha: selected ? 0.075 : 0.025),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : _InvoicesScreenState.ink,
            fontSize: 12,
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
    required this.wide,
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
  final bool wide;
  final VoidCallback onTap;
  final VoidCallback onViewPdf;
  final VoidCallback onSendInvoice;
  final VoidCallback onMarkPaid;
  final VoidCallback? onReceiptPdf;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final client = invoice.clientName.trim().isEmpty
        ? '-'
        : invoice.clientName.trim();
    final invoiceNumber = invoice.invoiceNumber.trim().isEmpty
        ? t.invoicesTitle
        : invoice.invoiceNumber.trim();

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
            padding: EdgeInsets.fromLTRB(14, wide ? 12 : 13, 8, wide ? 12 : 13),
            child: wide
                ? _wideContent(context, t, client, invoiceNumber)
                : _narrowContent(context, t, client, invoiceNumber),
          ),
        ),
      ),
    );
  }

  Widget _narrowContent(
    BuildContext context,
    AppLocalizations t,
    String client,
    String invoiceNumber,
  ) {
    return Column(
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
            _actionsMenu(t),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          invoiceNumber,
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
    );
  }

  Widget _wideContent(
    BuildContext context,
    AppLocalizations t,
    String client,
    String invoiceNumber,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: Align(
            alignment: Alignment.centerLeft,
            child: _StatusBadge(label: statusText, color: statusColor),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invoiceNumber,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _InvoicesScreenState.ink,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                client,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _InvoicesScreenState.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        SizedBox(
          width: 88,
          child: Text(
            dateText,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: _InvoicesScreenState.muted,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 14),
        SizedBox(
          width: 92,
          child: Text(
            amountText,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _InvoicesScreenState.ink,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 4),
        _actionsMenu(t),
      ],
    );
  }

  Widget _actionsMenu(AppLocalizations t) {
    return PopupMenuButton<String>(
      tooltip: _actionsLabel(t),
      icon: const Icon(Icons.more_vert, color: _InvoicesScreenState.ink),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onSelected: (value) {
        if (value == 'view_pdf') onViewPdf();
        if (value == 'send') onSendInvoice();
        if (value == 'paid') onMarkPaid();
        if (value == 'receipt') onReceiptPdf?.call();
        if (value == 'edit') onEdit();
        if (value == 'delete') onDelete();
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'view_pdf',
          child: _InvoiceMenuRow(
            icon: Icons.picture_as_pdf_outlined,
            label: t.sendPdf,
          ),
        ),
        PopupMenuItem(
          value: 'send',
          child: _InvoiceMenuRow(
            icon: invoice.isSent ? Icons.undo_outlined : Icons.send_outlined,
            label: invoice.isSent ? _unsendLabel(t) : t.sendPdf,
          ),
        ),
        PopupMenuItem(
          value: 'paid',
          child: _InvoiceMenuRow(
            icon: invoice.isPaid
                ? Icons.undo_outlined
                : Icons.check_circle_outline,
            label: invoice.isPaid ? _markUnpaidLabel(t) : _markPaidLabel(t),
          ),
        ),
        PopupMenuItem(
          value: 'receipt',
          enabled: onReceiptPdf != null,
          child: _InvoiceMenuRow(
            icon: Icons.receipt_long_outlined,
            label: _receiptPdfLabel(t),
          ),
        ),
        PopupMenuItem(
          value: 'edit',
          child: _InvoiceMenuRow(icon: Icons.edit_outlined, label: t.edit),
        ),
        PopupMenuItem(
          value: 'delete',
          child: _InvoiceMenuRow(
            icon: Icons.delete_outline,
            label: t.delete,
            danger: true,
          ),
        ),
      ],
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
    final t = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(_markPaidLabel(t)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            initialValue: _method,
            decoration: InputDecoration(
              labelText: _payMethodLabel(t),
              prefixIcon: const Icon(Icons.payments_outlined),
            ),
            items: [
              DropdownMenuItem(
                value: PaymentMethod.cash,
                child: Text(_cashLabel(t)),
              ),
              DropdownMenuItem(
                value: PaymentMethod.zelle,
                child: const Text('Zelle'),
              ),
              DropdownMenuItem(
                value: PaymentMethod.card,
                child: Text(_cardLabel(t)),
              ),
              DropdownMenuItem(
                value: PaymentMethod.check,
                child: Text(_checkLabel(t)),
              ),
              DropdownMenuItem(
                value: PaymentMethod.other,
                child: Text(_otherLabel(t)),
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
              labelText: _noteOptionalLabel(t),
              prefixIcon: const Icon(Icons.edit_note_outlined),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.cancel),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(
              context,
              _PayResult(method: _method, note: _note.text.trim()),
            );
          },
          child: Text(_confirmLabel(t)),
        ),
      ],
    );
  }
}

String _invLang(AppLocalizations t) => t.localeName.split('_').first;

String _invShort(AppLocalizations t, Map<String, String> values, String en) {
  return values[_invLang(t)] ?? en;
}

String _invoiceSearchLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Buscar facturas',
  'pt': 'Buscar faturas',
  'fr': 'Chercher factures',
  'de': 'Rechnungen suchen',
  'ar': 'بحث الفواتير',
  'hi': 'इनवॉइस खोजें',
  'ja': '請求書検索',
  'ru': 'Найти счета',
  'zh': '搜索发票',
}, 'Search invoices');

String _allLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Todo',
  'pt': 'Tudo',
  'fr': 'Tout',
  'de': 'Alle',
  'ar': 'الكل',
  'hi': 'सब',
  'ja': 'すべて',
  'ru': 'Все',
  'zh': '全部',
}, 'All');

String _unpaidFilterLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Sin pagar',
  'pt': 'Em aberto',
  'fr': 'Impayées',
  'de': 'Offen',
  'ar': 'غير مدفوعة',
  'hi': 'बकाया',
  'ja': '未払い',
  'ru': 'Не оплачено',
  'zh': '未付款',
}, 'Unpaid');

String _actionsLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Acciones',
  'pt': 'Ações',
  'fr': 'Actions',
  'de': 'Aktionen',
  'ar': 'إجراءات',
  'hi': 'क्रियाएं',
  'ja': '操作',
  'ru': 'Действия',
  'zh': '操作',
}, 'Actions');

String _unsendLabel(AppLocalizations t) => _invShort(t, {
  'es': 'No enviada',
  'pt': 'Não enviada',
  'fr': 'Non envoyée',
  'de': 'Nicht gesendet',
  'ar': 'غير مرسلة',
  'hi': 'न भेजी',
  'ja': '未送信',
  'ru': 'Не отправлено',
  'zh': '未发送',
}, 'Unsend');

String _markPaidLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Marcar pagada',
  'pt': 'Marcar paga',
  'fr': 'Marquer payée',
  'de': 'Als bezahlt',
  'ar': 'تحديد مدفوعة',
  'hi': 'भुगतान',
  'ja': '支払い済み',
  'ru': 'Оплачено',
  'zh': '标记已付',
}, 'Mark paid');

String _markUnpaidLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Marcar sin pagar',
  'pt': 'Marcar não paga',
  'fr': 'Marquer impayée',
  'de': 'Als offen',
  'ar': 'غير مدفوعة',
  'hi': 'बकाया',
  'ja': '未払い',
  'ru': 'Не оплачено',
  'zh': '标记未付',
}, 'Mark unpaid');

String _receiptPdfLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Recibo PDF',
  'pt': 'Recibo PDF',
  'fr': 'Reçu PDF',
  'de': 'Beleg PDF',
  'ar': 'إيصال PDF',
  'hi': 'रसीद PDF',
  'ja': '領収書PDF',
  'ru': 'Квитанция PDF',
  'zh': '收据 PDF',
}, 'Receipt PDF');

String _receiptPaidOnlyLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Recibo solo si está pagada.',
  'pt': 'Recibo só se paga.',
  'fr': 'Reçu si payée.',
  'de': 'Beleg nur bezahlt.',
  'ar': 'الإيصال للمدفوعة فقط.',
  'hi': 'रसीद केवल भुगतान पर.',
  'ja': '領収書は支払い済みのみ。',
  'ru': 'Квитанция после оплаты.',
  'zh': '仅已付款可开收据。',
}, 'Receipt only when paid.');

String _payMethodLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Método',
  'pt': 'Método',
  'fr': 'Mode',
  'de': 'Methode',
  'ar': 'الطريقة',
  'hi': 'तरीका',
  'ja': '方法',
  'ru': 'Метод',
  'zh': '方式',
}, 'Method');

String _cashLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Efectivo',
  'pt': 'Dinheiro',
  'fr': 'Espèces',
  'de': 'Bar',
  'ar': 'نقد',
  'hi': 'नकद',
  'ja': '現金',
  'ru': 'Наличные',
  'zh': '现金',
}, 'Cash');

String _cardLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Tarjeta',
  'pt': 'Cartão',
  'fr': 'Carte',
  'de': 'Karte',
  'ar': 'بطاقة',
  'hi': 'कार्ड',
  'ja': 'カード',
  'ru': 'Карта',
  'zh': '卡',
}, 'Card');

String _checkLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Cheque',
  'pt': 'Cheque',
  'fr': 'Chèque',
  'de': 'Scheck',
  'ar': 'شيك',
  'hi': 'चेक',
  'ja': '小切手',
  'ru': 'Чек',
  'zh': '支票',
}, 'Check');

String _otherLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Otro',
  'pt': 'Outro',
  'fr': 'Autre',
  'de': 'Andere',
  'ar': 'أخرى',
  'hi': 'अन्य',
  'ja': 'その他',
  'ru': 'Другое',
  'zh': '其他',
}, 'Other');

String _noteOptionalLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Nota opcional',
  'pt': 'Nota opcional',
  'fr': 'Note option',
  'de': 'Notiz optional',
  'ar': 'ملاحظة اختيارية',
  'hi': 'नोट वैकल्पिक',
  'ja': 'メモ任意',
  'ru': 'Заметка',
  'zh': '备注可选',
}, 'Note optional');

String _confirmLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Confirmar',
  'pt': 'Confirmar',
  'fr': 'Confirmer',
  'de': 'Bestätigen',
  'ar': 'تأكيد',
  'hi': 'पुष्टि',
  'ja': '確認',
  'ru': 'Подтвердить',
  'zh': '确认',
}, 'Confirm');

String _openTotalLabel(AppLocalizations t) => _invShort(t, {
  'es': 'Por cobrar',
  'pt': 'Em aberto',
  'fr': 'À recevoir',
  'de': 'Offen',
  'ar': 'مستحق',
  'hi': 'बकाया',
  'ja': '未回収',
  'ru': 'К получению',
  'zh': '待收款',
}, 'Open total');
