# Flujo de estado para la entidad principal - Usuario

Estados:
* pendingApproval
* active
* blocked

Flujo permitido:
pendingApproval -> active -> blocked

Flujos especiales:
blocked -> active

Flujos no permitidos:
pendingApproval -> blocked