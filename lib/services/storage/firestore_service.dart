import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirestoreService._();
  static final FirestoreService instance = FirestoreService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid {
    final u = _auth.currentUser;
    if (u == null) {
      throw Exception('Usuario no autenticado');
    }
    return u.uid;
  }

  // =========================
  // CLIENTES
  // =========================

  CollectionReference<Map<String, dynamic>> get _clientsRef =>
      _db.collection('users').doc(_uid).collection('clients');

  Future<String> createClient({
    required String name,
    String? phone,
    String? email,
    String? address,
    String? notes,
    bool isFavorite = false,
    String contactSource = 'manual',
    String? contactId,
  }) async {
    final now = DateTime.now();

    final doc = await _clientsRef.add({
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'notes': notes,
      'isFavorite': isFavorite,
      'contactSource': contactSource,
      'contactId': contactId,
      'createdAt': Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
    });

    return doc.id;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchClients() {
    return _clientsRef
        .orderBy('name')
        .snapshots();
  }

  Future<void> updateClient(
      String clientId, {
        String? name,
        String? phone,
        String? email,
        String? address,
        String? notes,
        bool? isFavorite,
      }) async {
    await _clientsRef.doc(clientId).update({
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (isFavorite != null) 'isFavorite': isFavorite,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> deleteClient(String clientId) async {
    await _clientsRef.doc(clientId).delete();
  }

  // =========================
  // INVOICES
  // =========================

  CollectionReference<Map<String, dynamic>> get _invoicesRef =>
      _db.collection('users').doc(_uid).collection('invoices');

  Future<String> createInvoice(Map<String, dynamic> invoiceData) async {
    /*
      invoiceData DEBE venir YA CALCULADO desde el app:
      subtotal, taxTotal, tipTotal, total, net, monthKey, year, etc.
    */

    final now = DateTime.now();

    final doc = await _invoicesRef.add({
      ...invoiceData,
      'createdAt': Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
    });

    await _updateReportsOnCreate(invoiceData);

    return doc.id;
  }

  Future<void> updateInvoice(
      String invoiceId,
      Map<String, dynamic> newData,
      Map<String, dynamic> oldData,
      ) async {
    /*
      newData = invoice NUEVA (calculada)
      oldData = snapshot ANTES del cambio
    */

    await _invoicesRef.doc(invoiceId).update({
      ...newData,
      'updatedAt': Timestamp.now(),
    });

    await _updateReportsOnUpdate(oldData, newData);
  }

  Future<void> deleteInvoice(
      String invoiceId,
      Map<String, dynamic> oldData,
      ) async {
    await _invoicesRef.doc(invoiceId).delete();
    await _updateReportsOnDelete(oldData);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchInvoices({
    String? monthKey,
    String? status,
  }) {
    Query<Map<String, dynamic>> q = _invoicesRef;

    if (monthKey != null) {
      q = q.where('monthKey', isEqualTo: monthKey);
    }
    if (status != null) {
      q = q.where('status', isEqualTo: status);
    }

    return q.orderBy('createdAt', descending: true).snapshots();
  }

  // =========================
  // REPORTES
  // =========================

  DocumentReference<Map<String, dynamic>> _monthlyReportRef(String monthKey) =>
      _db.collection('users').doc(_uid)
          .collection('reports_monthly')
          .doc(monthKey);

  DocumentReference<Map<String, dynamic>> _yearlyReportRef(int year) =>
      _db.collection('users').doc(_uid)
          .collection('reports_yearly')
          .doc(year.toString());

  // ---------- CREATE ----------
  Future<void> _updateReportsOnCreate(Map<String, dynamic> data) async {
    final batch = _db.batch();

    final monthKey = data['monthKey'] as String;
    final year = data['year'] as int;

    batch.set(
      _monthlyReportRef(monthKey),
      _monthlyDelta(data, isCreate: true),
      SetOptions(merge: true),
    );

    batch.set(
      _yearlyReportRef(year),
      _yearlyDelta(data, isCreate: true),
      SetOptions(merge: true),
    );

    await batch.commit();
  }

  // ---------- UPDATE ----------
  Future<void> _updateReportsOnUpdate(
      Map<String, dynamic> oldData,
      Map<String, dynamic> newData,
      ) async {
    final batch = _db.batch();

    final oldMonth = oldData['monthKey'];
    final newMonth = newData['monthKey'];

    final oldYear = oldData['year'];
    final newYear = newData['year'];

    // quitar del viejo
    batch.set(
      _monthlyReportRef(oldMonth),
      _monthlyDelta(oldData, isCreate: false),
      SetOptions(merge: true),
    );
    batch.set(
      _yearlyReportRef(oldYear),
      _yearlyDelta(oldData, isCreate: false),
      SetOptions(merge: true),
    );

    // agregar al nuevo
    batch.set(
      _monthlyReportRef(newMonth),
      _monthlyDelta(newData, isCreate: true),
      SetOptions(merge: true),
    );
    batch.set(
      _yearlyReportRef(newYear),
      _yearlyDelta(newData, isCreate: true),
      SetOptions(merge: true),
    );

    await batch.commit();
  }

  // ---------- DELETE ----------
  Future<void> _updateReportsOnDelete(Map<String, dynamic> data) async {
    final batch = _db.batch();

    batch.set(
      _monthlyReportRef(data['monthKey']),
      _monthlyDelta(data, isCreate: false),
      SetOptions(merge: true),
    );

    batch.set(
      _yearlyReportRef(data['year']),
      _yearlyDelta(data, isCreate: false),
      SetOptions(merge: true),
    );

    await batch.commit();
  }

  // =========================
  // HELPERS (SUMAS / RESTAS)
  // =========================

  Map<String, dynamic> _monthlyDelta(
      Map<String, dynamic> d, {
        required bool isCreate,
      }) {
    final s = isCreate ? 1 : -1;

    return {
      'monthKey': d['monthKey'],
      'year': d['year'],
      'month': int.parse((d['monthKey'] as String).split('-')[1]),
      'invoiceCount': FieldValue.increment(s),
      'subtotalSum': FieldValue.increment(s * (d['subtotal'] ?? 0)),
      'taxSum': FieldValue.increment(s * (d['taxTotal'] ?? 0)),
      'tipSum': FieldValue.increment(s * (d['tipTotal'] ?? 0)),
      'discountSum': FieldValue.increment(
          s * ((d['discount']?['amount']) ?? 0)),
      'totalSum': FieldValue.increment(s * (d['total'] ?? 0)),
      'netSum': FieldValue.increment(s * (d['net'] ?? 0)),
      'updatedAt': Timestamp.now(),
    };
  }

  Map<String, dynamic> _yearlyDelta(
      Map<String, dynamic> d, {
        required bool isCreate,
      }) {
    final s = isCreate ? 1 : -1;

    return {
      'year': d['year'],
      'invoiceCount': FieldValue.increment(s),
      'subtotalSum': FieldValue.increment(s * (d['subtotal'] ?? 0)),
      'taxSum': FieldValue.increment(s * (d['taxTotal'] ?? 0)),
      'tipSum': FieldValue.increment(s * (d['tipTotal'] ?? 0)),
      'discountSum': FieldValue.increment(
          s * ((d['discount']?['amount']) ?? 0)),
      'totalSum': FieldValue.increment(s * (d['total'] ?? 0)),
      'netSum': FieldValue.increment(s * (d['net'] ?? 0)),
      'updatedAt': Timestamp.now(),
    };
  }
}
