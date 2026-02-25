// lib/ui/invoices/widgets/item_description_field.dart

import 'package:ezinvoice/repositories/business_profile_repository.dart';
import 'package:flutter/material.dart';

class ItemDescriptionField extends StatefulWidget {
  final TextEditingController controller;

  /// lista de presets ya cargada (para no hacer fetch por cada item)
  final List<String> presets;

  /// callback opcional para refrescar lista en el padre (si quieres)
  final VoidCallback? onPresetAdded;

  const ItemDescriptionField({
    super.key,
    required this.controller,
    required this.presets,
    this.onPresetAdded,
  });

  @override
  State<ItemDescriptionField> createState() => _ItemDescriptionFieldState();
}

class _ItemDescriptionFieldState extends State<ItemDescriptionField> {
  static const brandGreen = Color(0xFF1F6E5C);

  final _repo = BusinessProfileRepository();

  bool _saving = false;

  bool _existsInPresets(String v) {
    final x = v.trim().toLowerCase();
    return widget.presets.any((p) => p.trim().toLowerCase() == x);
  }

  Future<void> _savePreset() async {
    final text = widget.controller.text.trim();
    if (text.isEmpty) return;
    if (_existsInPresets(text)) return;

    setState(() => _saving = true);
    try {
      await _repo.addPreset(text);
      widget.onPresetAdded?.call();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final presets = widget.presets;

    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue value) {
        final q = value.text.trim().toLowerCase();
        if (q.isEmpty) return const Iterable<String>.empty();

        return presets.where((p) => p.toLowerCase().contains(q));
      },
      onSelected: (selection) {
        widget.controller.text = selection;
        widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: selection.length),
        );
      },
      fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
        // ✅ Usamos tu controller real, pero el Autocomplete te da uno interno.
        // Sincronizamos el interno -> real
        textController.text = widget.controller.text;

        textController.addListener(() {
          if (widget.controller.text != textController.text) {
            widget.controller.text = textController.text;
          }
        });

        final canSave = widget.controller.text.trim().isNotEmpty &&
            !_existsInPresets(widget.controller.text);

        return TextField(
          controller: textController,
          focusNode: focusNode,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Description',
            prefixIcon: const Icon(Icons.list_alt_outlined, color: brandGreen),
            suffixIcon: canSave
                ? IconButton(
              tooltip: 'Save as preset',
              onPressed: _saving ? null : _savePreset,
              icon: _saving
                  ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Icon(Icons.bookmark_add_outlined, color: brandGreen),
            )
                : null,
          ),
          onSubmitted: (_) => onFieldSubmitted(),
        );
      },
    );
  }
}
