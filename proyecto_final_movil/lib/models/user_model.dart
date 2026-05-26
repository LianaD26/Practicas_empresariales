class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String role; // 'admin', 'user', etc.
  final DateTime createdAt;
  final bool isActive;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    required this.role,
    required this.createdAt,
    required this.isActive,
  });

  /// Convierte el modelo a JSON para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': role,
      'createdAt': createdAt,
      'isActive': isActive,
    };
  }

  /// Crea un modelo desde un mapa de Firestore
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'],
      role: map['role'] ?? 'user',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'].toDate().toString())
          : DateTime.now(),
      isActive: map['isActive'] ?? true,
    );
  }

  /// Copia el modelo con cambios
  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? role,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
