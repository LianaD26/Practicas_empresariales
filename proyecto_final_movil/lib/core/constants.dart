/// Definición centralizada de roles
class UserRoles {
  static const String student = 'student';
  static const String company = 'company';
  static const String coordinator = 'coordinator';
  static const String superadmin = 'superadmin';

  static bool isValidRole(String role) {
    return [student, company, coordinator, superadmin].contains(role);
  }

  static String getDisplayName(String role) {
    switch (role) {
      case student:
        return 'Estudiante';
      case company:
        return 'Empresa';
      case coordinator:
        return 'Coordinador';
      case superadmin:
        return 'Super Administrador';
      default:
        return 'Usuario';
    }
  }
}

/// Definición centralizada de estados
class AppStates {
  // Estados de cuenta de usuario
  static const String userStatusPendingApproval = 'pendingApproval';
  static const String userStatusActive = 'active';
  static const String userStatusBlocked = 'blocked';

  // Estados de oferta
  static const String offerStateDraft = 'borrador';
  static const String offerStatePublished = 'publicada';
  static const String offerStateClosed = 'cerrado';

  // Estados de postulación
  static const String applicationStateApplied = 'postulado';
  static const String applicationStatePreselected = 'preseleccionado';
  static const String applicationStateApproved = 'aprobado';
  static const String applicationStateRejected = 'rechazado';

  // Estados de sincronización (offline-first)
  static const String syncStatusPendingSync = 'pendingSync';
  static const String syncStatusSynced = 'synced';

  static const String syncPendingLabel = 'Pendiente de sincronización';
}

/// Firestore collections
class FirestoreCollections {
  static const String users = 'users';
  static const String companies = 'companies';
  static const String offers = 'offers';
  static const String applications = 'applications';
  static const String documents = 'documents';
  static const String tracking = 'tracking';
}

/// Mensajes de error comunes
class AppMessages {
  // Auth
  static const String errorUserNotFound = 'Usuario no encontrado';
  static const String errorWrongPassword = 'Contraseña incorrecta';
  static const String errorInvalidEmail = 'Email inválido';
  static const String errorUserDisabled = 'Usuario deshabilitado';
  static const String errorTooManyRequests = 'Demasiados intentos. Intenta más tarde';

  // Permissions
  static const String errorAccessDenied = 'Acceso denegado';
  static const String errorInsufficientPermissions = 'Permisos insuficientes';

  // Business Rules
  static const String errorDuplicateApplication = 'Ya te has postulado a esta oferta';
  static const String errorClosedOffer = 'Esta oferta ya está cerrada';
  static const String errorRejectionReasonRequired = 'El motivo del rechazo es obligatorio';

  // Account Status
  static const String errorAccountBlocked = 'Tu cuenta ha sido bloqueada';
  static const String errorAccountPendingApproval = 'Tu cuenta está pendiente de aprobación';

  // General
  static const String errorUnknown = 'Error desconocido';
  static const String errorOffline = 'Sin conexión a internet';
  static const String successOperation = 'Operación exitosa';
}

/// Reglas de validación
class ValidationRules {
  static const int minPasswordLength = 6;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= minPasswordLength;
  }

  static bool isValidName(String name) {
    return name.isNotEmpty && 
        name.length >= minNameLength && 
        name.length <= maxNameLength;
  }
}

/// Rutas de navegación
class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String studentHome = '/student/home';
  static const String companyHome = '/company/home';
  static const String coordinatorHome = '/coordinator/home';
  static const String superadminHome = '/superadmin/home';
  static const String blocked = '/blocked';
  static const String pendingApproval = '/pending-approval';
  static const String offline = '/offline';
  static const String error = '/error';
}
