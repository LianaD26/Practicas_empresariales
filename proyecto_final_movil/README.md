# Flujo de estado para la entidad principal - Usuario

Estados:
* pendingApproval: pendiente de aprobación - no puede usar la cuenta aún
* active: usuario activo - puede usar toda la aplicación con su respectivo rol
* blocked: usuario bloqueado - no puede usar la cuenta

Flujo permitido:
pendingApproval -> active -> blocked

Flujos especiales:
blocked -> active

Flujos no permitidos:
pendingApproval -> blocked

# Flujo de estado para Oferta

La postulación es del lado del estudiante, y del lado de la empresa y el coordinador es una oferta.

Estados:
* Publicada: oferta visible para los estudiantes
* Borrador: 
* Cerrada

# Flujo de estado para Postulación

* Postulado
* Preseleccionado
* Aprobado
* Rechazado