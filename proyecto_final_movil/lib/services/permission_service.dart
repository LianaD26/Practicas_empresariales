import '../models/user_model.dart';
import '../models/offer_model.dart';
import '../models/postulation_model.dart';
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
        user.role ==
            UserRoles.student; // El estudiante ve sus propias postulaciones
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

  /// REGLA 1: Un estudiante NO puede postularse dos veces a la misma oferta.
  /// Siempre retorna false — ningún rol puede tener postulaciones duplicadas
  /// a la misma oferta. La verificación de duplicado real se hace consultando
  /// [FirestoreService.hasStudentApplied] antes de llamar a [createOrUpdatePostulacion].
  bool canApplyMultipleTimes(UserModel user) {
    return false;
  }

  /// REGLA 2: Una oferta cerrada NO recibe postulaciones.
  /// Recibe el [OfertaEstado] para evitar errores de inversión lógica en el caller.
  /// Solo las ofertas con estado [OfertaEstado.publicada] aceptan postulaciones.
  bool canReceiveApplications(OfertaEstado estado) {
    return estado == OfertaEstado.publicada;
  }

  /// REGLA 3: Una postulación debe iniciar con estado [PostulacionEstado.postulado].
  /// Retorna el enum tipado para evitar incompatibilidades con el modelo.
  PostulacionEstado getInitialApplicationState() {
    return PostulacionEstado.postulado;
  }

  /// REGLA 4: Solo coordinador puede aprobar/rechazar
  bool canModifyApplicationStatus(UserModel user) {
    return user.role == UserRoles.coordinator && user.isActive;
  }

  /// REGLA 5: La empresa puede marcar como preseleccionado.
  /// Equivalente a [canPreselect] — se mantiene un único método.
  bool canMarkAsPreselected(UserModel user) {
    return user.role == UserRoles.company && user.isActive;
  }

  /// REGLA 6: Una postulación rechazada DEBE tener motivo.
  /// Valida que [motivo] no sea nulo ni vacío cuando el [estado] es rechazado.
  /// Lanza [ArgumentError] si la regla se viola.
  void validateRejectionReason(PostulacionEstado estado, String? motivo) {
    if (estado == PostulacionEstado.rechazado &&
        (motivo == null || motivo.trim().isEmpty)) {
      throw ArgumentError(AppMessages.errorRejectionReasonRequired);
    }
  }

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
      'canChangeRoles': canChangeRoles(user),
      'canAccessMainApp': canAccessMainApp(user),
      'isBlocked': isUserBlocked(user),
      'isPendingApproval': isUserPendingApproval(user),
    };
  }

  /// Verifica si el usuario puede cambiar roles de otros usuarios
  bool canChangeRoles(UserModel user) {
    return user.role == UserRoles.superadmin && user.isActive;
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
        case UserRoles.superadmin:
          return AppRoutes.superadminHome;
        case UserRoles.coordinator:
          return AppRoutes.coordinatorHome;
        default:
          return AppRoutes.home;
      }
    }

    return AppRoutes.home;
  }
}
