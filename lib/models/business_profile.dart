// lib/models/business_profile.dart

class BusinessProfile {
  static const Object _unset = Object();

  final String businessName;
  final String ownerName;
  final String phone;
  final String email;
  final String address;

  final String currencyCode; // USD, DOP, EUR
  final double defaultTaxRate; // 0-100
  final String footerNote;
  final String paletteId;
  final String invoicePaletteId;
  final String reportPaletteId;
  final String invoiceLayoutId;
  final String reportLayoutId;

  final String? logoFilePath;
  final String? logoDataBase64;
  factory BusinessProfile.empty() => const BusinessProfile(
    businessName: '',
    currencyCode: 'USD',
    defaultTaxRate: 0.0,
    // agrega aquí cualquier otro field required con default
  );

  // ✅ NEW: presets de servicios/descripciones
  final List<String> servicePresets;

  const BusinessProfile({
    this.businessName = '',
    this.ownerName = '',
    this.phone = '',
    this.email = '',
    this.address = '',
    this.currencyCode = 'USD',
    this.defaultTaxRate = 0.0,
    this.footerNote = '',
    this.paletteId = 'minimal',
    this.invoicePaletteId = 'minimal',
    this.reportPaletteId = 'minimal',
    this.invoiceLayoutId = 'minimal',
    this.reportLayoutId = 'minimal',
    this.logoFilePath,
    this.logoDataBase64,
    this.servicePresets = const [],
  });

  BusinessProfile copyWith({
    String? businessName,
    String? ownerName,
    String? phone,
    String? email,
    String? address,
    String? currencyCode,
    double? defaultTaxRate,
    String? footerNote,
    String? paletteId,
    String? invoicePaletteId,
    String? reportPaletteId,
    String? invoiceLayoutId,
    String? reportLayoutId,
    Object? logoFilePath = _unset,
    Object? logoDataBase64 = _unset,
    List<String>? servicePresets,
  }) {
    return BusinessProfile(
      businessName: businessName ?? this.businessName,
      ownerName: ownerName ?? this.ownerName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      currencyCode: currencyCode ?? this.currencyCode,
      defaultTaxRate: defaultTaxRate ?? this.defaultTaxRate,
      footerNote: footerNote ?? this.footerNote,
      paletteId: paletteId ?? this.paletteId,
      invoicePaletteId: invoicePaletteId ?? this.invoicePaletteId,
      reportPaletteId: reportPaletteId ?? this.reportPaletteId,
      invoiceLayoutId: invoiceLayoutId ?? this.invoiceLayoutId,
      reportLayoutId: reportLayoutId ?? this.reportLayoutId,
      logoFilePath: identical(logoFilePath, _unset)
          ? this.logoFilePath
          : logoFilePath as String?,
      logoDataBase64: identical(logoDataBase64, _unset)
          ? this.logoDataBase64
          : logoDataBase64 as String?,
      servicePresets: servicePresets ?? this.servicePresets,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'businessName': businessName,
      'ownerName': ownerName,
      'phone': phone,
      'email': email,
      'address': address,
      'currencyCode': currencyCode,
      'defaultTaxRate': defaultTaxRate,
      'footerNote': footerNote,
      'paletteId': paletteId,
      'invoicePaletteId': invoicePaletteId,
      'reportPaletteId': reportPaletteId,
      'invoiceLayoutId': invoiceLayoutId,
      'reportLayoutId': reportLayoutId,
      'logoFilePath': logoFilePath,
      'logoDataBase64': logoDataBase64,
      // ✅ NEW
      'servicePresets': servicePresets,
    };
  }

  static BusinessProfile fromMap(Map<String, dynamic>? m) {
    if (m == null) return const BusinessProfile();

    double toDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v) ?? 0.0;
      return 0.0;
    }

    List<String> toStringList(dynamic v) {
      if (v == null) return const [];
      if (v is List) {
        return v
            .map((e) => (e ?? '').toString())
            .where((s) => s.trim().isNotEmpty)
            .toList();
      }
      return const [];
    }

    return BusinessProfile(
      businessName: (m['businessName'] ?? '').toString(),
      ownerName: (m['ownerName'] ?? '').toString(),
      phone: (m['phone'] ?? '').toString(),
      email: (m['email'] ?? '').toString(),
      address: (m['address'] ?? '').toString(),
      currencyCode: (m['currencyCode'] ?? 'USD').toString(),
      defaultTaxRate: toDouble(m['defaultTaxRate']),
      footerNote: (m['footerNote'] ?? '').toString(),
      paletteId: (m['paletteId'] ?? 'minimal').toString(),
      invoicePaletteId: (m['invoicePaletteId'] ?? m['paletteId'] ?? 'minimal')
          .toString(),
      reportPaletteId: (m['reportPaletteId'] ?? m['paletteId'] ?? 'minimal')
          .toString(),
      invoiceLayoutId: (m['invoiceLayoutId'] ?? 'minimal').toString(),
      reportLayoutId: (m['reportLayoutId'] ?? 'minimal').toString(),
      logoFilePath: (m['logoFilePath'] as String?),
      logoDataBase64: (m['logoDataBase64'] as String?),
      // ✅ NEW
      servicePresets: toStringList(m['servicePresets']),
    );
  }
}
