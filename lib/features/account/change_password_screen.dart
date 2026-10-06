import 'package:firebase_auth/firebase_auth.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _saving = false;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  String? _requiredPassword(String? value) {
    final text = value?.trim() ?? '';
    if (text.length < 6) {
      return AppLocalizations.of(context).passwordAtLeastSix;
    }
    return null;
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;
    final t = AppLocalizations.of(context);

    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;
    if (user == null || email == null || email.isEmpty) {
      _showSnack(t.noActiveSession);
      return;
    }

    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      _showSnack(t.passwordsDoNotMatch);
      return;
    }

    if (currentPassword == newPassword) {
      _showSnack(t.passwordMustDiffer);
      return;
    }

    setState(() => _saving = true);
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();

      _showSnack(t.passwordUpdated);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        _showSnack(t.incorrectPassword);
      } else if (e.code == 'weak-password') {
        _showSnack(t.weakPassword);
      } else if (e.code == 'requires-recent-login') {
        _showSnack(t.reauthenticationNeeded);
      } else {
        _showSnack(t.changePasswordError);
      }
    } catch (_) {
      _showSnack(t.changePasswordError);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      textInputAction: TextInputAction.next,
      validator: validator ?? _requiredPassword,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
          onPressed: onToggle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.changePassword)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE6EAF0)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      t.changePasswordSubtitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.confirmCurrentPasswordHint,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 16),
                    _passwordField(
                      controller: _currentPasswordController,
                      label: t.currentPassword,
                      obscure: _obscureCurrent,
                      onToggle: () {
                        setState(() => _obscureCurrent = !_obscureCurrent);
                      },
                    ),
                    const SizedBox(height: 12),
                    _passwordField(
                      controller: _newPasswordController,
                      label: t.newPassword,
                      obscure: _obscureNew,
                      onToggle: () {
                        setState(() => _obscureNew = !_obscureNew);
                      },
                    ),
                    const SizedBox(height: 12),
                    _passwordField(
                      controller: _confirmPasswordController,
                      label: t.confirmNewPassword,
                      obscure: _obscureConfirm,
                      onToggle: () {
                        setState(() => _obscureConfirm = !_obscureConfirm);
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _saving ? null : _changePassword,
                      icon: _saving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.lock_reset),
                      label: Text(_saving ? t.saving : t.updatePassword),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
