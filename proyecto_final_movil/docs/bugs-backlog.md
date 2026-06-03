# **BUGS ENCONTRADOS**

# Bugs pendientes

## Prioridad Alta

### BUG-001

**Descripción:** Algunos cambios de estado pueden requerir actualización manual de la vista. Se requieren más pruebas de este bug, porque sólo se probó con casos específicos.

**Impacto:** Medio

**Estado:** Pendiente

**Responsable:** David

---

### BUG-002

**Descripción:** La validación del contenido de documentos cargados es limitada.

**Impacto:** Bajo

**Estado:** Pendiente

**Responsable:** Goez

---

## Prioridad Media

### BUG-003

**Descripción:** Falta una mejor organización visual de listas extensas (usuarios, postulaciones u ofertas). Se recomienda implementar agrupación, filtros o secciones desplegables para mejorar la navegación.

**Impacto:** Bajo

**Estado:** Pendiente

**Responsable:** Mateo

---

### BUG-004

**Descripción:** Inconsistencias visuales en el color de los íconos del menú de navegación inferior. En algunas pantallas los íconos presentan bajo contraste con el fondo, dificultando su identificación.

**Impacto:** Bajo

**Estado:** Pendiente

**Responsable:** Liana

# Bugs corregidos

### BUG-FIX-001

**Descripción:** Las ofertas cerradas seguían apareciendo en el listado de ofertas disponibles para estudiantes.

**Impacto:** Medio

**Solución aplicada:** Se ajustaron las consultas para mostrar únicamente ofertas con estado "Publicada".

**Estado:** Corregido

**Responsable:** Liana

### BUG-FIX-002

**Descripción:** El cierre de sesión no redirigía correctamente al usuario a la pantalla de autenticación en todos los casos.

**Impacto:** Medio

**Solución aplicada:** Se ajustó el flujo de navegación para limpiar el historial de rutas después del cierre de sesión.

**Estado:** Corregido

**Estado:** David