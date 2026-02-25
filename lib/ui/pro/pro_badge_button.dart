import 'package:flutter/material.dart';
import 'package:ezinvoice/services/purchases/feature_gate.dart';
import 'package:ezinvoice/ui/pro/require_pro.dart';

class ProActionButton extends StatelessWidget {
  final ProFeature feature;
  final IconData icon;
  final String label;
  final Future<void> Function() onAllowed;
  final bool filled;

  const ProActionButton({
    super.key,
    required this.feature,
    required this.icon,
    required this.label,
    required this.onAllowed,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    final allowed = FeatureGate.allowed(feature);

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 8),
        Text(label),
        if (!allowed) ...[
          const SizedBox(width: 8),
          _ProPill(),
        ],
      ],
    );

    final onPressed = () async {
      await RequirePro.run(
        context,
        feature: feature,
        onAllowed: () async => await onAllowed(),
      );
    };

    if (filled) {
      return ElevatedButton(
        onPressed: onPressed,
        child: child,
      );
    }

    return OutlinedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

class _ProPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black12),
        color: Colors.black.withOpacity(0.06),
      ),
      child: const Text(
        'PRO',
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
      ),
    );
  }
}
