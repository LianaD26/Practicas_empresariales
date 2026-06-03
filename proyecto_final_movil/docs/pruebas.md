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

# --------- Ejecución de pruebas automatizadas -------------

Para ejecutar todas las pruebas unitarias del proyecto:

```bash
flutter test
```

Para ejecutar únicamente las pruebas de permisos:

```bash
flutter test test/unit/permission_service_test.dart
```

Para ejecutar únicamente las pruebas de postulaciones:

```bash
flutter test test/unit/postulacion_model_test.dart
```

Para ejecutar únicamente las pruebas de validadores:

```bash
flutter test test/unit/auth_validators_test.dart
```

## Resultado esperado

Al ejecutar los comandos anteriores, Flutter debe mostrar una salida similar a:

```text
00:02 +6: All tests passed!
```

Lo anterior indica que las seis pruebas unitarias fueron ejecutadas correctamente y que todas las reglas de negocio verificadas cumplen con el comportamiento esperado.

```
```

