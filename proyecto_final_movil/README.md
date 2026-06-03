# Flujo de estado para la entidad principal - Usuario

Estados:
* pendingApproval: pendiente de aprobación - no puede usar la cuenta aún
* active: usuario activo - puede usar toda la aplicación con su respectivo rol
* blocked

Flujo permitido:
pendingApproval -> active -> blocked

Flujos especiales:
blocked -> active

Flujos no permitidos:
pendingApproval -> blocked

# Flujo de estado para Postulación/Oferta

Estados:
* Publicada
* Borrador
* Cerrada