// lib/repositories/business_profile_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/business_profile.dart';

class BusinessProfileRepository {
  DocumentReference<Map<String, dynamic>> _doc() {
    final user = FirebaseAuth.instance.currentUser!;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('business_profile')
        .doc('profile');
  }

  Stream<BusinessProfile> stream() {
    return _doc().snapshots().map((snap) {
      return BusinessProfile.fromMap(snap.data());
    });
  }

  Future<BusinessProfile> load() async {
    final snap = await _doc().get();
    return BusinessProfile.fromMap(snap.data());
  }

  Future<void> save(BusinessProfile p) async {
    await _doc().set(p.toMap(), SetOptions(merge: true));
  }

  // ✅ Presets helpers
  Future<List<String>> loadPresets() async {
    final p = await load();
    return _normalize(p.servicePresets);
  }

  Future<void> setPresets(List<String> presets) async {
    await _doc().set(
      {'servicePresets': _normalize(presets)},
      SetOptions(merge: true),
    );
  }

  Future<void> addPreset(String text) async {
    final v = text.trim();
    if (v.isEmpty) return;

    final current = await loadPresets();
    final next = {...current, v}.toList()..sort((a, b) => a.compareTo(b));
    await setPresets(next);
  }

  Future<void> removePreset(String text) async {
    final v = text.trim();
    final current = await loadPresets();
    current.removeWhere((e) => e.trim().toLowerCase() == v.toLowerCase());
    await setPresets(current);
  }

  List<String> _normalize(List<String> input) {
    final set = <String>{};
    for (final s in input) {
      final v = s.trim();
      if (v.isEmpty) continue;
      set.add(v);
    }
    final out = set.toList()..sort((a, b) => a.compareTo(b));
    return out;
  }
}
