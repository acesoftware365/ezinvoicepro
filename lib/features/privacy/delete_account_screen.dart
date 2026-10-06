import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool _deleting = false;

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _deleteCollection(
    CollectionReference<Map<String, dynamic>> col,
  ) async {
    const pageSize = 200;

    while (true) {
      final snap = await col.limit(pageSize).get();
      if (snap.docs.isEmpty) break;

      final batch = FirebaseFirestore.instance.batch();
      for (final doc in snap.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
  }

  Future<void> _deleteUserData(String uid) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

    await _deleteCollection(userRef.collection('invoices'));
    await _deleteCollection(userRef.collection('clients'));
    await _deleteCollection(userRef.collection('reports_monthly'));
    await _deleteCollection(userRef.collection('reports_yearly'));
    await _deleteCollection(userRef.collection('business_profile'));

    await userRef.delete();
  }

  Future<void> _reauthenticate(User user) async {
    final email = user.email;
    if (email == null || email.isEmpty) return;
    final t = AppLocalizations.of(context);

    final controller = TextEditingController();
    bool obscure = true;

    final pass = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(t.confirmPassword),
              content: TextField(
                controller: controller,
                obscureText: obscure,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: t.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setStateDialog(() => obscure = !obscure),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(t.cancel),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pop(dialogContext, controller.text.trim()),
                  child: Text(t.continueText),
                ),
              ],
            );
          },
        );
      },
    );

    if (pass == null || pass.isEmpty) {
      throw FirebaseAuthException(
        code: 'reauth-cancelled',
        message: t.reauthCancelled,
      );
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: pass,
    );
    await user.reauthenticateWithCredential(credential);
  }

  Future<void> _deleteAccount() async {
    final t = AppLocalizations.of(context);
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showSnack(t.noActiveSession);
      return;
    }

    final uid = user.uid;

    setState(() => _deleting = true);
    try {
      await _reauthenticate(user);
      await _deleteUserData(uid);
      await user.delete();
      await FirebaseAuth.instance.signOut();

      _showSnack(t.accountDeleted);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        _showSnack(t.deleteAccountIncorrectPassword);
      } else if (e.code == 'requires-recent-login') {
        _showSnack(t.reauthenticationNeeded);
      } else if (e.code != 'reauth-cancelled') {
        _showSnack(t.deleteAccountError);
      }
    } catch (_) {
      _showSnack(t.deleteAccountError);
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  Future<void> _confirmDeleteAccount() async {
    final t = AppLocalizations.of(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(t.deleteAccountConfirmTitle),
        content: Text(t.deleteAccountConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(t.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(t.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _deleteAccount();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final warningBody = t.deleteAccountBody;

    return Scaffold(
      appBar: AppBar(title: Text(t.deleteAccountTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE6EAF0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    t.deleteAccountTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    warningBody,
                    style: const TextStyle(color: Colors.black87, height: 1.35),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: _deleting ? null : _confirmDeleteAccount,
                    child: _deleting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(t.deleteAccountButton),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
