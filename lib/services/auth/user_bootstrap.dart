import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserBootstrap {
  static Future<void> ensureUserDoc() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final ref = FirebaseFirestore.instance.collection('users').doc(user.uid);

    await ref.set({
      'createdAt': FieldValue.serverTimestamp(),
      'email': user.email,
      'plan': 'free',
      'planUpdatedAt': FieldValue.serverTimestamp(),

      'business': {
        'name': '',
        'phone': '',
        'email': user.email ?? '',
        'address': '',
        'logoUrl': '',
      },

      'defaults': {
        'currency': 'USD',
        'taxRate': 6.35,
        'tipEnabled': true,
      },

      'invoiceStyle': {
        'templateId': 'minimal',
        'primaryColor': '#000000',
        'accentColor': '#0A84FF',
      },
    }, SetOptions(merge: true)); // merge = no borra nada si ya existía
  }
}
