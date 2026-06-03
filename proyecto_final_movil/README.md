# **PROYECTO: PRÁCTICAS EMPRESARIALES**
# Descripción del problema
El proceso de gestión de prácticas empresariales suele realizarse mediante correos electrónicos, formularios y documentos dispersos, lo que dificulta el seguimiento de los estudiantes, la publicación de ofertas y la comunicación entre las partes involucradas. Esta situación genera retrasos en la validación de información, pérdida de trazabilidad sobre las postulaciones y dificultades para monitorear el estado de cada proceso.

La plataforma de Prácticas Empresariales busca centralizar y automatizar este proceso mediante una aplicación que permita a estudiantes, empresas y administradores gestionar ofertas, postulaciones, documentos y seguimientos desde un único sistema. De esta manera, se mejora la organización de la información, se facilita el control de estados y se optimiza la interacción entre los diferentes actores del proceso de prácticas.

# Integrantes del equipo:
* Liana Díaz
* David López
* Mateo Molina
* Luis Pablo Goez

# Roles implementados:
* Estudiante
* Empresa
* SuperAdmin

# Usuarios de prueba

Estudiante: 
* Usuario: li@gmail.com, Contraseña: Lima2619
* Usuario: laura@gmail.com, Contraseña: Laura123

-- Pendiente -> Coordinador: margarita1@gmail.com, Marg123

SuperAdmin: 
* Usuario: admin1@gmail.com, Contraseña: Admin123456789

Empresa: 
* Usuario: sura@gmail.com, Contraseña: Sura123

# Entidades principales
* Usuario
* Empresa
* Oferta
* Postulación 
* Documento
* Seguimiento 

# Modelado de entidades en Firestone
La aplicación utiliza Firebase Firestore como base de datos NoSQL. Cada entidad principal se almacena en una colección independiente.

**users**

Almacena la información de estudiantes, empresas y administradores.

Ejemplo:

{
  "uid": "user123",
  "email": "li@gmail.com",
  "displayName": "Liana Díaz",
  "role": "student",
  "status": "active",
  "createdAt": "1 de junio de 2026 a las 9:41:22 p.m. UTC-5"
}

**offers**

Almacena las ofertas publicadas por las empresas.

{
  "areaPractica": Académica,
  "createdAt": "1 de junio de 2026 a las 9:41:22 p.m. UTC-5",
  "descripcion": "...",
  "empresaId": "snaibiwenconokcnew",
  "estado": "borrador",
  "fechaLimite": "2 de junio de 2026 a las 9:41:22 p.m. UTC-5",
  "id": "cniobvwinwinc",
  "requisitos": "tener 20 años de experiencia",
  "titulo": "ingeniero",
  "ubicacion": "Medellín",
  "updateAt": "1 de junio de 2026 a las 9:41:22 p.m. UTC-5",
  "vacantes": 1
}

**applications**

Almacena las postulaciones realizadas por los estudiantes.

{
  "createdAt": "1 de junio de 2026 a las 9:41:22 p.m. UTC-5",
  "estado": "preseleccionado",
  "id": "bcioowenope",
  "motivoRechazo": null,
  "ofertaId": "cbruioienpwn",
  "studentId": "beoirncdmxo",
  "syncStatus": "synced",
  "updateAt": "4 de junio de 2026 a las 9:41:22 p.m. UTC-5"
}

**documentos**

Almacena los documentos asociados a los estudiantes.

{
  "fechaSubida": "1 de junio de 2026 a las 9:41:22 p.m. UTC-5",
  "id": "cbwuosanxapos",
  "nombre": "hoja de vida",
  "tipo": "hoja_de_vida",
  "url": "https://drive.google.com/file/...",
  "usuarioId": "beucioenxow"
}


# Reglas de negocio
* Un estudiante no puede postularse dos veces a la misma oferta
* Una oferta cerrada no recibe postulaciones -> no aparece disponible
* Una postulación debe tener un estado inicial -> Postulado
* La empresa puede aprobar o rechazar una postulación
* La empresa puede marcar candidatos como preseleccionados
* Una postulación rechazada debe mostrar un motivo

# Estados de negocio

## Estados de Usuario
* pendingApproval
* active
* blocked

## Estados de Oferta
* borrador
* publicada
* cerrada

## Estados de Postulación
* postulado
* preseleccionado
* aprobado
* rechazado

# Flujos de estados - ENTIDADES

## Flujo de estado para la entidad principal - Usuario

**Estados:**
* pendingApproval: pendiente de aprobación - no puede usar la cuenta aún
* active: usuario activo - puede usar toda la aplicación con su respectivo rol
* blocked: usuario bloqueado - no puede usar la cuenta

**Flujo permitido:**
pendingApproval -> active -> blocked

**Flujos especiales:**
blocked -> active

**Flujos no permitidos:**
pendingApproval -> blocked

## Flujo de estado para Oferta

La postulación es del lado del estudiante, y del lado de la empresa y el coordinador es una oferta.

**Estados:**
* Publicada: oferta visible para los estudiantes
* Borrador: oferta creada y guardada pero no visible para los estudiantes
* Cerrada: oferta guardada en el perfil de la empresa pero no es visible para los estudiantes

**Flujos permitidos:**
borrador -> publicada -> cerrada

**Flujos especiales:**
* cerrada -> publicada (si la empresa decide reabrir la oferta)
* publicada -> borrador (para realizar modificaciones antes de volver a publicarla)

**Flujos no permitidos:**
* borrador -> cerrada
* cerrada -> borrador

## Flujo de estado para Postulación

**Estados:**
* Postulado
* Preseleccionado
* Aprobado
* Rechazado

**Flujos permitidos:**
* postulado -> preseleccionado -> aprobado
* postulado -> rechazado
* preseleccionado -> rechazado

**Flujos especiales:**
* aprobado -> rechazado (solo por corrección administrativa)
* rechazado -> preseleccionado (si la empresa reconsidera la candidatura)

**Flujos no permitidos:**
* aprobado -> postulado
* aprobado -> preseleccionado
* rechazado -> postulado

# Explicación de autenticación
La autenticación se realiza mediante Firebase Authentication utilizando correo electrónico y contraseña. Al iniciar sesión, el sistema consulta la información del usuario en Firestore para identificar su rol y estado. Dependiendo del rol asignado, el usuario es redirigido a la interfaz correspondiente.

# Explicación roles y permisos
## Estudiante
* Consultar ofertas disponibles.
* Postularse a ofertas.
* Consultar el estado de sus postulaciones.
* Gestionar documentos asociados a su práctica.
* Consultar seguimientos realizados.

## Empresa
* Crear, editar y cerrar ofertas.
* Consultar postulaciones recibidas.
* Aprobar, rechazar o preseleccionar candidatos.
* Registrar seguimientos a estudiantes.

## SuperAdmin
* Aprobar o bloquear usuarios.
* Gestionar información general del sistema.
* Supervisar usuarios, ofertas y postulaciones.

# Explicación persistencia local
La aplicación utiliza almacenamiento local para conservar información temporal de sesión y reducir consultas innecesarias a Firebase. Esto permite mantener datos básicos del usuario autenticado y mejorar la experiencia de navegación cuando la conectividad es limitada.

## Tecnologías Utilizadas

###  Drift
Se utilizó Drift como herramienta de persistencia local. Drift permite trabajar con bases de datos SQLite de forma segura y organizada dentro de Flutter.

### SQLite
SQLite es el motor de base de datos donde se almacenan los datos localmente en el dispositivo.

### Firebase Firestore
Firestore continúa siendo la base de datos principal en la nube para almacenar y compartir la información entre usuarios.

## Arquitectura Offline First

Se implementó una estrategia Offline First, donde la aplicación utiliza primero los datos almacenados localmente y luego sincroniza la información con Firestore cuando existe conexión.

**Flujo general:**

text Usuario -> App -> Drift (Local) -> Firestore (Remoto) 

## Funcionamiento

### Cuando hay Internet

1. La aplicación consulta Firestore.
2. Los datos obtenidos se guardan en Drift.
3. La información se muestra al usuario.

### Cuando no hay Internet

1. La aplicación consulta los datos almacenados en Drift.
2. La información se muestra sin necesidad de conexión.

De esta forma el usuario puede seguir utilizando la aplicación aun cuando pierda acceso a la red.

**La implementación de Drift junto con la estrategia Offline First permite que la aplicación continúe operando sin conexión, almacenando información localmente y sincronizándola con Firebase cuando hay acceso a Internet. Esto mejora la disponibilidad, el rendimiento y la confiabilidad del sistema.**

# Explicación de sincronización con Firebase
La información se almacena en Firestore y se sincroniza mediante consultas y streams en tiempo real. Cuando un usuario realiza una acción, los cambios se reflejan inmediatamente en la base de datos y son propagados a los demás usuarios autorizados que estén consultando la misma información.

# Instrucciones para ejecutar el proyecto
1. Clonar el repositorio.
2. Instalar Flutter y sus dependencias.

Ejecutar:
*flutter pub get*

4. Configurar Firebase utilizando los archivos de configuración correspondientes.
5. Ejecutar la aplicación:
*flutter run*

Para ejecución web:

*flutter run -d chrome*

# Instrucciones para generar o instalar el APK
Generar APK de producción:

*flutter build apk --release*

El archivo generado se encontrará en:

*build/app/outputs/flutter-apk/app-release.apk*

Para instalar el APK en un dispositivo Android:

1. Transferir el archivo APK al dispositivo.
2. Habilitar la instalación desde fuentes desconocidas.
3. Ejecutar el APK y completar la instalación.