import '../models/user_model.dart';
import '../core/constants.dart';

/// Servicio que centraliza la lógica de permisos y autorización
class PermissionService {
  static final PermissionService _instance = PermissionService._internal();

  factory PermissionService() {
    return _instance;
  }

  PermissionService._internal();

  // ============= PERMISOS POR ROL =============

  /// Verifica si el usuario puede ver ofertas
  bool canViewOffers(UserModel user) {
    return user.role == UserRoles.student ||
        user.role == UserRoles.coordinator ||
        user.role == UserRoles.company;
  }

  /// Verifica si el usuario puede crear ofertas
  bool canCreateOffer(UserModel user) {
    return user.role == UserRoles.company && user.isActive;
  }

  /// Verifica si el usuario puede editar una oferta
  bool canEditOffer(UserModel user, String offerCreatorId) {
    // Solo la empresa que creó la oferta puede editarla
    return user.role == UserRoles.company && user.uid == offerCreatorId;
  }

  /// Verifica si el usuario puede ver postulaciones
  bool canViewApplications(UserModel user) {
    return user.role == UserRoles.company ||
        user.role == UserRoles.coordinator ||
        user.role == UserRoles.student; // El estudiante ve sus propias postulaciones
  }

  /// Verifica si el usuario puede ver todas las postulaciones
  bool canViewAllApplications(UserModel user) {
    return user.role == UserRoles.coordinator || user.role == UserRoles.company;
  }

  /// Verifica si el usuario puede aplicar a una oferta
  bool canApplyToOffer(UserModel user) {
    return user.role == UserRoles.student && user.isActive;
  }

  /// Verifica si el usuario puede preseleccionar candidatos
  bool canPreselect(UserModel user) {
    return user.role == UserRoles.company && user.isActive;
  }

  /// Verifica si el usuario puede aprobar una postulación
  bool canApproveApplication(UserModel user) {
    return user.role == UserRoles.coordinator && user.isActive;
  }

  /// Verifica si el usuario puede rechazar una postulación
  bool canRejectApplication(UserModel user) {
    return user.role == UserRoles.coordinator && user.isActive;
  }

  /// Verifica si el usuario puede gestionar usuarios
  bool canManageUsers(UserModel user) {
    return user.role == UserRoles.coordinator && user.isActive;
  }

  /// Verifica si el usuario puede acceder a la app principal
  bool canAccessMainApp(UserModel user) {
    // Estudiantes, Empresas y Coordinadores activos pueden acceder
    return user.isActive || user.isPendingApproval;
  }

  /// Verifica si el usuario está bloqueado
  bool isUserBlocked(UserModel user) {
    return user.isBlocked;
  }

  /// Verifica si el usuario está pendiente de aprobación
  bool isUserPendingApproval(UserModel user) {
    return user.isPendingApproval;
  }

  // ============= REGLAS DE NEGOCIO =============

  /// REGLA 1: Un estudiante NO puede postularse dos veces a la misma oferta
  /// (Esto se valida en la lógica de aplicación, pero aquí está el permiso base)
  bool canApplyMultipleTimes(UserModel user) {
    // Estudiantes NO pueden postularse varias veces
    // Retorna false para evitar duplicados
    return user.role != UserRoles.student;
  }

  /// REGLA 2: Una oferta cerrada NO recibe postulaciones
  /// (Validado en el servicio de ofertas)
  bool canReceiveApplications(bool isClosed) {
    return !isClosed;
  }

  /// REGLA 3: Una postulación debe iniciar con estado "Postulado"
  /// (Validado en el modelo)
  String getInitialApplicationState() {
    return AppStates.applicationStateApplied; // 'postulado'
  }

  /// REGLA 4: Solo coordinador puede aprobar/rechazar
  bool canModifyApplicationStatus(UserModel user) {
    return user.role == UserRoles.coordinator && user.isActive;
  }

  /// REGLA 5: La empresa puede marcar como preseleccionado
  bool canMarkAsPreselected(UserModel user) {
    return user.role == UserRoles.company && user.isActive;
  }

  /// REGLA 6: Una postulación rechazada DEBE tener motivo
  bool isRejectionReasonRequired() {
    return true;
  }

  // ============= UTILIDADES =============

  /// Obtiene todos los permisos de un usuario en un map
  Map<String, bool> getAllPermissions(UserModel user) {
    return {
      'canViewOffers': canViewOffers(user),
      'canCreateOffer': canCreateOffer(user),
      'canViewApplications': canViewApplications(user),
      'canViewAllApplications': canViewAllApplications(user),
      'canApplyToOffer': canApplyToOffer(user),
      'canPreselect': canPreselect(user),
      'canApproveApplication': canApproveApplication(user),
      'canRejectApplication': canRejectApplication(user),
      'canManageUsers': canManageUsers(user),
      'canAccessMainApp': canAccessMainApp(user),
      'isBlocked': isUserBlocked(user),
      'isPendingApproval': isUserPendingApproval(user),
    };
  }

  /// Obtiene el rol de inicio recomendado para un usuario
  String getStartRoute(UserModel user) {
    // Si está bloqueado
    if (user.isBlocked) {
      return AppRoutes.blocked;
    }

    // Si está pendiente de aprobación
    if (user.isPendingApproval) {
      return AppRoutes.pendingApproval;
    }

    // Si está activo, ir según el rol
    if (user.isActive) {
      switch (user.role) {
        case UserRoles.student:
          return AppRoutes.studentHome;
        case UserRoles.company:
          return AppRoutes.companyHome;
        case UserRoles.coordinator:
          return AppRoutes.coordinatorHome;
        default:
          return AppRoutes.home;
      }
    }

    return AppRoutes.home;
  }
}
