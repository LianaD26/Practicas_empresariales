# Pruebas realizadas

## 1. Pruebas de autenticación

### Caso 1: Inicio de sesión correcto

**Rol:** Estudiante, Empresa y SuperAdmin

**Acción:** Ingresar correo y contraseña válidos.

**Resultado esperado:** Acceso exitoso y redirección a la vista correspondiente según el rol.

**Resultado obtenido:** Correcto.

---

### Caso 2: Credenciales incorrectas

**Acción:** Ingresar correo o contraseña incorrectos.

**Resultado esperado:** Mostrar mensaje de error y bloquear acceso.

**Resultado obtenido:** Correcto.

---

### Caso 3: Usuario pendiente de aprobación

**Acción:** Intentar iniciar sesión con un usuario en estado `pendingApproval`.

**Resultado esperado:** No permitir acceso a la plataforma e informar el estado de la cuenta.

**Resultado obtenido:** Correcto.

---

### Caso 4: Usuario bloqueado

**Acción:** Intentar iniciar sesión con un usuario en estado `blocked`.

**Resultado esperado:** No permitir acceso a la plataforma.

**Resultado obtenido:** Correcto.

---

# 2. Pruebas por rol

## Estudiante

### Caso 5: Consultar ofertas

**Resultado esperado:** Visualizar únicamente ofertas publicadas.

**Resultado obtenido:** Correcto.

### Caso 6: Buscar ofertas

**Resultado esperado:** Filtrar ofertas por palabras clave.

**Resultado obtenido:** Correcto.

### Caso 7: Postularse a una oferta

**Resultado esperado:** Crear una nueva postulación.

**Resultado obtenido:** Correcto.

### Caso 8: Intentar postularse dos veces

**Resultado esperado:** El sistema debe impedir la duplicación.

**Resultado obtenido:** Correcto.

### Caso 9: Gestión de documentos

**Resultado esperado:** Crear, editar y eliminar documentos.

**Resultado obtenido:** Correcto.

---

## Empresa

### Caso 10: Crear oferta

**Resultado esperado:** Oferta almacenada en Firestore.

**Resultado obtenido:** Correcto.

### Caso 11: Editar oferta

**Resultado esperado:** Actualización correcta de los datos.

**Resultado obtenido:** Correcto.

### Caso 12: Cerrar oferta

**Resultado esperado:** La oferta deja de estar disponible para estudiantes.

**Resultado obtenido:** Correcto.

### Caso 13: Gestionar postulaciones

**Resultado esperado:** Cambiar estado de postulaciones.

**Resultado obtenido:** Correcto.

---

## SuperAdmin

### Caso 14: Consultar usuarios

**Resultado esperado:** Visualizar usuarios registrados.

**Resultado obtenido:** Correcto.

### Caso 15: Cambiar estado de usuario

**Resultado esperado:** Activar o bloquear usuarios.

**Resultado obtenido:** Correcto.

---

# 3. Flujo principal validado

1. Empresa crea una oferta.
2. Oferta se publica.
3. Estudiante consulta la oferta.
4. Estudiante realiza la postulación.
5. Empresa revisa postulaciones.
6. Empresa aprueba o rechaza candidatos.
7. Cambios de estado se reflejan en Firestore.

**Resultado:** Flujo ejecutado satisfactoriamente.

---

# 4. Casos de error

### Formulario vacío

**Acción:** Intentar guardar formularios sin completar campos obligatorios.

**Resultado esperado:** Mostrar mensajes de validación.

**Resultado obtenido:** Correcto - Faltan más pruebas.

---

### Datos inválidos

**Acción:** Ingresar valores incorrectos en formularios.

**Resultado esperado:** Impedir el envío.

**Resultado obtenido:** Correcto - Faltan más pruebas.

---

# 5. Pruebas de conectividad

### Firebase no disponible

**Acción:** Simular fallo de conexión con Firebase.

**Resultado esperado:** Mostrar mensaje de error y evitar pérdida de datos.

**Resultado obtenido:** Parcialmente validado.

---

### Sin conexión a Internet

**Acción:** Desconectar la red durante operaciones de consulta.

**Resultado esperado:** Informar error al usuario.

**Resultado obtenido:** Parcialmente validado.

---

# 6. Pruebas de persistencia y sincronización

### Persistencia local

**Resultado esperado:** Mantener la sesión del usuario.

**Resultado obtenido:** Correcto.

---

### Sincronización Firestore

**Resultado esperado:** Reflejar cambios en tiempo real.

**Resultado obtenido:** Correcto.

---

# 7. Unit Tests y Widget Tests

Actualmente el proyecto se validó principalmente mediante pruebas manuales.

Pruebas automatizadas implementadas: Sí.

Pruebas widget implementadas: Sí.

# 8. Pruebas automatizadas (Unit Tests)

Las pruebas automatizadas fueron implementadas utilizando el paquete `flutter_test`. Estas pruebas validan reglas de negocio, permisos por rol, cambios de estado y sincronización, garantizando el correcto funcionamiento de los procesos principales de la aplicación.

## UT-001: Estudiante activo puede aplicar a una oferta

**Objetivo:** Verificar que un usuario con rol estudiante y estado activo pueda realizar postulaciones.

**Regla de negocio validada:** Solo los estudiantes activos pueden aplicar a ofertas.

**Resultado esperado:** El método `canApplyToOffer()` retorna `true`.

---

## UT-002: Usuario pendiente de aprobación no puede aplicar a una oferta

**Objetivo:** Verificar que un usuario en estado `pendingApproval` no pueda realizar postulaciones.

**Regla de negocio validada:** Un usuario pendiente de aprobación no tiene acceso completo a las funcionalidades de la plataforma.

**Resultado esperado:** El método `canApplyToOffer()` retorna `false`.

---

## UT-003: Empresa activa puede aprobar postulaciones

**Objetivo:** Verificar que únicamente las empresas activas puedan aprobar postulaciones.

**Regla de negocio validada:** La aprobación de postulaciones es responsabilidad exclusiva de la empresa.

**Resultado esperado:** El método `canApproveApplication()` retorna `true`.

---

## UT-004: Estudiante no puede aprobar postulaciones

**Objetivo:** Verificar que un estudiante no pueda aprobar postulaciones.

**Regla de negocio validada:** Los estudiantes no tienen permisos administrativos sobre postulaciones.

**Resultado esperado:** El método `canApproveApplication()` retorna `false`.

---

## UT-005: Una nueva postulación inicia en estado "Postulado"

**Objetivo:** Verificar que toda postulación creada tenga el estado inicial correcto.

**Regla de negocio validada:** Toda postulación debe iniciar en estado `postulado`.

**Resultado esperado:** El atributo `estado` contiene el valor `PostulacionEstado.postulado`.

---

## UT-006: Una postulación pendiente requiere sincronización

**Objetivo:** Verificar el comportamiento de sincronización para registros creados sin conexión.

**Regla de negocio validada:** Los registros pendientes de sincronización deben marcarse con estado `pending`.

**Resultado esperado:** El método `necesitaSincronizacion` retorna `true`.

---

## Cobertura de requisitos de la rúbrica

Las pruebas implementadas validan:

* Reglas de negocio.
* Permisos y autorización por rol.
* Cambios de estado.
* Restricciones de acceso según estado de usuario.
* Comportamiento de sincronización (`pendingSync`).

# 9. Pruebas automatizadas (Widget Tests)
Las pruebas de widgets fueron implementadas utilizando el paquete `flutter_test`. Estas pruebas verifican la correcta construcción de modelos de usuario, la validación de estados y roles, y el comportamiento esperado de la lógica asociada a la navegación basada en perfiles dentro de la aplicación.

## WT-001: Validación de estados de usuario en AuthWrapper

**Objetivo:** Verificar que el modelo de usuario identifique correctamente los estados `active`, `blocked` y `pendingApproval`.

**Regla de negocio validada:** El sistema debe reconocer el estado de cada usuario para determinar el acceso a las funcionalidades de la plataforma.

**Resultado esperado:** Las propiedades `isActive`, `isBlocked` e `isPendingApproval` retornan los valores correctos según el estado asignado al usuario.

---

## WT-002: Detección de usuario bloqueado

**Objetivo:** Verificar que un usuario con estado `blocked` sea identificado correctamente.

**Regla de negocio validada:** Los usuarios bloqueados deben ser diferenciados de los usuarios activos y pendientes de aprobación.

**Resultado esperado:** La propiedad `isBlocked` retorna `true`, mientras que `isActive` e `isPendingApproval` retornan `false`.

---

## WT-003: Detección de usuario pendiente de aprobación

**Objetivo:** Verificar que un usuario con estado `pendingApproval` sea identificado correctamente.

**Regla de negocio validada:** Los usuarios pendientes de aprobación no deben considerarse activos ni bloqueados.

**Resultado esperado:** La propiedad `isPendingApproval` retorna `true`, mientras que `isActive` e `isBlocked` retornan `false`.

---

## WT-004: Serialización y deserialización de UserModel

**Objetivo:** Verificar que los datos de un usuario se conviertan correctamente a un mapa para su almacenamiento o transferencia.

**Regla de negocio validada:** La información del usuario debe conservar sus atributos al realizar procesos de serialización.

**Resultado esperado:** El método `toMap()` genera un mapa con los valores correctos para los campos `uid`, `email`, `displayName`, `role` y `status`.

---

## WT-005: Validación de constantes de roles

**Objetivo:** Verificar que las constantes definidas para los roles de usuario correspondan a los valores esperados.

**Regla de negocio validada:** Los roles del sistema deben mantenerse consistentes para garantizar el correcto funcionamiento de la navegación y los permisos.

**Resultado esperado:** Las constantes `student`, `company`, `coordinator` y `superadmin` contienen los valores definidos en la configuración del sistema.

---

## WT-006: Construcción de usuario con rol estudiante

**Objetivo:** Verificar que un usuario con rol `student` pueda ser creado correctamente.

**Regla de negocio validada:** La página principal debe poder identificar usuarios estudiantes para mostrar la interfaz correspondiente.

**Resultado esperado:** El usuario posee el rol `student` y su estado es reconocido como activo.

---

## WT-007: Construcción de usuario con rol empresa

**Objetivo:** Verificar que un usuario con rol `company` pueda ser creado correctamente.

**Regla de negocio validada:** La página principal debe poder identificar usuarios empresa para habilitar las funcionalidades asociadas a este perfil.

**Resultado esperado:** El usuario posee el rol `company` y su estado es reconocido como activo.

---

## WT-008: Gestión de todos los roles en HomePage

**Objetivo:** Verificar que la lógica de la página principal pueda manejar todos los roles definidos en el sistema.

**Regla de negocio validada:** La navegación basada en roles debe funcionar para estudiantes, empresas, coordinadores y superadministradores.

**Resultado esperado:** Cada usuario conserva correctamente su rol asignado y es reconocido como usuario activo durante el proceso de validación.

---

## WT-009: Cambio de roles permitido únicamente para superadministradores

**Objetivo:** Verificar que únicamente los usuarios con rol `superadmin` y estado activo puedan modificar los roles de otros usuarios.

**Regla de negocio validada:** La gestión de roles es una función exclusiva de los superadministradores activos.

**Resultado esperado:** El método `canChangeRoles()` retorna `true` para un superadministrador activo y `false` para otros roles o superadministradores bloqueados.

---

## WT-010: Creación de ofertas permitida únicamente para empresas activas

**Objetivo:** Verificar que solo las empresas con estado activo puedan publicar ofertas laborales.

**Regla de negocio validada:** La publicación de ofertas está restringida a usuarios con rol `company` y estado activo.

**Resultado esperado:** El método `canCreateOffer()` retorna `true` para empresas activas y `false` para estudiantes o empresas pendientes de aprobación.

---

## WT-011: Aprobación y rechazo de postulaciones por coordinadores

**Objetivo:** Verificar que únicamente los coordinadores activos puedan aprobar o rechazar postulaciones.

**Regla de negocio validada:** La gestión de postulaciones corresponde exclusivamente al rol de coordinador.

**Resultado esperado:** Los métodos `canApproveApplication()` y `canRejectApplication()` retornan `true` para coordinadores activos y `false` para estudiantes o empresas.

---

## WT-012: Postulación a ofertas permitida únicamente para estudiantes activos

**Objetivo:** Verificar que solo los estudiantes con estado activo puedan postularse a ofertas laborales.

**Regla de negocio validada:** La funcionalidad de postulación está restringida a estudiantes activos.

**Resultado esperado:** El método `canApplyToOffer()` retorna `true` para estudiantes activos y `false` para empresas o estudiantes pendientes de aprobación.

---

## WT-013: Acceso autorizado mediante RequireRole

**Objetivo:** Verificar que el widget `RequireRole` permita visualizar el contenido cuando el usuario posee uno de los roles autorizados.

**Regla de negocio validada:** Los usuarios con permisos adecuados deben acceder a las vistas protegidas.

**Resultado esperado:** El contenido protegido se muestra correctamente cuando el rol del usuario coincide con alguno de los roles permitidos.

---

## WT-014: Restricción de acceso por rol no autorizado

**Objetivo:** Verificar que el widget `RequireRole` impida el acceso cuando el usuario no posee los roles requeridos.

**Regla de negocio validada:** Los usuarios sin permisos suficientes no deben visualizar contenido restringido.

**Resultado esperado:** El contenido protegido no se muestra y se presenta la interfaz de acceso denegado.

---

## WT-015: Acceso permitido para múltiples roles autorizados

**Objetivo:** Verificar que el widget `RequireRole` permita el acceso cuando el usuario posee cualquiera de los roles incluidos en la lista de permisos.

**Regla de negocio validada:** Una vista puede ser compartida entre varios perfiles autorizados.

**Resultado esperado:** El contenido protegido se muestra correctamente cuando el usuario posee al menos uno de los roles configurados.

---

## WT-016: Validación de usuario pendiente de aprobación

**Objetivo:** Verificar que un usuario en estado `pendingApproval` sea identificado correctamente como usuario inactivo.

**Regla de negocio validada:** Los usuarios pendientes de aprobación no deben ser considerados activos dentro del sistema.

**Resultado esperado:** La propiedad `isPendingApproval` retorna `true`, la propiedad `isActive` retorna `false` y el rol del usuario se mantiene correctamente asignado.
