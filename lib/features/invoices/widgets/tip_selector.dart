import 'package:flutter/material.dart';

enum TipMode { amount, percent }

class TipSelector extends StatelessWidget {
  final TipMode mode;
  final ValueChanged<TipMode> onModeChanged;

  final TextEditingController controller; // valor escrito
  final double subtotal;
  final ValueChanged<double> onTipAmountChanged; // tip ya calculado (monto final)

  const TipSelector({
    super.key,
    required this.mode,
    required this.onModeChanged,
    required this.controller,
    required this.subtotal,
    required this.onTipAmountChanged,
  });

  double _parse(String v) {
    final s = v.trim().replaceAll('%', '');
    return double.tryParse(s) ?? 0.0;
  }

  double _calcTipAmount(TipMode m, double value, double sub) {
    if (sub < 0) sub = 0;
    if (m == TipMode.percent) {
      final pct = value.clamp(0, 100);
      return sub * (pct / 100.0);
    }
    return value < 0 ? 0 : value;
  }

  void _emit(TipMode m) {
    final value = _parse(controller.text);
    final tipAmount = _calcTipAmount(m, value, subtotal);
    onTipAmountChanged(tipAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<TipMode>(
                value: mode,
                decoration: const InputDecoration(
                  labelText: 'Tip tipo',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: TipMode.amount,
                    child: Text('Monto (\$)'),
                  ),
                  DropdownMenuItem(
                    value: TipMode.percent,
                    child: Text('Porcentaje (%)'),
                  ),
                ],
                onChanged: (v) {
                  final newMode = v ?? TipMode.amount;
                  onModeChanged(newMode);
                  _emit(newMode);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: mode == TipMode.percent ? 'Tip %' : 'Tip \$',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (_) => _emit(mode),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
