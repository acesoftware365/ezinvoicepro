// lib/models/invoice.dart

import 'package:cloud_firestore/cloud_firestore.dart';

/// =========================
/// Constantes
/// =========================


class InvoiceStatus {
  static const String unsent = 'unsent';
  static const String sent = 'sent';
  static const String unpaid = 'unpaid';
  static const String paid = 'paid';
}
class PaymentMethod {
  static const String cash = 'cash';
  static const String zelle = 'zelle';
  static const String card = 'card';
  static const String check = 'check';
  static const String other = 'other';
}

/// =========================
/// Invoice Item
/// =========================

class InvoiceItem {
  final String description;
  final int? dateMs; // service/item date
  final double qty;
  final double price;

  const InvoiceItem({
    required this.description,
    this.dateMs,
    required this.qty,
    required this.price,
  });


  double get lineTotal => qty * price;

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'dateMs': dateMs,
      'qty': qty,
      'price': price,
    };
  }

  factory InvoiceItem.fromMap(Map<String, dynamic>? map) {
    final m = map ?? const <String, dynamic>{};
    return InvoiceItem(
      description: (m['description'] ?? '').toString(),
      dateMs: _toNullableInt(m['dateMs']),
      qty: _toDouble(m['qty'], fallback: 1),
      price: _toDouble(m['price'], fallback: 0),
    );
  }
}

/// =========================
/// Invoice
/// =========================

class Invoice {
  final String id;

  final String invoiceNumber;

  // Client
  final String clientId;
  final String clientName;
  final String clientEmail;
  final String clientPhoneE164;

  // Dates
  final int createdAtMs;
  final int? dueAtMs;

  // Status / flow
  final String status; // unpaid|paid|sent
  final int? sentAtMs;

  // Payment
  final int? paidAtMs;
  final String paymentMethod; // cash|zelle|card|check|other
  final String paymentNote;

  // Items
  final List<InvoiceItem> items;

  // Totals
  final double subtotal;
  final double taxRate;
  final double taxAmount;

  final double tip;
  final bool tipIsPercent;
  final double tipPercent;

  final double total;

  // Message/Note
  final String message;

  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.clientId,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhoneE164,
    required this.createdAtMs,
    this.dueAtMs,
    required this.status,
    this.sentAtMs,
    this.paidAtMs,
    required this.paymentMethod,
    required this.paymentNote,
    required this.items,
    required this.subtotal,
    required this.taxRate,
    required this.taxAmount,
    required this.tip,
    required this.tipIsPercent,
    required this.tipPercent,
    required this.total,
    required this.message,
  });

  /// ✅ Getter usado por tu UI: inv.isPaid
  bool get isPaid {
    if ((paidAtMs ?? 0) > 0) return true;
    return status == InvoiceStatus.paid;
  }

  bool get isSent {
    if ((sentAtMs ?? 0) > 0) return true;
    return status == InvoiceStatus.sent;
  }

  bool get isUnsent => status == InvoiceStatus.unsent;

  /// =========================
  /// Firestore serialization
  /// =========================

  Map<String, dynamic> toMap() {
    return {
      'invoiceNumber': invoiceNumber,
      'clientId': clientId,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'clientPhoneE164': clientPhoneE164,
      'createdAtMs': createdAtMs,
      'dueAtMs': dueAtMs,
      'status': status,
      'sentAtMs': sentAtMs,
      'paidAtMs': paidAtMs,
      'paymentMethod': paymentMethod,
      'paymentNote': paymentNote,
      'items': items.map((e) => e.toMap()).toList(),
      'subtotal': subtotal,
      'taxRate': taxRate,
      'taxAmount': taxAmount,
      'tip': tip,
      'tipIsPercent': tipIsPercent,
      'tipPercent': tipPercent,
      'total': total,
      'message': message,
    };
  }

  /// ✅ COMPAT: tu código viejo llama Invoice.fromMap(d.id, d.data())
  factory Invoice.fromMap(String id, Map<String, dynamic>? map) {
    return Invoice.fromDoc(id: id, map: map);
  }

  /// ✅ Estilo nuevo (named): Invoice.fromDoc(id: ..., map: ...)
  factory Invoice.fromDoc({
    required String id,
    required Map<String, dynamic>? map,
  }) {
    final m = map ?? const <String, dynamic>{};

    final itemsRaw = (m['items'] as List?) ?? const [];
    final items = itemsRaw
        .whereType<Map>()
        .map((e) => InvoiceItem.fromMap(e.cast<String, dynamic>()))
        .toList();

    return Invoice(
      id: id,
      invoiceNumber: (m['invoiceNumber'] ?? '').toString(),
      clientId: (m['clientId'] ?? '').toString(),
      clientName: (m['clientName'] ?? '').toString(),
      clientEmail: (m['clientEmail'] ?? '').toString(),
      clientPhoneE164: (m['clientPhoneE164'] ?? '').toString(),
      createdAtMs: _toInt(m['createdAtMs'], fallback: 0),
      dueAtMs: _toNullableInt(m['dueAtMs']),
      status: (m['status'] ?? InvoiceStatus.unpaid).toString(),
      sentAtMs: _toNullableInt(m['sentAtMs']),
      paidAtMs: _toNullableInt(m['paidAtMs']),
      paymentMethod: (m['paymentMethod'] ?? PaymentMethod.other).toString(),
      paymentNote: (m['paymentNote'] ?? '').toString(),
      items: items,
      subtotal: _toDouble(m['subtotal'], fallback: 0),
      taxRate: _toDouble(m['taxRate'], fallback: 0),
      taxAmount: _toDouble(m['taxAmount'], fallback: 0),
      tip: _toDouble(m['tip'], fallback: 0),
      tipIsPercent: (m['tipIsPercent'] ?? true) == true,
      tipPercent: _toDouble(m['tipPercent'], fallback: 0),
      total: _toDouble(m['total'], fallback: 0),
      message: (m['message'] ?? '').toString(),
    );
  }

  /// Helper opcional si usas DocumentSnapshot
  factory Invoice.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    return Invoice.fromDoc(id: snap.id, map: snap.data());
  }

  Invoice copyWith({
    String? id,
    String? invoiceNumber,
    String? clientId,
    String? clientName,
    String? clientEmail,
    String? clientPhoneE164,
    int? createdAtMs,
    int? dueAtMs,
    String? status,
    int? sentAtMs,
    int? paidAtMs,
    String? paymentMethod,
    String? paymentNote,
    List<InvoiceItem>? items,
    double? subtotal,
    double? taxRate,
    double? taxAmount,
    double? tip,
    bool? tipIsPercent,
    double? tipPercent,
    double? total,
    String? message,
  }) {
    return Invoice(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientEmail: clientEmail ?? this.clientEmail,
      clientPhoneE164: clientPhoneE164 ?? this.clientPhoneE164,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      dueAtMs: dueAtMs ?? this.dueAtMs,
      status: status ?? this.status,
      sentAtMs: sentAtMs ?? this.sentAtMs,
      paidAtMs: paidAtMs ?? this.paidAtMs,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentNote: paymentNote ?? this.paymentNote,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      taxRate: taxRate ?? this.taxRate,
      taxAmount: taxAmount ?? this.taxAmount,
      tip: tip ?? this.tip,
      tipIsPercent: tipIsPercent ?? this.tipIsPercent,
      tipPercent: tipPercent ?? this.tipPercent,
      total: total ?? this.total,
      message: message ?? this.message,
    );
  }
}

/// =========================
/// Helpers parse seguros
/// =========================

int _toInt(dynamic v, {int fallback = 0}) {
  if (v == null) return fallback;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v) ?? fallback;
  return fallback;
}

int? _toNullableInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v);
  return null;
}

double _toDouble(dynamic v, {double fallback = 0}) {
  if (v == null) return fallback;
  if (v is double) return v;
  if (v is int) return v.toDouble();
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v) ?? fallback;
  return fallback;
}
