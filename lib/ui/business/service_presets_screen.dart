// lib/ui/business/service_presets_screen.dart

import 'package:flutter/material.dart';
import 'package:ezinvoice/l10n/app/app_localizations.dart';
import '../../repositories/business_profile_repository.dart';

class ServicePresetsScreen extends StatefulWidget {
  const ServicePresetsScreen({super.key});

  @override
  State<ServicePresetsScreen> createState() => _ServicePresetsScreenState();
}

class _ServicePresetsScreenState extends State<ServicePresetsScreen> {
  static const brandGreen = Color(0xFF1F6E5C);

  final _repo = BusinessProfileRepository();
  final _controller = TextEditingController();

  bool _busy = false;

  Future<void> _add() async {
    final v = _controller.text.trim();
    if (v.isEmpty) return;

    setState(() => _busy = true);
    try {
      await _repo.addPreset(v);
      _controller.clear();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _remove(String v) async {
    setState(() => _busy = true);
    try {
      await _repo.removePreset(v);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: brandGreen,
          foregroundColor: Colors.white,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text(t.servicePresetsScreenTitle)),
        body: StreamBuilder(
          stream: _repo.stream(),
          builder: (context, snap) {
            final presets = snap.hasData
                ? (snap.data!.servicePresets)
                : <String>[];
            final list = presets.toList()..sort((a, b) => a.compareTo(b));

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        t.servicePresetsAddNew,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _busy ? null : _add(),
                        decoration: InputDecoration(
                          hintText: t.servicePresetsHint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FilledButton.icon(
                        onPressed: _busy ? null : _add,
                        icon: const Icon(Icons.add),
                        label: Text(t.servicePresetsAddButton),
                        style: FilledButton.styleFrom(
                          backgroundColor: brandGreen,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  t.yourPresets,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                if (list.isEmpty)
                  Text(
                    t.noPresetsYet,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  )
                else
                  ...list.map(
                    (p) => Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.black.withOpacity(0.06)),
                      ),
                      child: ListTile(
                        title: Text(
                          p,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                          ),
                          onPressed: _busy ? null : () => _remove(p),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
