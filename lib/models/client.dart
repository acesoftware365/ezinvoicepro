class Client {
  final String id;

  final String name;
  final String email;

  /// Guardar E.164: +15555551234
  final String phoneE164;

  /// Guardar como se ve en pantalla: 555-555-1234 (depende del país)
  final String phoneDisplay;

  /// ISO del país: US, DO, ES, etc.
  final String phoneIso;

  final String notes;

  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneE164,
    required this.phoneDisplay,
    required this.phoneIso,
    required this.notes,
  });

  factory Client.fromMap(String id, Map<String, dynamic> data) {
    return Client(
      id: id,
      name: (data['name'] ?? '').toString(),
      email: (data['email'] ?? '').toString(),
      phoneE164: (data['phoneE164'] ?? '').toString(),
      phoneDisplay: (data['phoneDisplay'] ?? '').toString(),
      phoneIso: (data['phoneIso'] ?? 'US').toString(),
      notes: (data['notes'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'phoneE164': phoneE164,
    'phoneDisplay': phoneDisplay,
    'phoneIso': phoneIso,
    'notes': notes,
  };
}
