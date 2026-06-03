# Release Candidate (RC)

## Versión candidata a entrega

Esta versión incluye las funcionalidades principales para la gestión de prácticas empresariales entre estudiantes, empresas y administradores. El sistema cuenta con autenticación, gestión de usuarios, publicación de ofertas y manejo de postulaciones básicas.

---

# Funcionalidades incluidas

## Estudiante

### Gestión de ofertas

* Visualizar ofertas publicadas por las empresas.
* Consultar información detallada de cada oferta.
* Filtrar ofertas mediante palabras clave (título, descripción, ubicación o área de práctica).

### Gestión de postulaciones

* Postularse a ofertas disponibles.
* Restricción para evitar postulaciones duplicadas a una misma oferta.
* Visualizar el estado actual de sus postulaciones.

### Gestión documental

* Crear documentos asociados al perfil.
* Consultar documentos cargados.
* Actualizar documentos existentes.
* Eliminar documentos.
* Almacenar hojas de vida y cartas de presentación.

---

## Empresa

### Gestión de ofertas

* Crear ofertas de práctica.
* Editar ofertas existentes.
* Cerrar ofertas.
* Consultar todas las ofertas creadas por la empresa.

### Gestión de postulaciones

* Visualizar postulaciones recibidas.
* Cambiar el estado de una postulación.
* Marcar candidatos como preseleccionados.
* Aprobar candidatos.
* Rechazar candidatos.

### Gestión de seguimiento

* Registrar seguimientos asociados a estudiantes.
* Consultar seguimientos realizados.

---

## SuperAdmin

### Gestión de usuarios

* Visualizar todos los usuarios registrados.
* Consultar fecha de creación de usuarios.
* Consultar estado de cada usuario.
* Activar usuarios.
* Bloquear usuarios.
* Gestionar estudiantes, empresas y administradores desde una única interfaz.

---


# Funcionalidades pendientes

## Estudiante

* Visualización consolidada de seguimientos realizados durante la práctica.
* Historial detallado de cambios de estado de las postulaciones.

## Postulaciones

* Asociar documentos específicos a cada postulación.
* Cierre automático de ofertas cuando no existan vacantes disponibles.
* Notificaciones de cambios de estado.

## Empresa

* Estadísticas sobre ofertas publicadas.
* Dashboard con indicadores de postulaciones y candidatos.

## SuperAdmin

* Filtros avanzados por rol y estado de usuario.
* Dashboard administrativo con métricas del sistema.
* Exportación de reportes.
* Gestión de permisos más granular.

## Coordinador

* Implementación completa del rol Coordinador.
* Asignación de estudiantes a empresas.
* Validación institucional de postulaciones.
* Seguimiento académico de prácticas.

---

# Riesgos conocidos

## Estudiante

* Carga de documentos con contenido incorrecto o información incompleta.
* Dependencia de la calidad de la información registrada por las empresas.

## Empresa

* Registro de ubicaciones o información empresarial incorrecta.
* Publicación de ofertas con información insuficiente.

## Plataforma

* Dependencia de la disponibilidad de Firebase.
* Posibles inconsistencias si múltiples usuarios modifican simultáneamente una misma entidad.
* Rendimiento variable en conexiones de internet lentas.

---

# Lista para entrega

## Funcionalidades críticas

* [x] Autenticación
* [x] Gestión de usuarios
* [x] Gestión de ofertas
* [x] Gestión de postulaciones
* [x] Gestión documental
* [x] Gestión básica de seguimiento
* [x] Persistencia en Firebase

## Validaciones

* [x] Restricción de postulaciones duplicadas
* [x] Validación de formularios
* [x] Validación de autenticación

## Calidad

* [x] Pruebas manuales básicas
* [x] Revisión de flujos principales
* [x] Verificación de roles

## Entrega
Sí, versión inicial.
