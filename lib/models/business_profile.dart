// lib/models/business_profile.dart

class BusinessProfile {
  final String businessName;
  final String ownerName;
  final String phone;
  final String email;
  final String address;

  final String currencyCode; // USD, DOP, EUR
  final double defaultTaxRate; // 0-100
  final String footerNote;

  final String? logoFilePath;
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
    this.logoFilePath,
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
    String? logoFilePath,
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
      logoFilePath: logoFilePath ?? this.logoFilePath,
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
      'logoFilePath': logoFilePath,
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
        return v.map((e) => (e ?? '').toString()).where((s) => s.trim().isNotEmpty).toList();
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
      logoFilePath: (m['logoFilePath'] as String?),
      // ✅ NEW
      servicePresets: toStringList(m['servicePresets']),
    );
  }
}
