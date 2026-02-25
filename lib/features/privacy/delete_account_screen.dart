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

  bool _isSpanish(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'es';
  }

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

  Future<void> _reauthenticate(User user, bool isEs) async {
    final email = user.email;
    if (email == null || email.isEmpty) return;

    final controller = TextEditingController();
    bool obscure = true;

    final pass = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(isEs ? 'Confirmar contraseña' : 'Confirm password'),
              content: TextField(
                controller: controller,
                obscureText: obscure,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: isEs ? 'Contraseña' : 'Password',
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
                  child: Text(isEs ? 'Cancelar' : 'Cancel'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pop(dialogContext, controller.text.trim()),
                  child: Text(isEs ? 'Continuar' : 'Continue'),
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
        message: isEs
            ? 'Cancelaste la confirmacion.'
            : 'Reauthentication cancelled.',
      );
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: pass,
    );
    await user.reauthenticateWithCredential(credential);
  }

  Future<void> _deleteAccount({required bool isEs}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showSnack(isEs ? 'No hay sesion activa.' : 'No active session.');
      return;
    }

    final uid = user.uid;

    setState(() => _deleting = true);
    try {
      await _reauthenticate(user, isEs);
      await _deleteUserData(uid);
      await user.delete();
      await FirebaseAuth.instance.signOut();

      _showSnack(
        isEs
            ? 'Tu cuenta y datos fueron eliminados permanentemente.'
            : 'Your account and data were permanently deleted.',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        _showSnack(isEs ? 'Contrasena incorrecta.' : 'Incorrect password.');
      } else if (e.code == 'requires-recent-login') {
        _showSnack(
          isEs
              ? 'Por seguridad, vuelve a iniciar sesion e intenta otra vez.'
              : 'For security, sign in again and try once more.',
        );
      } else if (e.code != 'reauth-cancelled') {
        _showSnack(
          isEs ? 'No se pudo eliminar la cuenta.' : 'Could not delete account.',
        );
      }
    } catch (_) {
      _showSnack(
        isEs ? 'No se pudo eliminar la cuenta.' : 'Could not delete account.',
      );
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  Future<void> _confirmDeleteAccount() async {
    final t = AppLocalizations.of(context);
    final isEs = _isSpanish(context);

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
      await _deleteAccount(isEs: isEs);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final isEs = _isSpanish(context);

    final warningBody = isEs
        ? 'Si eliminas tu cuenta:\n\n'
              '• Se eliminarán permanentemente tus clientes, facturas, reportes y perfil de negocio.\n'
              '• Esta acción no se puede deshacer.\n'
              '• Si tienes una suscripción activa, debes gestionarla o cancelarla en App Store/Google Play.'
        : 'If you delete your account:\n\n'
              '• Your clients, invoices, reports, and business profile will be permanently deleted.\n'
              '• This action cannot be undone.\n'
              '• If you have an active subscription, manage or cancel it in App Store/Google Play.';

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
