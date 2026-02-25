class StylePreset {
  final String id;
  final String label;

  const StylePreset(this.id, this.label);
}

class PalettePreset extends StylePreset {
  final int primary;
  final int soft;
  final int accent;

  const PalettePreset(
    super.id,
    super.label, {
    required this.primary,
    required this.soft,
    required this.accent,
  });
}

class AppThemePresets {
  static const String paletteMinimal = 'minimal';
  static const String paletteProfessional = 'professional';
  static const String paletteCorporate = 'corporate';
  static const String paletteModern = 'modern';
  static const String paletteSlate = 'slate';

  static const List<PalettePreset> palettes = [
    PalettePreset(
      paletteMinimal,
      'Minimal',
      primary: 0xFF4B5563,
      soft: 0xFFF9FAFB,
      accent: 0xFF1F2937,
    ),
    PalettePreset(
      paletteProfessional,
      'Professional',
      primary: 0xFF1E3A5F,
      soft: 0xFFEAF1F8,
      accent: 0xFF2B5D92,
    ),
    PalettePreset(
      paletteCorporate,
      'Corporate',
      primary: 0xFF0D4A3A,
      soft: 0xFFE8F4EF,
      accent: 0xFF1D7A5F,
    ),
    PalettePreset(
      paletteModern,
      'Modern',
      primary: 0xFF0F766E,
      soft: 0xFFE6F6F4,
      accent: 0xFFF59E0B,
    ),
    PalettePreset(
      paletteSlate,
      'Slate',
      primary: 0xFF334155,
      soft: 0xFFF1F5F9,
      accent: 0xFF0F172A,
    ),
  ];

  static const String layoutMinimal = 'minimal';
  static const String layoutProfessional = 'professional';
  static const String layoutCorporate = 'corporate';
  static const String layoutModern = 'modern';

  static const List<StylePreset> layouts = [
    StylePreset(layoutMinimal, 'Minimal'),
    StylePreset(layoutProfessional, 'Professional'),
    StylePreset(layoutCorporate, 'Corporate'),
    StylePreset(layoutModern, 'Modern'),
  ];

  static String normalizePalette(String? id) {
    final v = (id ?? '').trim().toLowerCase();
    for (final p in palettes) {
      if (p.id == v) return p.id;
    }
    return paletteMinimal;
  }

  static String normalizeLayout(String? id) {
    final v = (id ?? '').trim().toLowerCase();
    for (final l in layouts) {
      if (l.id == v) return l.id;
    }
    return layoutMinimal;
  }

  static String paletteLabel(String? id) {
    final normalized = normalizePalette(id);
    for (final p in palettes) {
      if (p.id == normalized) return p.label;
    }
    return 'Minimal';
  }

  static String layoutLabel(String? id) {
    final normalized = normalizeLayout(id);
    for (final l in layouts) {
      if (l.id == normalized) return l.label;
    }
    return 'Minimal';
  }
}
