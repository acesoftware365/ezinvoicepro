import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/client.dart';

class ClientsService {
  static final _db = FirebaseFirestore.instance;

  static String get _uid {
    final u = FirebaseAuth.instance.currentUser;
    if (u == null) throw Exception('User not logged in');
    return u.uid;
  }

  static CollectionReference<Map<String, dynamic>> _col() =>
      _db.collection('users').doc(_uid).collection('clients');

  static Stream<List<Client>> streamClients() {
    return _col().orderBy('name').snapshots().map((s) {
      return s.docs.map((d) => Client.fromMap(d.id, d.data())).toList();
    });
  }

  static Future<void> add(Client c) async {
    await _col().add({
      ...c.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> update(Client c) async {
    await _col().doc(c.id).set({
      ...c.toMap(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<void> delete(String id) async {
    await _col().doc(id).delete();
  }
}
