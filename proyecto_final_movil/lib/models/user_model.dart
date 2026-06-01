/// Estados posibles de una cuenta de usuario
enum UserStatus { pendingApproval, active, blocked }

class UserModel {
  final String uid;
  final String email;
  final String displayName; // Nombre del usuario
  final String role; // 'student', 'company', 'coordinator'
  final UserStatus status; // Estado de la cuenta
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    this.status = UserStatus.pendingApproval,
    required this.createdAt,
  });

  /// Convierte el modelo a JSON para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': role,
      'status': status.toString().split('.').last, // 'pendingApproval', 'active', 'blocked'
      'createdAt': createdAt,
    };
  }

  /// Crea un modelo desde un mapa de Firestore
  factory UserModel.fromMap(Map<String, dynamic> map) {
    // Convertir string de status a enum
    UserStatus statusEnum = UserStatus.pendingApproval;
    if (map['status'] != null) {
      try {
        statusEnum = UserStatus.values.firstWhere(
          (e) => e.toString().split('.').last == map['status'],
          orElse: () => UserStatus.pendingApproval,
        );
      } catch (e) {
        statusEnum = UserStatus.pendingApproval;
      }
    }

    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? map['name'] ?? '',
      role: map['role'] ?? 'student',
      status: statusEnum,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] is DateTime
              ? map['createdAt']
              : DateTime.parse(map['createdAt'].toDate().toString()))
          : DateTime.now(),
    );
  }

  /// Copia el modelo con cambios
  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? role,
    UserStatus? status,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Verifica si la cuenta está activa
  bool get isActive => status == UserStatus.active;

  /// Verifica si la cuenta está bloqueada
  bool get isBlocked => status == UserStatus.blocked;

  /// Verifica si la cuenta está pendiente de aprobación
  bool get isPendingApproval => status == UserStatus.pendingApproval;

  /// Verifica si puede acceder a la aplicación
  bool get canAccessApp => status == UserStatus.active || status == UserStatus.pendingApproval;
}
