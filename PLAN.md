Título: US-001: Setup proyecto Firebase con ambientes y configuración inicial

Descripción:

Resumen: Crear y configurar proyecto Firebase con tres ambientes (dev, staging, production) incluyendo Firestore, Authentication, Cloud Functions, Storage, Hosting y Cloud Messaging.
Detalle:
Crear proyecto Firebase en Google Cloud Platform
Configurar ambientes separados (dev, staging, prod) con proyectos independientes
Habilitar todos los servicios Firebase necesarios según arquitectura
Configurar billing y límites de uso apropiados
Generar archivos de configuración para cada ambiente
Documentar credenciales y accesos en documentación interna (secrets management)
Referencia: Ver Sección 7.2 FASE 1 → Sprint 1-2 (Backend) y Sección 3 (Arquitectura de Sistema)
Criterios de aceptación (AC):

 AC1: Existen 3 proyectos Firebase completamente configurados (dev, staging, production) con naming convention consistente
 AC2: Todos los servicios están habilitados: Firestore, Auth, Functions, Storage, Hosting, FCM
 AC3: Archivos de configuración generados (firebase-config-dev.json, firebase-config-staging.json, firebase-config-prod.json) y almacenados de forma segura
 AC4: Billing configurado con alertas en $50, $100, $200 para evitar sobrecostos
 AC5: Documentación creada con URLs de consolas, service accounts y procedimiento de rotación de credenciales
Checklist técnica (Tareas):

 T1: Crear 3 proyectos en Firebase Console (smartfleet-dev, smartfleet-staging, smartfleet-prod)
 T2: Habilitar Firestore en modo nativo (no Datastore) con región us-central1
 T3: Habilitar Authentication con proveedores: Email/Password, Google (para admin web)
 T4: Habilitar Cloud Functions con runtime Node.js 20
 T5: Habilitar Cloud Storage con buckets por ambiente
 T6: Habilitar Firebase Hosting
 T7: Habilitar Cloud Messaging (FCM)
 T8: Configurar billing con método de pago y alertas presupuestarias
 T9: Generar y descargar service account keys para CI/CD
 T10: Crear documento docs/firebase-setup.md con toda la configuración
Estimación: 5 SP / 8h

Prioridad: Alta

Etiquetas (labels): tipo:setup fase:MVP componente:backend componente:devops

Dependencias: Ninguna (primer issue del proyecto)

Archivos/Carpetas relacionados:

/firebase/ (crear estructura base)
/docs/firebase-setup.md
/.env.example (template para variables de entorno)
Notas/Consideraciones:

Seguridad: NUNCA commitear credenciales al repositorio. Usar GitHub Secrets para CI/CD.
Costos: Configurar alertas de billing desde el inicio. Plan Blaze (pay-as-you-go) requerido para Cloud Functions.
Región: Usar us-central1 para minimizar latencia hacia Latinoamérica (Colombia, Perú, Chile son mercados target).
Naming: Usar prefijo smartfleet- para todos los proyectos para fácil identificación en GCP.
Service Accounts: Crear service account dedicado para CI/CD con permisos mínimos necesarios (principio de least privilege).

Título: US-002: Definir colecciones base Firestore con schemas iniciales

Descripción:

Resumen: Crear estructura de colecciones Firestore para companies, users, vehicles, trips con schemas base y reglas de validación iniciales.
Detalle:
Implementar schemas de las 4 colecciones principales del MVP
Crear índices compuestos necesarios para queries básicas
Definir estructura de documentos según especificación de base de datos
Preparar datos seed para desarrollo y testing
Referencia: Ver Sección 6.2 (Firestore Collections) y Sección 6.4 (Índices Compuestos)
Criterios de aceptación (AC):

 AC1: Colecciones companies, users, vehicles, trips creadas en Firestore dev con estructura documentada
 AC2: Índices compuestos definidos en firestore.indexes.json para queries básicas
 AC3: Datos seed creados con al menos 1 company, 3 users (1 admin, 2 drivers), 2 vehicles, 5 trips de ejemplo
 AC4: Schemas validados con TypeScript interfaces en /firebase/functions/src/types/
 AC5: Documentación de estructura de datos creada en /docs/database-schema.md
Checklist técnica (Tareas):

 T1: Crear archivo firestore.indexes.json con índices para company_id, user roles, vehicle status, trip status
 T2: Crear TypeScript interfaces para Company, User, Vehicle, Trip en /firebase/functions/src/types/models.ts
 T3: Crear script seed firebase/functions/src/scripts/seedData.ts para poblar datos de prueba
 T4: Definir estructura de subcollecciones (trips/{tripId}/route_points para preparar Fase 2)
 T5: Validar que campos requeridos coincidan con especificación (company_id, timestamps, status, etc)
 T6: Crear helper functions para generación de IDs consistentes (COMP-YYYY-XXX, USR-YYYY-XXX, VEH-YYYY-XXX, TRIP-YYYYMMDD-XXXX)
 T7: Deploy índices a Firestore dev: firebase deploy --only firestore:indexes
 T8: Ejecutar seed script y verificar datos en Firestore Console
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:backend componente:database

Dependencias: US-001

Archivos/Carpetas relacionados:

/firebase/firestore.indexes.json
/firebase/functions/src/types/models.ts
/firebase/functions/src/scripts/seedData.ts
/docs/database-schema.md
Notas/Consideraciones:

Multi-tenancy: Todos los documentos DEBEN incluir company_id para aislamiento de datos por empresa
Timestamps: Usar FieldValue.serverTimestamp() para created_at y updated_at en todas las colecciones
IDs: Implementar generación determinística de IDs legibles (no usar auto-IDs de Firestore) para facilitar debugging
Índices: Los índices compuestos pueden tardar varios minutos en crearse. Verificar estado en Firestore Console antes de testing
Schema evolution: Diseñar schemas con flexibilidad para agregar campos opcionales sin romper compatibilidad

Título: US-003: Implementar Firebase Security Rules básicas para MVP

Descripción:

Resumen: Configurar reglas de seguridad Firestore para proteger datos con aislamiento multi-tenant y control de acceso basado en roles.
Detalle:
Implementar reglas de lectura/escritura por colección
Validar aislamiento por company_id en todas las operaciones
Definir permisos por rol (admin, conductor, supervisor)
Crear test suite para validar reglas de seguridad
Referencia: Ver Sección 4.8 (Seguridad) y ADR-006 (Multi-tenancy Strategy)
Criterios de aceptación (AC):

 AC1: Archivo firestore.rules implementado con reglas para las 4 colecciones base
 AC2: Usuarios solo pueden acceder a datos de su propia empresa (validación company_id)
 AC3: Roles respetados: admins pueden escribir todo, conductores solo leen sus propios datos
 AC4: Test suite con al menos 15 casos de prueba pasando exitosamente
 AC5: Reglas deployed a ambiente dev y validadas manualmente
Checklist técnica (Tareas):

 T1: Crear archivo firebase/firestore.rules con estructura base
 T2: Implementar función helper isAuthenticated() y belongsToCompany(companyId)
 T3: Definir reglas para colección companies: solo admins pueden modificar
 T4: Definir reglas para users: usuarios pueden leer su propio perfil, admins pueden leer/escribir todos de su company
 T5: Definir reglas para vehicles: conductores pueden leer vehículos asignados, admins todo
 T6: Definir reglas para trips: conductores pueden leer/actualizar sus trips, admins todo
 T7: Crear archivo de tests firebase/firestore.rules.spec.ts usando @firebase/rules-unit-testing
 T8: Implementar tests para escenarios: acceso propio, acceso cross-company (debe fallar), acceso sin auth (debe fallar)
 T9: Deploy reglas: firebase deploy --only firestore:rules
 T10: Validar en Firestore Console con Rules Playground
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:security fase:MVP componente:backend componente:database

Dependencias: US-001, US-002

Archivos/Carpetas relacionados:

/firebase/firestore.rules
/firebase/firestore.rules.spec.ts
Notas/Consideraciones:

Seguridad crítica: Las reglas son la ÚNICA barrera de seguridad en Firestore. Nunca confiar solo en lógica client-side.
Testing obligatorio: No deploy a production sin test suite completo pasando al 100%.
Performance: Reglas complejas pueden afectar latencia. Mantener funciones helper simples y evitar reads adicionales dentro de reglas cuando sea posible.
Custom claims: Para roles de usuario, usar Firebase Auth custom claims (admin: true, role: 'conductor') en lugar de leer desde Firestore dentro de las reglas (más rápido).
Versioning: Mantener comentarios con fecha de cambio en reglas para auditoría.

Título: US-004: Setup CI/CD con GitHub Actions para deploy automático

Descripción:

Resumen: Configurar pipeline CI/CD con GitHub Actions para deploy automático de Firebase Functions, Firestore rules/indexes y hosting en push a branches dev/staging/main.
Detalle:
Crear workflows para ambientes dev, staging, production
Configurar secrets de GitHub para service accounts Firebase
Implementar jobs de lint, test, build, deploy
Configurar protección de branches y required checks
Referencia: Ver Sección 7.2 FASE 1 → Sprint 1-2 (Backend: Setup CI/CD)
Criterios de aceptación (AC):

 AC1: Workflow .github/workflows/deploy-dev.yml deployando a Firebase dev en push a branch develop
 AC2: Workflow .github/workflows/deploy-staging.yml deployando a staging en push a branch staging
 AC3: Workflow .github/workflows/deploy-prod.yml deployando a production en push a branch main (con aprobación manual)
 AC4: Jobs ejecutándose correctamente: lint → test → build → deploy
 AC5: Notificaciones de deploy en Slack/Discord (opcional pero recomendado)
Checklist técnica (Tareas):

 T1: Crear estructura de carpetas .github/workflows/
 T2: Crear workflow deploy-dev.yml con triggers en push a develop
 T3: Crear workflow deploy-staging.yml con triggers en push a staging
 T4: Crear workflow deploy-prod.yml con triggers en push a main y required manual approval
 T5: Configurar GitHub Secrets: FIREBASE_SERVICE_ACCOUNT_DEV, FIREBASE_SERVICE_ACCOUNT_STAGING, FIREBASE_SERVICE_ACCOUNT_PROD
 T6: Implementar job lint usando ESLint para Functions
 T7: Implementar job test ejecutando unit tests de Functions y Firestore rules
 T8: Implementar job build compilando TypeScript
 T9: Implementar job deploy usando firebase-tools con token de service account
 T10: Configurar branch protection rules en GitHub: require PR reviews para main y staging
Estimación: 5 SP / 8h

Prioridad: Alta

Etiquetas (labels): tipo:devops fase:MVP componente:devops componente:ci-cd

Dependencias: US-001

Archivos/Carpetas relacionados:

/.github/workflows/deploy-dev.yml
/.github/workflows/deploy-staging.yml
/.github/workflows/deploy-prod.yml
/.github/workflows/pr-checks.yml (opcional: checks en PRs)
Notas/Consideraciones:

Service accounts: Usar service accounts dedicados por ambiente (no compartir credenciales entre dev/staging/prod)
Secrets rotation: Documentar procedimiento de rotación de service accounts cada 90 días
Deploy failures: Configurar rollback automático en caso de fallo en deploy a production
Caching: Usar cache de GitHub Actions para node_modules y .firebase para acelerar builds
Monitoreo: Agregar step de verificación post-deploy (health check) antes de marcar deploy como exitoso
Costos: GitHub Actions es gratis para repos públicos, 2000 minutos/mes para privados en plan gratuito

Título: US-005: Setup proyecto Flutter con Clean Architecture y state management

Descripción:

Resumen: Inicializar proyecto Flutter 3.24+ con arquitectura limpia, configuración de Riverpod para state management, y estructura de carpetas modular.
Detalle:
Crear proyecto Flutter con configuración multi-plataforma (iOS, Android)
Implementar estructura de carpetas siguiendo Clean Architecture
Configurar Riverpod como state management solution
Setup linting, formatting, y análisis estático
Configurar flavors para dev/staging/production
Referencia: Ver Sección 3 (Stack Tecnológico: Flutter 3.24+) y Sección 7.2 FASE 1 → Sprint 1-2 (Mobile)
Criterios de aceptación (AC):

 AC1: Proyecto Flutter creado y ejecutándose en iOS Simulator y Android Emulator
 AC2: Estructura de carpetas implementada: /lib/core, /lib/features, /lib/shared
 AC3: Riverpod configurado con ProviderScope en main.dart
 AC4: Flavors configurados (dev, staging, prod) con diferentes app IDs y nombres
 AC5: Linting configurado con analysis_options.yaml y pre-commit hooks
Checklist técnica (Tareas):

 T1: Ejecutar flutter create --org com.smartfleetpro totaltracking (ajustar según naming decidido)
 T2: Crear estructura de carpetas: lib/core/{constants,utils,errors}, lib/features/{auth,tracking,trips}, lib/shared/{widgets,theme}
 T3: Agregar dependencias en pubspec.yaml: flutter_riverpod, riverpod_annotation, freezed, json_serializable
 T4: Configurar analysis_options.yaml con reglas strict (lint package recomendado: flutter_lints o very_good_analysis)
 T5: Crear archivos de configuración de flavors: lib/core/config/app_config.dart con clase AppConfig (apiUrl, environment, etc)
 T6: Configurar flavors en Android: android/app/build.gradle con productFlavors (dev, staging, prod)
 T7: Configurar schemes en iOS: crear schemes en Xcode para dev/staging/prod
 T8: Crear scripts de run: scripts/run_dev.sh, scripts/run_staging.sh, scripts/run_prod.sh
 T9: Configurar pre-commit hook con husky (o equivalente Dart) para ejecutar flutter analyze y dart format
 T10: Crear README con instrucciones de setup y comandos de run por flavor
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:setup fase:MVP componente:mobile

Dependencias: US-001 (necesita Firebase config para flavors)

Archivos/Carpetas relacionados:

/lib/main.dart
/lib/core/config/app_config.dart
/pubspec.yaml
/analysis_options.yaml
/android/app/build.gradle
/ios/Runner.xcodeproj/
/scripts/run_dev.sh
Notas/Consideraciones:

Flutter version: Usar Flutter 3.24+ según especificación. Fijar versión en .fvm/fvm_config.json si se usa FVM para gestión de versiones
Riverpod: Usar riverpod_generator para generar providers automáticamente con code generation (mejora DX)
Freezed: Configurar build_runner para code generation de modelos inmutables con Freezed
Clean Architecture: Separar en capas: Presentation (UI + ViewModels/Providers) → Domain (Entities + Use Cases) → Data (Repositories + Data Sources)
Flavors naming: Dev app debe tener sufijo visible (ej: "SmartFleet DEV") para evitar confusión con prod en dispositivos de testing
Performance: Habilitar profiling en dev flavor, deshabilitar en prod


Título: US-006: Implementar Design System base con Material Design 3

Descripción:

Resumen: Crear Design System completo con paleta de colores, tipografía, componentes base y temas claro/oscuro siguiendo Material Design 3.
Detalle:
Definir paleta de colores según especificación UI/UX
Configurar tipografía con Google Fonts (Inter/Roboto)
Crear componentes base reutilizables (botones, cards, inputs)
Implementar temas claro y oscuro
Documentar componentes en Storybook/Widgetbook
Referencia: Ver Sección 5.1 (Design System y Paleta de Colores) y Sección 7.2 FASE 1 → Sprint 1-2 (Mobile: Design System)
Criterios de aceptación (AC):

 AC1: Archivo lib/shared/theme/app_theme.dart con ThemeData completo para modo claro y oscuro
 AC2: Paleta de colores implementada: Primary (#2563EB), Secondary (#10B981), Error (#EF4444), Warning (#F59E0B), Surface, Background
 AC3: Tipografía configurada: Headings (24/20/18/16px bold), Body (16/14px regular), Caption (12px)
 AC4: Al menos 8 componentes base creados: PrimaryButton, SecondaryButton, AppTextField, AppCard, AppAppBar, LoadingIndicator, ErrorWidget, EmptyState
 AC5: Widgetbook configurado con showcase de todos los componentes
Checklist técnica (Tareas):

 T1: Crear lib/shared/theme/app_colors.dart con clase AppColors conteniendo toda la paleta
 T2: Crear lib/shared/theme/app_text_styles.dart con TextStyles predefinidos
 T3: Crear lib/shared/theme/app_theme.dart con ThemeData light y dark
 T4: Agregar Google Fonts al proyecto: pubspec.yaml (google_fonts: ^latest)
 T5: Crear componentes en lib/shared/widgets/buttons/: primary_button.dart, secondary_button.dart, text_button_custom.dart
 T6: Crear lib/shared/widgets/inputs/app_text_field.dart con validación y estados (error, disabled, focused)
 T7: Crear lib/shared/widgets/cards/app_card.dart con elevaciones y bordes consistentes
 T8: Crear lib/shared/widgets/feedback/: loading_indicator.dart, error_widget.dart, empty_state.dart
 T9: Agregar widgetbook dependency y crear widgetbook/main.dart con showcase
 T10: Documentar uso de componentes en /docs/design-system.md con screenshots
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:ui

Dependencias: US-005

Archivos/Carpetas relacionados:

/lib/shared/theme/app_theme.dart
/lib/shared/theme/app_colors.dart
/lib/shared/theme/app_text_styles.dart
/lib/shared/widgets/
/widgetbook/main.dart
/docs/design-system.md
Notas/Consideraciones:

Accesibilidad: Validar contraste de colores con WCAG 2.1 AA (mínimo 4.5:1 para texto normal, 3:1 para texto grande)
Dark mode: Usar Theme.of(context).brightness para detectar tema activo y ajustar colores dinámicamente
Consistency: Todos los componentes DEBEN usar valores del Design System (no hardcodear colores/tamaños directamente en widgets)
Spacing: Definir escala de spacing consistente (4, 8, 12, 16, 24, 32, 48px) en AppSpacing class
Responsive: Componentes deben adaptarse a diferentes tamaños de pantalla (usar MediaQuery o LayoutBuilder cuando necesario)
Performance: Evitar reconstrucciones innecesarias. Usar const constructors donde sea posible
Título: US-007: Implementar pantalla de Login con Firebase Authentication

Descripción:

Resumen: Crear pantalla de login con email/password, integración con Firebase Auth, validación de formularios y manejo de estados (loading, error, success).
Detalle:
Diseñar UI de login siguiendo mockups de especificación
Implementar validación de email y password
Integrar Firebase Authentication
Manejar errores de autenticación (credenciales inválidas, red, etc)
Implementar navegación a home tras login exitoso
Referencia: Ver Sección 4.1 (Autenticación y Gestión de Usuarios) y Sección 7.2 FASE 1 → Sprint 1-2 (Mobile: Login)
Criterios de aceptación (AC):

 AC1: Pantalla de login visible con campos email, password y botón "Iniciar Sesión"
 AC2: Validación funcional: email debe ser válido, password mínimo 6 caracteres
 AC3: Login exitoso guarda token y navega a HomeScreen
 AC4: Errores mostrados al usuario con mensajes claros ("Email o contraseña incorrectos", "Error de conexión")
 AC5: Estado de loading visible durante autenticación (botón deshabilitado + spinner)
Checklist técnica (Tareas):

 T1: Agregar dependencias: firebase_auth, firebase_core en pubspec.yaml
 T2: Crear lib/features/auth/presentation/screens/login_screen.dart
 T3: Crear lib/features/auth/presentation/providers/auth_provider.dart con Riverpod StateNotifier
 T4: Implementar lib/features/auth/domain/usecases/login_usecase.dart
 T5: Implementar lib/features/auth/data/repositories/auth_repository_impl.dart con Firebase Auth
 T6: Crear formulario con TextFields para email y password usando Form widget y TextEditingController
 T7: Implementar validadores de email (RegExp) y password (longitud mínima)
 T8: Conectar botón de login con AuthProvider usando ref.read(authProvider.notifier).login(email, password)
 T9: Manejar estados con pattern matching: when(data: ..., loading: ..., error: ...)
 T10: Implementar navegación a HomeScreen usando GoRouter o Navigator.pushReplacement tras login exitoso
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:auth

Dependencias: US-005, US-006

Archivos/Carpetas relacionados:

/lib/features/auth/presentation/screens/login_screen.dart
/lib/features/auth/presentation/providers/auth_provider.dart
/lib/features/auth/domain/usecases/login_usecase.dart
/lib/features/auth/data/repositories/auth_repository_impl.dart
Notas/Consideraciones:

Seguridad: NUNCA guardar password en texto plano. Firebase Auth maneja esto automáticamente
Session management: Usar FirebaseAuth.instance.authStateChanges() stream para persistir sesión automáticamente
Error handling: Mapear errores de Firebase a mensajes user-friendly (ej: user-not-found → "Usuario no encontrado", wrong-password → "Contraseña incorrecta")
UX: Deshabilitar botón durante loading para evitar múltiples submits
Testing: Crear tests unitarios para validators y AuthRepository (mock Firebase Auth)
Accessibility: Agregar labels a TextFields y semantic labels a iconos
Título: US-008: Implementar pantalla de Registro con creación de usuario en Firestore

Descripción:

Resumen: Crear pantalla de registro para nuevos usuarios con validación de datos, creación de cuenta en Firebase Auth y documento de usuario en Firestore.
Detalle:
Diseñar formulario de registro con campos: nombre, email, password, confirmación password
Validar datos antes de envío
Crear usuario en Firebase Auth
Crear documento en colección users con perfil básico
Manejar errores (email duplicado, password débil)
Referencia: Ver Sección 4.1 (Autenticación) y Sección 6.2.2 (Collection: users)
Criterios de aceptación (AC):

 AC1: Pantalla de registro con campos: nombre completo, email, password, confirmar password
 AC2: Validación: emails deben coincidir, passwords deben coincidir y cumplir requisitos (min 8 chars, 1 mayúscula, 1 número)
 AC3: Usuario creado en Firebase Auth y documento creado en Firestore users/{uid} con campos básicos
 AC4: Errores manejados: "Email ya registrado", "Contraseña débil", "Error de conexión"
 AC5: Tras registro exitoso, usuario es redirigido a pantalla de bienvenida/onboarding
Checklist técnica (Tareas):

 T1: Crear lib/features/auth/presentation/screens/register_screen.dart
 T2: Crear formulario con 4 TextFields: nombre, email, password, confirmar password
 T3: Implementar validadores: email format, password strength, passwords match
 T4: Crear lib/features/auth/domain/usecases/register_usecase.dart
 T5: Implementar lógica en AuthRepository: createUserWithEmailAndPassword() de Firebase Auth
 T6: Tras creación exitosa en Auth, crear documento en Firestore users/{uid} con campos: user_id, email, personal_info.full_name, created_at, status: 'active'
 T7: Agregar provider registerProvider en auth_provider.dart para manejar estado de registro
 T8: Conectar botón "Registrarse" con provider
 T9: Manejar errores específicos de Firebase: email-already-in-use, weak-password, invalid-email
 T10: Implementar navegación a WelcomeScreen o directamente a HomeScreen tras registro exitoso
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:auth

Dependencias: US-007

Archivos/Carpetas relacionados:

/lib/features/auth/presentation/screens/register_screen.dart
/lib/features/auth/domain/usecases/register_usecase.dart
/lib/features/auth/data/repositories/auth_repository_impl.dart
Notas/Consideraciones:

Transacción atómica: Si creación en Firestore falla, considerar eliminar usuario de Auth (o implementar Cloud Function que lo maneje)
Password strength: Usar librería como password_strength para validación robusta
Email verification: En MVP no es obligatorio, pero considerar agregar sendEmailVerification() para Fase 2
GDPR/Privacy: Agregar checkbox de aceptación de Términos y Condiciones antes de permitir registro
Company assignment: En MVP, usuario puede crear company o debe ser invitado? Definir flujo (actualmente spec sugiere admin crea conductores)
Role default: Nuevos usuarios registrados deben tener role conductor por defecto, a menos que sea primer usuario (entonces admin)
Título: US-009: Implementar manejo de sesiones persistentes con auto-login

Descripción:

Resumen: Configurar persistencia de sesión para que usuarios autenticados no tengan que hacer login cada vez que abren la app.
Detalle:
Escuchar stream de authStateChanges en Firebase Auth
Redirigir automáticamente a HomeScreen si usuario ya está autenticado
Implementar splash screen con verificación de sesión
Manejar logout con limpieza de sesión
Referencia: Ver Sección 4.1 (Autenticación) y Sección 7.2 FASE 1 → Sprint 1-2 (Mobile: Manejo de sesiones persistentes)
Criterios de aceptación (AC):

 AC1: Al abrir app, si usuario está autenticado, va directo a HomeScreen (sin mostrar login)
 AC2: Si usuario no está autenticado, muestra LoginScreen
 AC3: Splash screen visible durante verificación de sesión (máximo 2 segundos)
 AC4: Botón de logout funcional: cierra sesión y redirige a LoginScreen
 AC5: Token de sesión persiste tras cerrar y reabrir app
Checklist técnica (Tareas):

 T1: Crear lib/core/presentation/screens/splash_screen.dart con logo y loading indicator
 T2: Modificar main.dart para mostrar SplashScreen como initial route
 T3: Crear lib/features/auth/presentation/providers/auth_state_provider.dart que escucha FirebaseAuth.instance.authStateChanges()
 T4: Implementar lógica en SplashScreen: escuchar authStateProvider y navegar según estado (authenticated → HomeScreen, unauthenticated → LoginScreen)
 T5: Configurar Firebase Auth persistence: FirebaseAuth.instance.setPersistence(Persistence.LOCAL) (por defecto ya está activo en móvil)
 T6: Implementar método logout() en AuthRepository que ejecute FirebaseAuth.instance.signOut()
 T7: Crear botón de logout en settings/profile screen que llame ref.read(authProvider.notifier).logout()
 T8: Tras logout, limpiar navigation stack y redirigir a LoginScreen usando Navigator.pushAndRemoveUntil()
 T9: Agregar timeout de 2 segundos en SplashScreen para evitar flash en caso de respuesta muy rápida
 T10: Testing: cerrar app, reabrir, verificar que sesión persiste
Estimación: 5 SP / 8h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:auth

Dependencias: US-007, US-008

Archivos/Carpetas relacionados:

/lib/core/presentation/screens/splash_screen.dart
/lib/features/auth/presentation/providers/auth_state_provider.dart
/lib/main.dart
Notas/Consideraciones:

Performance: Evitar delays innecesarios en splash. Si auth state se resuelve en <500ms, skip splash y mostrar pantalla directamente
Token refresh: Firebase Auth maneja refresh de tokens automáticamente
Offline: Si app abre sin conexión, Firebase Auth debería mantener sesión desde cache. Validar este caso
Security: No guardar datos sensibles en SharedPreferences. Usar solo Firebase Auth para session management
Deep linking: Si se implementan deep links, validar que redirección respete auth state
Testing: Usar MockFirebaseAuth para unit tests de auth state transitions
Título: US-010: Setup proyecto Flutter Web con layout base y sidebar de navegación

Descripción:

Resumen: Inicializar proyecto Flutter Web para dashboard administrativo con layout responsivo, sidebar de navegación y routing básico.
Detalle:
Configurar proyecto Flutter para compilar a Web
Crear layout base con AppBar y Sidebar
Implementar navegación entre secciones (Dashboard, Conductores, Vehículos, Viajes)
Configurar routing con go_router
Hacer responsive para desktop (mínimo 1280px width)
Referencia: Ver Sección 5.4 (Web Admin Dashboard) y Sección 7.2 FASE 1 → Sprint 1-2 (Web: Layout base con sidebar)
Criterios de aceptación (AC):

 AC1: App Flutter Web ejecutándose en localhost:5000 con flutter run -d chrome
 AC2: Layout con Sidebar fijo a la izquierda (240px width) y contenido principal a la derecha
 AC3: Sidebar con items de navegación: Dashboard, Conductores, Vehículos, Viajes (iconos + labels)
 AC4: Routing funcional: click en sidebar item navega a pantalla correspondiente
 AC5: AppBar con título de sección actual y botón de logout
Checklist técnica (Tareas):

 T1: Habilitar web en proyecto Flutter: flutter config --enable-web (si no está habilitado)
 T2: Crear web/index.html personalizado con meta tags apropiados y favicon
 T3: Agregar dependencia go_router en pubspec.yaml
 T4: Crear lib/features/admin/presentation/layouts/admin_layout.dart con Scaffold que incluya Sidebar + body
 T5: Crear lib/features/admin/presentation/widgets/sidebar.dart con NavigationRail o Drawer permanente
 T6: Crear screens placeholder: dashboard_screen.dart, drivers_screen.dart, vehicles_screen.dart, trips_screen.dart
 T7: Configurar GoRouter en lib/core/routing/app_router.dart con rutas: /dashboard, drivers, /vehicles, /trips
 T8: Implementar highlight del item activo en sidebar según ruta actual (usar GoRouter.of(context).location)
 T9: Crear AppBar con título dinámico que cambia según ruta actual
 T10: Testing responsivo: validar en 1280px, 1440px, 1920px widths
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:setup fase:MVP componente:web

Dependencias: US-005 (mismo proyecto Flutter, solo habilitar web target)

Archivos/Carpetas relacionados:

/web/index.html
/lib/features/admin/presentation/layouts/admin_layout.dart
/lib/features/admin/presentation/widgets/sidebar.dart
/lib/core/routing/app_router.dart
/lib/features/admin/presentation/screens/
Notas/Consideraciones:

Responsivo: Dashboard debe funcionar en desktop (1280px+). Mobile responsive no es prioridad en MVP para web admin
Performance web: Usar flutter build web --release para producción (genera archivos optimizados con tree-shaking)
PWA: En MVP no es necesario, pero considerar agregar manifest.json para Fase 2
SEO: Web admin es app privada (requiere login), no necesita SEO. Agregar robots.txt con Disallow: /
Browser support: Validar en Chrome (primary), Firefox y Safari. Edge debería funcionar igual que Chrome (Chromium-based)
Routing: Usar ShellRoute de go_router para mantener AdminLayout persistente mientras cambia contenido central
Título: US-011: Implementar login admin en web con Firebase Auth

Descripción:

Resumen: Crear pantalla de login para dashboard web admin con autenticación Firebase, validación de rol admin y redirección a dashboard.
Detalle:
Diseñar página de login web con formulario centrado
Integrar Firebase Auth para web
Validar que usuario tenga rol admin antes de permitir acceso
Implementar session management para web
Manejar errores y estados de loading
Referencia: Ver Sección 4.1 (Autenticación) y Sección 7.2 FASE 1 → Sprint 1-2 (Web: Login admin)
Criterios de aceptación (AC):

 AC1: Página de login visible en /login con campos email y password
 AC2: Login exitoso solo si usuario tiene role: 'admin' en Firestore
 AC3: Si usuario no es admin, mostrar error "Acceso denegado. Solo administradores."
 AC4: Tras login exitoso como admin, redirigir a /dashboard
 AC5: Sesión persiste en refresh de página (usar Firebase Auth persistence)
Checklist técnica (Tareas):

 T1: Crear lib/features/auth/presentation/screens/web_login_screen.dart
 T2: Inicializar Firebase para web: firebase init en carpeta /web y agregar Firebase config en index.html
 T3: Agregar script de Firebase en web/index.html: <script src="/__/firebase/init.js"></script>
 T4: Crear formulario de login con TextFields y botón "Iniciar Sesión"
 T5: Implementar lógica de login en AuthRepository para web (mismo código que mobile)
 T6: Tras login exitoso, leer documento users/{uid} desde Firestore
 T7: Validar campo employment.role del usuario. Si no es admin, ejecutar FirebaseAuth.instance.signOut() y mostrar error
 T8: Si es admin, guardar info en provider y navegar a /dashboard
 T9: Configurar FirebaseAuth.instance.setPersistence(Persistence.LOCAL) para persistir sesión en browser
 T10: Crear guard de ruta en GoRouter que valide rol admin antes de mostrar rutas protegidas
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:web componente:auth

Dependencias: US-010

Archivos/Carpetas relacionados:

/lib/features/auth/presentation/screens/web_login_screen.dart
/web/index.html
/lib/core/routing/app_router.dart
Notas/Consideraciones:

Role validation: CRÍTICO validar role en backend también. No confiar solo en client-side check. Implementar Cloud Function o Security Rules que validen role en cada request
Session security: Web es más vulnerable a XSS. No guardar datos sensibles en localStorage directamente
Firebase config: NUNCA commitear Firebase config con API keys reales al repo público. Usar variables de entorno o Firebase Hosting reserved URLs
Redirect after logout: Si usuario hace logout, redirigir a /login y limpiar navigation history
Browser back button: Validar que usuario no pueda usar back button para volver a dashboard después de logout
Multi-tab: Firebase Auth sincroniza estado entre tabs automáticamente
Título: US-012: Solicitar permisos de ubicación en app móvil (Android/iOS)

Descripción:

Resumen: Implementar solicitud de permisos de ubicación precisa en foreground para Android e iOS siguiendo mejores prácticas de UX.
Detalle:
Solicitar permisos de ubicación al iniciar app por primera vez
Mostrar rationale (explicación) antes de solicitar permiso
Manejar estados: granted, denied, permanentlyDenied
Redirigir a settings si permiso denegado permanentemente
Validar permisos antes de iniciar tracking GPS
Referencia: Ver Sección 4.2 (Tracking GPS en Tiempo Real) y Sección 7.2 FASE 1 → Sprint 3-4 (Mobile: Permisos de ubicación)
Criterios de aceptación (AC):

 AC1: Al abrir app por primera vez, se muestra diálogo explicando por qué se necesita ubicación
 AC2: Si usuario acepta, permiso queda granted y app puede acceder a GPS
 AC3: Si usuario niega, se muestra mensaje y botón para abrir settings del dispositivo
 AC4: Permisos funcionan correctamente en Android 10+ (background location no requerido en MVP)
 AC5: Permisos funcionan correctamente en iOS 14+ con "Permitir mientras se usa la app"
Checklist técnica (Tareas):

 T1: Agregar dependencia permission_handler en pubspec.yaml
 T2: Configurar permisos en android/app/src/main/AndroidManifest.xml: ACCESS_FINE_LOCATION, ACCESS_COARSE_LOCATION
 T3: Configurar permisos en ios/Runner/Info.plist: NSLocationWhenInUseUsageDescription con mensaje descriptivo
 T4: Crear lib/features/tracking/presentation/screens/location_permission_screen.dart con explicación y botón "Permitir ubicación"
 T5: Crear lib/core/services/permission_service.dart con métodos: checkLocationPermission(), requestLocationPermission(), openAppSettings()
 T6: Implementar lógica: al abrir app, verificar estado de permiso con Permission.location.status
 T7: Si permiso no granted, mostrar LocationPermissionScreen
 T8: Implementar botón "Permitir" que ejecute Permission.location.request()
 T9: Manejar resultado: si granted → navegar a HomeScreen, si denied → mostrar mensaje, si permanentlyDenied → mostrar botón "Abrir Configuración"
 T10: Testing en Android 13+ y iOS 16+ para validar flujo completo
Estimación: 5 SP / 8h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:tracking

Dependencias: US-009 (necesita session management funcional)

Archivos/Carpetas relacionados:

/lib/features/tracking/presentation/screens/location_permission_screen.dart
/lib/core/services/permission_service.dart
/android/app/src/main/AndroidManifest.xml
/ios/Runner/Info.plist
Notas/Consideraciones:

Android 10+: Background location requiere permiso separado (ACCESS_BACKGROUND_LOCATION). No implementar en MVP (solo foreground tracking)
iOS privacy: Mensaje en NSLocationWhenInUseUsageDescription debe ser claro: "Necesitamos tu ubicación para trackear tus viajes y calcular rutas en tiempo real"
UX: No solicitar permiso inmediatamente al abrir app. Mostrar primero pantalla explicativa (rationale) para aumentar tasa de aceptación
Permanently denied: Si usuario niega dos veces en Android, se marca como permanently denied. Validar este caso
Testing: Usar emulador con diferentes estados de permiso para validar todos los flujos
Fallback: Si GPS no está disponible (ej: en emulador sin location mock), mostrar error claro al usuario
Título: US-013: Implementar tracking GPS en foreground con Geolocator

Descripción:

Resumen: Configurar captura de coordenadas GPS cada 15 segundos mientras app está en foreground usando Geolocator package.
Detalle:
Implementar stream de posiciones GPS con Geolocator
Configurar accuracy, distanceFilter y interval
Mostrar coordenadas actuales en UI (debug en MVP)
Manejar errores (GPS deshabilitado, sin señal)
Optimizar consumo de batería con settings apropiados
Referencia: Ver Sección 4.2 (GPS Tracking) y Sección 7.2 FASE 1 → Sprint 3-4 (Mobile: Tracking GPS en foreground)
Criterios de aceptación (AC):

 AC1: Stream de posiciones GPS activo capturando coordenadas cada 10-15 segundos cuando app está en foreground
 AC2: Coordenadas mostradas en pantalla de tracking (lat, lng, accuracy, speed) para debugging
 AC3: Si GPS está deshabilitado, mostrar diálogo pidiendo al usuario habilitarlo
 AC4: Accuracy configurada en HIGH (mejor que 10 metros)
 AC5: Stream se pausa cuando app va a background (para MVP, background tracking es Fase 2)
Checklist técnica (Tareas):

 T1: Agregar dependencia geolocator en pubspec.yaml
 T2: Crear lib/features/tracking/data/services/gps_service.dart
 T3: Implementar método startTracking() que cree stream con Geolocator.getPositionStream()
 T4: Configurar LocationSettings: accuracy: LocationAccuracy.high, distanceFilter: 10 (metros), timeLimit: Duration(seconds: 15)
 T5: Crear provider gpsPositionProvider que escuche el stream y actualice estado
 T6: Crear lib/features/tracking/presentation/screens/tracking_screen.dart que muestre posición actual
 T7: Implementar verificación de servicios de ubicación: Geolocator.isLocationServiceEnabled()
 T8: Si servicios deshabilitados, mostrar diálogo con botón "Habilitar GPS" que ejecute Geolocator.openLocationSettings()
 T9: Implementar AppLifecycleState listener para pausar stream cuando app va a background
 T10: Testing: verificar que coordenadas se actualizan caminando/moviendo dispositivo
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:tracking

Dependencias: US-012

Archivos/Carpetas relacionados:

/lib/features/tracking/data/services/gps_service.dart
/lib/features/tracking/presentation/providers/gps_position_provider.dart
/lib/features/tracking/presentation/screens/tracking_screen.dart
Notas/Consideraciones:

Battery optimization: distanceFilter: 10 significa que solo se emite nueva posición si usuario se movió >10 metros. Reduce updates innecesarios
Accuracy vs Battery: LocationAccuracy.high consume más batería pero es necesario para tracking preciso. En Fase 2 implementar adaptive accuracy
iOS background: En iOS, tracking en foreground funciona sin configuración adicional. Background requiere Background Modes capability (Fase 2)
Error handling: Manejar PermissionDeniedException, LocationServiceDisabledException, TimeoutException
Mock locations: En Android developer options, detectar si usuario usa mock locations (GPS spoofing). Por ahora solo logging, validación robusta en Fase 2
Performance: Stream puede generar muchos eventos. Usar debounce o throttle si es necesario para evitar rebuilds excesivos de UI
Título: US-014: Enviar coordenadas GPS a Firestore cada 15 segundos

Descripción:

Resumen: Implementar sincronización de posiciones GPS capturadas a Firestore, guardando puntos en subcollección de trip activo o en buffer temporal.
Detalle:
Escuchar stream de posiciones GPS
Enviar coordenadas a Firestore con batch writes para optimizar
Guardar en estructura preparada para route_points
Incluir metadata: timestamp, accuracy, speed, bearing
Implementar retry logic para fallos de red
Referencia: Ver Sección 4.2 (GPS Tracking) y Sección 6.2.5 (Subcollection: route_points)
Criterios de aceptación (AC):

 AC1: Coordenadas GPS enviadas a Firestore cada 15 segundos mientras hay tracking activo
 AC2: Puntos guardados en Firestore con estructura: {lat, lng, timestamp, accuracy, speed, bearing}
 AC3: Si hay trip activo, puntos se guardan en trips/{tripId}/route_points/{pointId}
 AC4: Si no hay trip, puntos se almacenan en buffer local (Hive) para MVP
 AC5: Retry automático si fallo de red (máximo 3 intentos)
Checklist técnica (Tareas):

 T1: Crear lib/features/tracking/data/repositories/tracking_repository.dart
 T2: Implementar método saveGPSPoint(Position position, String? tripId) en repository
 T3: Conectar stream de GPS con repository: cada nueva posición se envía a Firestore
 T4: Crear función de transformación: Position → RoutePoint model con campos: point_id, lat, lng, timestamp, accuracy, speed, bearing
 T5: Generar point_id incremental: PT-{sequence_number} (usar contador en trip document)
 T6: Si tripId existe, guardar en trips/{tripId}/route_points/{pointId}
 T7: Usar batch writes para optimizar: acumular hasta 10 puntos y enviar en batch cada ~2 minutos (o cuando se completen 10)
 T8: Implementar retry logic con exponential backoff: retry después de 1s, 2s, 4s
 T9: Si falla después de 3 reintentos, guardar en buffer local (Hive) para sync posterior
 T10: Agregar logging de errores para monitoring
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:tracking componente:backend

Dependencias: US-013, US-002 (necesita estructura de Firestore lista)

Archivos/Carpetas relacionados:

/lib/features/tracking/data/repositories/tracking_repository.dart
/lib/features/tracking/domain/models/route_point.dart
/lib/features/tracking/data/services/gps_sync_service.dart
Notas/Consideraciones:

Firestore costs: Cada write tiene costo. Batch writes reducen costos y mejoran performance (1 batch = 1 write vs 10 writes individuales)
Offline handling: Si device está offline, puntos se acumulan en buffer local. Sincronizar automáticamente cuando recupere conexión
Data volume: 1 punto cada 15s = 240 puntos/hora = 2400 puntos en viaje de 10h. Con batch writes y TTL (90 días) esto es manejable
Sequence number: Mantener contador en documento de trip (route_points_count) para generar IDs secuenciales
Sensor data: En MVP solo GPS básico. En Fase 2 agregar acelerómetro, giroscopio para detección de eventos
Compression: En Fase 2 implementar Douglas-Peucker algorithm para simplificar rutas y reducir almacenamiento
Título: US-015: Implementar Cloud Function para recibir y procesar coordenadas GPS

Descripción:

Resumen: Crear Cloud Function que se ejecute en cada write a route_points para procesar coordenadas, detectar movimiento vs detenido y agregar metadata.
Detalle:
Crear trigger Firestore onCreate para route_points
Calcular si vehículo está en movimiento o detenido (basado en speed)
Agregar campos calculados: is_moving, stopped_duration
Detectar eventos básicos (harsh_brake por cambio de velocidad)
Actualizar estadísticas del trip (distancia recorrida)
Referencia: Ver Sección 4.2 (GPS Processing) y Sección 7.2 FASE 1 → Sprint 3-4 (Backend: Cloud Function para procesar coordenadas)
Criterios de aceptación (AC):

 AC1: Cloud Function se ejecuta automáticamente cuando se crea nuevo document en trips/{tripId}/route_points
 AC2: Function calcula is_moving (true si speed > 5 km/h, false si <= 5)
 AC3: Si vehículo detenido, actualizar stopped_duration sumando tiempo desde último punto
 AC4: Function actualiza distance_traveled en documento del trip usando cálculo de distancia Haversine
 AC5: Logs de Cloud Function visibles en Firebase Console para debugging
Checklist técnica (Tareas):

 T1: Crear archivo firebase/functions/src/triggers/onRoutePointCreated.ts
 T2: Implementar trigger: functions.firestore.document('trips/{tripId}/route_points/{pointId}').onCreate()
 T3: Leer documento anterior (route_points ordenados por timestamp DESC, limit 1) para calcular delta
 T4: Calcular is_moving: snapshot.data().speed > 5 ? true : false
 T5: Si is_moving === false, calcular stopped_duration como diferencia entre timestamps
 T6: Implementar función calculateDistance(lat1, lng1, lat2, lng2) usando fórmula Haversine
 T7: Actualizar documento trip: incrementar statistics.distance_km con distancia calculada
 T8: Detectar harsh_brake: si delta de speed > 20 km/h en < 2 segundos, marcar evento
 T9: Si harsh_brake detectado, crear documento en colección alerts (preparar para Fase 2)
 T10: Deploy function: firebase deploy --only functions:onRoutePointCreated
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:backend componente:functions

Dependencias: US-014, US-001 (necesita Firebase Functions configurado)

Archivos/Carpetas relacionados:

/firebase/functions/src/triggers/onRoutePointCreated.ts
/firebase/functions/src/utils/distanceCalculator.ts
Notas/Consideraciones:

Performance: Cloud Functions tienen cold start. Primeras ejecuciones pueden tomar 1-2 segundos. Considerar usar min instances = 1 en production
Costs: Cada trigger = 1 invocación. Con 240 puntos/hora/vehículo, son ~5760 invocaciones/día/vehículo. En plan gratuito: 2M invocaciones/mes (suficiente para ~350 vehículos)
Haversine formula: Apropiada para distancias cortas (<100km). Para mayor precisión en Fase 2 considerar Vincenty formula
Threshold de movimiento: 5 km/h es razonable. Ajustar según feedback de piloto (puede ser muy sensible en tráfico lento)
Batch processing: Si volumen crece mucho, considerar procesar en batches (ej: cada 10 puntos) en lugar de 1 a 1
Error handling: Implementar try-catch y logging robusto. Si function falla, no debe bloquear escritura del punto en Firestore
Título: US-016: Crear estructura de datos básica para trips en Firestore

Descripción:

Resumen: Implementar colección trips con estructura completa según especificación, incluyendo lifecycle, planning, execution y statistics.
Detalle:
Definir schema completo de trip con TypeScript interfaces
Implementar helpers para creación de trips
Configurar índices compuestos necesarios
Crear función de generación de trip_id único
Validar estructura con datos de prueba
Referencia: Ver Sección 6.2.4 (Collection: trips) y Sección 7.2 FASE 1 → Sprint 3-4 (Backend: Estructura de datos para trip_points)
Criterios de aceptación (AC):

 AC1: Interface TypeScript Trip definida con todos los campos según especificación (lifecycle, planning, execution, statistics)
 AC2: Función createTrip() implementada que genera documento con estructura completa y valores iniciales
 AC3: Trip IDs generados con formato TRIP-YYYYMMDD-XXXX (ej: TRIP-20251120-0001)
 AC4: Índices compuestos creados en firestore.indexes.json para queries de trips
 AC5: Al menos 3 trips de ejemplo creados en Firestore dev para testing
Checklist técnica (Tareas):

 T1: Crear /firebase/functions/src/types/trip.types.ts con interface completa de Trip
 T2: Crear sub-interfaces: TripLifecycle, TripPlanning, TripExecution, TripStatistics, Waypoint
 T3: Implementar función generateTripId() que genere ID con fecha actual y secuencia
 T4: Crear función createTrip(data: CreateTripDto) en /firebase/functions/src/services/tripService.ts
 T5: Implementar valores por defecto en creación: status: 'planeado', created_at: FieldValue.serverTimestamp(), estadísticas en 0
 T6: Agregar índices en firestore.indexes.json: company_id + status + planning.planned_start DESC, driver_id + status, vehicle_id + status
 T7: Crear endpoint HTTP function (opcional para MVP): POST /api/trips para crear trip desde web admin
 T8: Implementar validaciones: driver_id y vehicle_id deben existir, planned_start debe ser futuro
 T9: Deploy índices: firebase deploy --only firestore:indexes
 T10: Crear script seed para generar 3 trips de prueba con diferentes estados
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:backend componente:database

Dependencias: US-002 (necesita colecciones base creadas)

Archivos/Carpetas relacionados:

/firebase/functions/src/types/trip.types.ts
/firebase/functions/src/services/tripService.ts
/firebase/firestore.indexes.json
/firebase/functions/src/scripts/seedTrips.ts
Notas/Consideraciones:

Trip ID sequence: Mantener contador global o por día para generar secuencia. Considerar usar Firestore counter sharding para alta concurrencia
Lifecycle timestamps: Usar FieldValue.serverTimestamp() para todas las timestamps para evitar inconsistencias de timezone client-side
Nested objects: Firestore permite hasta 20 niveles de anidación. Estructura actual es apropiada (máximo 3-4 niveles)
Initial state: Trips creados deben tener status: 'planeado' y solo transicionar a otros estados mediante funciones específicas (state machine pattern)
Validation: En producción, validar con Firebase Security Rules también (no solo en Functions)
Performance: Pre-calcular campos agregados (distance_total, duration_total) en planning para evitar recalcular constantemente
Título: US-017: Integrar Mapbox SDK en Flutter para visualización de mapa

Descripción:

Resumen: Integrar Mapbox GL SDK en app Flutter para mostrar mapa interactivo con ubicación actual del conductor.
Detalle:
Configurar Mapbox SDK para Android e iOS
Obtener y configurar Mapbox access token
Crear widget de mapa básico
Mostrar ubicación actual del usuario en mapa
Implementar controles de zoom y rotación
Referencia: Ver Sección 3 (Stack: Mapbox GL) y Sección 7.2 FASE 1 → Sprint 3-4 (Mobile: Integración Mapbox SDK)
Criterios de aceptación (AC):

 AC1: Mapa Mapbox visible en pantalla de tracking mostrando ubicación actual
 AC2: Marcador (marker) azul indica posición GPS del conductor
 AC3: Cámara del mapa sigue ubicación del usuario (auto-center cuando se mueve)
 AC4: Controles de zoom (+/-) visibles y funcionales
 AC5: Mapa carga en <2 segundos con conexión 4G
Checklist técnica (Tareas):

 T1: Crear cuenta en Mapbox y obtener access token desde https://account.mapbox.com/
 T2: Agregar dependencia mapbox_gl o flutter_mapbox_gl en pubspec.yaml
 T3: Configurar token en Android: agregar en android/app/src/main/res/values/strings.xml
 T4: Configurar token en iOS: agregar en ios/Runner/Info.plist con key MBXAccessToken
 T5: Crear widget MapboxMapWidget en /lib/features/tracking/presentation/widgets/mapbox_map.dart
 T6: Inicializar mapa con centro en coordenadas actuales del usuario
 T7: Agregar marcador (Symbol o Circle layer) en posición GPS actual
 T8: Escuchar stream de GPS y actualizar posición del marcador en tiempo real
 T9: Implementar animateCamera() para seguir ubicación del usuario suavemente
 T10: Configurar estilo de mapa: usar mapbox://styles/mapbox/streets-v11 (calles estándar)
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:maps

Dependencias: US-013 (necesita stream de GPS funcionando)

Archivos/Carpetas relacionados:

/lib/features/tracking/presentation/widgets/mapbox_map.dart
/android/app/src/main/res/values/strings.xml
/ios/Runner/Info.plist
/lib/core/config/mapbox_config.dart
Notas/Consideraciones:

API token security: NO commitear access token directamente en código. Usar variables de entorno o archivos .env (agregados a .gitignore)
Mapbox pricing: 50K map loads/mes gratis. Después $0.60/1000 loads. Estimar ~80K loads/mes con 50 vehículos = ~$18/mes (dentro de presupuesto)
Offline maps: Mapbox permite descargar mapas offline. No implementar en MVP, pero considerar para Fase 2
Custom styles: MVP usa estilo estándar. En Fase 2 crear estilo custom en Mapbox Studio con branding
Performance: Mapbox es nativo (no WebView). Mejor performance que Google Maps en Flutter
Alternative: Si Mapbox presenta problemas, fallback a google_maps_flutter, pero preferir Mapbox por features de routing para trucks
Título: US-018: Mostrar indicadores de estado GPS, batería y conectividad en app

Descripción:

Resumen: Crear widget de status bar que muestre iconos indicadores del estado de GPS (activo/inactivo), nivel de batería y conectividad de red.
Detalle:
Mostrar icono GPS verde si activo, rojo si deshabilitado
Mostrar nivel de batería en porcentaje con icono
Mostrar estado de conectividad (WiFi, 4G, sin conexión)
Actualizar indicadores en tiempo real
Alertar si GPS se desactiva o batería baja (<15%)
Referencia: Ver Sección 4.2 (GPS Tracking) y Sección 7.2 FASE 1 → Sprint 3-4 (Mobile: Indicadores de estado)
Criterios de aceptación (AC):

 AC1: Barra de estado visible en parte superior de tracking screen con 3 indicadores
 AC2: Indicador GPS: verde si activo y recibiendo señal, rojo si deshabilitado, amarillo si buscando señal
 AC3: Indicador batería: muestra porcentaje y cambia a rojo si <15%
 AC4: Indicador red: muestra tipo de conexión (WiFi/4G/3G/sin conexión)
 AC5: Si GPS se desactiva durante tracking, mostrar snackbar alertando al usuario
Checklist técnica (Tareas):

 T1: Agregar dependencias: battery_plus, connectivity_plus en pubspec.yaml
 T2: Crear widget StatusIndicatorsBar en /lib/features/tracking/presentation/widgets/status_indicators_bar.dart
 T3: Crear provider batteryLevelProvider que escuche stream de Battery().onBatteryStateChanged
 T4: Crear provider connectivityProvider que escuche Connectivity().onConnectivityChanged
 T5: Crear provider gpsStatusProvider que verifique Geolocator.isLocationServiceEnabled() cada 5 segundos
 T6: Implementar widget GpsIndicator: Circle verde/amarillo/rojo según estado
 T7: Implementar widget BatteryIndicator: Icon + Text con porcentaje, color rojo si <15%
 T8: Implementar widget ConnectivityIndicator: Icon WiFi/4G/offline con color apropiado
 T9: Mostrar SnackBar si GPS pasa de enabled a disabled mientras hay tracking activo
 T10: Agregar tooltips a cada indicador explicando su significado
Estimación: 5 SP / 8h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:tracking

Dependencias: US-013 (necesita GPS tracking)

Archivos/Carpetas relacionados:

/lib/features/tracking/presentation/widgets/status_indicators_bar.dart
/lib/features/tracking/presentation/providers/battery_level_provider.dart
/lib/features/tracking/presentation/providers/connectivity_provider.dart
Notas/Consideraciones:

Battery optimization: No consultar batería muy frecuentemente. Stream de battery_plus ya optimiza esto
GPS polling: Verificar estado de GPS cada 5 segundos es suficiente. No hacerlo en cada frame
Connectivity types: connectivity_plus detecta: wifi, mobile, ethernet, bluetooth, none. Mostrar iconos diferentes para cada tipo
User feedback: Indicadores deben ser claros pero no intrusivos. Tamaño pequeño (16-20px icons)
Accessibility: Agregar semantic labels para lectores de pantalla: "GPS activo", "Batería 65%", etc
Testing: Simular diferentes estados en emulador/dispositivo: airplane mode, GPS off, battery low
Título: US-019: Implementar mapa en vivo en dashboard web con Mapbox GL JS

Descripción:

Resumen: Integrar Mapbox GL JS en dashboard web admin para mostrar mapa con ubicación en tiempo real de todos los vehículos activos.
Detalle:
Configurar Mapbox GL JS en Flutter Web
Mostrar mapa centrado en ubicación de flota
Renderizar marcadores para cada vehículo activo
Actualizar posiciones en tiempo real desde Firestore
Implementar info popup al hacer click en marcador
Referencia: Ver Sección 5.4 (Web Dashboard) y Sección 7.2 FASE 1 → Sprint 3-4 (Web: Mapa en vivo)
Criterios de aceptación (AC):

 AC1: Mapa Mapbox visible en página /dashboard mostrando vehículos activos
 AC2: Cada vehículo representado con marcador (icon de camión) en su última posición conocida
 AC3: Marcadores se actualizan en tiempo real cuando vehículo se mueve (cada 15-30s)
 AC4: Click en marcador muestra popup con: placa, conductor, velocidad actual, última actualización
 AC5: Mapa se centra automáticamente para mostrar todos los vehículos (fit bounds)
Checklist técnica (Tareas):

 T1: Agregar Mapbox GL JS en web/index.html: <script src='https://api.mapbox.com/mapbox-gl-js/v2.15.0/mapbox-gl.js'></script>
 T2: Agregar CSS de Mapbox: <link href='https://api.mapbox.com/mapbox-gl-js/v2.15.0/mapbox-gl.css' rel='stylesheet' />
 T3: Crear widget MapboxWebMap usando HtmlElementView para embeber mapa JS en Flutter Web
 T4: Inicializar mapa con mapboxgl.Map() y configurar access token
 T5: Crear provider activeVehiclesProvider que escuche colección vehicles con query where('operation.operational_status', '==', 'activo')
 T6: Para cada vehículo, leer su current_location y crear marcador con mapboxgl.Marker()
 T7: Agregar custom icon de camión a marcadores (SVG o PNG)
 T8: Escuchar cambios en tiempo real con Firestore snapshot listeners y actualizar posición de marcadores
 T9: Implementar popup con mapboxgl.Popup() mostrando info del vehículo
 T10: Calcular bounds de todos los vehículos y centrar mapa con map.fitBounds()
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:web componente:maps

Dependencias: US-010, US-014 (necesita coordenadas en Firestore)

Archivos/Carpetas relacionados:

/lib/features/admin/presentation/widgets/mapbox_web_map.dart
/lib/features/admin/presentation/providers/active_vehicles_provider.dart
/web/index.html
/web/assets/icons/truck-marker.svg
Notas/Consideraciones:

Flutter Web + JS interop: Usar dart:js para comunicación entre Dart y JavaScript de Mapbox
Performance: Con 50 vehículos activos, 50 marcadores son manejables. Si escala a 500+, implementar clustering en Fase 3
Real-time updates: Firestore snapshot listeners pueden generar muchos updates. Considerar debounce de 5-10 segundos
Custom markers: Usar iconos de camión SVG con color diferente según estado (verde=en movimiento, rojo=detenido, gris=sin señal)
Popup content: Mostrar: placa, nombre conductor, velocidad actual, tiempo desde última actualización, botón "Ver detalles" que navega a trip detail
Bounds calculation: Si solo hay 1 vehículo, no usar fitBounds (puede hacer zoom extremo). Usar zoom fijo nivel 13-14
Título: US-020: Crear panel lateral con lista de vehículos activos en dashboard web

Descripción:

Resumen: Implementar sidebar en dashboard web que liste todos los vehículos activos con información resumida y filtros básicos.
Detalle:
Mostrar lista de vehículos activos con card compacto por vehículo
Incluir info: placa, conductor, estado, última ubicación
Implementar filtros: por estado, por sucursal
Click en vehículo centra mapa en su ubicación
Actualizar lista en tiempo real
Referencia: Ver Sección 5.4 (Web Dashboard) y Sección 7.2 FASE 1 → Sprint 3-4 (Web: Panel lateral con lista de vehículos)
Criterios de aceptación (AC):

 AC1: Sidebar visible a la derecha del mapa (o izquierda según diseño) con ancho fijo 320px
 AC2: Lista de vehículos mostrada con cards: placa, nombre conductor, estado (icono + texto), última actualización
 AC3: Filtros funcionales: dropdown "Todos los estados" / "En movimiento" / "Detenido" / "Sin señal"
 AC4: Click en card de vehículo centra mapa en su ubicación y abre popup
 AC5: Lista se actualiza en tiempo real cuando vehículos cambian estado
Checklist técnica (Tareas):

 T1: Crear widget VehiclesSidebar en /lib/features/admin/presentation/widgets/vehicles_sidebar.dart
 T2: Usar mismo provider activeVehiclesProvider que el mapa para consistencia de datos
 T3: Crear widget VehicleListCard para renderizar cada vehículo: Row con icon, placa, conductor, badge de estado
 T4: Implementar badges de estado: verde "En movimiento", amarillo "Detenido", rojo "Sin señal" (basado en last_location_update)
 T5: Agregar dropdown filter con opciones: Todos, En movimiento, Detenido, Sin señal
 T6: Implementar lógica de filtrado: actualizar lista según opción seleccionada
 T7: Agregar filtro por sucursal (dropdown con branches de la company)
 T8: Implementar onTap en card: centrar mapa en vehículo con map.flyTo({center: [lng, lat], zoom: 15})
 T9: Agregar scroll a lista si hay más de 10 vehículos
 T10: Mostrar contador: "12 vehículos activos" en header del sidebar
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:web componente:ui

Dependencias: US-019 (necesita mapa web funcionando)

Archivos/Carpetas relacionados:

/lib/features/admin/presentation/widgets/vehicles_sidebar.dart
/lib/features/admin/presentation/widgets/vehicle_list_card.dart
Notas/Consideraciones:

Real-time badge update: Calcular estado basado en last_location_update. Si >5 minutos, marcar como "Sin señal"
Performance: Si hay 100+ vehículos, virtualizar lista con ListView.builder para no renderizar todos a la vez
Empty state: Si no hay vehículos activos, mostrar mensaje: "No hay vehículos activos en este momento"
Search: Considerar agregar barra de búsqueda por placa o conductor (opcional en MVP, útil para producción)
Sorting: Ordenar por defecto por última actualización DESC (más recientes primero)
Responsive: Sidebar debe ser colapsable en pantallas pequeñas (tablet landscape: <1280px)
Título: US-021: Implementar filtros básicos en dashboard web (estado, sucursal)

Descripción:

Resumen: Agregar controles de filtro en dashboard web para filtrar vehículos por estado operacional y sucursal, con actualización automática del mapa y lista.
Detalle:
Crear sección de filtros en parte superior del dashboard
Implementar dropdown de estado operacional
Implementar dropdown de sucursal
Aplicar filtros a query de Firestore
Actualizar mapa y lista simultáneamente al cambiar filtro
Referencia: Ver Sección 5.4 (Web Dashboard) y Sección 7.2 FASE 1 → Sprint 3-4 (Web: Filtros básicos)
Criterios de aceptación (AC):

 AC1: Barra de filtros visible en top del dashboard con 2 dropdowns: Estado y Sucursal
 AC2: Dropdown Estado con opciones: Todos, Activo, Inactivo, En mantenimiento
 AC3: Dropdown Sucursal poblado dinámicamente desde company.branches
 AC4: Al cambiar filtro, tanto mapa como sidebar se actualizan mostrando solo vehículos que cumplen criterios
 AC5: Filtros persisten en session (si refresca página, filtros mantienen valor seleccionado)
Checklist técnica (Tareas):

 T1: Crear widget DashboardFilters en /lib/features/admin/presentation/widgets/dashboard_filters.dart
 T2: Crear provider dashboardFiltersProvider con estado: selectedStatus, selectedBranch
 T3: Implementar dropdown de estado con opciones: Todos, Activo, Inactivo, En mantenimiento
 T4: Crear provider companyBranchesProvider que lea branches desde Firestore companies/{companyId}
 T5: Poblar dropdown de sucursales con branches de la company del admin
 T6: Modificar query en activeVehiclesProvider para incluir filtros: where('operation.operational_status', '==', selectedStatus) si no es "Todos"
 T7: Agregar filtro por branch: where('operation.branch_id', '==', selectedBranch) si seleccionado
 T8: Usar Riverpod ref.watch() para que mapa y sidebar se reconstruyan automáticamente al cambiar filtros
 T9: Guardar filtros seleccionados en SessionStorage usando dart:html para persistencia
 T10: Cargar filtros desde SessionStorage al inicializar dashboard
Estimación: 5 SP / 8h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:MVP componente:web componente:ui

Dependencias: US-020

Archivos/Carpetas relacionados:

/lib/features/admin/presentation/widgets/dashboard_filters.dart
/lib/features/admin/presentation/providers/dashboard_filters_provider.dart
/lib/features/admin/presentation/providers/active_vehicles_provider.dart
Notas/Consideraciones:

Query optimization: Firestore requiere índice compuesto para queries con múltiples where clauses. Agregar en firestore.indexes.json: company_id + operation.operational_status + operation.branch_id
Performance: No hacer query si no hay cambios en filtros. Riverpod maneja esto automáticamente con memoization
UX: Mostrar contador de resultados: "Mostrando 8 de 25 vehículos"
Clear filters: Agregar botón "Limpiar filtros" que resetea a valores por defecto (Todos, Todas las sucursales)
Empty state: Si filtros resultan en 0 vehículos, mostrar mensaje: "No se encontraron vehículos con los filtros seleccionados"
Future enhancement: En Fase 2 agregar más filtros: por tipo de vehículo, por rango de health score, etc
Título: US-022: Crear pantalla de inicio (Home) en app móvil con viaje asignado

Descripción:

Resumen: Implementar HomeScreen para conductores que muestre viaje asignado del día con información resumida y botón para iniciar.
Detalle:
Mostrar card con viaje asignado si existe
Incluir info: origen, destino, hora estimada de salida
Mostrar estado del viaje (planeado, en curso, completado)
Botón "Iniciar viaje" si está planeado
Si no hay viaje, mostrar empty state
Referencia: Ver Sección 4.3 (Gestión de Viajes) y Sección 7.2 FASE 1 → Sprint 5-6 (Mobile: Pantalla de inicio con viaje asignado)
Criterios de aceptación (AC):

 AC1: HomeScreen visible tras login mostrando viaje asignado del conductor para hoy
 AC2: Card de viaje muestra: origen, destino, hora planeada de inicio, distancia estimada
 AC3: Botón "Iniciar Viaje" visible y habilitado si status es 'planeado' o 'asignado'
 AC4: Si no hay viaje asignado, mostrar empty state: "No tienes viajes asignados para hoy"
 AC5: Pull to refresh actualiza lista de viajes
Checklist técnica (Tareas):

 T1: Crear lib/features/trips/presentation/screens/home_screen.dart
 T2: Crear provider assignedTripProvider que query trips: where('driver_id', '==', currentUserId).where('status', 'in', ['planeado', 'asignado', 'en_curso']).orderBy('planning.planned_start').limit(1)
 T3: Crear widget TripCard que muestre información del viaje
 T4: Implementar diseño de card: icon de camión, título "Viaje a {destino}", subtítulo con origen y hora
 T5: Agregar badge de estado: "Planeado" (gris), "En Curso" (verde), "Completado" (azul)
 T6: Implementar botón "Iniciar Viaje" que navega a TripDetailScreen
 T7: Crear widget EmptyTripsState con icon, mensaje y sugerencia de contactar administrador
 T8: Implementar RefreshIndicator con pull-to-refresh que recargue assignedTripProvider
 T9: Agregar shimmer loading mientras carga datos
 T10: Mostrar últimos 3 viajes completados en sección "Viajes recientes" (opcional en MVP)
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:trips

Dependencias: US-016 (necesita estructura de trips), US-009 (necesita auth)

Archivos/Carpetas relacionados:

/lib/features/trips/presentation/screens/home_screen.dart
/lib/features/trips/presentation/widgets/trip_card.dart
/lib/features/trips/presentation/providers/assigned_trip_provider.dart
Notas/Consideraciones:

Query optimization: Query con in operator en status permite buscar múltiples estados en una query. Más eficiente que múltiples queries
Time validation: Considerar mostrar solo viajes de hoy y mañana. Filtrar por planning.planned_start >= startOfDay AND <= endOfTomorrow
Notifications: Cuando se asigna nuevo viaje, enviar FCM push notification al conductor (implementar en Fase 2)
Multiple trips: Si conductor tiene múltiples viajes en el día, mostrar el próximo a iniciar (ordenar por planned_start ASC)
Offline: Si app está offline, mostrar datos cacheados con banner indicando "Sin conexión"
Action buttons: Además de "Iniciar", considerar botón "Ver detalles" que navegue a detalle sin iniciar
Título: US-023: Implementar flujo de inicio de viaje (Planeado → Iniciado)

Descripción:

Resumen: Crear pantalla de detalle de viaje con botón para iniciar, actualizando status del trip y comenzando tracking GPS automáticamente.
Detalle:
Mostrar detalles completos del viaje (waypoints, carga, instrucciones)
Implementar botón "Iniciar Viaje" con confirmación
Actualizar trip status de 'planeado' a 'iniciado'
Registrar timestamp de inicio real
Comenzar tracking GPS automáticamente
Referencia: Ver Sección 4.3 (Trips Lifecycle) y Sección 7.2 FASE 1 → Sprint 5-6 (Mobile: Flujo Iniciar Viaje)
Criterios de aceptación (AC):

 AC1: TripDetailScreen muestra toda la información del viaje: origen, destino, waypoints, carga, notas
 AC2: Botón "Iniciar Viaje" visible solo si status es 'planeado' o 'asignado'
 AC3: Al presionar botón, mostrar diálogo de confirmación: "¿Estás listo para iniciar el viaje?"
 AC4: Tras confirmar, trip actualiza status a 'iniciado' y lifecycle.started_at se registra con timestamp actual
 AC5: Tracking GPS inicia automáticamente y pantalla navega a TrackingScreen
Checklist técnica (Tareas):

 T1: Crear lib/features/trips/presentation/screens/trip_detail_screen.dart
 T2: Recibir trip_id como parámetro de navegación
 T3: Crear provider tripDetailProvider(tripId) que lea documento trips/{tripId}
 T4: Diseñar UI mostrando secciones: Info general, Waypoints (lista), Carga, Notas especiales
 T5: Crear widget WaypointListItem para mostrar cada waypoint con icon, dirección, hora estimada
 T6: Implementar botón flotante "Iniciar Viaje" (FloatingActionButton)
 T7: Crear función startTrip(tripId) en TripRepository que actualice Firestore: {status: 'iniciado', 'lifecycle.started_at': FieldValue.serverTimestamp()}
 T8: Mostrar AlertDialog de confirmación con mensaje y botones "Cancelar" / "Iniciar"
 T9: Tras actualización exitosa, iniciar GPS tracking llamando a GPSService.startTracking()
 T10: Navegar a TrackingScreen pasando tripId como parámetro
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:trips

Dependencias: US-022, US-013 (GPS tracking)

Archivos/Carpetas relacionados:

/lib/features/trips/presentation/screens/trip_detail_screen.dart
/lib/features/trips/data/repositories/trip_repository.dart
/lib/features/trips/presentation/providers/trip_detail_provider.dart
Notas/Consideraciones:

Validation: Antes de permitir inicio, validar que GPS esté habilitado y permiso granted. Si no, mostrar error y pedir habilitar
Optimistic update: Actualizar UI inmediatamente (optimistic) mientras se guarda en Firestore para mejor UX
Error handling: Si falla actualización en Firestore, revertir cambio local y mostrar error al usuario
State machine: Implementar validación de transiciones válidas: 'planeado' → 'iniciado' OK, 'completado' → 'iniciado' NOT OK
Offline: Si no hay conexión, guardar inicio en local storage y sincronizar cuando reconecte
Pre-trip inspection: En Fase 2 (PESV), requerir completar IPO antes de permitir iniciar viaje
Título: US-024: Implementar pantalla de tracking activo durante viaje

Descripción:

Resumen: Crear pantalla de tracking que se muestre durante viaje activo con mapa, ruta, estadísticas en tiempo real y botón para finalizar.
Detalle:
Mostrar mapa con ubicación actual y ruta planeada
Renderizar polyline de ruta ya recorrida
Mostrar estadísticas: distancia recorrida, tiempo transcurrido, velocidad actual
Botón flotante "Finalizar Viaje"
Mantener pantalla activa (screen always on)
Referencia: Ver Sección 4.3 (Trip Tracking) y Sección 7.2 FASE 1 → Sprint 5-6 (Mobile: En Curso → Finalizar)
Criterios de aceptación (AC):

 AC1: TrackingScreen visible durante viaje con mapa centrado en ubicación actual
 AC2: Polyline azul muestra ruta ya recorrida basada en route_points
 AC3: Panel inferior muestra: distancia recorrida, tiempo transcurrido, velocidad actual
 AC4: Botón "Finalizar Viaje" visible y funcional
 AC5: Pantalla permanece encendida durante tracking (no se apaga por inactividad)
Checklist técnica (Tareas):

 T1: Crear lib/features/trips/presentation/screens/tracking_screen.dart
 T2: Agregar dependencia wakelock para mantener pantalla encendida
 T3: Activar wakelock al entrar a TrackingScreen: Wakelock.enable()
 T4: Desactivar wakelock al salir: Wakelock.disable() en dispose
 T5: Renderizar mapa Mapbox con ubicación actual siguiendo al usuario
 T6: Crear provider routePointsProvider(tripId) que escuche subcollection trips/{tripId}/route_points ordenados por timestamp
 T7: Convertir route_points a coordenadas y dibujar polyline en mapa con LineLayer
 T8: Crear widget TripStatsPanel mostrando: distancia, tiempo, velocidad en cards horizontales
 T9: Calcular estadísticas en tiempo real: sumar distancias entre puntos, calcular tiempo desde trip.lifecycle.started_at, velocidad desde último GPS point
 T10: Implementar botón "Finalizar Viaje" que navega a confirmación
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:trips componente:tracking

Dependencias: US-023, US-017 (Mapbox), US-014 (route points en Firestore)

Archivos/Carpetas relacionados:

/lib/features/trips/presentation/screens/tracking_screen.dart
/lib/features/trips/presentation/widgets/trip_stats_panel.dart
/lib/features/trips/presentation/providers/route_points_provider.dart
Notas/Consideraciones:

Battery drain: Wakelock + GPS + mapa = alto consumo de batería. Validar que con optimizaciones se mantenga <10% en 10h (según spec)
Polyline performance: Con 2400 puntos en 10h, polyline puede ser pesada. Considerar simplificación con Douglas-Peucker si lag
Stats calculation: Calcular stats en provider, no en build method. Usar memoization para evitar recalcular en cada rebuild
Offline resilience: Si pierde conexión, seguir mostrando stats basadas en datos locales. Polyline puede no actualizarse hasta reconectar
Stop detection: Mostrar badge "Detenido" si velocidad = 0 por >2 minutos
Navigation: En Fase 2, agregar navegación turn-by-turn con Mapbox Directions API
Título: US-025: Implementar finalización de viaje con cálculo de estadísticas básicas

Descripción:

Resumen: Crear flujo de finalización de viaje que actualice status a 'completado', registre timestamp final y calcule estadísticas básicas del trip.
Detalle:
Botón "Finalizar Viaje" con confirmación
Actualizar trip status a 'completado'
Registrar timestamp de finalización
Calcular distancia total, duración, velocidad promedio
Detener tracking GPS
Navegar a resumen de viaje
Referencia: Ver Sección 4.3 (Trip Lifecycle) y Sección 7.2 FASE 1 → Sprint 5-6 (Mobile: Finalizar viaje)
Criterios de aceptación (AC):

 AC1: Botón "Finalizar Viaje" muestra diálogo de confirmación: "¿Confirmas que el viaje ha finalizado?"
 AC2: Tras confirmar, trip actualiza status a 'completado' y lifecycle.completed_at se registra
 AC3: Cloud Function calcula estadísticas finales: statistics.distance_km, statistics.duration_minutes, statistics.average_speed_kmh
 AC4: GPS tracking se detiene automáticamente
 AC5: App navega a TripSummaryScreen mostrando resumen del viaje
Checklist técnica (Tareas):

 T1: Implementar método completeTrip(tripId) en TripRepository
 T2: Actualizar Firestore: {status: 'completado', 'lifecycle.completed_at': FieldValue.serverTimestamp()}
 T3: Crear Cloud Function onTripCompleted trigger en trips/{tripId} cuando status cambia a 'completado'
 T4: En Cloud Function, leer todos los route_points del trip
 T5: Calcular distancia total sumando distancias entre puntos consecutivos
 T6: Calcular duración: diferencia entre lifecycle.started_at y lifecycle.completed_at
 T7: Calcular velocidad promedio: distancia_total / (duracion / 60)
 T8: Actualizar documento trip con estadísticas calculadas
 T9: Detener GPS tracking: GPSService.stopTracking() y desactivar wakelock
 T10: Navegar a TripSummaryScreen pasando tripId
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:backend componente:trips

Dependencias: US-024

Archivos/Carpetas relacionados:

/lib/features/trips/data/repositories/trip_repository.dart
/firebase/functions/src/triggers/onTripCompleted.ts
/lib/features/trips/presentation/screens/trip_summary_screen.dart
Notas/Consideraciones:

Validation: No permitir finalizar si viaje tiene <5 minutos de duración o <1 km recorrido (probable error). Mostrar warning
POD (Proof of Delivery): En MVP no es obligatorio. En Fase 2, requerir firma/foto antes de finalizar
Async calculation: Cloud Function puede tardar 5-10 segundos en calcular stats. Mostrar loading en TripSummaryScreen mientras calcula
Offline: Si finaliza sin conexión, guardar localmente y sincronizar stats cuando reconecte
Error recovery: Si Cloud Function falla, tener fallback que calcule stats en siguiente sync o manualmente
Notification: Enviar notificación al admin/supervisor cuando viaje se completa (Fase 2)
Título: US-026: Crear Cloud Function para calcular estadísticas de viaje al finalizar

Descripción:

Resumen: Implementar Cloud Function trigger que calcule automáticamente estadísticas completas del viaje cuando status cambia a 'completado'.
Detalle:
Trigger en cambio de status a 'completado'
Leer todos los route_points del viaje
Calcular distancia total, duración, velocidades (promedio/máxima)
Contar stops, calcular tiempo idle
Actualizar documento trip con estadísticas
Referencia: Ver Sección 4.3 (Trip Statistics) y Sección 7.2 FASE 1 → Sprint 5-6 (Backend: Cloud Function para estadísticas)
Criterios de aceptación (AC):

 AC1: Function se ejecuta automáticamente cuando trip.status cambia a 'completado'
 AC2: Calcula y guarda: statistics.distance_km, duration_minutes, average_speed_kmh, max_speed_kmh
 AC3: Calcula stops_count y idle_time_minutes (tiempo detenido)
 AC4: Actualiza documento trip con todas las estadísticas calculadas
 AC5: Function completa ejecución en <30 segundos para viajes de 10 horas
Checklist técnica (Tareas):

 T1: Crear archivo firebase/functions/src/triggers/onTripStatusChange.ts
 T2: Implementar trigger: functions.firestore.document('trips/{tripId}').onUpdate()
 T3: Verificar si status cambió a 'completado': before.data().status !== 'completado' && after.data().status === 'completado'
 T4: Leer subcollection route_points: db.collection('trips').doc(tripId).collection('route_points').orderBy('timestamp').get()
 T5: Implementar función calculateTotalDistance(points) usando Haversine entre puntos consecutivos
 T6: Calcular duración: diferencia entre primer y último punto timestamp
 T7: Calcular velocidad promedio: totalDistance / (duration / 60) y max speed recorriendo puntos
 T8: Detectar stops: puntos con speed < 5 km/h consecutivos por >2 minutos
 T9: Actualizar trip: tripRef.update({statistics: {...calculatedStats}})
 T10: Agregar error handling y logging para debugging
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:backend componente:functions

Dependencias: US-015 (Cloud Functions setup), US-025 (trip completion)

Archivos/Carpetas relacionados:

/firebase/functions/src/triggers/onTripStatusChange.ts
/firebase/functions/src/utils/tripStatsCalculator.ts
/firebase/functions/src/utils/distanceCalculator.ts
Notas/Consideraciones:

Performance: Con 2400 puntos, leer todos de Firestore puede ser lento. Considerar pagination si >1000 puntos
Timeout: Cloud Functions tienen timeout default de 60s. Si viajes muy largos causan timeout, aumentar a 120s o 300s
Cost optimization: Function se ejecuta solo 1 vez por trip completado. Bajo costo (~2 centavos por ejecución)
Idempotency: Validar que si function se ejecuta múltiples veces (retry), no cause cálculos duplicados
Edge cases: Manejar trips sin route_points (fallback a 0), trips con solo 1 punto, etc
Accuracy: Haversine es aproximación. Diferencia con distancia real puede ser 1-3%. Aceptable para MVP
Título: US-027: Implementar notificaciones push con Firebase Cloud Messaging

Descripción:

Resumen: Configurar FCM en app móvil para recibir notificaciones push cuando se asigna viaje o hay eventos importantes.
Detalle:
Configurar FCM en Android e iOS
Solicitar permiso de notificaciones
Registrar FCM token en Firestore user document
Manejar notificaciones en foreground y background
Implementar deep linking al tap notificación
Referencia: Ver Sección 4.1 (Notifications) y Sección 7.2 FASE 1 → Sprint 5-6 (Mobile: Notificaciones push)
Criterios de aceptación (AC):

 AC1: App solicita permiso de notificaciones al usuario tras primer login
 AC2: FCM token generado y guardado en Firestore users/{uid}.device_info.fcm_token
 AC3: Notificaciones recibidas cuando app está en foreground (mostrar in-app)
 AC4: Notificaciones recibidas cuando app está en background (mostrar en bandeja)
 AC5: Tap en notificación abre app y navega a pantalla relevante (ej: trip detail)
Checklist técnica (Tareas):

 T1: Agregar dependencia firebase_messaging en pubspec.yaml
 T2: Configurar FCM en Android: agregar google-services.json en /android/app/
 T3: Configurar FCM en iOS: agregar capability "Push Notifications" en Xcode
 T4: Solicitar permiso: FirebaseMessaging.instance.requestPermission()
 T5: Obtener FCM token: FirebaseMessaging.instance.getToken()
 T6: Guardar token en Firestore: users/{uid}.update({device_info.fcm_token: token})
 T7: Escuchar mensajes en foreground: FirebaseMessaging.onMessage.listen()
 T8: Manejar mensajes en background: FirebaseMessaging.onBackgroundMessage()
 T9: Mostrar notificación local cuando app en foreground usando flutter_local_notifications
 T10: Implementar onMessageOpenedApp para deep linking según data payload de notificación
Estimación: 8 SP / 13h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:notifications

Dependencias: US-001 (Firebase configurado), US-009 (auth para guardar token)

Archivos/Carpetas relacionados:

/lib/core/services/notification_service.dart
/lib/core/services/deep_link_handler.dart
/android/app/google-services.json
/ios/Runner/GoogleService-Info.plist
Notas/Consideraciones:

iOS APNs: Requiere certificado APNs configurado en Firebase Console. Obtener de Apple Developer
Token refresh: FCM tokens pueden cambiar. Escuchar onTokenRefresh y actualizar en Firestore
Permission timing: No solicitar permiso inmediatamente. Esperar a momento contextual (ej: tras asignar primer viaje)
Notification channels: En Android 8+, crear notification channel apropiado ("Viajes", "Alertas", etc)
Data vs Notification: Usar data messages (no notification messages) para mejor control de UI
Testing: Usar Firebase Console para enviar notificaciones de prueba durante desarrollo
Título: US-028: Crear CRUD de conductores en dashboard web

Descripción:

Resumen: Implementar pantalla de gestión de conductores en web admin con tabla, búsqueda, crear, editar y desactivar conductores.
Detalle:
Mostrar tabla con lista de conductores paginada
Implementar búsqueda por nombre, email, DNI
Formulario modal para crear nuevo conductor
Formulario modal para editar conductor existente
Botón para desactivar/activar conductor
Referencia: Ver Sección 4.1 (Driver Management) y Sección 7.2 FASE 1 → Sprint 5-6 (Web: CRUD conductores)
Criterios de aceptación (AC):

 AC1: Página drivers muestra tabla con conductores: nombre, email, licencia, estado, acciones
 AC2: Botón "Nuevo Conductor" abre modal con formulario de creación
 AC3: Formulario incluye campos: nombre completo, email, DNI, teléfono, número de licencia, fecha de vencimiento
 AC4: Click en "Editar" abre modal pre-poblado con datos del conductor
 AC5: Botón "Desactivar" cambia status del conductor sin eliminarlo de Firestore
Checklist técnica (Tareas):

 T1: Crear lib/features/admin/presentation/screens/drivers_screen.dart
 T2: Crear provider driversProvider que query users donde employment.role == 'conductor' y company_id == currentCompanyId
 T3: Crear tabla con DataTable o package pluto_grid para tabla avanzada
 T4: Implementar columnas: Avatar, Nombre, Email, Licencia, Estado (badge), Acciones (botones)
 T5: Crear widget CreateDriverModal con formulario usando Form + TextFields
 T6: Implementar validación: email válido, DNI 8 dígitos, licencia obligatoria
 T7: Al crear, ejecutar: crear usuario en Firebase Auth + crear documento en Firestore users/{uid}
 T8: Crear widget EditDriverModal pre-poblado con datos actuales
 T9: Implementar botón "Desactivar" que actualice status: 'inactivo' en Firestore
 T10: Agregar barra de búsqueda que filtre tabla por nombre, email o DNI
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:web componente:crud

Dependencias: US-010 (web setup), US-011 (web auth)

Archivos/Carpetas relacionados:

/lib/features/admin/presentation/screens/drivers_screen.dart
/lib/features/admin/presentation/widgets/create_driver_modal.dart
/lib/features/admin/presentation/widgets/edit_driver_modal.dart
/lib/features/admin/presentation/providers/drivers_provider.dart
Notas/Consideraciones:

Password generation: Al crear conductor, generar password temporal aleatorio y enviarlo por email (usar SendGrid en Fase 2). En MVP, usar password fijo "Conductor123!" y pedir cambio en primer login
Email uniqueness: Firebase Auth valida que email sea único automáticamente. Manejar error email-already-in-use
Permissions: Solo admins pueden crear/editar conductores. Validar role en Security Rules también
Pagination: Si hay >50 conductores, implementar paginación (25 por página)
Bulk actions: Considerar checkbox para seleccionar múltiples conductores y desactivar en batch (Fase 2)
Photo upload: En MVP no requerido. En Fase 2 permitir subir foto de perfil a Cloud Storage
Título: US-029: Crear CRUD de vehículos en dashboard web

Descripción:

Resumen: Implementar pantalla de gestión de vehículos en web admin con tabla, formularios para crear/editar vehículos y asignación a conductores.
Detalle:
Mostrar tabla de vehículos con info básica
Formulario para registrar nuevo vehículo
Editar información de vehículo existente
Asignar/desasignar vehículo a conductor
Marcar vehículo como activo/inactivo/en mantenimiento
Referencia: Ver Sección 4.1 (Vehicle Management) y Sección 7.2 FASE 1 → Sprint 5-6 (Web: CRUD vehículos)
Criterios de aceptación (AC):

 AC1: Página /vehicles muestra tabla con vehículos: placa, marca, modelo, conductor asignado, estado
 AC2: Formulario de creación incluye: placa, VIN, marca, modelo, año, tipo, capacidad
 AC3: Dropdown para asignar conductor al vehículo
 AC4: Dropdown para cambiar estado operacional: Activo, Inactivo, En mantenimiento
 AC5: Validaciones: placa única, VIN único, año entre 1990-2025
Checklist técnica (Tareas):

 T1: Crear lib/features/admin/presentation/screens/vehicles_screen.dart
 T2: Crear provider vehiclesProvider que query vehicles donde company_id == currentCompanyId
 T3: Crear tabla mostrando: Foto (placeholder icon), Placa, Marca/Modelo, Conductor, Estado, Acciones
 T4: Crear widget CreateVehicleModal con formulario completo
 T5: Implementar campos: placa (uppercase auto), VIN, marca (dropdown con opciones comunes), modelo, año (number input), tipo (dropdown: camión, camioneta, etc), capacidad_kg
 T6: Agregar dropdown "Conductor asignado" poblado con conductores activos
 T7: Al crear, generar vehicle_id con formato VEH-YYYY-XXXX y guardar en Firestore
 T8: Crear widget EditVehicleModal pre-poblado
 T9: Implementar cambio de estado operacional: dropdown con opciones (activo, inactivo, en_mantenimiento)
 T10: Validar placa y VIN únicos antes de crear (query Firestore para verificar)
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:web componente:crud

Dependencias: US-028 (necesita conductores creados para asignar)

Archivos/Carpetas relacionados:

/lib/features/admin/presentation/screens/vehicles_screen.dart
/lib/features/admin/presentation/widgets/create_vehicle_modal.dart
/lib/features/admin/presentation/widgets/edit_vehicle_modal.dart
/lib/features/admin/presentation/providers/vehicles_provider.dart
Notas/Consideraciones:

Vehicle assignment: Al asignar vehículo a conductor, actualizar ambos documentos: vehicles/{id}.operation.assigned_driver_id y users/{driverId}.assigned_vehicle_id
Unique constraints: Firestore no valida uniqueness automáticamente. Implementar check manual o usar Cloud Function
VIN validation: VIN tiene 17 caracteres. Validar longitud y formato (alfanumérico sin I, O, Q)
Plate format: Validar formato de placa según país (Perú: ABC-123, Colombia: ABC123, Chile: ABCD12). Por ahora aceptar cualquier formato
Photos: Permitir subir foto del vehículo en Fase 2. En MVP usar icon placeholder
Documents: En MVP no gestionar documentos (SOAT, revisión técnica). Implementar en Fase 2 con Sprint 15-16
Título: US-030: Implementar asignación de vehículo a conductor en web

Descripción:

Resumen: Crear funcionalidad para asignar/desasignar vehículos a conductores desde dashboard web, actualizando ambos documentos en Firestore.
Detalle:
Botón "Asignar Vehículo" en detalle de conductor
Modal con lista de vehículos disponibles
Validar que vehículo no esté ya asignado
Actualizar documentos de user y vehicle
Mostrar vehículo asignado en perfil de conductor
Referencia: Ver Sección 4.1 (Driver-Vehicle Assignment) y Sección 7.2 FASE 1 → Sprint 5-6 (Web: Asignar vehículo a conductor)
Criterios de aceptación (AC):

 AC1: En DriverDetailScreen, botón "Asignar Vehículo" visible si conductor no tiene vehículo asignado
 AC2: Modal muestra lista de vehículos disponibles (sin conductor asignado)
 AC3: Al asignar, actualiza users/{driverId}.assigned_vehicle_id y vehicles/{vehicleId}.operation.assigned_driver_id
 AC4: Si conductor ya tiene vehículo, mostrar botón "Cambiar Vehículo" en lugar de "Asignar"
 AC5: Botón "Desasignar" limpia asignación en ambos documentos
Checklist técnica (Tareas):

 T1: Crear lib/features/admin/presentation/screens/driver_detail_screen.dart
 T2: Mostrar info completa del conductor incluyendo vehículo asignado (si existe)
 T3: Crear widget AssignVehicleModal con lista de vehículos disponibles
 T4: Query vehículos disponibles: where('operation.assigned_driver_id', '==', null).where('operation.operational_status', '==', 'activo')
 T5: Implementar función assignVehicleToDriver(driverId, vehicleId) en repository
 T6: Usar batch write de Firestore para actualizar ambos documentos atómicamente
 T7: Implementar función unassignVehicle(driverId) que limpie asignación
 T8: Mostrar confirmación: "¿Asignar vehículo {placa} a {conductor}?"
 T9: Actualizar UI optimísticamente mientras se guarda en Firestore
 T10: Manejar errores: si falla batch, revertir cambio y mostrar error
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:web componente:drivers componente:vehicles

Dependencias: US-028, US-029

Archivos/Carpetas relacionados:

/lib/features/admin/presentation/screens/driver_detail_screen.dart
/lib/features/admin/presentation/widgets/assign_vehicle_modal.dart
/lib/features/admin/data/repositories/assignment_repository.dart
Notas/Consideraciones:

Atomicity: Usar WriteBatch para garantizar que ambos updates ocurran o ninguno (evitar inconsistencias)
Race conditions: Validar en Cloud Function también para evitar que 2 admins asignen mismo vehículo simultáneamente
History: Considerar mantener log de asignaciones en subcollection assignment_history (Fase 2)
Notifications: Enviar notificación push al conductor cuando se le asigna vehículo (Fase 2)
Validation: No permitir asignar vehículo si está en mantenimiento o inactivo
UI feedback: Mostrar SnackBar con mensaje de éxito: "Vehículo {placa} asignado a {conductor}"

Título: US-031: Crear formulario de asignación manual de viajes en web

Descripción:

Resumen: Implementar pantalla en web admin para crear y asignar viajes manualmente a conductores, definiendo origen, destino, waypoints y horarios.
Detalle:
Formulario con campos de origen y destino
Selección de conductor y vehículo
Fecha y hora planeada de inicio
Agregar waypoints intermedios (opcional)
Validar disponibilidad de conductor/vehículo
Crear trip en Firestore con status 'planeado'
Referencia: Ver Sección 4.3 (Trip Management) y Sección 7.2 FASE 1 → Sprint 5-6 (Web: Crear y asignar viajes)
Criterios de aceptación (AC):

 AC1: Botón "Crear Viaje" en /trips abre modal con formulario completo
 AC2: Campos obligatorios: Conductor, Vehículo, Origen, Destino, Fecha y hora de inicio
 AC3: Autocomplete de origen/destino usando Mapbox Geocoding API
 AC4: Dropdown de conductor muestra solo conductores activos y disponibles
 AC5: Al guardar, trip creado con status 'asignado' y notificación enviada al conductor
Checklist técnica (Tareas):

 T1: Crear lib/features/admin/presentation/widgets/create_trip_modal.dart
 T2: Implementar campo "Conductor" con dropdown poblado desde driversProvider (solo activos)
 T3: Implementar campo "Vehículo" con dropdown de vehículos asignados al conductor seleccionado
 T4: Agregar dependencia mapbox_search para geocoding
 T5: Implementar campo "Origen" con autocomplete de direcciones usando Mapbox Geocoding
 T6: Implementar campo "Destino" con autocomplete similar
 T7: Agregar DateTimePicker para seleccionar fecha y hora planeada de inicio
 T8: Crear botón "+ Agregar waypoint" para waypoints intermedios (opcional en MVP)
 T9: Implementar validación: fecha debe ser futura, conductor/vehículo no deben tener otro trip activo en ese horario
 T10: Crear función createAndAssignTrip() que guarde en Firestore con status: 'asignado' y envíe notificación FCM
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:web componente:trips

Dependencias: US-028, US-029, US-016 (estructura de trips)

Archivos/Carpetas relacionados:

/lib/features/admin/presentation/widgets/create_trip_modal.dart
/lib/features/admin/data/services/mapbox_geocoding_service.dart
/lib/features/trips/data/repositories/trip_repository.dart
Notas/Consideraciones:

Geocoding costs: Mapbox Geocoding: 100K requests/mes gratis. Después $0.50/1000. Con ~50 viajes/día = 1500/mes = gratis
Availability check: Query Firestore para verificar que conductor no tenga trip con status 'iniciado' o 'asignado' en horario solapado
Address validation: Geocoding retorna coordenadas. Guardar tanto address string como lat/lng en trip
Waypoints: En MVP, permitir max 3 waypoints intermedios. En Fase 2, ilimitados
Route calculation: En MVP no calcular ruta automáticamente. En Fase 2, usar Mapbox Directions API para calcular distancia/duración estimadas
Notification: Usar Cloud Function trigger para enviar FCM cuando se crea trip asignado a conductor
Título: US-032: Implementar vista de detalle de viaje en web dashboard

Descripción:

Resumen: Crear pantalla de detalle de viaje en web que muestre información completa, mapa con ruta recorrida y estadísticas en tiempo real.
Detalle:
Mostrar info del trip: conductor, vehículo, origen/destino, estado
Renderizar mapa con polyline de ruta recorrida
Mostrar waypoints en mapa
Panel con estadísticas: distancia, duración, velocidad
Actualización en tiempo real si trip está activo
Referencia: Ver Sección 4.3 (Trip Detail) y Sección 7.2 FASE 1 → Sprint 5-6 (Web: Vista de detalle de viaje)
Criterios de aceptación (AC):

 AC1: Página /trips/{tripId} muestra información completa del viaje
 AC2: Mapa Mapbox muestra polyline de ruta recorrida basada en route_points
 AC3: Marcadores en origen, destino y waypoints intermedios
 AC4: Panel de estadísticas muestra: distancia recorrida, tiempo transcurrido, velocidad promedio/máxima
 AC5: Si trip está activo, datos se actualizan en tiempo real (cada 30s)
Checklist técnica (Tareas):

 T1: Crear lib/features/admin/presentation/screens/trip_detail_screen.dart
 T2: Recibir tripId como parámetro de ruta
 T3: Crear provider tripDetailProvider(tripId) que escuche documento trips/{tripId}
 T4: Crear provider tripRoutePointsProvider(tripId) que escuche subcollection route_points
 T5: Diseñar layout: mapa a la izquierda (70%), panel info a la derecha (30%)
 T6: Renderizar mapa Mapbox centrado en bounding box de la ruta
 T7: Dibujar polyline usando coordenadas de route_points
 T8: Agregar marcadores: bandera verde (origen), bandera roja (destino), pins (waypoints)
 T9: Crear widget TripInfoPanel mostrando: conductor, vehículo, horarios, estado (badge)
 T10: Crear widget TripStatsPanel con cards de estadísticas actualizadas en tiempo real
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:MVP componente:web componente:trips

Dependencias: US-031, US-019 (mapa web)

Archivos/Carpetas relacionados:

/lib/features/admin/presentation/screens/trip_detail_screen.dart
/lib/features/admin/presentation/widgets/trip_info_panel.dart
/lib/features/admin/presentation/widgets/trip_stats_panel.dart
Notas/Consideraciones:

Real-time performance: Con viajes de 10h (2400 puntos), polyline puede ser pesada. Aplicar simplificación de ruta si >500 puntos
Live updates: Usar Firestore snapshot listeners para actualización automática. Considerar throttle de 30s para reducir reads
Bounding box: Calcular bounds de todos los puntos para auto-zoom del mapa
Color coding: Polyline verde si velocidad normal, rojo si exceso de velocidad detectado
Export: Agregar botón "Exportar PDF" con resumen del viaje (Fase 2)
Timeline: Mostrar timeline de eventos del viaje (inicio, waypoints visitados, fin) en panel lateral
Título: US-033: Crear tabla de historial de viajes en web con filtros

Descripción:

Resumen: Implementar pantalla de historial de viajes en web admin con tabla paginada, filtros por fecha, conductor, estado y búsqueda.
Detalle:
Mostrar tabla con todos los viajes ordenados por fecha DESC
Filtros: rango de fechas, conductor, vehículo, estado
Barra de búsqueda por ID de viaje o destino
Paginación (25 viajes por página)
Click en fila navega a detalle del viaje
Referencia: Ver Sección 4.3 (Trip History) y Sección 7.2 FASE 1 → Sprint 5-6 (Web: Historial de viajes)
Criterios de aceptación (AC):

 AC1: Página /trips muestra tabla con viajes: ID, Conductor, Vehículo, Origen→Destino, Fecha, Estado, Acciones
 AC2: Filtro de rango de fechas funcional (últimos 7 días, 30 días, custom)
 AC3: Dropdown de filtro por conductor y por estado (completado, cancelado, en curso)
 AC4: Barra de búsqueda filtra por trip ID o dirección de destino
 AC5: Paginación muestra 25 viajes por página con controles next/previous
Checklist técnica (Tareas):

 T1: Crear lib/features/admin/presentation/screens/trips_screen.dart
 T2: Crear provider tripsProvider con query: where('company_id', '==', companyId).orderBy('lifecycle.started_at', 'DESC').limit(25)
 T3: Crear tabla con columnas: ID, Conductor, Vehículo, Ruta (origen→destino), Inicio, Fin, Estado (badge), Ver
 T4: Implementar filtro de fecha: DateRangePicker que actualice query con where('lifecycle.started_at', '>=', startDate)
 T5: Crear dropdown de conductor que filtre por driver_id
 T6: Crear dropdown de estado con opciones: Todos, Planeado, Iniciado, Completado, Cancelado
 T7: Implementar barra de búsqueda con debounce de 500ms
 T8: Implementar paginación: usar startAfter() de Firestore para paginar resultados
 T9: Agregar botón "Ver" en cada fila que navegue a /trips/{tripId}
 T10: Mostrar contador: "Mostrando 25 de 150 viajes" y botones next/previous
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:MVP componente:web componente:trips

Dependencias: US-032

Archivos/Carpetas relacionados:

/lib/features/admin/presentation/screens/trips_screen.dart
/lib/features/admin/presentation/providers/trips_provider.dart
/lib/features/admin/presentation/widgets/trips_filters.dart
Notas/Consideraciones:

Firestore pagination: startAfter() requiere mantener último documento de página anterior. Guardar en provider state
Composite index: Query con orderBy + multiple where requiere índice: company_id + driver_id + lifecycle.started_at DESC
Date filter performance: Firestore es eficiente con range queries en timestamps
Search implementation: Firestore no soporta full-text search. Para MVP, search solo en campos exactos. En Fase 2, usar Algolia o ElasticSearch
Export: Agregar botón "Exportar a Excel" que descargue CSV con viajes filtrados (Fase 2)
Empty state: Si no hay viajes, mostrar mensaje con botón "Crear primer viaje"
Título: US-034: Implementar detección básica de movimiento vs detenido

Descripción:

Resumen: Mejorar Cloud Function de procesamiento de GPS para detectar automáticamente cuando vehículo está en movimiento o detenido basado en velocidad.
Detalle:
Analizar velocidad de cada punto GPS
Marcar punto como moving si speed > 5 km/h
Detectar stops: múltiples puntos consecutivos con speed < 5 km/h
Calcular duración de stops
Actualizar estadísticas de trip con tiempo idle
Referencia: Ver Sección 4.2 (Movement Detection) y ya implementado parcialmente en US-015
Criterios de aceptación (AC):

 AC1: Cada route_point tiene campo is_moving calculado automáticamente (true/false)
 AC2: Si vehículo está detenido (speed < 5 km/h) por >2 minutos, se marca como stop
 AC3: Campo stopped_duration calculado sumando tiempo de puntos consecutivos detenidos
 AC4: Estadísticas de trip incluyen idle_time_minutes con total de tiempo detenido
 AC5: En web dashboard, mostrar icono diferente en mapa para vehículos detenidos vs en movimiento
Checklist técnica (Tareas):

 T1: Modificar Cloud Function onRoutePointCreated para calcular is_moving
 T2: Implementar lógica: is_moving = point.speed > 5 ? true : false
 T3: Leer punto anterior para calcular si es parte de un stop
 T4: Si punto actual y anterior están detenidos, calcular stopped_duration como diferencia de timestamps
 T5: Actualizar trip statistics: incrementar idle_time_minutes con stopped_duration
 T6: Agregar campo movement_state al trip: 'moving', 'stopped', 'unknown'
 T7: Crear índice en route_points para query de stops: trip_id + is_moving + timestamp
 T8: En dashboard web, modificar color de marcador: verde si moving, rojo si stopped
 T9: Agregar badge "Detenido" en vehicle card si stopped_duration > 5 minutos
 T10: Crear query de vehículos detenidos: where('movement_state', '==', 'stopped')
Estimación: 8 SP / 13h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:MVP componente:backend componente:tracking

Dependencias: US-015 (Cloud Function de GPS)

Archivos/Carpetas relacionados:

/firebase/functions/src/triggers/onRoutePointCreated.ts
/firebase/functions/src/utils/movementDetector.ts
Notas/Consideraciones:

Speed threshold: 5 km/h es razonable. Ajustar según feedback (puede ser muy bajo para tráfico lento)
Stop definition: 2 minutos detenido es suficiente para considerar stop real (vs semáforo)
GPS accuracy: Con baja precisión GPS, speed puede variar mucho. Considerar promediar últimos 3 puntos
Idle cost: Tiempo idle es métrica importante para eficiencia. Mostrar prominentemente en reportes
Alerts: En Fase 2, generar alerta si vehículo detenido >30 minutos sin razón aparente
Battery impact: Detection es server-side, no afecta batería del dispositivo
Título: US-035: Configurar detección básica de GPS spoofing

Descripción:

Resumen: Implementar validación básica en Cloud Function para detectar posibles intentos de falsificación de GPS (mock locations).
Detalle:
Verificar consistencia de timestamps
Detectar saltos imposibles de ubicación (teletransporte)
Validar accuracy razonable
Marcar puntos sospechosos con flag
Loggear eventos de spoofing detectado
Referencia: Ver Sección 4.2 (GPS Security) y Sección 7.2 FASE 1 → Sprint 3-4 (Backend: Detección de GPS spoofing básica)
Criterios de aceptación (AC):

 AC1: Cloud Function valida que distancia entre puntos consecutivos sea físicamente posible
 AC2: Si punto tiene accuracy > 100 metros, marcar como low_accuracy: true
 AC3: Si velocidad calculada entre puntos > 200 km/h, marcar como suspicious: true
 AC4: Eventos sospechosos loggeados en Cloud Logging para revisión
 AC5: En dashboard web, mostrar warning icon en puntos sospechosos
Checklist técnica (Tareas):

 T1: Modificar Cloud Function onRoutePointCreated para agregar validaciones
 T2: Calcular distancia entre punto actual y anterior usando Haversine
 T3: Calcular velocidad requerida: distance / timeDelta
 T4: Si velocidad > 200 km/h (imposible para vehículo terrestre), marcar suspicious: true
 T5: Validar accuracy: si point.accuracy > 100, marcar low_accuracy: true
 T6: Validar timestamp coherente: no puede ser futuro, no puede ser anterior al punto previo
 T7: Si se detecta anomalía, loggear evento: console.warn('GPS spoofing detected', {tripId, pointId, reason})
 T8: Agregar campo validation_flags al route_point: {suspicious, low_accuracy, timestamp_invalid}
 T9: En web, mostrar icon de warning en polyline donde hay puntos sospechosos
 T10: Crear reporte admin de viajes con alta incidencia de puntos sospechosos
Estimación: 8 SP / 13h

Prioridad: Baja

Etiquetas (labels): tipo:security fase:MVP componente:backend componente:tracking

Dependencias: US-015 (Cloud Function GPS)

Archivos/Carpetas relacionados:

/firebase/functions/src/triggers/onRoutePointCreated.ts
/firebase/functions/src/utils/gpsValidator.ts
Notas/Consideraciones:

False positives: Túneles, zonas de mala señal pueden causar saltos aparentes. No bloquear automáticamente, solo marcar para revisión
Speed limit: 200 km/h es conservador para detección. Camiones no deberían superar 100 km/h, pero usar 200 para evitar falsos positivos
Mock location detection: Android permite detectar si developer options tienen "mock locations" habilitado. Implementar en app en Fase 2
Enforcement: En MVP solo logging. En Fase 2, considerar bloquear trip o alertar supervisor si alta incidencia
ML approach: En Fase 3, usar ML para detectar patrones más sofisticados de spoofing
Legal: En algunos países, tracking con GPS puede tener restricciones legales. Consultar con legal antes de enforcement estricto
Título: US-036: Validar coherencia de datos GPS antes de guardar en Firestore

Descripción:

Resumen: Implementar validaciones client-side y server-side para garantizar calidad de datos GPS antes de persistir en Firestore.
Detalle:
Validar que coordenadas estén en rango válido (lat: -90 a 90, lng: -180 a 180)
Rechazar puntos con accuracy muy baja (>200m)
Validar que timestamp no sea futuro
Verificar que trip_id exista antes de guardar punto
Implementar retry con backoff exponencial en caso de fallos
Referencia: Ver Sección 4.2 (Data Quality) y Sección 7.2 FASE 1 → Sprint 3-4 (Backend: Validación de coherencia)
Criterios de aceptación (AC):

 AC1: Puntos GPS con coordenadas inválidas son rechazados antes de enviar a Firestore
 AC2: Puntos con accuracy > 200m no se guardan (se descartan con logging)
 AC3: Timestamp validado: no puede ser futuro, debe ser posterior al punto anterior
 AC4: Si falla escritura a Firestore, se reintenta hasta 3 veces con backoff exponencial
 AC5: Puntos rechazados se loggean localmente para análisis
Checklist técnica (Tareas):

 T1: Crear clase GPSPointValidator en /lib/features/tracking/data/validators/gps_point_validator.dart
 T2: Implementar validación de coordenadas: isValidLatitude(lat), isValidLongitude(lng)
 T3: Implementar validación de accuracy: rechazar si accuracy > 200 metros
 T4: Validar timestamp: timestamp.isBefore(DateTime.now()) y timestamp.isAfter(previousPoint.timestamp)
 T5: Antes de enviar a Firestore, ejecutar todas las validaciones
 T6: Si validación falla, loggear localmente: logRejectedPoint(point, reason)
 T7: Implementar retry logic con exponential backoff en TrackingRepository.saveGPSPoint()
 T8: Usar package retry o implementar manualmente: retry después de 1s, 2s, 4s
 T9: Tras 3 fallos, guardar punto en buffer local (Hive) para sync posterior
 T10: Crear Cloud Function validation como segunda capa de seguridad
Estimación: 5 SP / 8h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:backend componente:tracking

Dependencias: US-014 (guardar GPS en Firestore)

Archivos/Carpetas relacionados:

/lib/features/tracking/data/validators/gps_point_validator.dart
/lib/features/tracking/data/repositories/tracking_repository.dart
/firebase/functions/src/validators/routePointValidator.ts
Notas/Consideraciones:

Accuracy threshold: 200m es razonable para MVP. En zonas urbanas densas, GPS puede tener accuracy >50m con señal débil
Rejected points: No acumular infinitamente. Limpiar puntos rechazados >7 días
Retry backoff: 1s, 2s, 4s = total 7s máximo de espera. Suficiente para fallos transitorios de red
Buffer overflow: Si buffer local crece >1000 puntos sin sync, eliminar más antiguos (FIFO)
Security Rules: Firestore rules deben validar también que user tenga permiso para escribir en ese trip
Monitoring: En producción, trackear tasa de rechazo. Si >10%, investigar problema sistémico
Título: US-037: Implementar almacenamiento offline con Hive para sincronización posterior

Descripción:

Resumen: Configurar base de datos local Hive para almacenar puntos GPS cuando app está offline, con sincronización automática al recuperar conexión.
Detalle:
Configurar Hive para almacenamiento local
Guardar puntos GPS en Hive cuando falla envío a Firestore
Detectar cambio de conectividad (offline → online)
Sincronizar automáticamente puntos pendientes al reconectar
Limpiar puntos sincronizados exitosamente
Referencia: Ver Sección 4.2 (Offline Capabilities) y Sección 7.2 FASE 1 → Sprint 7-8 (Mobile: Almacenamiento offline)
Criterios de aceptación (AC):

 AC1: Hive configurado y almacenando puntos GPS cuando app está offline
 AC2: Al recuperar conexión, puntos se sincronizan automáticamente a Firestore
 AC3: Puntos sincronizados exitosamente se eliminan de Hive
 AC4: Indicador visual muestra cantidad de puntos pendientes de sincronización
 AC5: Si hay >100 puntos pendientes, sincronizar en batches de 10
Checklist técnica (Tareas):

 T1: Agregar dependencias: hive, hive_flutter en pubspec.yaml
 T2: Inicializar Hive en main.dart: await Hive.initFlutter()
 T3: Crear modelo RoutePointLocal con TypeAdapter para Hive
 T4: Registrar adapter: Hive.registerAdapter(RoutePointLocalAdapter())
 T5: Abrir box: final box = await Hive.openBox<RoutePointLocal>('offline_points')
 T6: Modificar TrackingRepository.saveGPSPoint() para guardar en Hive si falla Firestore
 T7: Crear servicio SyncService que escuche cambios de conectividad con connectivity_plus
 T8: Cuando conectividad cambia a online, ejecutar syncPendingPoints()
 T9: Leer puntos de Hive, enviar a Firestore en batches de 10, eliminar si exitoso
 T10: Mostrar badge en UI indicando "{count} puntos pendientes" si box no está vacío
Estimación: 8 SP / 13h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:tracking componente:offline

Dependencias: US-014, US-036

Archivos/Carpetas relacionados:

/lib/core/services/sync_service.dart
/lib/features/tracking/data/models/route_point_local.dart
/lib/features/tracking/data/repositories/tracking_repository.dart
Notas/Consideraciones:

Hive vs Sqflite: Hive es más simple y rápido para este caso de uso. Sqflite sería overkill
Storage limits: Hive almacena en filesystem del dispositivo. No hay límite práctico para miles de puntos
Batch size: 10 puntos por batch es balance entre velocidad y no saturar Firestore con writes simultáneos
Sync conflicts: Firestore maneja timestamps server-side. No debería haber conflictos
User feedback: Mostrar SnackBar cuando sync completa: "150 puntos sincronizados correctamente"
Battery consideration: Sync al reconectar puede consumir batería. Considerar delay de 30s antes de iniciar sync
Título: US-038: Implementar indicador visual de modo offline en tracking screen

Descripción:

Resumen: Agregar indicador en tracking screen que muestre claramente cuando app está offline y puntos se están guardando localmente.
Detalle:
Banner superior mostrando "Modo Offline" cuando no hay conexión
Indicar cantidad de puntos pendientes de sincronización
Mostrar icono en status bar de conectividad
Banner verde cuando se sincroniza exitosamente
Permitir forzar sincronización manual
Referencia: Ver Sección 4.2 (UX Offline) y mejora de US-018 (indicadores de estado)
Criterios de aceptación (AC):

 AC1: Banner naranja con texto "Sin conexión - guardando localmente" visible cuando offline
 AC2: Badge muestra "{N} puntos pendientes de sincronización"
 AC3: Icono de WiFi/4G en status bar cambia a offline cuando no hay red
 AC4: Banner verde aparece cuando sync exitoso: "200 puntos sincronizados"
 AC5: Botón "Sincronizar ahora" visible solo si hay puntos pendientes
Checklist técnica (Tareas):

 T1: Usar provider connectivityProvider ya creado en US-018
 T2: Crear widget OfflineBanner que escuche connectivity state
 T3: Mostrar banner con AnimatedContainer en top de TrackingScreen
 T4: Crear provider pendingPointsCountProvider que cuente items en Hive box
 T5: Mostrar badge con count si >0
 T6: Crear botón "Sincronizar ahora" que ejecute SyncService.syncPendingPoints() manualmente
 T7: Mostrar CircularProgressIndicator durante sincronización
 T8: Tras sync exitoso, mostrar banner verde con SnackBar: "✓ {count} puntos sincronizados"
 T9: Auto-ocultar banner verde después de 3 segundos
 T10: Agregar animación de slide-in/slide-out para banners
Estimación: 5 SP / 8h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:ui componente:offline

Dependencias: US-037, US-018

Archivos/Carpetas relacionados:

/lib/features/tracking/presentation/widgets/offline_banner.dart
/lib/features/tracking/presentation/providers/pending_points_count_provider.dart
Notas/Consideraciones:

UX clarity: Banner debe ser claro pero no intrusivo. Usuario debe poder seguir usando app normalmente
Color coding: Naranja para offline, verde para sync exitoso, rojo para error de sync
Auto-hide: Banner de éxito debe desaparecer automáticamente para no molestar
Manual sync: Útil si usuario sabe que tendrá WiFi pronto y quiere sincronizar antes
Accessibility: Banner debe tener semantic label para lectores de pantalla
Testing: Simular offline mode en emulador activando airplane mode
Título: US-039: Crear query de detección básica de movimiento vs detenido en app

Descripción:

Resumen: Implementar lógica client-side para detectar cuando conductor está detenido y mostrar indicador visual en tiempo real.
Detalle:
Analizar velocidad de GPS en tiempo real
Mostrar badge "Detenido" si speed < 5 km/h por >1 minuto
Cambiar color de marcador en mapa (verde → rojo)
Reproducir sonido/vibración cuando se reanuda movimiento
Actualizar estadísticas de tiempo detenido
Referencia: Ver Sección 4.2 (Movement Detection Client) complementando US-034
Criterios de aceptación (AC):

 AC1: Badge "Detenido" visible en tracking screen cuando velocidad < 5 km/h por >1 minuto
 AC2: Marcador de ubicación actual en mapa cambia de color: verde (movimiento) → rojo (detenido)
 AC3: Timer de tiempo detenido incrementa en tiempo real mientras está parado
 AC4: Cuando reanuda movimiento (speed > 5 km/h), badge desaparece y vibra dispositivo
 AC5: Estadísticas muestran tiempo total detenido durante el viaje
Checklist técnica (Tareas):

 T1: Crear provider movementStateProvider que analice stream de GPS
 T2: Implementar lógica: si últimos 3 puntos tienen speed < 5 km/h, estado = 'stopped'
 T3: Si estado cambia de 'moving' a 'stopped', iniciar timer de duración
 T4: Crear widget StoppedBadge que se muestre solo cuando estado es 'stopped'
 T5: Modificar color de marcador en mapa según estado (usar conditional rendering)
 T6: Implementar contador de tiempo detenido que incremente cada segundo
 T7: Cuando estado cambia de 'stopped' a 'moving', ejecutar Vibration.vibrate() (usar package vibration)
 T8: Guardar tiempo total detenido en provider para mostrar en resumen
 T9: Agregar esta métrica a TripStatsPanel: card "Tiempo detenido: 15 min"
 T10: Persistir estado en trip document para sincronización con backend
Estimación: 5 SP / 8h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:tracking

Dependencias: US-013 (GPS stream), US-024 (tracking screen)

Archivos/Carpetas relacionados:

/lib/features/tracking/presentation/providers/movement_state_provider.dart
/lib/features/tracking/presentation/widgets/stopped_badge.dart
Notas/Consideraciones:

Speed threshold: 5 km/h puede ser muy bajo para tráfico lento. Considerar ajustar a 3 km/h
Sample size: Analizar últimos 3 puntos (45s de datos) para evitar falsos positivos por variación de GPS
Vibration permission: Android requiere permiso VIBRATE en AndroidManifest.xml
Battery impact: Detection es muy ligera. No afecta batería significativamente
User value: Esta métrica ayuda a identificar ineficiencias en ruta o problemas de tráfico
Future enhancement: En Fase 2, generar alerta si detenido >30 min (posible problema)
Título: US-040: Implementar detección básica de harsh braking mediante acelerómetro

Descripción:

Resumen: Usar sensor de acelerómetro del smartphone para detectar frenados bruscos y registrarlos como eventos en el viaje.
Detalle:
Leer datos del acelerómetro cada 100ms
Detectar cambio brusco de aceleración en eje Y (freno)
Threshold: desaceleración > 8 m/s² = harsh brake
Registrar evento con timestamp y ubicación
Guardar en route_point y crear documento en alerts (preparación Fase 2)
Referencia: Ver Sección 4.4 (Alerts - Harsh Braking) y Sección 7.2 FASE 2 → Sprint 9-10 (preparación)
Criterios de aceptación (AC):

 AC1: App lee acelerómetro mientras hay tracking activo
 AC2: Cuando detecta desaceleración > 8 m/s², marca evento como harsh_brake
 AC3: Evento registrado en route_point con flag harsh_brake_detected: true
 AC4: Feedback táctil inmediato al conductor (vibración corta)
 AC5: En resumen de viaje, mostrar contador: "3 frenados bruscos detectados"
Checklist técnica (Tareas):

 T1: Agregar dependencia sensors_plus en pubspec.yaml
 T2: Crear servicio AccelerometerService en /lib/core/services/
 T3: Escuchar stream de acelerómetro: accelerometerEvents.listen()
 T4: Calcular magnitud de aceleración: sqrt(x² + y² + z²)
 T5: Detectar harsh brake: si delta de aceleración > 8 m/s² en ventana de 200ms
 T6: Cuando detectado, marcar en route_point actual: harsh_brake_detected: true
 T7: Ejecutar vibración: Vibration.vibrate(duration: 200)
 T8: Incrementar contador en trip: events.harsh_brakes_count++
 T9: Guardar ubicación del evento para análisis posterior
 T10: Mostrar contador en TripSummaryScreen
Estimación: 8 SP / 13h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:MVP componente:mobile componente:tracking componente:sensors

Dependencias: US-013 (GPS tracking), US-014 (route points)

Archivos/Carpetas relacionados:

/lib/core/services/accelerometer_service.dart
/lib/features/tracking/data/repositories/tracking_repository.dart
Notas/Consideraciones:

Threshold calibration: 8 m/s² es aproximado. Puede necesitar ajuste según feedback de conductores reales
False positives: Baches, curvas cerradas pueden causar falsos positivos. Combinar con GPS speed change en Fase 2
Battery impact: Leer acelerómetro cada 100ms tiene impacto moderado en batería (~2-3% adicional)
Sensor availability: Todos los smartphones modernos tienen acelerómetro. Validar disponibilidad antes de usar
Future enhancement: Detectar también harsh acceleration (aceleración brusca) y harsh turns (curvas bruscas)
Gamification: En Fase 2, usar estos eventos para calcular driver score y dar feedback inmediato

---

Título: US-041: Implementar tracking GPS en background con foreground service (Android)

Descripción:

Resumen: Permitir que el tracking GPS continúe funcionando cuando la app está en background o pantalla bloqueada usando foreground service en Android.
Detalle:
Crear foreground service persistente para tracking GPS
Mostrar notificación permanente mientras tracking activo
Mantener wake lock para evitar que sistema mate el proceso
Sincronizar puntos GPS desde background a Firestore
Manejar reinicio del servicio si el sistema lo mata (START_STICKY)
Optimizar consumo de batería con location updates adaptativos
Referencia: Ver Sección 7.2 FASE 2 → Sprint 7-8 (Background Tracking) y Sección 4.2 (GPS Tracking - Background Mode)
Criterios de aceptación (AC):

 AC1: Tracking GPS continúa funcionando cuando app está en background o pantalla bloqueada
 AC2: Notificación persistente visible en Android con icono, título "Tracking activo" y botón "Detener"
 AC3: Puntos GPS se sincronizan a Firestore cada 15 segundos desde background
 AC4: Si sistema mata el servicio, se reinicia automáticamente y resume tracking
 AC5: Batería optimizada: location updates se reducen de 15s a 30s cuando velocidad < 5 km/h
Checklist técnica (Tareas):

 T1: Agregar dependencia flutter_foreground_task: ^8.0.0 en pubspec.yaml
 T2: Crear TrackingForegroundService en /lib/core/services/android/
 T3: Configurar AndroidManifest.xml con permisos: FOREGROUND_SERVICE, WAKE_LOCK, ACCESS_BACKGROUND_LOCATION
 T4: Crear notificación persistente con NotificationChannel "tracking_channel"
 T5: Implementar callback startCallback() que inicia GPS listener en background
 T6: Configurar foreground service con autoRunOnBoot: false, allowWakeLock: true
 T7: Manejar onDestroy() para reiniciar servicio (START_STICKY)
 T8: Implementar lógica adaptativa: si speed < 5 km/h, interval = 30s; si speed >= 5 km/h, interval = 15s
 T9: Agregar botón "Detener tracking" en notificación que llama a stopForegroundTask()
 T10: Probar en dispositivo físico con pantalla bloqueada por 30 minutos
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:Fase2 componente:mobile componente:tracking plataforma:android

Dependencias: US-013 (GPS tracking), US-014 (route points sync)

Archivos/Carpetas relacionados:

/lib/core/services/android/tracking_foreground_service.dart
/android/app/src/main/AndroidManifest.xml
/lib/features/tracking/presentation/providers/tracking_provider.dart
Notas/Consideraciones:

Permisos Android 10+: ACCESS_BACKGROUND_LOCATION requiere permiso adicional explícito del usuario (popup separado)
Battery optimization: Advertir al usuario que desactive "Battery optimization" para la app en Settings para evitar que Doze mode mate el servicio
Testing: DEBE probarse en dispositivo físico, NO funciona correctamente en emulador
Notificación: Incluir tiempo transcurrido, distancia recorrida y velocidad actual en notificación para dar feedback al conductor
Doze mode: En Android 6+, Doze puede limitar background tasks. Usar setAlarmClock() si necesario para mantener precisión
iOS equivalent: Esta historia es solo Android. Para iOS se requiere US-042 separado (Background Modes + Significant Location Change)

---

Título: US-042: Implementar tracking GPS en background (iOS) con Background Modes

Descripción:

Resumen: Permitir tracking GPS continuo en iOS cuando app está en background usando Background Modes y Significant Location Change API.
Detalle:
Configurar Background Modes en Xcode (Location updates)
Usar allowsBackgroundLocationUpdates para GPS continuo
Implementar fallback con Significant Location Change para batería
Mostrar banner azul "App está usando tu ubicación" en iOS
Optimizar consumo de batería con pausesLocationUpdatesAutomatically
Sincronizar puntos GPS a Firestore desde background
Referencia: Ver Sección 7.2 FASE 2 → Sprint 7-8 (Background Tracking) y Sección 4.2 (GPS Tracking - iOS Background)
Criterios de aceptación (AC):

 AC1: Tracking GPS continúa funcionando cuando app está en background o pantalla bloqueada en iOS
 AC2: Banner azul de iOS visible indicando "SmartFleet está usando tu ubicación"
 AC3: Puntos GPS se sincronizan a Firestore cada 15 segundos desde background
 AC4: Batería optimizada: usa Significant Location Change cuando app >30 min en background
 AC5: Location permission "Always Allow" solicitado y explicado claramente al usuario
Checklist técnica (Tareas):

 T1: Abrir ios/Runner.xcworkspace en Xcode
 T2: En Target → Signing & Capabilities, agregar Background Modes capability
 T3: Habilitar "Location updates" en Background Modes
 T4: Editar Info.plist y agregar NSLocationAlwaysAndWhenInUseUsageDescription con texto explicativo
 T5: En TrackingService, configurar locationSettings con allowsBackgroundLocationUpdates: true
 T6: Configurar pausesLocationUpdatesAutomatically: false para tracking continuo
 T7: Implementar lógica: si app >30 min en background, cambiar a startMonitoringSignificantLocationChanges()
 T8: Crear timer para detectar cuando app vuelve a foreground y restaurar tracking normal
 T9: Probar en iPhone físico (NO funciona en simulador) con Xcode Instruments para medir battery drain
 T10: Validar que syncs a Firestore funcionan desde background
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:Fase2 componente:mobile componente:tracking plataforma:ios

Dependencias: US-013 (GPS tracking), US-014 (route points sync), US-041 (background tracking Android)

Archivos/Carpetas relacionados:

/ios/Runner/Info.plist
/ios/Runner.xcworkspace (configuración Xcode)
/lib/core/services/ios/tracking_background_service.dart
/lib/features/tracking/data/services/tracking_service.dart
Notas/Consideraciones:

iOS permissions: "Always Allow" es muy sensible. Explicar CLARAMENTE al usuario por qué necesitamos background location (tracking de viaje)
Apple Review: App Store review puede rechazar si no justificas bien el uso de background location. Preparar screenshots y explicación
Significant Location Change: Menos preciso (~500m accuracy) pero consume 99% menos batería. Ideal para trips largos (>1 hora)
Battery testing: IMPERATIVO medir consumo real con Instruments. Target: <10% battery drain por hora de tracking
Blue banner: No se puede ocultar. Es requirement de iOS para transparencia con usuario
Alternative: Para trips cortos (<30 min), solo usar "When In Use" permission es suficiente

---

Título: US-043: Optimizar consumo de batería con estrategias adaptativas de tracking

Descripción:

Resumen: Implementar estrategias inteligentes para reducir consumo de batería durante tracking GPS prolongado sin sacrificar precisión de datos.
Detalle:
Detectar estado de movimiento (stopped, moving, highway)
Ajustar intervalo de GPS según estado: stopped=60s, moving=15s, highway=30s
Reducir accuracy cuando velocidad es estable
Pausar acelerómetro cuando vehículo detenido >2 minutos
Mostrar estimación de batería restante en UI
Implementar "Battery Saver Mode" opcional que reduce precisión al 50%
Referencia: Ver Sección 4.2 (GPS Tracking - Optimización) y Sección 7.2 FASE 2 → Sprint 7-8
Criterios de aceptación (AC):

 AC1: Sistema detecta automáticamente 3 estados: stopped (speed <5 km/h), moving (5-80 km/h), highway (>80 km/h)
 AC2: Intervalos GPS adaptativos: stopped=60s, moving=15s, highway=30s
 AC3: Acelerómetro se pausa cuando vehículo detenido >2 minutos
 AC4: UI muestra badge "Modo ahorro batería" cuando activo
 AC5: Consumo de batería medido: <8% por hora en modo normal, <5% por hora en battery saver mode
Checklist técnica (Tareas):

 T1: Crear BatteryOptimizationService en /lib/core/services/
 T2: Implementar detector de estado basado en speed: getMovementState(double speed)
 T3: Crear enum MovementState { stopped, moving, highway }
 T4: En TrackingService, ajustar distanceFilter según estado: stopped=50m, moving=10m, highway=20m
 T5: Ajustar timeInterval según estado: stopped=60s, moving=15s, highway=30s
 T6: En AccelerometerService, pausar listening si speed <5 km/h por >2 minutos
 T7: Crear toggle "Battery Saver Mode" en TripTrackingScreen settings
 T8: En Battery Saver: reducir accuracy a LocationAccuracy.low, interval=30s para todos estados
 T9: Usar battery_plus package para leer battery level actual
 T10: Mostrar estimación: "Batería estimada para X horas de tracking" basado en battery level y consumption rate
 T11: Implementar tests unitarios para MovementState detector
 T12: Probar en dispositivo físico durante 2 horas y medir drain real
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:Fase2 componente:mobile componente:tracking componente:optimization

Dependencias: US-013 (GPS tracking), US-041 (Android background), US-042 (iOS background)

Archivos/Carpas relacionados:

/lib/core/services/battery_optimization_service.dart
/lib/features/tracking/data/services/tracking_service.dart
/lib/features/tracking/presentation/screens/trip_tracking_screen.dart
Notas/Consideraciones:

Testing methodology: Usar Xcode Instruments (iOS) y Android Battery Historian (Android) para medir consumo real
Highway detection: 80 km/h threshold puede variar por país. Hacer configurable en futuro
False positives: Tráfico pesado (speed oscilando 0-20 km/h) puede causar cambios frecuentes de estado. Implementar hysteresis (debounce de 30 segundos)
User control: Algunos usuarios prefieren precisión sobre batería. Hacer Battery Saver Mode opcional, NO forzado
Baseline: Sin optimización, tracking consume ~15-20% batería por hora. Target post-optimización: <8%
Trade-offs: Highway mode con interval=30s puede perder algunos harsh braking events. Aceptable según prioridades de negocio

---

Título: US-044: Implementar sistema base de alertas y notificaciones push

Descripción:

Resumen: Crear infraestructura de alertas con Cloud Functions y FCM para notificar eventos importantes (geofence breach, speeding, device offline) a supervisores en tiempo real.
Detalle:
Crear colección alerts en Firestore
Implementar Cloud Function para procesar eventos y crear alertas
Enviar notificaciones push via FCM a supervisores
Categorizar alertas por severidad (low, medium, high, critical)
Mostrar alertas en web dashboard con filtros
Implementar in-app notifications en mobile
Referencia: Ver Sección 4.4 (Alerts & Notifications), Sección 6.2.5 (alerts collection) y Sprint 9-10
Criterios de aceptación (AC):

 AC1: Colección alerts creada en Firestore con campos: id, company_id, trip_id, vehicle_id, type, severity, message, timestamp, acknowledged
 AC2: Cloud Function onAlertCreated() escucha nuevos alerts y envía FCM notification a supervisores
 AC3: Tipos de alerta implementados: geofence_breach, speeding, harsh_braking, device_offline
 AC4: Web dashboard muestra lista de alertas en tiempo real con badge de no leídas
 AC5: Supervisores pueden marcar alertas como "acknowledged" desde web
Checklist técnica (Tareas):

 T1: Crear interface Alert en /firebase/functions/src/types/models.ts
 T2: Agregar índices en firestore.indexes.json para company_id, trip_id, timestamp
 T3: Crear Cloud Function onAlertCreated en /firebase/functions/src/triggers/onAlertCreated.ts
 T4: Implementar lógica: cuando nuevo alert, query users con role=supervisor y company_id
 T5: Obtener FCM tokens de supervisores desde users collection
 T6: Enviar FCM multicast message con admin.messaging().sendMulticast()
 T7: Payload de notificación: title, body, data (alert_id, trip_id, severity)
 T8: En web, crear AlertsPage que escucha alerts collection en tiempo real (onSnapshot)
 T9: Implementar filtros: tipo de alerta, severidad, fecha, vehículo
 T10: Crear helper createAlert() que genera documento alert con campos validados
 T11: Agregar badge en AppBar web mostrando count de alertas no acknowledged
 T12: Probar creando alert manualmente y verificando FCM notification
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:Fase2 componente:backend componente:notifications componente:web

Dependencias: US-001 (Firebase setup), US-007 (Mobile auth), US-010 (Web auth)

Archivos/Carpetas relacionados:

/firebase/functions/src/triggers/onAlertCreated.ts
/firebase/functions/src/utils/notificationHelper.ts
/web/lib/features/alerts/presentation/pages/alerts_page.dart
/lib/core/models/alert.dart
Notas/Consideraciones:

FCM tokens: Validar que tokens están frescos. Tokens pueden expirar. Manejar NotRegistered error y eliminar token obsoleto
Severities: low (info), medium (warning), high (action needed), critical (immediate action). Afecta color de badge y sonido de notificación
Batching: Si >100 alertas generadas simultáneamente (ej. geofence breach de toda flota), enviar summary notification en vez de 100 notificaciones
Acknowledged: Agregar user_id y acknowledged_at cuando supervisor marca como leída
Future: Agregar canal de Slack/Teams para alertas critical
Rate limiting: Evitar spam de alertas. Si mismo tipo de alerta para mismo trip en <5 minutos, no crear duplicado

---

Título: US-045: Implementar geofencing básico con creación y monitoreo de geocercas

Descripción:

Resumen: Permitir a administradores crear geocercas circulares en mapa web y detectar cuando vehículos entran/salen de estas zonas para generar alertas.
Detalle:
Crear colección geofences en Firestore
Implementar UI en web para dibujar geocercas en Mapbox
Almacenar geocercas como GeoJSON con radio y metadata
Cloud Function para detectar breach usando geofire-common
Generar alert cuando vehículo entra o sale de geocerca
Mostrar geocercas en mapa móvil (solo lectura)
Referencia: Ver Sección 4.3 (Geofencing), Sección 6.2.6 (geofences collection) y Sprint 9-10
Criterios de aceptación (AC):

 AC1: Colección geofences creada con campos: id, company_id, name, center (GeoPoint), radius_meters, type (circular), created_by, active
 AC2: Admin web puede crear geocerca haciendo click en mapa, arrastrando para definir radio
 AC3: Cloud Function monitorea route_points y detecta cuando GPS entra/sale de geocerca (usando geofire-common)
 AC4: Al detectar breach, crea documento en alerts con tipo geofence_breach
 AC5: App móvil muestra geocercas en mapa como círculos semitransparentes durante tracking
Checklist técnica (Tareas):

 T1: Crear interface Geofence en /firebase/functions/src/types/models.ts
 T2: Agregar geofire-common dependency en functions: npm install geofire-common
 T3: Crear índice geohash en firestore.indexes.json para queries espaciales
 T4: En web, crear GeofencesPage con Mapbox GL en modo dibujo
 T5: Implementar MapboxDraw para dibujar círculos: mapboxgl.Draw con mode: 'draw_circle'
 T6: Al completar dibujo, extraer center (lat, lng) y radius, guardar en Firestore
 T7: Crear Cloud Function onRoutePointCreated que verifica geofences
 T8: Usar geofireCommon.distanceBetween() para calcular distancia entre GPS point y geofence center
 T9: Si distance <= radius, marcar como "inside"; si estaba "outside" antes, generar alert tipo "geofence_entered"
 T10: Almacenar último estado (inside/outside) en trip document para tracking
 T11: En mobile, query geofences de company_id y renderizar en mapa como círculos
 T12: Probar creando geocerca, iniciando trip y cruzando perímetro
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:Fase2 componente:backend componente:web componente:mobile componente:geofencing

Dependencias: US-018 (Mapbox web), US-044 (Sistema de alertas), US-014 (route points)

Archivos/Carpetas relacionados:

/firebase/functions/src/triggers/onRoutePointCreated.ts
/firebase/functions/src/utils/geofenceHelper.ts
/web/lib/features/geofences/presentation/pages/geofences_page.dart
/lib/features/tracking/presentation/widgets/geofence_overlay.dart
Notas/Consideraciones:

GeoJSON: Almacenar como GeoPoint (lat, lng) + radius es suficiente para MVP. Polígonos arbitrarios quedan para Fase 3
Performance: geofire-common es muy eficiente. Puede verificar cientos de geocercas sin lag
Geohash indexes: Firestore requiere índice en geohash field para queries espaciales rápidas
Edge cases: Si GPS tiene accuracy >200m, puede causar false positives en geocercas pequeñas (<500m radius). Validar accuracy antes de verificar
Types: Implementar solo circular geofences en MVP. Polygon geofences requieren turf.js y más complejidad
Alert deduplication: Si vehículo oscila en borde de geocerca, puede generar múltiples alerts. Implementar cooldown de 5 minutos
Future: Agregar scheduled geofences (solo alertar en horario específico), geofence analytics (tiempo promedio dentro de zona)

---

Título: US-046: Implementar detección de speeding y alertas de exceso de velocidad

Descripción:

Resumen: Detectar cuando vehículos exceden límites de velocidad configurados (general o por geocerca) y generar alertas automáticas a supervisores.
Detalle:
Configurar límite de velocidad global por company (ej. 80 km/h)
Permitir límites específicos por geocerca (ej. zona escolar 30 km/h)
Cloud Function valida speed de cada route_point contra límites
Generar alert cuando speed > límite por >10 segundos consecutivos
Mostrar eventos de speeding en timeline de trip
Dashboard web muestra ranking de conductores por infracciones
Referencia: Ver Sección 4.4 (Alerts - Speeding) y Sección 7.2 FASE 2 → Sprint 9-10
Criterios de aceptación (AC):

 AC1: Company document tiene campo speed_limit_kmh (default: 80 km/h) configurable por admin
 AC2: Geofence puede tener campo speed_limit_kmh opcional que sobrescribe el global
 AC3: Cloud Function detecta speeding cuando GPS speed > límite aplicable por >10 segundos
 AC4: Alert creado con tipo speeding, incluyendo speed_actual, speed_limit, duration
 AC5: Web dashboard muestra "Top 5 Speeders" con count de infracciones por conductor
Checklist técnica (Tareas):

 T1: Agregar campo speed_limit_kmh a Company model (default: 80)
 T2: Agregar campo speed_limit_kmh opcional a Geofence model
 T3: En Cloud Function onRoutePointCreated, obtener speed del GPS point
 T4: Verificar si punto está dentro de alguna geocerca con límite específico
 T5: Si no hay geocerca, usar límite global de company
 T6: Implementar buffer de 10 segundos: almacenar últimos 10 puntos GPS en memoria
 T7: Si speed > límite en >=10 puntos consecutivos (10 puntos * 15s interval ≈ 2.5 min), generar alert
 T8: Alert incluye: speed_actual (máximo detectado), speed_limit, duration_seconds, location (GeoPoint)
 T9: Marcar route_points con flag speeding_detected: true
 T10: Crear Cloud Function getSpeedingStats que agrega infracciones por driver
 T11: En web, crear widget SpeedingLeaderboard que muestra top 5 infractores
 T12: Probar simulando GPS points con speed > límite
Estimación: 8 SP / 13h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:Fase2 componente:backend componente:alerts componente:web

Dependencias: US-044 (Sistema de alertas), US-045 (Geofencing), US-014 (route points)

Archivos/Carpetas relacionados:

/firebase/functions/src/triggers/onRoutePointCreated.ts
/firebase/functions/src/triggers/getSpeedingStats.ts
/web/lib/features/analytics/presentation/widgets/speeding_leaderboard.dart
/lib/core/models/company.dart
Notas/Consideraciones:

GPS accuracy: Speed de GPS puede tener errores ±10 km/h. Considerar margin de error (ej. alertar solo si speed > límite + 10 km/h)
Buffer duration: 10 segundos puede ser muy corto. En producción ajustar a 30 segundos para evitar false positives en aceleración puntual
Geofence priority: Si vehículo en múltiples geocercas sobrepuestas, usar el límite MÁS RESTRICTIVO
Legal considerations: En algunos países, speeding detection puede tener implicaciones legales. Consultar con legal antes de lanzar
Gamification: Usar datos de speeding para driver score (penalizar infracciones). Ver US-051 (scoring)
Alert severity: Considerar severity basado en exceso: <20 km/h = medium, >20 km/h = high, >40 km/h = critical
Future: Integrar con API de límites de velocidad reales (OpenStreetMap tags, Google Maps Roads API) para validación automática

---

Título: US-047: Implementar detección de dispositivo offline y alertas de pérdida de señal

Descripción:

Resumen: Detectar cuando un dispositivo móvil pierde conectividad por tiempo prolongado y alertar a supervisores sobre posible problema técnico.
Detalle:
Cloud Function monitorea timestamp del último route_point recibido
Si no hay puntos GPS en >10 minutos durante trip activo, marcar como offline
Generar alert tipo device_offline con timestamp y última ubicación conocida
Mostrar badge "Offline" en mapa web en tiempo real
Enviar notificación push a supervisor
Auto-resolver alert cuando dispositivo vuelve online
Referencia: Ver Sección 4.4 (Alerts - Device Offline) y Sección 7.2 FASE 2 → Sprint 9-10
Criterios de aceptación (AC):

 AC1: Cloud Function scheduled corre cada 5 minutos verificando trips en status "in_progress"
 AC2: Si último route_point tiene timestamp >10 minutos atrás, marcar trip como device_offline: true
 AC3: Generar alert tipo device_offline con última ubicación conocida
 AC4: Web dashboard muestra vehículo con badge rojo "Offline" en mapa
 AC5: Cuando dispositivo vuelve online (nuevo route_point recibido), auto-resolver alert
Checklist técnica (Tareas):

 T1: Crear Cloud Function scheduled checkOfflineDevices con cron: every 5 minutes
 T2: En función, query trips donde status="in_progress" y company_id
 T3: Para cada trip, obtener último route_point (orderBy timestamp desc, limit 1)
 T4: Calcular diff: Date.now() - lastPoint.timestamp
 T5: Si diff > 10 minutos y trip.device_offline != true, marcar como offline
 T6: Actualizar trip: { device_offline: true, offline_since: serverTimestamp() }
 T7: Crear alert con tipo device_offline, severity: high
 T8: En onRoutePointCreated, verificar si trip.device_offline === true
 T9: Si true, actualizar trip: { device_offline: false, online_since: serverTimestamp() }
 T10: Auto-resolver alert: { resolved: true, resolved_at: serverTimestamp() }
 T11: En web, leer trip.device_offline y mostrar badge "Offline" en VehicleMarker
 T12: Probar deteniendo app por 15 minutos y verificando alert
Estimación: 8 SP / 13h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:backend componente:alerts componente:web

Dependencias: US-044 (Sistema de alertas), US-018 (Mapbox web), US-014 (route points)

Archivos/Carpetas relacionados:

/firebase/functions/src/scheduled/checkOfflineDevices.ts
/firebase/functions/src/triggers/onRoutePointCreated.ts
/web/lib/features/tracking/presentation/widgets/vehicle_marker.dart
Notas/Consideraciones:

Threshold tuning: 10 minutos puede ser muy sensible en zonas rurales con cobertura intermitente. Hacer configurable por company
Scheduled function: Usar Cloud Scheduler con timezone UTC. Cron expression: */5 * * * * (cada 5 minutos)
Cost: Función corriendo cada 5 minutos puede generar ~8,640 invocaciones/mes. Monitorear costos en Firebase console
Battery saver mode: Si app en battery saver, puede pausar sync temporalmente. Distinguir entre "offline network" vs "offline app paused"
False positives: Túneles, parkings subterráneos causan pérdida temporal de GPS y network. Considerar resolver auto después de 2 minutos online
Auto-resolution: Incluir duración del offline en alert para analytics: offline_duration_minutes
Future: Detectar patrón de offline recurrente (mismo conductor, mismo vehículo) y sugerir cambio de dispositivo

---

Título: US-048: Implementar CRUD completo de geocercas en web con validaciones

Descripción:

Resumen: Permitir a administradores crear, editar, eliminar y listar geocercas desde web dashboard con validaciones de negocio.
Detalle:
Lista de geocercas en tabla con filtros y búsqueda
Formulario de creación/edición con validaciones
Dibujo interactivo en mapa usando Mapbox Draw
Eliminar geocerca con confirmación (soft delete)
Visualizar todas las geocercas activas en mapa
Asignar nombre, descripción, límite de velocidad a cada geocerca
Referencia: Ver Sección 4.3 (Geofencing) y Sección 7.2 FASE 2 → Sprint 9-10
Criterios de aceptación (AC):

 AC1: GeofencesPage muestra tabla con todas las geocercas de la company (nombre, tipo, radio, speed limit, activa)
 AC2: Botón "Nueva Geocerca" abre modal con mapa para dibujar círculo
 AC3: Validaciones: nombre requerido (max 50 chars), radio entre 100m y 10km, speed_limit entre 10 y 120 km/h
 AC4: Botón "Eliminar" marca geocerca como active: false (soft delete, no elimina de Firestore)
 AC5: Mapa muestra todas las geocercas activas con colores según tipo
Checklist técnica (Tareas):

 T1: Crear GeofencesPage en /web/lib/features/geofences/presentation/pages/
 T2: Crear GeofencesDataTable con columnas: nombre, tipo, radio, speed_limit, activa, acciones
 T3: Implementar filtros: búsqueda por nombre, filtro por activa/inactiva
 T4: Botón "Nueva Geocerca" abre GeofenceFormModal
 T5: En modal, renderizar Mapbox con MapboxDraw plugin
 T6: Configurar draw mode: circle only (deshabilitar polygon, line)
 T7: Al completar dibujo, extraer center y radius del GeoJSON
 T8: Mostrar form: nombre (TextField), descripción (TextField), speed_limit (NumberField)
 T9: Validar: nombre required, radius 100-10000m, speed_limit 10-120 km/h
 T10: Guardar en Firestore con company_id, created_by (user_id), created_at
 T11: Implementar EditGeofenceModal que precarga datos y permite modificar
 T12: Botón "Eliminar" muestra confirmDialog, luego actualiza active: false
 T13: En mapa, renderizar geocercas activas como círculos con fill-opacity: 0.2
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:Fase2 componente:web componente:geofencing

Dependencias: US-045 (Geofencing base), US-018 (Mapbox web)

Archivos/Carpetas relacionados:

/web/lib/features/geofences/presentation/pages/geofences_page.dart
/web/lib/features/geofences/presentation/widgets/geofence_form_modal.dart
/web/lib/features/geofences/data/repositories/geofence_repository.dart
Notas/Consideraciones:

Mapbox Draw: Instalar @mapbox/mapbox-gl-draw package en web. Requiere configuración adicional en index.html
Soft delete: No eliminar documentos de Firestore. Usar active: false para mantener historial
Radius limits: 100m mínimo para evitar geocercas demasiado pequeñas propensas a false positives. 10km máximo razonable para logística urbana
Speed limit: Hacer opcional. Si no se especifica, usar límite global de company
Overlapping geofences: Permitir geocercas sobrepuestas. Lógica de detección maneja múltiples matches
Colors: Asignar colores según tipo de geocerca (warehouse: blue, customer: green, restricted: red) para visualización
Future: Agregar import/export de geocercas via CSV/GeoJSON para carga masiva

---

Título: US-049: Implementar panel de notificaciones in-app en mobile

Descripción:

Resumen: Mostrar notificaciones push recibidas dentro de la app móvil en un centro de notificaciones con historial y badge de no leídas.
Detalle:
Crear colección notifications en Firestore
Almacenar todas las notificaciones enviadas via FCM
Mostrar lista de notificaciones en app con filtro leídas/no leídas
Badge numérico en AppBar indicando notificaciones pendientes
Marcar como leída al hacer tap
Deep links: tap en notificación navega a pantalla relevante (trip detail, alert, etc)
Referencia: Ver Sección 4.4 (Notifications) y Sección 6.2.9 (notifications collection)
Criterios de aceptación (AC):

 AC1: Colección notifications creada con campos: id, user_id, company_id, title, body, type, data, read, timestamp
 AC2: NotificationsPage muestra lista de notificaciones ordenadas por timestamp desc
 AC3: Badge rojo en AppBar muestra count de notificaciones no leídas
 AC4: Tap en notificación marca como read: true y navega a pantalla correspondiente
 AC5: Filtro para ver "Todas" o "No leídas"
Checklist técnica (Tareas):

 T1: Crear interface Notification en /lib/core/models/notification.dart
 T2: Agregar índice en firestore.indexes.json para user_id, company_id, timestamp
 T3: Modificar Cloud Function onAlertCreated para crear documento en notifications además de enviar FCM
 T4: Crear NotificationsPage en /lib/features/notifications/presentation/pages/
 T5: Implementar NotificationsRepository que escucha notifications con onSnapshot
 T6: Crear NotificationTile widget que muestra title, body, timestamp relativo, badge de no leída
 T7: En AppBar, mostrar IconButton con Badge(count: unreadCount)
 T8: Implementar método markAsRead() que actualiza notification: { read: true, read_at: serverTimestamp() }
 T9: Implementar deep linking: si type=trip_completed, navegar a TripDetailPage(tripId)
 T10: Si type=alert_speeding, navegar a AlertDetailPage(alertId)
 T11: Implementar filtro ToggleButtons: "Todas" / "No leídas"
 T12: Probar enviando FCM notification y verificando que aparece en lista
Estimación: 8 SP / 13h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:mobile componente:notifications

Dependencias: US-044 (Sistema de alertas), US-007 (Mobile auth)

Archivos/Carpetas relacionados:

/lib/features/notifications/presentation/pages/notifications_page.dart
/lib/features/notifications/data/repositories/notification_repository.dart
/lib/core/models/notification.dart
/firebase/functions/src/utils/notificationHelper.ts
Notas/Consideraciones:

Read status: Almacenar en Firestore (no solo en local) para sincronizar entre dispositivos si usuario usa múltiples devices
Deep linking: Requiere configuración en AndroidManifest.xml y Info.plist. Usar firebase_dynamic_links o go_router
Badge count: Query notifications.where('user_id', '==', uid).where('read', '==', false).count() es costoso. Considerar almacenar unread_count en user document
Retention: Considerar TTL (time-to-live) para notificaciones >30 días. Usar Cloud Function scheduled para limpiar
Types: Definir enum NotificationType { trip_completed, alert_speeding, alert_geofence, alert_offline, maintenance_due, etc }
Future: Agregar settings de notificaciones (usuario puede desactivar tipos específicos)

---

Título: US-050: Implementar sistema de configuración de alertas por usuario/rol

Descripción:

Resumen: Permitir que supervisores y administradores configuren qué tipos de alertas desean recibir y por qué canales (push, email, in-app).
Detalle:
Agregar campos de configuración a user document
UI en web/mobile para toggle de tipos de alerta
Configurar severidad mínima para recibir notificaciones
Configurar canales: push, email, in-app
Cloud Functions respeta configuración antes de enviar notificaciones
Configuración por defecto según rol
Referencia: Ver Sección 4.4 (Alerts Configuration) y Sección 7.2 FASE 2 → Sprint 9-10
Criterios de aceptación (AC):

 AC1: User document tiene campo alert_preferences con configuración de tipos y canales
 AC2: Web/mobile muestra página "Configuración de Alertas" con toggles por tipo
 AC3: Configuración incluye: speeding, geofence_breach, harsh_braking, device_offline
 AC4: Usuario puede elegir canales: push (FCM), email, in-app para cada tipo
 AC5: Cloud Function verifica preferencias antes de enviar, solo envía si usuario opted-in
Checklist técnica (Tareas):

 T1: Agregar campo alert_preferences a User model: { speeding: { enabled: bool, channels: string[], min_severity: string }, ... }
 T2: Crear AlertSettingsPage en web y mobile
 T3: Mostrar lista de tipos de alerta con Switch para enabled/disabled
 T4: Para cada tipo, mostrar checkboxes: "Push", "Email", "In-app"
 T5: Agregar dropdown "Severidad mínima": low, medium, high, critical
 T6: Guardar configuración en Firestore: users/{userId}/alert_preferences
 T7: Modificar onAlertCreated Cloud Function para leer alert_preferences
 T8: Filtrar destinatarios: solo incluir usuarios con alerta enabled y severity >= min_severity
 T9: Filtrar canales: solo enviar FCM si 'push' en channels, solo crear notification si 'in-app' en channels
 T10: Implementar defaults según rol: admin recibe todo, supervisor recibe high+, conductor solo critical
 T11: Agregar botón "Restaurar defaults" que resetea a configuración por rol
 T12: Probar generando alert y verificando que solo usuarios con preferencia correcta reciben notificación
Estimación: 8 SP / 13h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:backend componente:web componente:mobile componente:notifications

Dependencias: US-044 (Sistema de alertas), US-049 (Notificaciones in-app)

Archivos/Carpetas relacionados:

/lib/features/settings/presentation/pages/alert_settings_page.dart
/web/lib/features/settings/presentation/pages/alert_settings_page.dart
/firebase/functions/src/triggers/onAlertCreated.ts
/lib/core/models/user.dart
Notas/Consideraciones:

GDPR compliance: Configuración de alertas es parte de privacy settings. Documentar en privacy policy
Defaults: Evitar spam. Conductores por defecto solo reciben critical alerts. Supervisores reciben high+. Admins reciben todo
Email: Implementar envío de email requiere SendGrid o similar. Dejar para Fase 3, solo documentar estructura
Opt-out: Permitir desactivar completamente un tipo de alerta. Útil si supervisor solo monitorea speeding, no geofences
Channels array: Usar array ['push', 'email', 'in-app'] para flexibilidad futura (SMS, Slack, etc)
Performance: Cache alert_preferences en memoria en Cloud Function para evitar read a Firestore por cada alerta
Future: Alert schedules (solo recibir alertas en horario laboral), alert grouping (digest diario en vez de real-time)

---

Título: US-051: Implementar algoritmo de scoring de conductores con métricas básicas

Descripción:

Resumen: Calcular score de 0-100 para cada conductor basado en métricas de conducción (speeding, harsh braking, trip completion, distancia) para gamificación.
Detalle:
Definir fórmula de scoring con pesos por métrica
Calcular score automáticamente al finalizar cada trip
Almacenar score histórico en user document
Mostrar score actual en perfil de conductor (mobile)
Dashboard web muestra ranking de conductores por score
Penalizar infracciones, premiar conducción segura
Referencia: Ver Sección 4.5 (Scoring & Gamification) y Sección 7.2 FASE 2 → Sprint 11-12
Criterios de aceptación (AC):

 AC1: User document tiene campos: driver_score (0-100), total_trips, total_distance_km, infractions_count
 AC2: Cloud Function onTripCompleted calcula score basado en: speeding events (-5 pts), harsh braking (-3 pts), trip completion (+2 pts)
 AC3: Score se actualiza en user document al finalizar cada trip
 AC4: App móvil muestra score en DriverProfileScreen con badge de nivel
 AC5: Web dashboard muestra LeaderboardPage con top 10 conductores ordenados por score
Checklist técnica (Tareas):

 T1: Agregar campos a User model: driver_score, total_trips, total_distance_km, infractions_count
 T2: Crear Cloud Function calculateDriverScore en /firebase/functions/src/utils/scoringEngine.ts
 T3: Definir fórmula: score_base = 100, cada speeding -5 pts, cada harsh_brake -3 pts, cada trip completado +2 pts
 T4: Normalizar score: min 0, max 100
 T5: En onTripCompleted, llamar calculateDriverScore(userId, tripData)
 T6: Actualizar user document: { driver_score, total_trips: increment(1), total_distance_km: increment(trip.distance_km) }
 T7: Incrementar infractions_count si hay speeding o harsh braking events
 T8: Crear DriverProfileScreen en mobile mostrando: score, nivel, trips, distancia, infracciones
 T9: Implementar badge visual: 90-100="Oro", 70-89="Plata", 50-69="Bronce", <50="En mejora"
 T10: En web, crear LeaderboardPage que query users orderBy driver_score desc limit 10
 T11: Mostrar tabla con: posición, nombre, score, trips, infracciones
 T12: Probar completando trips con/sin infracciones y validando cambios en score
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:backend componente:mobile componente:web componente:gamification

Dependencias: US-025 (Trip completion), US-046 (Speeding), US-040 (Harsh braking)

Archivos/Carpetas relacionados:

/firebase/functions/src/utils/scoringEngine.ts
/firebase/functions/src/triggers/onTripCompleted.ts
/lib/features/profile/presentation/pages/driver_profile_screen.dart
/web/lib/features/analytics/presentation/pages/leaderboard_page.dart
Notas/Consideraciones:

Formula tuning: Pesos iniciales son aproximados. Ajustar según feedback de clientes (algunos priorizan seguridad, otros eficiencia)
Decay: Considerar decay temporal (infracciones antiguas pesan menos). Implementar en Fase 3
Normalization: Score puede volverse negativo con muchas infracciones. Forzar min=0 para evitar scores ridículos
Levels: Definir niveles claros: Oro (90-100), Plata (70-89), Bronce (50-69), En mejora (<50). Mostrar badge visual
Transparency: Mostrar fórmula al conductor para que entienda cómo mejorar su score
Incentives: Clientes pueden dar bonos por score alto. Considerar integración con payroll en Fase 3
Future: Scoring avanzado con ML (detección de patrones de conducción), comparación con promedio de flota, alerts proactivas

---

Título: US-052: Implementar sistema de badges y achievements para conductores

Descripción:

Resumen: Crear sistema de logros desbloqueables (badges) para motivar conductores: "100 trips completados", "Semana sin infracciones", "10,000 km conducidos".
Detalle:
Definir catálogo de badges con condiciones de desbloqueo
Cloud Function verifica condiciones al finalizar trip
Crear documento en user_badges cuando se desbloquea achievement
Mostrar badges en perfil de conductor con progress bars
Notificación push cuando desbloquea nuevo badge
Dashboard web muestra estadísticas de badges por flota
Referencia: Ver Sección 4.5 (Gamification - Achievements) y Sección 7.2 FASE 2 → Sprint 11-12
Criterios de aceptación (AC):

 AC1: Colección user_badges creada con campos: id, user_id, badge_id, unlocked_at, progress
 AC2: Al menos 5 badges definidos: "Novato" (1 trip), "Veterano" (100 trips), "Seguro" (semana sin infracciones), "Explorador" (1000 km), "Élite" (score >90)
 AC3: Cloud Function verifica condiciones al finalizar trip y desbloquea badges automáticamente
 AC4: Notificación push enviada cuando se desbloquea badge: "¡Felicitaciones! Desbloqueaste: Veterano"
 AC5: DriverProfileScreen muestra galería de badges con locked/unlocked y progress (ej. "75/100 trips para Veterano")
Checklist técnica (Tareas):

 T1: Crear colección badges en Firestore con catálogo: id, name, description, icon_url, condition_type, condition_value
 T2: Seed badges: novato (1 trip), veterano (100 trips), seguro (7 días sin infracciones), explorador (1000 km), elite (score >90)
 T3: Crear colección user_badges: user_id, badge_id, unlocked_at, progress
 T4: Crear Cloud Function checkBadgeUnlocks que corre al finalizar trip
 T5: Implementar lógica: if user.total_trips >= badge.condition_value && badge no unlocked, unlock badge
 T6: Crear documento en user_badges y enviar FCM notification
 T7: En mobile, crear BadgesGalleryWidget en DriverProfileScreen
 T8: Mostrar badges en grid: locked (grayscale) vs unlocked (color)
 T9: Mostrar progress bar: "75/100 trips" debajo de cada badge
 T10: Implementar achievement_unlocked notification type con animación especial
 T11: En web, crear BadgeStatsWidget mostrando distribución de badges en flota
 T12: Probar completando trips y verificando unlock de badges
Estimación: 13 SP / 21h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:Fase2 componente:backend componente:mobile componente:web componente:gamification

Dependencias: US-051 (Driver scoring), US-044 (Sistema de alertas)

Archivos/Carpetas relacionados:

/firebase/functions/src/triggers/checkBadgeUnlocks.ts
/lib/features/profile/presentation/widgets/badges_gallery_widget.dart
/web/lib/features/analytics/presentation/widgets/badge_stats_widget.dart
/firebase/firestore/seeds/badges.json
Notas/Consideraciones:

Icon design: Requiere diseño de iconos para cada badge. Considerar contratar diseñador o usar icon packs (Flaticon, Icons8)
Condition types: Implementar enum: trip_count, distance_km, score_threshold, infraction_free_days, consecutive_safe_trips
Progress tracking: Almacenar progress en user_badges para mostrar "estás a X de desbloquear"
Retroactive: Al lanzar feature, ejecutar script que evalúa usuarios existentes y desbloquea badges retroactivamente
Notification: Hacer animación especial en app cuando desbloquea badge (confetti, sound effect)
Social: Permitir compartir badge desbloqueado en redes sociales (WhatsApp, Facebook). Genera engagement
Future: Badges de equipo (toda la flota completa 1000 trips), badges temporales (mes de la seguridad vial)

---

Título: US-053: Implementar panel de analytics web con métricas clave de flota

Descripción:

Resumen: Crear dashboard de analytics en web mostrando KPIs principales: total trips, distancia, tiempo en ruta, utilización de vehículos, top conductores.
Detalle:
Diseñar layout de dashboard con cards de métricas
Calcular KPIs usando Cloud Functions scheduled
Almacenar métricas agregadas en colección analytics_daily
Mostrar gráficos de tendencia (últimos 7/30 días)
Filtros por rango de fecha y vehículo
Exportar reportes a PDF
Referencia: Ver Sección 4.6 (Reports & Analytics), Sección 7.2 FASE 2 → Sprint 13-14
Criterios de aceptación (AC):

 AC1: AnalyticsDashboardPage muestra 6 cards: Total Trips, Distancia Total, Tiempo en Ruta, Vehículos Activos, Score Promedio, Alertas Generadas
 AC2: Cada card muestra valor actual y variación vs período anterior (ej. "+12% vs semana pasada")
 AC3: Gráfico de línea muestra tendencia de trips por día (últimos 30 días)
 AC4: Filtros: date range picker, dropdown de vehículos
 AC5: Botón "Exportar PDF" genera reporte descargable con todas las métricas
Checklist técnica (Tareas):

 T1: Crear colección analytics_daily con campos: date, company_id, total_trips, total_distance_km, total_duration_hours, active_vehicles, avg_score, alerts_count
 T2: Crear Cloud Function scheduled aggregateDailyMetrics que corre diariamente a medianoche UTC
 T3: Función agrega data del día anterior: count trips, sum distance, sum duration, count distinct vehicles, avg driver_score, count alerts
 T4: Guardar resultado en analytics_daily/{date}
 T5: Crear AnalyticsDashboardPage en web con GridView de 6 MetricCards
 T6: Implementar MetricCard widget: title, value, percentage change, trend icon (↑↓)
 T7: Calcular percentage change: ((current - previous) / previous) * 100
 T8: Implementar TrendChart usando fl_chart package (LineChart)
 T9: Query analytics_daily últimos 30 días para poblar chart
 T10: Implementar DateRangePicker con presets: "Hoy", "Última semana", "Último mes", "Custom"
 T11: Implementar filtro de vehículos (multi-select dropdown)
 T12: Botón "Exportar PDF" llama a Cloud Function generateAnalyticsPDF que usa pdfkit.js
 T13: Probar con datos seed y validar cálculos de KPIs
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:Fase2 componente:web componente:backend componente:analytics

Dependencias: US-025 (Trip completion), US-051 (Driver scoring), US-044 (Sistema de alertas)

Archivos/Carpetas relacionados:

/firebase/functions/src/scheduled/aggregateDailyMetrics.ts
/firebase/functions/src/http/generateAnalyticsPDF.ts
/web/lib/features/analytics/presentation/pages/analytics_dashboard_page.dart
/web/lib/features/analytics/presentation/widgets/metric_card.dart
Notas/Consideraciones:

Aggregation time: Correr a medianoche UTC asegura data completa del día. Ajustar timezone según región del cliente
Performance: analytics_daily es snapshot diario. Evita queries costosas sobre trips collection completa
Charts library: fl_chart (Flutter) o Recharts (React si web es React). Configurar tooltips y zoom
Percentage change: Manejar división por cero (si previous=0, mostrar "N/A" o "∞%")
PDF generation: pdfkit.js en Cloud Function. Incluir logo de empresa, fecha de generación, disclaimer
Caching: Cache analytics_daily en frontend para evitar re-fetches. Invalidar cache a medianoche
Future: Integración con BigQuery para analytics avanzados, dashboards customizables (drag & drop widgets), scheduled email reports

---

Título: US-054: Implementar integración con BigQuery para analytics avanzados

Descripción:

Resumen: Exportar datos de Firestore a BigQuery para análisis SQL avanzados, reportes complejos y preparación para integración con Looker Studio.
Detalle:
Configurar BigQuery dataset y tables
Usar Firestore Extension para streaming automático
Crear scheduled Cloud Function para ETL de datos históricos
Definir schema de tablas: trips, route_points, alerts, users
Optimizar tablas con partitioning por fecha
Crear vistas materializadas para queries comunes
Referencia: Ver Sección 5.3 (BigQuery Integration), Sección 7.2 FASE 2 → Sprint 13-14
Criterios de aceptación (AC):

 AC1: BigQuery dataset smartfleet_analytics creado en proyecto GCP
 AC2: Firestore Extension instalada y sincronizando trips, alerts, users a BigQuery en tiempo real
 AC3: Tabla bq_route_points poblada con ETL diario de route_points (filtrado para evitar data masiva)
 AC4: Tablas particionadas por fecha (created_at) para optimizar queries
 AC5: Vista materializada trip_summary_daily creada para queries recurrentes
Checklist técnica (Tareas):

 T1: Habilitar BigQuery API en proyecto GCP
 T2: Crear dataset smartfleet_analytics en región us-central1
 T3: Instalar Firestore Extension: "Stream Collections to BigQuery"
 T4: Configurar extension para colecciones: trips, alerts, users, vehicles
 T5: Crear tabla bq_route_points con schema: trip_id, timestamp, lat, lng, speed, accuracy
 T6: Crear Cloud Function scheduled etlRoutePoints que corre diariamente
 T7: Función query route_points del día anterior y batch insert a BigQuery (10,000 rows/batch)
 T8: Configurar table partitioning en todas las tablas: PARTITION BY DATE(created_at)
 T9: Crear vista materializada: CREATE MATERIALIZED VIEW trip_summary_daily AS SELECT DATE(created_at), COUNT(*), SUM(distance_km)...
 T10: Crear service account con rol BigQuery Data Editor para Cloud Functions
 T11: Probar ejecutando query SQL simple: SELECT COUNT(*) FROM trips WHERE DATE(created_at) = CURRENT_DATE()
 T12: Documentar schema y queries de ejemplo en /docs/bigquery-guide.md
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:backend componente:analytics componente:data

Dependencias: US-001 (Firebase setup), US-025 (Trip completion)

Archivos/Carpetas relacionados:

/firebase/functions/src/scheduled/etlRoutePoints.ts
/docs/bigquery-guide.md
/bigquery/schemas/ (definiciones de schema)
Notas/Consideraciones:

Cost: BigQuery cobra por storage ($0.02/GB/mes) y queries ($5/TB scanned). Usar partitioning y clustering para minimizar scan
Firestore Extension: Crea automáticamente tablas con schema basado en documentos. Puede requerir ajustes manuales para tipos específicos
Route points: NO sincronizar todos los route_points en tiempo real (millones de registros). Usar ETL diario con sampling (ej. 1 punto cada 5 minutos)
Partitioning: Queries que usan WHERE DATE(created_at) = '2025-01-15' solo escanean esa partición. Ahorra 99% de costo
Materialized views: Se actualizan automáticamente pero tienen costo de refresh. Usar solo para queries muy frecuentes
Schema evolution: BigQuery permite agregar columnas pero no eliminarlas. Diseñar schema pensando en futuro
Future: Configurar Looker Studio dashboards conectados a BigQuery, ML models para predictive analytics

---

Título: US-055: Implementar generación de reportes PDF programados con envío por email

Descripción:

Resumen: Permitir a administradores configurar reportes automáticos (diarios, semanales, mensuales) que se generan en PDF y envían por email a destinatarios configurados.
Detalle:
Crear colección scheduled_reports con configuración de reportes
UI en web para crear/editar reportes programados
Cloud Function scheduled genera PDFs usando datos de BigQuery
Enviar email con PDF adjunto usando SendGrid
Tipos de reporte: Trip Summary, Driver Performance, Fleet Utilization, Alerts Report
Almacenar PDFs generados en Cloud Storage para historial
Referencia: Ver Sección 4.6 (Scheduled Reports), Sección 7.2 FASE 2 → Sprint 13-14
Criterios de aceptación (AC):

 AC1: Colección scheduled_reports creada con campos: id, company_id, report_type, frequency (daily/weekly/monthly), recipients (emails), active
 AC2: Web muestra ScheduledReportsPage donde admin puede crear nuevo reporte
 AC3: Cloud Function scheduled generateScheduledReports corre diariamente verificando reportes pending
 AC4: PDF generado incluye: logo empresa, período, tablas/gráficos según tipo, footer con timestamp
 AC5: Email enviado a recipients con PDF adjunto usando SendGrid
Checklist técnica (Tareas):

 T1: Crear interface ScheduledReport en /firebase/functions/src/types/models.ts
 T2: Crear ScheduledReportsPage en web con tabla de reportes configurados
 T3: Form para crear reporte: tipo (dropdown), frecuencia (radio buttons), recipients (chips input), filtros opcionales
 T4: Guardar en Firestore con next_run_date calculado según frecuencia
 T5: Crear Cloud Function scheduled generateScheduledReports (cron: daily at 6am UTC)
 T6: Función query scheduled_reports donde next_run_date <= today
 T7: Para cada reporte, query datos de BigQuery según tipo y período
 T8: Usar puppeteer para generar PDF desde HTML template
 T9: Subir PDF a Cloud Storage: gs://smartfleet-reports/{company_id}/{report_id}/{date}.pdf
 T10: Enviar email usando SendGrid API con PDF adjunto
 T11: Actualizar next_run_date según frecuencia (daily: +1 day, weekly: +7 days, monthly: +1 month)
 T12: Crear templates HTML para cada tipo de reporte en /firebase/functions/src/templates/reports/
 T13: Probar creando reporte scheduled y verificando generación + email
Estimación: 21 SP / 34h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:backend componente:web componente:reports

Dependencias: US-054 (BigQuery), US-053 (Analytics dashboard)

Archivos/Carpetas relacionados:

/firebase/functions/src/scheduled/generateScheduledReports.ts
/firebase/functions/src/templates/reports/trip_summary.html
/web/lib/features/reports/presentation/pages/scheduled_reports_page.dart
Notas/Consideraciones:

SendGrid: Requiere cuenta SendGrid (free tier: 100 emails/día). Configurar API key en Firebase config
Puppeteer: Agregar puppeteer dependency en functions. Requiere ~250MB extra en deployment (usar functions with 1GB RAM)
PDF templates: Usar HTML/CSS para diseño. Puppeteer renderiza a PDF. Incluir inline CSS para compatibilidad
Email size: PDFs pueden ser grandes (>5MB con muchos gráficos). Considerar comprimir o link de descarga en vez de adjunto
Timezone: Generar reportes en timezone de la empresa, no UTC. Almacenar timezone en company document
Retry logic: Si generación falla (BigQuery timeout, SendGrid error), marcar para retry. Max 3 intentos
Future: Reportes customizables (usuario elige métricas), multi-formato (Excel, CSV además de PDF), webhooks para integración con BI tools

---

Título: US-056: Implementar módulo de mantenimiento preventivo con recordatorios

Descripción:

Resumen: Crear sistema de gestión de mantenimiento preventivo para vehículos con recordatorios automáticos basados en kilometraje o fecha.
Detalle:
Crear colección maintenance_records en Firestore
Definir tipos de mantenimiento: cambio aceite, rotación llantas, revisión técnica, etc.
Configurar intervalos de recordatorio (ej. cada 5000 km o cada 3 meses)
Cloud Function monitorea kilometraje y genera alertas cuando cerca de mantenimiento
UI en web para registrar mantenimientos realizados
Historial de mantenimiento por vehículo en mobile y web
Referencia: Ver Sección 4.7 (Maintenance Management), Sección 6.2.7 (maintenance_records), Sprint 15-16
Criterios de aceptación (AC):

 AC1: Colección maintenance_records creada con campos: id, vehicle_id, company_id, type, date, odometer_km, next_due_km, next_due_date, notes, cost
 AC2: Web permite crear nuevo registro de mantenimiento con form: vehículo, tipo, fecha, kilometraje, costo, notas
 AC3: Cloud Function scheduled checkMaintenanceDue corre diariamente y genera alerts cuando next_due_km - current_km < 500
 AC4: Alert tipo maintenance_due enviado a supervisor con detalles: vehículo, tipo de mantenimiento, km restantes
 AC5: MaintenanceHistoryPage en web muestra tabla con historial completo filtrable por vehículo y tipo
Checklist técnica (Tareas):

 T1: Crear interface MaintenanceRecord en /firebase/functions/src/types/models.ts
 T2: Agregar índices en firestore.indexes.json para vehicle_id, company_id, next_due_date
 T3: Crear MaintenanceRecordsPage en web con tabla de registros
 T4: Implementar CreateMaintenanceModal con form: vehículo (dropdown), tipo (select), fecha (DatePicker), odometer_km, cost, notas
 T5: Al guardar, calcular next_due_km y next_due_date según tipo (ej. aceite: +5000 km, +3 meses)
 T6: Crear Cloud Function scheduled checkMaintenanceDue (cron: daily at 8am)
 T7: Función query vehicles y obtiene current_km (último trip.end_odometer)
 T8: Query maintenance_records donde next_due_km - current_km < 500 o next_due_date - today < 7 days
 T9: Generar alert tipo maintenance_due para cada registro encontrado
 T10: Crear MaintenanceHistoryPage con filtros: vehículo, tipo, rango de fecha
 T11: Mostrar tabla: fecha, tipo, km, costo, próximo mantenimiento (km y fecha)
 T12: En mobile, agregar sección Maintenance en VehicleDetailScreen mostrando próximo mantenimiento
 T13: Probar creando registro y validando alert cuando se acerca fecha/kilometraje
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:Fase2 componente:backend componente:web componente:mobile componente:maintenance

Dependencias: US-044 (Sistema de alertas), US-001 (Firebase setup)

Archivos/Carpetas relacionados:

/firebase/functions/src/scheduled/checkMaintenanceDue.ts
/web/lib/features/maintenance/presentation/pages/maintenance_records_page.dart
/web/lib/features/maintenance/presentation/widgets/create_maintenance_modal.dart
/lib/features/vehicles/presentation/screens/vehicle_detail_screen.dart
Notas/Consideraciones:

Maintenance types: Definir enum: oil_change, tire_rotation, brake_inspection, technical_review, etc. Cada tipo tiene intervalo default
Odometer tracking: Requiere que trips almacenen start_odometer y end_odometer. Actualizar Trip model si no existe
Cost tracking: Útil para calcular TCO (Total Cost of Ownership). Incluir en analytics futuros
Calendar integration: Considerar enviar .ics file para agregar mantenimiento a calendario (Google Calendar, Outlook)
Recurring: Después de completar mantenimiento, auto-crear próximo registro con next_due calculado
Overdue: Marcar vehículo como "Overdue maintenance" si pasa fecha/km sin registrar mantenimiento. Bloquear creación de trips (opcional)
Future: Integración con talleres mecánicos, cotizaciones automáticas, recordatorios vía WhatsApp

---

Título: US-057: Implementar inspección digital pre-viaje (PESV) con checklist

Descripción:

Resumen: Crear checklist digital de inspección pre-viaje obligatorio según PESV (Plan Estratégico de Seguridad Vial) antes de iniciar trip.
Detalle:
Definir checklist items: llantas, frenos, luces, documentos, limpieza, etc.
Conductor debe completar checklist antes de iniciar trip
Captura fotográfica de ítems críticos (llantas, luces)
Almacenar inspección en Firestore con timestamp y fotos en Storage
Reportes de inspecciones incompletas o con issues
Bloquear inicio de trip si inspección no aprobada (configurable)
Referencia: Ver Sección 4.7 (PESV Digital Inspection), Sección 7.2 FASE 2 → Sprint 15-16
Criterios de aceptación (AC):

 AC1: Al crear trip, app móvil muestra PESVInspectionScreen con checklist de 10 items
 AC2: Conductor marca cada item como OK/Defecto, agrega notas opcionales
 AC3: Items críticos (llantas, frenos, luces) requieren foto (subir a Cloud Storage)
 AC4: Inspección guardada en subcollection trips/{tripId}/inspections
 AC5: Si algún item marcado como "Defecto", trip no puede iniciarse hasta aprobación de supervisor (configurable)
Checklist técnica (Tareas):

 T1: Crear interface PESVInspection con campos: trip_id, inspector_id (user), timestamp, items (array), photos (urls), approved
 T2: Definir checklist items: tires_condition, brakes, lights, mirrors, cleanliness, documents, fire_extinguisher, first_aid_kit, fuel_level, vehicle_cleanliness
 T3: Crear PESVInspectionScreen en mobile con ListView de ChecklistItems
 T4: Cada item tiene: título, status (RadioButtons: OK/Defecto), notes (TextField opcional), photo (IconButton)
 T5: Para items críticos, botón "Tomar foto" abre cámara usando image_picker
 T6: Subir foto a Cloud Storage: /inspections/{company_id}/{trip_id}/{item_name}_{timestamp}.jpg
 T7: Al completar checklist, guardar en Firestore: trips/{tripId}/inspections/{inspectionId}
 T8: Si algún item = "Defecto", marcar inspection.approved = false y mostrar AlertDialog: "Requiere aprobación supervisor"
 T9: Enviar notification a supervisor con detalles de defectos
 T10: Supervisor puede aprobar desde web (InspectionReviewPage) marcando approved = true
 T11: Solo permitir iniciar trip si inspection.approved = true
 T12: Crear InspectionHistoryPage en web mostrando todas las inspecciones con filtros
 T13: Probar flujo completo: checklist → foto → defecto → approval → inicio trip
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:Fase2 componente:mobile componente:backend componente:web componente:pesv componente:compliance

Dependencias: US-021 (Trip creation), US-001 (Firebase Storage)

Archivos/Carpetas relacionados:

/lib/features/trips/presentation/screens/pesv_inspection_screen.dart
/firebase/functions/src/triggers/onInspectionCreated.ts
/web/lib/features/inspections/presentation/pages/inspection_review_page.dart
Notas/Consideraciones:

PESV compliance: Checklist debe cumplir normativa colombiana de PESV. Validar con cliente items específicos requeridos
Photo compression: Comprimir fotos antes de subir (max 1MB) usando flutter_image_compress para ahorrar storage y bandwidth
Offline support: Permitir completar checklist offline, fotos se suben cuando recupera conexión
Legal: Fotos e inspecciones son evidencia legal. Configurar retention de 5 años mínimo
Configurable: Permitir a admin customizar checklist (agregar/quitar items) según necesidades de empresa
Frequency: Inspección requerida 1 vez al día (primer trip). Trips subsiguientes del mismo día usan misma inspección
Future: OCR para extraer texto de documentos (licencia, SOAT, tecnomecánica), AI para detectar defectos en fotos de llantas

---

Título: US-058: Implementar gestión de documentos de vehículos con vencimientos

Descripción:

Resumen: Administrar documentos legales de vehículos (SOAT, tecnomecánica, revisión gases) con alertas de vencimiento y almacenamiento en Cloud Storage.
Detalle:
Agregar campos de documentos a vehicle document
Subir PDFs de documentos a Cloud Storage
Alertas automáticas 30/15/7 días antes de vencimiento
Dashboard web muestra estado de documentos por vehículo
Marcar vehículo como "No disponible" si documentos vencidos
Historial de renovaciones
Referencia: Ver Sección 4.7 (Document Management), Sección 7.2 FASE 2 → Sprint 15-16
Criterios de aceptación (AC):

 AC1: Vehicle model tiene campo documents: { soat: {number, expiry_date, file_url}, tecnicomecanica: {...}, gases: {...}, insurance: {...} }
 AC2: Web permite subir documentos en VehicleEditPage con DatePicker para expiry_date
 AC3: Cloud Function scheduled checkDocumentExpiry genera alerts 30, 15, 7 días antes de vencimiento
 AC4: Web dashboard muestra DocumentStatusWidget con badges: verde (>30 días), amarillo (7-30 días), rojo (vencido)
 AC5: Vehículos con documentos vencidos marcados como available: false automáticamente
Checklist técnica (Tareas):

 T1: Agregar campo documents a Vehicle model con sub-campos para cada tipo de documento
 T2: En VehicleEditPage (web), agregar sección "Documentos Legales"
 T3: Para cada tipo: número de documento (TextField), fecha vencimiento (DatePicker), upload file (FilePicker)
 T4: Al seleccionar archivo, subir a Cloud Storage: /documents/{company_id}/vehicles/{vehicle_id}/{doc_type}.pdf
 T5: Guardar URL del archivo y metadata en vehicle.documents
 T6: Crear Cloud Function scheduled checkDocumentExpiry (cron: daily at 9am)
 T7: Query vehicles y verificar expiry_date de cada documento
 T8: Generar alert si days_until_expiry in [30, 15, 7] con severity según proximidad
 T9: Si expiry_date < today, actualizar vehicle.available = false
 T10: Crear DocumentStatusWidget en web mostrando tabla: tipo doc, número, vencimiento, estado (badge)
 T11: Implementar VehicleDocumentsPage mostrando todos los documentos con opción de descargar PDF
 T12: Probar subiendo documentos con fechas próximas y validando alerts
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:Fase2 componente:web componente:backend componente:compliance

Dependencias: US-001 (Firebase Storage), US-044 (Sistema de alertas)

Archivos/Carpetas relacionados:

/firebase/functions/src/scheduled/checkDocumentExpiry.ts
/web/lib/features/vehicles/presentation/pages/vehicle_edit_page.dart
/web/lib/features/vehicles/presentation/widgets/document_status_widget.dart
Notas/Consideraciones:

Document types: SOAT (seguro obligatorio), Tecnomecánica (revisión técnica), Revisión gases (emisiones), Póliza todo riesgo. Varían por país
File format: Aceptar PDF, JPG, PNG. Convertir imágenes a PDF para consistencia
OCR: Considerar extraer fecha de vencimiento automáticamente del PDF usando Cloud Vision API
Auto-renewal: Integrar con aseguradoras para renovación automática (SOAT online). Requiere partnerships
Notifications: Enviar email y WhatsApp además de alert en sistema para documentos críticos (SOAT)
History: Mantener historial de renovaciones en subcollection vehicle_documents_history para auditoría
Legal compliance: Documentos vencidos = vehículo no puede operar legalmente. Bloqueo es crítico para evitar multas

---

Título: US-059: Implementar dashboard de utilización de flota con métricas operativas

Descripción:

Resumen: Crear dashboard web mostrando métricas de utilización de vehículos: tiempo activo, tiempo inactivo, trips por vehículo, eficiencia operativa.
Detalle:
Calcular métricas: utilization rate, idle time, average trips/day, distance/day por vehículo
Mostrar gráficos comparativos entre vehículos
Identificar vehículos subutilizados o sobreutilizados
Exportar reporte de utilización a Excel
Alertas de baja utilización (<50% del promedio)
Recomendaciones de optimización de flota
Referencia: Ver Sección 4.6 (Fleet Utilization Analytics), Sprint 13-14
Criterios de aceptación (AC):

 AC1: FleetUtilizationPage muestra tabla con métricas por vehículo: utilization_rate, active_hours, idle_hours, trips_count, avg_distance
 AC2: Utilization rate calculado como: (active_hours / 24) * 100
 AC3: Gráfico de barras compara utilization_rate de todos los vehículos
 AC4: Vehículos con utilization <30% marcados con badge "Subutilizado"
 AC5: Botón "Exportar Excel" genera archivo con todas las métricas
Checklist técnica (Tareas):

 T1: Crear Cloud Function scheduled calculateFleetUtilization (cron: daily at 1am)
 T2: Para cada vehículo, query trips del día anterior
 T3: Calcular active_hours: sum(trip.duration_hours) where status=completed
 T4: Calcular idle_hours: 24 - active_hours
 T5: Calcular utilization_rate: (active_hours / 24) * 100
 T6: Guardar en colección fleet_utilization_daily: { date, vehicle_id, ...metrics }
 T7: Crear FleetUtilizationPage en web
 T8: Query fleet_utilization_daily para rango de fecha seleccionado
 T9: Mostrar DataTable con columnas: vehículo, utilización %, horas activas, horas inactivas, trips, distancia promedio
 T10: Implementar UtilizationChart (BarChart) comparando vehículos
 T11: Marcar vehículos con utilization <30% con badge "Subutilizado" (amarillo)
 T12: Botón "Exportar Excel" usa excel.js para generar archivo .xlsx
 T13: Implementar filtros: rango de fecha, tipo de vehículo
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:web componente:backend componente:analytics

Dependencias: US-053 (Analytics dashboard), US-025 (Trip completion)

Archivos/Carpetas relacionados:

/firebase/functions/src/scheduled/calculateFleetUtilization.ts
/web/lib/features/analytics/presentation/pages/fleet_utilization_page.dart
/web/lib/features/analytics/presentation/widgets/utilization_chart.dart
Notas/Consideraciones:

Business hours: Considerar horario laboral (ej. 6am-10pm) en vez de 24h para cálculo más realista
Weekends: Excluir fines de semana si flota no opera sábados/domingos. Hacer configurable
Underutilization: <30% puede indicar exceso de capacidad. Sugerir reducir flota o aumentar operaciones
Overutilization: >90% puede indicar falta de vehículos. Sugerir expansión de flota
Seasonality: Comparar utilización vs mismo período año anterior para detectar tendencias
Cost analysis: Correlacionar utilización con costos fijos (depreciación, seguros) para calcular costo/km real
Future: ML model para predecir utilización futura y optimizar asignaciones, what-if scenarios (¿qué pasa si agregamos 2 vehículos?)

---

Título: US-060: Implementar módulo de costos y TCO (Total Cost of Ownership)

Descripción:

Resumen: Gestionar y analizar costos operativos de vehículos incluyendo combustible, mantenimiento, seguros, depreciación para calcular TCO completo.
Detalle:
Registrar costos por categoría: fuel, maintenance, insurance, taxes, depreciation
Calcular cost per kilometer y cost per trip
Dashboard con breakdown de costos por vehículo y por flota
Tendencias de costos mensuales
Identificar vehículos con costos anormalmente altos
Proyección de costos futuros basado en tendencias
Referencia: Ver Sección 4.6 (Cost Analysis & TCO), Sprint 13-14
Criterios de aceptación (AC):

 AC1: Colección vehicle_costs creada con campos: id, vehicle_id, company_id, category, amount, date, notes
 AC2: Web permite registrar costos en VehicleCostsPage con form: vehículo, categoría, monto, fecha, notas
 AC3: Dashboard muestra métricas: total_cost_mtd, cost_per_km, cost_per_trip, cost_breakdown_by_category
 AC4: Gráfico de pie muestra distribución de costos por categoría
 AC5: Tabla compara cost_per_km entre vehículos, identificando outliers (>20% del promedio)
Checklist técnica (Tareas):

 T1: Crear interface VehicleCost en /firebase/functions/src/types/models.ts
 T2: Crear colección vehicle_costs con índices: vehicle_id, company_id, date
 T3: Crear VehicleCostsPage en web con tabla de costos registrados
 T4: Form para agregar costo: vehículo, categoría (dropdown: fuel, maintenance, insurance, taxes, depreciation, other), monto, fecha, notas
 T5: Crear Cloud Function scheduled calculateTCO (cron: monthly on 1st)
 T6: Función agrega costos del mes anterior por vehículo y categoría
 T7: Calcular cost_per_km: total_cost / total_distance_km
 T8: Calcular cost_per_trip: total_cost / total_trips
 T9: Guardar en colección tco_monthly: { month, vehicle_id, total_cost, cost_per_km, breakdown: {...} }
 T10: Crear TCODashboardPage mostrando cards: Total Costs MTD, Cost/km, Cost/trip
 T11: Implementar CostBreakdownChart (PieChart) con categorías
 T12: Tabla comparativa: vehículo, cost/km, variación vs promedio, badge si outlier
 T13: Implementar CostTrendChart (LineChart) mostrando evolución mensual
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:web componente:backend componente:analytics componente:finance

Dependencias: US-056 (Maintenance), US-025 (Trip completion)

Archivos/Carpetas relacionados:

/firebase/functions/src/scheduled/calculateTCO.ts
/web/lib/features/costs/presentation/pages/vehicle_costs_page.dart
/web/lib/features/costs/presentation/pages/tco_dashboard_page.dart
/web/lib/features/costs/presentation/widgets/cost_breakdown_chart.dart
Notas/Consideraciones:

Depreciation: Calcular depreciación lineal basada en valor inicial y vida útil (ej. 5 años). Requiere agregar campos a Vehicle model
Fuel costs: Puede integrarse con trips si conductor registra combustible. Alternativa: integrar con API de tarjetas de combustible
Currency: Almacenar en moneda local (COP, PEN, USD según país). Agregar campo currency en company document
Budget: Permitir definir presupuesto mensual por vehículo y alertar si excede
Benchmarking: Comparar cost/km con estándares de industria (ej. promedio Colombia: $500 COP/km)
Profitability: Si trips tienen revenue, calcular profit per trip (revenue - costs). Útil para flotas de delivery
Future: Integración con software contable (QuickBooks, Siigo), forecasting de costos con ML, optimización de rutas para minimizar costos

---

Título: US-061: Configurar TensorFlow Lite on-device para preparación ML features

Descripción:

Resumen: Integrar TensorFlow Lite en app móvil para ejecutar modelos de machine learning on-device, preparando infraestructura para detección avanzada de comportamiento.
Detalle:
Agregar dependencias tflite_flutter en Flutter
Configurar permisos y assets para modelos .tflite
Crear servicio base MLInferenceService
Implementar helper para preprocessing de datos (GPS, acelerómetro)
Probar con modelo simple de clasificación (driving behavior: safe/aggressive)
Documentar pipeline de entrenamiento de modelos
Referencia: Ver Sección 8.1 (ML/IA Features), Sección 7.2 FASE 3 → Sprint 17-18
Criterios de aceptación (AC):

 AC1: Dependencia tflite_flutter: ^0.10.0 agregada y configurada en pubspec.yaml
 AC2: Carpeta /assets/models/ creada para almacenar modelos .tflite
 AC3: MLInferenceService implementado con método runInference(inputData)
 AC4: Modelo simple driving_behavior.tflite cargado y ejecutando predicciones on-device
 AC5: Documentación creada en /docs/ml-pipeline.md explicando cómo entrenar y deployar modelos
Checklist técnica (Tareas):

 T1: Agregar tflite_flutter: ^0.10.0 en pubspec.yaml
 T2: Crear carpeta /assets/models/ y agregar a pubspec.yaml en assets
 T3: Configurar permisos Android: agregar tensorflow-lite en build.gradle
 T4: Configurar iOS: agregar framework TensorFlowLiteC en Podfile
 T5: Crear MLInferenceService en /lib/core/services/ml_inference_service.dart
 T6: Implementar loadModel(String modelPath) usando Interpreter.fromAsset()
 T7: Crear DataPreprocessor helper para normalizar datos GPS y acelerómetro
 T8: Entrenar modelo simple con scikit-learn/TensorFlow: clasificar driving (safe/aggressive) basado en aceleración
 T9: Convertir modelo a .tflite usando TFLiteConverter
 T10: Copiar driving_behavior.tflite a /assets/models/
 T11: Implementar runInference() que toma array de features y retorna predicción
 T12: Probar con datos reales de viaje y validar accuracy
 T13: Crear /docs/ml-pipeline.md documentando: dataset, training, conversion, deployment
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase3 componente:mobile componente:ml componente:ai

Dependencias: US-013 (GPS tracking), US-040 (Accelerometer)

Archivos/Carpetas relacionados:

/lib/core/services/ml_inference_service.dart
/lib/core/utils/data_preprocessor.dart
/assets/models/driving_behavior.tflite
/docs/ml-pipeline.md
/ml_training/ (scripts Python para entrenar modelos)
Notas/Consideraciones:

Model size: Mantener modelos <10MB para no inflar tamaño de app. Usar quantization (int8) para reducir tamaño 4x
On-device vs Cloud: On-device tiene latencia ~10ms vs Cloud ~500ms. Crítico para real-time feedback
Training data: Requiere dataset etiquetado. Usar datos históricos de trips con labels (safe/aggressive) basados en infracciones
Privacy: On-device ML = data nunca sale del dispositivo. Ventaja de privacidad vs enviar a Cloud
Performance: TFLite optimizado para móviles. Usar GPU delegation en devices compatibles para 5x speedup
Model versioning: Implementar hot-reload de modelos desde Firebase Storage para actualizar sin redeploy de app
Future: Modelos avanzados para predecir mantenimiento, optimizar rutas, detectar fraude (GPS spoofing), clasificar calidad de caminos

---

Título: US-062: Implementar detección avanzada de comportamiento de conducción con ML

Descripción:

Resumen: Usar modelo de ML para clasificar en tiempo real el estilo de conducción (safe, moderate, aggressive, reckless) basado en GPS, acelerómetro y contexto.
Detalle:
Entrenar modelo con features: aceleración, frenado, curvas, velocidad, jerk (cambio de aceleración)
Clasificar cada ventana de 30 segundos de conducción
Mostrar feedback en tiempo real al conductor
Almacenar clasificaciones en trip para scoring avanzado
Dashboard web muestra distribución de comportamiento por conductor
Alertas proactivas si detecta conducción reckless por >2 minutos
Referencia: Ver Sección 8.1 (Advanced Behavior Detection), Sprint 17-18
Criterios de aceptación (AC):

 AC1: Modelo ML clasifica driving behavior en 4 categorías: safe, moderate, aggressive, reckless
 AC2: Durante tracking, app analiza ventanas de 30s y muestra badge en UI: "Conducción: Segura" (verde)
 AC3: Clasificaciones almacenadas en trip: { behavior_timeline: [{timestamp, classification, confidence}] }
 AC4: Alert generado si detecta reckless driving por >2 minutos consecutivos
 AC5: Web dashboard muestra BehaviorDistributionChart por conductor (% safe, moderate, aggressive, reckless)
Checklist técnica (Tareas):

 T1: Crear dataset de entrenamiento: extraer features de route_points históricos
 T2: Features: avg_acceleration, max_acceleration, avg_jerk, harsh_brake_count, harsh_turn_count, speed_variance
 T3: Etiquetar datos: safe (score >80), moderate (60-80), aggressive (40-59), reckless (<40)
 T4: Entrenar modelo RandomForest o XGBoost con 80/20 train/test split
 T5: Evaluar accuracy, precision, recall. Target: accuracy >85%
 T6: Convertir modelo a TFLite y deployar en /assets/models/behavior_classifier.tflite
 T7: En TrackingService, crear buffer de 30 segundos de datos (GPS + acelerómetro)
 T8: Cada 30s, extraer features y ejecutar runInference()
 T9: Mostrar resultado en UI: badge con color (verde/amarillo/naranja/rojo) y texto
 T10: Guardar clasificación en array behavior_timeline en trip document
 T11: Si classification = "reckless" por >2 min, generar alert tipo reckless_driving
 T12: Crear BehaviorDistributionChart en web (pie chart) con breakdown por conductor
 T13: Probar con viajes reales y validar clasificaciones vs realidad
Estimación: 21 SP / 34h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase3 componente:mobile componente:backend componente:ml componente:analytics

Dependencias: US-061 (TFLite setup), US-051 (Driver scoring)

Archivos/Carpetas relacionados:

/ml_training/behavior_classifier/train_model.py
/assets/models/behavior_classifier.tflite
/lib/features/tracking/data/services/behavior_analysis_service.dart
/web/lib/features/analytics/presentation/widgets/behavior_distribution_chart.dart
Notas/Consideraciones:

Feature engineering: Jerk (derivada de aceleración) es muy indicativo de conducción agresiva. Calcular como delta_acceleration / delta_time
Labeling: Usar driver_score existente como proxy para etiquetar datos. Validar con supervisores para mejorar labels
Model accuracy: 85% es baseline. Iterar con más features (hora del día, tipo de vía, condiciones climáticas)
Real-time feedback: Mostrar badge en pantalla motivando al conductor a mejorar. "¡Vas muy bien! Conducción Segura"
Gamification: Integrar con badges. "Semana de conducción segura" badge si 100% safe classification en 7 días
Context awareness: Modelo debe considerar contexto: aceleración alta en autopista es normal, en zona escolar es reckless
Future: Detección de drowsiness (somnolencia) usando patrones de aceleración irregular, detección de uso de celular, coaching proactivo

---

Título: US-063: Implementar predicción de mantenimiento con machine learning

Descripción:

Resumen: Usar ML para predecir cuándo vehículo necesitará mantenimiento basado en patrones históricos, uso, y sensores.
Detalle:
Entrenar modelo de regresión para predecir km hasta próximo mantenimiento
Features: km acumulados, días desde último mantenimiento, harsh events, tipo de vía
Generar alertas proactivas 1 semana antes de mantenimiento predicho
Dashboard web muestra predicciones por vehículo
Optimizar calendario de mantenimiento para minimizar downtime
Detectar anomalías que indican problema mecánico inminente
Referencia: Ver Sección 8.1 (Predictive Maintenance), Sprint 17-18
Criterios de aceptación (AC):

 AC1: Modelo ML predice km_until_maintenance con error <10%
 AC2: Cloud Function scheduled runMaintenancePrediction ejecuta predicciones semanalmente
 AC3: Predicciones almacenadas en maintenance_predictions collection
 AC4: Alert generado si predicción indica mantenimiento en <7 días
 AC5: Web muestra MaintenancePredictionsPage con tabla: vehículo, tipo mantenimiento, km predichos, fecha estimada
Checklist técnica (Tareas):

 T1: Crear dataset de entrenamiento desde maintenance_records históricos
 T2: Features: current_km, days_since_last_maintenance, total_harsh_brakes, total_harsh_acceleration, avg_speed, road_type_distribution
 T3: Target: km_until_next_maintenance (calcular desde historical data)
 T4: Entrenar modelo de regresión (RandomForest Regressor o Gradient Boosting)
 T5: Evaluar con RMSE, MAE. Target: MAE <500 km
 T6: Guardar modelo como .pkl y deployar en Cloud Function (Python runtime)
 T7: Crear Cloud Function scheduled runMaintenancePrediction (cron: weekly on Sunday)
 T8: Función carga modelo, query vehicles y extrae features
 T9: Ejecutar predicción para cada vehículo: predicted_km_until_maintenance
 T10: Calcular estimated_date basado en avg_km_per_day
 T11: Guardar en maintenance_predictions collection
 T12: Si predicted_km < 500 o estimated_date < 7 days, generar alert tipo predictive_maintenance
 T13: Crear MaintenancePredictionsPage en web mostrando predicciones con filtros
Estimación: 21 SP / 34h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:Fase3 componente:backend componente:ml componente:maintenance

Dependencias: US-056 (Maintenance module), US-061 (ML setup)

Archivos/Carpetas relacionados:

/ml_training/predictive_maintenance/train_model.py
/firebase/functions/src/scheduled/runMaintenancePrediction.py
/web/lib/features/maintenance/presentation/pages/maintenance_predictions_page.dart
Notas/Consideraciones:

Python runtime: Cloud Functions soporta Python 3.11. Usar scikit-learn, pandas, numpy
Model retraining: Retrain modelo mensualmente con nuevos datos para mejorar accuracy. Automatizar con Cloud Scheduler
Feature importance: Analizar qué features son más predictivas. Típicamente: km_since_last, harsh_events, vehicle_age
Anomaly detection: Si predicción indica mantenimiento mucho antes de lo esperado, puede ser señal de problema. Alert con severity=high
Cost savings: Mantenimiento predictivo reduce downtime 30-50% vs mantenimiento reactivo. ROI alto
Vehicle-specific models: Considerar entrenar modelos específicos por tipo de vehículo (camión vs sedan tienen patrones diferentes)
Future: Integrar sensores IoT (OBD-II) para datos de motor, temperatura, presión. Mejora accuracy significativamente

---

Título: US-064: Implementar optimización inteligente de rutas con ML

Descripción:

Resumen: Usar machine learning para sugerir rutas óptimas considerando histórico de tráfico, condiciones de vía, y patrones de la flota.
Detalle:
Entrenar modelo que aprende patrones de duración de rutas
Predecir ETA (tiempo estimado de arribo) más preciso que Google Maps
Sugerir mejor hora de salida para evitar tráfico
Identificar rutas alternativas basadas en experiencia de flota
Integrar con Mapbox Directions API para routing
Aprendizaje continuo: mejora predicciones con cada trip completado
Referencia: Ver Sección 8.1 (Intelligent Routing), Sprint 19-20
Criterios de aceptación (AC):

 AC1: Al crear trip, sistema sugiere mejor ruta basado en ML predictions
 AC2: ETA predicho tiene accuracy >90% comparado con tiempo real
 AC3: Sistema sugiere mejor hora de salida si trip es flexible: "Salir a las 7am ahorrará 15 minutos"
 AC4: App muestra 3 rutas alternativas con ETA y score de cada una
 AC5: Después de trip, modelo se actualiza con data real para aprendizaje continuo
Checklist técnica (Tareas):

 T1: Crear dataset de trips históricos con features: origin, destination, departure_time, day_of_week, actual_duration
 T2: Entrenar modelo de regresión para predecir duration basado en features
 T3: Features adicionales: historical_avg_duration, traffic_pattern (peak/off-peak), weather_condition
 T4: Deployar modelo en Cloud Function: predictRouteDuration
 T5: Al crear trip en mobile, llamar Cloud Function con origin/destination
 T6: Función ejecuta predicción y retorna estimated_duration, suggested_departure_time
 T7: Integrar Mapbox Directions API para obtener 3 rutas alternativas
 T8: Para cada ruta, ejecutar ML prediction de duration
 T9: Calcular route_score considerando: duration, distance, historical_safety (harsh events en esa ruta)
 T10: Mostrar RouteSelectionScreen en mobile con mapa y 3 opciones
 T11: Usuario selecciona ruta, trip se crea con selected_route
 T12: Al completar trip, enviar feedback al modelo: predicted_duration vs actual_duration
 T13: Implementar online learning: actualizar modelo cada 1000 trips
Estimación: 21 SP / 34h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:Fase3 componente:mobile componente:backend componente:ml componente:routing

Dependencias: US-061 (ML setup), US-021 (Trip creation)

Archivos/Carpetas relacionados:

/ml_training/route_optimization/train_model.py
/firebase/functions/src/http/predictRouteDuration.ts
/lib/features/trips/presentation/screens/route_selection_screen.dart
Notas/Consideraciones:

Mapbox Directions API: Tiene límite de 100,000 requests/mes en free tier. Considerar caching de rutas frecuentes
ETA accuracy: Google Maps ETA tiene accuracy ~80-85%. Target es >90% usando data histórica propia
Traffic patterns: Patterns varían por ciudad. Modelo debe ser city-specific o tener city como feature
Weather: Lluvia puede aumentar duration 20-30%. Integrar Weather API (OpenWeather) como feature
Cost optimization: Considerar fuel cost además de time. Ruta más larga puede ser más barata si evita peajes
Dynamic routing: En Fase futura, actualizar ruta en tiempo real si tráfico cambia durante trip
Future: Multi-stop optimization (Traveling Salesman Problem), load balancing entre vehículos, integration con dispatching systems

---

Título: US-065: Crear API marketplace para integraciones de terceros

Descripción:

Resumen: Desarrollar API REST pública y sistema de API keys para permitir integraciones con sistemas de terceros (ERP, WMS, TMS, etc).
Detalle:
Crear endpoints REST para acceso a trips, vehicles, drivers, alerts
Implementar autenticación con API keys
Rate limiting por cliente (1000 requests/hour)
Documentación OpenAPI/Swagger
Portal de desarrolladores para gestionar API keys
Webhooks para eventos en tiempo real
Monitoreo de uso y analytics por cliente
Referencia: Ver Sección 8.2 (API Marketplace), Sprint 21-22
Criterios de aceptación (AC):

 AC1: API REST disponible en https://api.smartfleet.com con endpoints: /trips, /vehicles, /drivers, /alerts
 AC2: Autenticación via header: Authorization: Bearer {api_key}
 AC3: Rate limiting: 1000 requests/hour por API key, retorna 429 Too Many Requests si excede
 AC4: Documentación OpenAPI completa en https://api.smartfleet.com/docs
 AC5: Portal de desarrolladores permite crear/revocar API keys desde web dashboard
Checklist técnica (Tareas):

 T1: Crear Cloud Functions HTTP para endpoints REST: getTrips, getVehicles, getDrivers, getAlerts
 T2: Implementar middleware de autenticación que valida API key contra collection api_keys
 T3: Crear colección api_keys: { key, company_id, name, created_by, rate_limit, active, created_at }
 T4: Implementar rate limiting usando Firestore: track request count por key en ventana de 1 hora
 T5: Si excede límite, retornar 429 con header Retry-After
 T6: Crear OpenAPI spec (swagger.yaml) documentando todos los endpoints
 T7: Deployar Swagger UI en Firebase Hosting: https://api.smartfleet.com/docs
 T8: Crear APIKeysPage en web dashboard donde admin puede generar nuevas keys
 T9: Generar API key con crypto.randomBytes(32).toString('hex')
 T10: Implementar revocar key: actualizar active: false
 T11: Crear APIUsageAnalyticsPage mostrando requests por endpoint, por key, errores
 T12: Implementar CORS headers para permitir requests desde dominios autorizados
 T13: Probar con Postman haciendo requests a todos los endpoints
Estimación: 21 SP / 34h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:Fase3 componente:backend componente:api componente:integration

Dependencias: US-001 (Firebase setup), US-025 (Trips), US-044 (Alerts)

Archivos/Carpetas relacionados:

/firebase/functions/src/api/v1/trips.ts
/firebase/functions/src/api/v1/vehicles.ts
/firebase/functions/src/middleware/apiKeyAuth.ts
/firebase/functions/src/middleware/rateLimiter.ts
/docs/api/swagger.yaml
/web/lib/features/api/presentation/pages/api_keys_page.dart
Notas/Consideraciones:

Versioning: Usar /api/v1/ en URLs para permitir breaking changes en futuras versiones
Security: API keys son sensibles. Mostrar solo una vez al crear, después mostrar solo últimos 4 chars (sk_...abc123)
Rate limits: 1000/hour es baseline. Permitir customizar por cliente (enterprise clients pueden necesitar más)
Webhooks: Implementar en Fase futura. Clientes registran URL callback, sistema envía POST cuando evento ocurre
Pagination: Endpoints deben soportar pagination: ?page=1&limit=100 para manejar datasets grandes
Authentication: Considerar OAuth 2.0 para integraciones más sofisticadas en futuro
Monetization: API puede ser fuente de revenue. Considerar tiered pricing (free: 1k/hour, pro: 10k/hour, enterprise: unlimited)
Future: GraphQL API para queries más flexibles, SDK en múltiples lenguajes (Python, JavaScript, Java), partner program

---

Título: US-066: Implementar sistema multi-tenant con aislamiento completo de datos

Descripción:

Resumen: Reforzar aislamiento de datos entre empresas (tenants) con validaciones en backend, security rules Firestore, y auditoría de accesos.
Detalle:
Implementar Firestore Security Rules estrictas basadas en company_id
Cloud Functions validan company_id en todos los requests
Índices compuestos optimizados para queries multi-tenant
Auditoría de accesos: log de quién accede qué datos
Prevenir data leakage entre companies
Testing exhaustivo de aislamiento
Referencia: Ver Sección 3.5 (Multi-tenant Security), transversal a todas las fases
Criterios de aceptación (AC):

 AC1: Firestore Security Rules validan que user.company_id == resource.data.company_id en todos los reads/writes
 AC2: Cloud Functions incluyen middleware validateCompanyAccess que rechaza requests cross-company
 AC3: Índices compuestos incluyen company_id como primer campo en todas las colecciones
 AC4: Colección access_logs registra todos los accesos con: user_id, company_id, resource, action, timestamp
 AC5: Tests de seguridad validan que user de company A no puede acceder datos de company B
Checklist técnica (Tareas):

 T1: Crear firestore.rules completo con validación company_id en todas las colecciones
 T2: Regla base: allow read, write: if request.auth != null && request.auth.token.company_id == resource.data.company_id
 T3: Crear middleware validateCompanyAccess en Cloud Functions
 T4: Middleware extrae company_id del token JWT y valida contra request params
 T5: Revisar todos los índices en firestore.indexes.json: agregar company_id como primer campo
 T6: Crear colección access_logs para auditoría
 T7: Implementar trigger onDocumentRead (via Cloud Functions) que registra en access_logs
 T8: Crear test suite: intentar acceder datos cross-company, validar que falla
 T9: Test con user de company A intentando leer trips de company B
 T10: Test con admin intentando modificar company_id de documento existente
 T11: Crear SecurityAuditPage en web mostrando access logs con filtros
 T12: Implementar alert si detecta intento de acceso no autorizado (suspicious activity)
 T13: Documentar security model en /docs/security-architecture.md
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:security fase:transversal componente:backend componente:database componente:compliance

Dependencias: US-002 (Firestore collections), US-007 (Auth)

Archivos/Carpetas relacionados:

/firebase/firestore.rules
/firebase/functions/src/middleware/validateCompanyAccess.ts
/firebase/firestore.indexes.json
/web/lib/features/security/presentation/pages/security_audit_page.dart
/docs/security-architecture.md
Notas/Consideraciones:

Defense in depth: Security rules son primera línea. Cloud Functions son segunda. Ambas deben validar
Custom claims: Almacenar company_id en JWT custom claims para acceso rápido sin query a Firestore
Performance: Índices con company_id como primer campo permiten queries eficientes sin full collection scan
GDPR compliance: Access logs son requeridos para compliance. Retention de 1 año mínimo
Shared resources: Algunos recursos pueden ser shared (ej. geocercas públicas). Manejar con company_id = null
Super admin: Considerar rol super_admin que puede acceder múltiples companies para soporte técnico
Testing: CRÍTICO. Data leakage puede tener consecuencias legales graves. Testing exhaustivo pre-launch

---

Título: US-067: Implementar backup automático y disaster recovery

Descripción:

Resumen: Configurar backups automáticos de Firestore, Cloud Storage y configuraciones críticas con procedimientos de recuperación ante desastres.
Detalle:
Backups diarios automáticos de Firestore a Cloud Storage
Backups incrementales para optimizar costos
Procedimiento de restore documentado y probado
Retention policy: 30 días daily, 12 meses monthly
Point-in-time recovery para datos críticos
Testing de restore cada trimestre
Monitoreo de backups con alertas si falla
Referencia: Ver Sección 9 (Deployment & Operations), transversal
Criterios de aceptación (AC):

 AC1: Cloud Scheduler ejecuta backup diario de Firestore a las 2am UTC
 AC2: Backups almacenados en bucket gs://smartfleet-backups/{date}/
 AC3: Retention policy configurada: 30 días de backups diarios, 12 meses de backups mensuales
 AC4: Procedimiento de restore documentado en /docs/disaster-recovery.md con paso a paso
 AC5: Alert enviado a admin si backup falla 2 días consecutivos
Checklist técnica (Tareas):

 T1: Habilitar Firestore Managed Export/Import API
 T2: Crear bucket gs://smartfleet-backups en Cloud Storage con lifecycle rules
 T3: Lifecycle rule 1: delete files older than 30 days (daily backups)
 T4: Lifecycle rule 2: transition to Coldline storage after 90 days (monthly backups)
 T5: Crear Cloud Function scheduled firestoreBackup (cron: daily at 2am UTC)
 T6: Función ejecuta gcloud firestore export gs://smartfleet-backups/{YYYY-MM-DD}/
 T7: Backup incluye todas las colecciones excepto access_logs (demasiado voluminoso)
 T8: Guardar metadata del backup en collection backup_history: { date, size_gb, duration_seconds, status }
 T9: Si backup falla, increment fail_count. Si fail_count >= 2, enviar alert critical a admin
 T10: Crear script restore_firestore.sh que importa backup: gcloud firestore import gs://...
 T11: Documentar en /docs/disaster-recovery.md: scenarios, RPO/RTO, step-by-step restore
 T12: Programar quarterly backup drill: realizar restore a proyecto test y validar data
 T13: Crear BackupMonitoringPage en web mostrando historial de backups con status
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:devops fase:transversal componente:backend componente:database componente:operations

Dependencias: US-001 (Firebase setup)

Archivos/Carpetas relacionados:

/firebase/functions/src/scheduled/firestoreBackup.ts
/scripts/restore_firestore.sh
/docs/disaster-recovery.md
/web/lib/features/admin/presentation/pages/backup_monitoring_page.dart
Notas/Consideraciones:

Cost: Firestore exports son gratis. Cloud Storage cobra ~$0.02/GB/mes. Backup de 100GB = $2/mes. Coldline = $0.004/GB/mes
RPO/RTO: Recovery Point Objective = 24 hours (daily backup). Recovery Time Objective = 2 hours (tiempo para restore)
Testing: Backups no testeados = no backups. IMPERATIVO probar restore cada trimestre
Incremental: Firestore no soporta incremental backups nativamente. Considerar export solo colecciones modificadas
Critical data: Priorizar restore de companies, users, vehicles, trips. Alerts y logs pueden ser secundarios
Encryption: Backups en Cloud Storage están encrypted at rest por default. Considerar customer-managed keys (CMEK) para compliance
Alternative: Considerar replicación cross-region de Firestore en vez de backups (mayor costo pero RTO/RPO mejor)

---

Título: US-068: Implementar monitoreo y observability con logs y métricas

Descripción:

Resumen: Configurar logging estructurado, métricas de performance, y dashboards de monitoreo para detectar problemas proactivamente.
Detalle:
Logging estructurado en Cloud Functions con niveles (debug, info, warn, error)
Métricas custom en Cloud Monitoring: latency, error rate, throughput
Dashboards en Google Cloud Console con alertas
Tracing distribuido para debugging de requests lentos
Error tracking con notificaciones a Slack/email
SLO (Service Level Objectives) definidos y monitoreados
Referencia: Ver Sección 9 (Operations & Monitoring), transversal
Criterios de aceptación (AC):

 AC1: Cloud Functions logean eventos importantes con winston logger estructurado
 AC2: Métricas custom registradas: api_request_duration, trip_creation_count, alert_generation_rate
 AC3: Dashboard en Cloud Monitoring muestra: request latency p50/p95/p99, error rate, active trips
 AC4: Alertas configuradas: error_rate >5%, api_latency_p95 >2s, backup_failure
 AC5: Logs de errores enviados a Slack channel #smartfleet-alerts en tiempo real
Checklist técnica (Tareas):

 T1: Instalar winston logger en Cloud Functions: npm install winston
 T2: Configurar structured logging: logger.info('trip_created', { trip_id, user_id, company_id })
 T3: Usar niveles apropiados: debug (development), info (events), warn (degraded), error (failures)
 T4: Implementar custom metrics usando Cloud Monitoring API
 T5: Registrar métrica api_request_duration en cada endpoint
 T6: Registrar métrica trip_creation_count en onTripCreated
 T7: Crear dashboard en Cloud Console: Monitoring → Dashboards → Create Dashboard
 T8: Agregar charts: Line chart (latency over time), Gauge (active trips), Table (error count by function)
 T9: Configurar alerting policies: Cloud Monitoring → Alerting → Create Policy
 T10: Alert 1: error_rate >5% por 5 minutos → notify email + Slack
 T11: Alert 2: api_latency_p95 >2s por 10 minutos → notify email
 T12: Integrar Slack: crear Incoming Webhook, configurar en Cloud Functions
 T13: Implementar error handler global que envía errors críticos a Slack
 T14: Definir SLOs: 99.5% uptime, p95 latency <1s, error rate <1%
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:devops fase:transversal componente:backend componente:monitoring componente:operations

Dependencias: US-001 (Firebase setup)

Archivos/Carpetas relacionados:

/firebase/functions/src/utils/logger.ts
/firebase/functions/src/middleware/metricsMiddleware.ts
/firebase/functions/src/integrations/slackNotifier.ts
/docs/monitoring-guide.md
Notas/Consideraciones:

Structured logging: Usar JSON format para fácil parsing. Incluir siempre: timestamp, level, message, context (user_id, company_id)
Log levels: debug = desarrollo, info = eventos normales, warn = problemas no críticos, error = failures, critical = sistema down
Sampling: En producción, logear todos los errors pero sample info logs (10%) para reducir volumen
Metrics cardinality: Evitar labels con alta cardinalidad (ej. user_id). Usar company_id, endpoint_name
Alerting fatigue: Configurar thresholds realistas. Alertas demasiado sensibles = ruido, equipo las ignora
On-call: Definir rotación on-call. Alertas críticas van a on-call engineer via PagerDuty/OpsGenie
Cost: Cloud Logging cobra después de 50GB/mes. Monitorear usage y ajustar retention (default 30 días, reducir a 7 días si necesario)

---

Título: US-069: Implementar CI/CD pipeline con GitHub Actions

Descripción:

Resumen: Automatizar testing, building y deployment con GitHub Actions para mobile (iOS/Android), web y Cloud Functions.
Detalle:
Pipeline de CI: tests automáticos en cada PR
Pipeline de CD: deploy a staging en merge a develop, production en merge a main
Build automático de apps móviles (APK, IPA)
Deploy de Cloud Functions y Firestore rules
Environments separados (dev, staging, production)
Rollback automático si deployment falla
Notificaciones de deployment en Slack
Referencia: Ver Sección 9 (CI/CD Pipeline), Sprint 1-2 (inicial), refinado transversal
Criterios de aceptación (AC):

 AC1: GitHub Actions workflow ejecuta tests en cada PR: flutter test, npm test (functions)
 AC2: Merge a branch develop dispara deploy automático a ambiente staging
 AC3: Merge a branch main dispara deploy automático a ambiente production
 AC4: APK generado automáticamente y subido a Firebase App Distribution en cada deploy
 AC5: Notificación en Slack cuando deployment completa exitosamente o falla
Checklist técnica (Tareas):

 T1: Crear archivo .github/workflows/ci.yml para continuous integration
 T2: Job 1 (test-mobile): checkout code, setup Flutter, run flutter test
 T3: Job 2 (test-functions): checkout code, setup Node.js, run npm test
 T4: Job 3 (lint): run flutter analyze, eslint
 T5: Crear archivo .github/workflows/cd-staging.yml (trigger: push to develop)
 T6: Deploy Cloud Functions: firebase deploy --only functions --project smartfleet-staging
 T7: Deploy Firestore rules: firebase deploy --only firestore:rules,firestore:indexes
 T8: Build APK: flutter build apk --release --flavor staging
 T9: Upload a Firebase App Distribution: firebase appdistribution:distribute --app $ANDROID_APP_ID
 T10: Crear .github/workflows/cd-production.yml (trigger: push to main)
 T11: Identical steps pero con --project smartfleet-prod y flavor production
 T12: Implementar rollback: si deploy falla, ejecutar firebase functions:config:set de versión anterior
 T13: Integrar Slack notifications: usar action slackapi/slack-github-action
 T14: Configurar GitHub Secrets: FIREBASE_TOKEN, SLACK_WEBHOOK_URL
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:devops fase:transversal componente:ci-cd componente:automation

Dependencias: US-001 (Firebase setup), US-003 (Flutter setup)

Archivos/Carpetas relacionados:

/.github/workflows/ci.yml
/.github/workflows/cd-staging.yml
/.github/workflows/cd-production.yml
/docs/ci-cd-guide.md
Notas/Consideraciones:

GitHub Actions: Free tier = 2000 minutos/mes. Mobile builds consumen ~10 min. Monitorear usage
Firebase token: Generar con firebase login:ci y almacenar en GitHub Secrets. Rotar cada 3 meses
Flavors: Flutter flavors permiten múltiples ambientes en misma codebase. Configurar en build.gradle y Info.plist
App Distribution: Permite QA testing pre-release. Distribuir a testers internos antes de Play Store/App Store
Versioning: Auto-increment build number usando GitHub run number: flutter build apk --build-number $GITHUB_RUN_NUMBER
Rollback: Mantener últimas 3 versiones deployadas. Si falla, rollback a versión anterior automáticamente
Future: Deploy a Play Store/App Store automático (requiere fastlane), blue-green deployments, canary releases

---

Título: US-070: Implementar performance optimization y caching strategies

Descripción:

Resumen: Optimizar performance de app móvil y web con caching inteligente, lazy loading, y reducción de queries a Firestore.
Detalle:
Implementar caching en memoria con Riverpod StateNotifier
Caching persistente con Hive para datos frecuentes
Lazy loading de listas largas con pagination
Optimizar queries Firestore: usar limits, indexes, composite queries
Image caching con cached_network_image
Precaching de datos críticos al login
Métricas de performance en Firebase Performance Monitoring
Referencia: Ver Sección 9 (Performance Optimization), transversal
Criterios de aceptación (AC):

 AC1: Listas largas (trips, vehicles) usan pagination: load 20 items, lazy load más al scroll
 AC2: Datos estáticos (vehicles, drivers) cacheados en Hive por 1 hora
 AC3: Queries Firestore optimizados: incluyen .limit() y usan índices compuestos
 AC4: Firebase Performance Monitoring reporta: app startup time <2s, screen render <100ms
 AC5: Reducción de 50% en Firestore reads comparado con baseline (medido con Firebase Usage)
Checklist técnica (Tareas):

 T1: Implementar pagination en TripsListPage: query.limit(20), load more button
 T2: Usar firestore_ui package para infinite scroll automático
 T3: Crear CacheService con Hive para almacenar vehicles, drivers, geofences
 T4: Implementar cache expiration: almacenar timestamp, invalidar si >1 hora
 T5: En login, precargar datos críticos: vehicles, drivers, company config
 T6: Optimizar queries: agregar .limit(100) a queries sin pagination
 T7: Usar cached_network_image para avatars y fotos de vehículos
 T8: Implementar StateNotifier con caching: mantener data en memoria mientras app activa
 T9: Agregar índices faltantes: verificar warnings en Firestore Console y crear índices
 T10: Habilitar Firebase Performance Monitoring en app
 T11: Crear custom traces para screens críticos: TripCreationScreen, TrackingScreen
 T12: Medir baseline: Firestore reads/día. Target: reducir 50% después de optimizaciones
 T13: Probar con app en modo release (debug mode es más lento)
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:optimization fase:transversal componente:mobile componente:web componente:performance

Dependencias: US-007 (Mobile auth), US-020 (Web dashboard)

Archivos/Carpetas relacionados:

/lib/core/services/cache_service.dart
/lib/features/trips/presentation/pages/trips_list_page.dart
/lib/core/utils/performance_monitor.dart
Notas/Consideraciones:

Firestore pricing: Cobra por read, write, delete. Cada query cuenta reads = documents returned. Caching reduce costos significativamente
Cache invalidation: "There are only two hard things in Computer Science: cache invalidation and naming things". Implementar estrategia clara
Memory leaks: Caching en memoria puede causar leaks. Usar WeakReference o limitar cache size (LRU eviction)
Pagination: UX importante. Mostrar shimmer/skeleton mientras carga, mensaje "No hay más datos"
Images: cached_network_image almacena en disco. Configurar maxCacheSize para evitar llenar storage
Performance Monitoring: Firebase PM es gratis. Usarlo extensivamente. Detectar regressions antes de afectar usuarios
Future: Implement service worker para web (PWA), prefetching de rutas predictivas, optimistic UI updates

---

Título: US-071: Implementar onboarding flow para nuevos usuarios y primera configuración

Descripción:

Resumen: Crear experiencia guiada de onboarding para nuevos usuarios que configure empresa, primer vehículo, primer conductor y tutorial de funcionalidades principales.
Detalle:
Wizard de setup inicial para administradores nuevos
Pantallas de bienvenida con features principales
Tutorial interactivo de creación de primer viaje
Configuración inicial de empresa: nombre, logo, límites de velocidad
Skippable pero con opción de reactivar desde settings
Tracking de completion para analytics
Referencia: Ver Sección 10 (User Experience), transversal
Criterios de aceptación (AC):

 AC1: Al primer login de admin, muestra OnboardingWizard con 5 pasos: Bienvenida, Config Empresa, Agregar Vehículo, Agregar Conductor, Tutorial
 AC2: Wizard puede saltarse en cualquier momento (botón "Skip"), pero marca onboarding_completed: false
 AC3: User document almacena onboarding_completed y onboarding_step para resumir después
 AC4: Tutorial interactivo muestra overlay con hints: "Aquí creas un viaje", "Aquí ves el mapa en tiempo real"
 AC5: Opción "Ver tutorial" disponible en Settings para reactivar onboarding
Checklist técnica (Tareas):

 T1: Crear OnboardingWizardScreen en mobile y web
 T2: Paso 1 (Welcome): Carousel con 3 slides explicando features: Tracking GPS, Alertas, Reportes
 T3: Paso 2 (Company Setup): Form para company name, upload logo, speed_limit_kmh
 T4: Paso 3 (Add Vehicle): Form simplificado para agregar primer vehículo (plate, model)
 T5: Paso 4 (Add Driver): Form para agregar primer conductor (email, name, phone)
 T6: Paso 5 (Interactive Tutorial): Overlay con showcase_view package mostrando features principales
 T7: Botón "Skip" en cada paso que cierra wizard y marca onboarding_completed: false
 T8: Al completar último paso, marcar onboarding_completed: true en user document
 T9: Guardar onboarding_step actual para poder resumir si usuario sale
 T10: En Settings, agregar botón "Repetir tutorial" que re-inicia wizard
 T11: Implementar analytics: track completion rate, step abandonment
 T12: Crear WelcomeBackScreen que muestra si onboarding_completed: false
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:transversal componente:mobile componente:web componente:ux

Dependencias: US-007 (Mobile auth), US-010 (Web auth)

Archivos/Carpetas relacionados:

/lib/features/onboarding/presentation/screens/onboarding_wizard_screen.dart
/web/lib/features/onboarding/presentation/pages/onboarding_wizard_page.dart
/lib/core/widgets/tutorial_overlay.dart
Notas/Consideraciones:

First impressions: Onboarding es crítico para retention. 40% de usuarios abandonan si onboarding es confuso
Progressive disclosure: No abrumar con todas las features. Mostrar solo lo esencial en onboarding
Skip option: Algunos usuarios quieren explorar por su cuenta. Hacer skip fácil pero no demasiado obvio
Analytics: Medir completion rate. Si <60%, onboarding necesita mejoras
Localization: Preparar textos para múltiples idiomas (español, inglés, portugués)
Video tutorial: Considerar video de 2 minutos en vez de texto. Engagement mucho mayor
Future: Personalized onboarding basado en rol (admin ve features diferentes que conductor), gamification (badges por completar onboarding)

---

Título: US-072: Implementar sistema de notificaciones in-app mejorado con action buttons

Descripción:

Resumen: Mejorar sistema de notificaciones con acciones rápidas (approve, dismiss, view details) directamente desde notificación sin abrir app.
Detalle:
Action buttons en notificaciones push (Android/iOS)
Acciones: "Aprobar inspección", "Ver alerta", "Llamar conductor"
Manejo de acciones en background con Cloud Functions
Deep linking automático al hacer tap en notificación
Notificaciones agrupadas por tipo para evitar spam
Configuración de sonidos personalizados por severidad
Referencia: Ver Sección 4.4 (Advanced Notifications), Sprint 9-10 mejorado
Criterios de aceptación (AC):

 AC1: Notificaciones de inspección PESV incluyen botones: "Aprobar" y "Ver detalles"
 AC2: Notificaciones de alertas incluyen botones: "Acknowledged" y "Ver en mapa"
 AC3: Al presionar "Aprobar" en notificación, ejecuta acción sin abrir app
 AC4: Notificaciones agrupadas: si >3 alerts del mismo tipo en 5 minutos, mostrar "3 alertas de speeding"
 AC5: Severidad critical usa sonido urgente, high usa sonido normal, medium/low usa vibración solo
Checklist técnica (Tareas):

 T1: Configurar FCM notification con actions en payload: { actions: [{ action: 'approve', title: 'Aprobar' }] }
 T2: En Android, configurar NotificationChannel con action buttons
 T3: En iOS, configurar UNNotificationCategory con actions
 T4: Implementar BroadcastReceiver (Android) para manejar action clicks
 T5: Implementar UNUserNotificationCenterDelegate (iOS) para manejar action clicks
 T6: Al recibir action, ejecutar Cloud Function: approveInspection, acknowledgeAlert
 T7: Implementar notification grouping: usar group_id en FCM payload
 T8: Si >3 notificaciones mismo group_id en 5 min, mostrar summary notification
 T9: Configurar custom sounds: copiar .wav files a android/app/src/main/res/raw/
 T10: Mapear severity a sound: critical=urgent.wav, high=default, medium/low=silent+vibrate
 T11: Implementar deep linking: notification data incluye route y params
 T12: Al tap, navegar a route usando go_router: /trips/:id, /alerts/:id
 T13: Probar en dispositivos reales: action buttons, grouping, sounds
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:mobile componente:notifications componente:ux

Dependencias: US-044 (Sistema de alertas), US-049 (Notificaciones in-app)

Archivos/Carpetas relacionados:

/lib/core/services/notification_handler_service.dart
/android/app/src/main/kotlin/com/softwaretotal/totaltracking/NotificationActionReceiver.kt
/ios/Runner/NotificationService.swift
/android/app/src/main/res/raw/ (sound files)
Notas/Consideraciones:

Action buttons: Android soporta hasta 3 buttons, iOS hasta 4. Priorizar acciones más comunes
Background execution: Actions ejecutan en background. Limitar a operaciones simples (<10s)
Battery: Action buttons pueden aumentar battery drain si usuario interactúa frecuentemente
UX: Mostrar feedback visual inmediato al presionar action: "Inspección aprobada ✓"
Permissions: iOS requiere explicit permission para notification actions. Solicitar en onboarding
Accessibility: Action buttons deben tener labels descriptivos para screen readers
Future: Rich notifications con imágenes (foto del vehículo en alert), progress tracking (trip completion %), inline reply (responder a notificación con texto)

---

Título: US-073: Implementar sistema de roles y permisos granular (RBAC)

Descripción:

Resumen: Expandir sistema de roles actual con permisos granulares que permiten control fino de qué usuarios pueden ver/editar recursos específicos.
Detalle:
Roles predefinidos: super_admin, admin, supervisor, dispatcher, driver, viewer
Permisos granulares: trips.create, trips.view, trips.edit, alerts.acknowledge, etc.
Configuración de permisos por rol en web dashboard
Validación de permisos en backend (Cloud Functions)
Firestore Security Rules basadas en permisos
UI adaptativa que oculta features sin permiso
Referencia: Ver Sección 3.6 (RBAC), transversal
Criterios de aceptación (AC):

 AC1: Collection roles creada con permisos predefinidos para cada rol
 AC2: User document incluye array permissions derivado de su role
 AC3: Cloud Functions validan permisos antes de ejecutar acciones: requirePermission('trips.create')
 AC4: UI oculta botones/pantallas si usuario no tiene permiso (ej. "Crear viaje" solo visible si tiene trips.create)
 AC5: RolesManagementPage en web permite admin customizar permisos de cada rol
Checklist técnica (Tareas):

 T1: Crear colección roles con documentos: super_admin, admin, supervisor, dispatcher, driver, viewer
 T2: Definir permissions array para cada rol. Ej. admin: ['trips.*', 'vehicles.*', 'drivers.*', 'alerts.acknowledge']
 T3: Wildcard support: 'trips.*' = trips.create, trips.view, trips.edit, trips.delete
 T4: Al crear user, asignar role y copiar permissions de role a user.permissions
 T5: Crear middleware requirePermission en Cloud Functions
 T6: Middleware verifica: user.permissions.includes(required_permission)
 T7: Actualizar Firestore Security Rules: allow write if hasPermission('trips.create')
 T8: Implementar helper hasPermission() en mobile/web que verifica permisos localmente
 T9: Usar hasPermission() para mostrar/ocultar UI: if (hasPermission('trips.create')) showCreateButton
 T10: Crear RolesManagementPage en web con tabla de roles y permisos
 T11: Permitir admin editar permissions de rol (agregar/quitar), actualizar users con ese rol
 T12: Implementar PermissionDeniedScreen para mostrar cuando usuario intenta acceder sin permiso
 T13: Probar con usuarios de diferentes roles validando accesos
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:transversal componente:backend componente:security componente:web

Dependencias: US-007 (Mobile auth), US-010 (Web auth), US-066 (Multi-tenant security)

Archivos/Carpetas relacionados:

/firebase/functions/src/middleware/requirePermission.ts
/firebase/firestore.rules (actualizar con permissions)
/web/lib/features/roles/presentation/pages/roles_management_page.dart
/lib/core/utils/permissions_helper.dart
Notas/Consideraciones:

Roles vs Permissions: Roles agrupan permissions. User tiene 1 role, pero múltiples permissions derivadas
Wildcards: Simplifica management. 'trips.*' en vez de enumerar cada permiso
Custom roles: MVP usa roles predefinidos. Fase futura: permitir crear custom roles
Inheritance: Considerar jerarquía: super_admin hereda todos los permisos, admin hereda supervisor, etc.
Caching: Cachear permissions en JWT custom claims para evitar query a Firestore en cada request
Audit: Log cambios de roles/permissions para compliance
Future: Fine-grained permissions por recurso (ej. "puede editar solo sus propios trips"), time-based permissions (ej. "dispatcher solo entre 8am-6pm")

---

Título: US-074: Implementar búsqueda global y filtros avanzados

Descripción:

Resumen: Crear sistema de búsqueda global que permita buscar trips, vehículos, conductores, alertas desde una barra de búsqueda unificada con filtros avanzados.
Detalle:
Barra de búsqueda global en AppBar (mobile y web)
Búsqueda full-text en múltiples colecciones simultáneamente
Filtros avanzados: fecha, estado, tipo, conductor, vehículo
Resultados agrupados por tipo con navegación
Historial de búsquedas recientes
Sugerencias autocompletadas mientras escribe
Referencia: Ver Sección 10 (UX Improvements), transversal
Criterios de aceptación (AC):

 AC1: Barra de búsqueda en AppBar permite buscar por: trip ID, placa vehículo, nombre conductor, tipo de alerta
 AC2: Resultados agrupados en categorías: Trips (5), Vehículos (2), Conductores (3), Alertas (1)
 AC3: Filtros avanzados disponibles: rango de fechas, estado (completed/in_progress), tipo de alert
 AC4: Autocomplete muestra sugerencias después de 3 caracteres
 AC5: Historial de últimas 10 búsquedas almacenado localmente y mostrado al abrir search
Checklist técnica (Tareas):

 T1: Crear GlobalSearchBar widget en AppBar con TextField y search icon
 T2: Implementar debounced search: esperar 300ms después de último keystroke antes de buscar
 T3: Crear SearchService que busca en paralelo: trips, vehicles, users, alerts
 T4: Para trips: query WHERE trip_id LIKE '%search%' OR driver_name LIKE '%search%'
 T5: Para vehicles: query WHERE license_plate LIKE '%search%'
 T6: Para users: query WHERE name LIKE '%search%' OR email LIKE '%search%'
 T7: Combinar resultados y agrupar por tipo
 T8: Crear SearchResultsPage mostrando grouped results con tabs
 T9: Implementar filtros: DateRangePicker, StatusDropdown, TypeDropdown
 T10: Aplicar filtros a queries: añadir WHERE clauses según filtros activos
 T11: Guardar historial de búsquedas en Hive: search_history (max 10 items)
 T12: Mostrar historial en dropdown al hacer tap en search bar (antes de escribir)
 T13: Implementar autocomplete usando typesense o Algolia (opcional, o usar Firestore prefix queries)
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:transversal componente:mobile componente:web componente:ux

Dependencias: US-020 (Web dashboard), US-021 (Trips)

Archivos/Carpetas relacionados:

/lib/core/widgets/global_search_bar.dart
/lib/core/services/search_service.dart
/lib/features/search/presentation/pages/search_results_page.dart
/web/lib/core/widgets/global_search_bar.dart
Notas/Consideraciones:

Full-text search: Firestore no soporta full-text search nativamente. Opciones: Algolia (pago), Typesense (self-hosted), o prefix matching con Firestore
Performance: Buscar en múltiples colecciones simultáneamente puede ser costoso. Limitar resultados: 10 por tipo
Relevance ranking: Mostrar resultados más relevantes primero. Priorizar matches exactos sobre parciales
Latency: Debounce de 300ms mejora UX y reduce queries innecesarias mientras usuario escribe
Offline: Búsqueda debe funcionar offline usando cache local (Hive)
Analytics: Track búsquedas más frecuentes para identificar features más usadas
Future: AI-powered search (búsqueda natural: "viajes de Juan esta semana"), search filters saved as presets, voice search

---

Título: US-075: Implementar dark mode y personalización de tema

Descripción:

Resumen: Agregar soporte para dark mode en mobile y web con posibilidad de personalizar colores principales de la empresa (white-label).
Detalle:
Dark mode con toggle en Settings
Auto-switch según configuración del sistema operativo
Temas personalizables por empresa: color primario, logo, nombre
Persistencia de preferencia de tema
Smooth transition al cambiar tema
Accesibilidad: contraste WCAG AA compliant
Referencia: Ver Sección 10 (UX & Accessibility), transversal
Criterios de aceptación (AC):

 AC1: Settings incluye toggle "Modo oscuro" con 3 opciones: Light, Dark, System (auto)
 AC2: Al cambiar a dark mode, toda la app usa palette de colores oscuros (background #121212, cards #1E1E1E)
 AC3: Company document permite configurar primary_color, logo_url para personalización
 AC4: Al iniciar app, aplica primary_color de empresa como accent color
 AC5: Preferencia de tema persistida en Hive y aplicada al abrir app
Checklist técnica (Tareas):

 T1: Crear ThemeProvider con Riverpod que maneja light/dark themes
 T2: Definir ThemeData para lightTheme: Colors.white background, Colors.blue primary
 T3: Definir ThemeData para darkTheme: Colors.grey[900] background, Colors.blue primary
 T4: En Settings, agregar ThemeModeSelector: Radio buttons (Light, Dark, System)
 T5: Guardar preferencia en Hive: theme_mode ('light'|'dark'|'system')
 T6: Al iniciar app, leer theme_mode y aplicar con MaterialApp(themeMode: ...)
 T7: Implementar detectSystemTheme(): usar MediaQuery.platformBrightness
 T8: Agregar campos a Company model: primary_color (hex string), secondary_color, logo_url
 T9: Al cargar company, generar ThemeData con ColorScheme.fromSeed(seedColor: primary_color)
 T10: Aplicar logo de empresa en AppBar en vez de logo genérico
 T11: Validar contraste de colores usando contrast checker (WCAG AA: min 4.5:1)
 T12: Animar transition con AnimatedTheme para smooth change
 T13: Probar en iOS y Android validando system theme auto-switch
Estimación: 13 SP / 21h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:transversal componente:mobile componente:web componente:ux componente:accessibility

Dependencias: US-007 (Mobile auth), US-010 (Web auth)

Archivos/Carpetas relacionados:

/lib/core/theme/theme_provider.dart
/lib/core/theme/app_theme.dart
/lib/features/settings/presentation/widgets/theme_mode_selector.dart
/web/lib/core/theme/app_theme.dart
Notas/Consideraciones:

OLED optimization: Para AMOLED screens, usar true black (#000000) en dark mode ahorra batería significativamente
Accessibility: Dark mode no es solo estética. Personas con sensibilidad a luz necesitan dark mode
Color customization: White-label permite revender producto a múltiples empresas con branding propio
Color validation: Validar que primary_color tiene contraste suficiente con backgrounds. Si no, ajustar automáticamente
Material 3: Usar Material 3 design system con dynamic color scheme
Gradual rollout: Algunos widgets pueden verse mal en dark mode. Testear exhaustivamente
Future: Multiple theme presets (Ocean Blue, Forest Green, Sunset Orange), scheduled theme (dark mode solo en noche), high contrast mode para accesibilidad

---

Título: US-076: Implementar internacionalización (i18n) con múltiples idiomas

Descripción:

Resumen: Agregar soporte para múltiples idiomas (español, inglés, portugués) con detección automática según locale del dispositivo y selector manual.
Detalle:
Archivos de traducción para ES, EN, PT
Auto-detección de idioma del dispositivo
Selector de idioma en Settings
Persistencia de preferencia de idioma
Traducción de todos los textos estáticos
Formateo de fechas y números según locale
Soporte RTL (right-to-left) para futuras expansiones
Referencia: Ver Sección 10 (Internationalization), transversal
Criterios de aceptación (AC):

 AC1: App detecta idioma del dispositivo al primer inicio y usa ese idioma
 AC2: Settings incluye LanguageSelector con opciones: Español, English, Português
 AC3: Todos los textos estáticos traducidos en 3 idiomas
 AC4: Fechas formateadas según locale: "15/11/2025" (ES), "11/15/2025" (EN)
 AC5: Cambio de idioma actualiza toda la UI sin reiniciar app
Checklist técnica (Tareas):

 T1: Agregar dependencias: flutter_localizations, intl: ^0.18.0
 T2: Crear archivos ARB en /lib/l10n/: app_es.arb, app_en.arb, app_pt.arb
 T3: Extraer todos los strings hardcoded y moverlos a archivos ARB
 T4: Configurar MaterialApp con localizationsDelegates y supportedLocales
 T5: Implementar LocaleProvider con Riverpod para cambio dinámico de idioma
 T6: En Settings, crear LanguageSelectorDropdown con banderas de países
 T7: Guardar preferencia en Hive: selected_locale ('es'|'en'|'pt')
 T8: Al iniciar app, leer selected_locale o usar deviceLocale si es primera vez
 T9: Usar AppLocalizations.of(context)!.keyName para acceder traducciones
 T10: Formatear fechas con DateFormat.yMd(locale) de package intl
 T11: Formatear números con NumberFormat.currency(locale: locale)
 T12: Probar cambiando idioma y validando que todos los textos se actualizan
 T13: Crear /docs/translation-guide.md documentando proceso para agregar nuevos idiomas
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:transversal componente:mobile componente:web componente:i18n

Dependencias: US-007 (Mobile auth), US-010 (Web auth)

Archivos/Carpetas relacionados:

/lib/l10n/app_es.arb
/lib/l10n/app_en.arb
/lib/l10n/app_pt.arb
/lib/core/providers/locale_provider.dart
/lib/features/settings/presentation/widgets/language_selector.dart
Notas/Consideraciones:

ARB format: Application Resource Bundle, formato estándar para i18n en Flutter
Context: Algunos textos dependen del contexto (ej. "trip" puede ser "viaje" o "trayecto"). Usar placeholders y contexto
Pluralization: Manejar plurales correctamente: "1 trip" vs "2 trips". ARB soporta plural rules
Gender: Español tiene género. "El conductor" vs "La conductora". Considerar en traducciones
RTL support: Árabe, hebreo son RTL. Preparar UI para futuro soporte (evitar hardcoded left/right)
Professional translation: Para producción, contratar traductor profesional. Google Translate no es suficiente
Future: Crowdsourcing de traducciones, dynamic translations desde Firestore (sin redeploy), regional variants (español México vs España)

---

Título: US-077: Implementar sistema de feedback y rating de conductores

Descripción:

Resumen: Permitir que supervisores califiquen conductores al finalizar viajes y conductores den feedback sobre condiciones de ruta, vehículos, etc.
Detalle:
Rating de 1-5 estrellas de conductor por supervisor
Feedback textual opcional sobre desempeño
Conductores pueden reportar problemas: vía en mal estado, vehículo con fallas
Historial de ratings y feedback por conductor
Dashboard de análisis de feedback
Feedback anónimo para reporte de problemas sensibles
Referencia: Ver Sección 4.5 (Feedback & Rating), Sprint 11-12 extendido
Criterios de aceptación (AC):

 AC1: Al finalizar trip, supervisor puede calificar conductor: 1-5 estrellas + comentario opcional
 AC2: Rating almacenado en colección driver_ratings vinculado a trip
 AC3: Conductor puede dar feedback post-trip: reportar vía mala, problema vehículo, sugerencia
 AC4: User profile muestra average_rating calculado de todos sus trips
 AC5: FeedbackAnalyticsPage muestra distribución de ratings y word cloud de comentarios frecuentes
Checklist técnica (Tareas):

 T1: Crear colección driver_ratings: { id, trip_id, driver_id, rated_by_user_id, rating (1-5), comment, timestamp }
 T2: Al completar trip, si user es supervisor, mostrar RatingDialog
 T3: Dialog con StarRating widget (5 estrellas interactivas) y TextField para comentario
 T4: Guardar rating en Firestore y actualizar trip: { driver_rating }
 T5: Crear Cloud Function calculateAverageRating que corre al crear rating
 T6: Función query todos ratings del driver y calcula avg, actualiza user: { average_rating, total_ratings }
 T7: Crear colección trip_feedback para feedback de conductores
 T8: Post-trip, mostrar FeedbackFormScreen a conductor con opciones: road_quality (1-5), vehicle_condition (1-5), suggestions (text)
 T9: Opción "Reportar problema" que abre form anónimo para issues sensibles
 T10: Crear FeedbackAnalyticsPage con charts: rating distribution (bar chart), feedback trends
 T11: Implementar word cloud de comentarios más frecuentes (usando cloud function para procesamiento)
 T12: Mostrar average_rating en DriverProfileScreen con estrellas visuales
 T13: Probar flujo completo: completar trip → calificar → validar average_rating actualizado
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:mobile componente:web componente:feedback

Dependencias: US-025 (Trip completion), US-051 (Driver scoring)

Archivos/Carpetas relacionados:

/lib/features/trips/presentation/widgets/rating_dialog.dart
/lib/features/feedback/presentation/screens/feedback_form_screen.dart
/web/lib/features/analytics/presentation/pages/feedback_analytics_page.dart
/firebase/functions/src/triggers/calculateAverageRating.ts
Notas/Consideraciones:

Bias: Ratings tienden a ser extremos (5 estrellas o 1 estrella). Normalizar considerando distribución
Anonymity: Feedback anónimo fomenta honestidad pero puede usarse para abuso. Monitorear patterns
Incentives: Considerar premios para conductores con ratings >4.5 (bonos, badges)
Response: Permitir a conductor responder a ratings negativos (derecho a réplica)
Timing: Pedir rating inmediatamente post-trip tiene mayor response rate (70% vs 20% si se pide después)
Sentiment analysis: Usar NLP para analizar comentarios y detectar problemas recurrentes automáticamente
Future: Peer ratings (conductores califican entre sí), customer ratings (si es delivery/ride-sharing), predictive ratings (predecir rating antes de asignar conductor)

---

Título: US-078: Implementar sistema de notificaciones por email con templates

Descripción:

Resumen: Complementar notificaciones push con emails transaccionales usando SendGrid: bienvenida, reportes, alertas críticas, resumen semanal.
Detalle:
Integración con SendGrid API
Templates HTML para emails profesionales
Emails transaccionales: bienvenida, reset password, alert crítica
Emails periódicos: resumen semanal, reporte mensual
Tracking de emails: abiertos, clicks
Unsubscribe link en emails opcionales
Personalización con logo y colores de empresa
Referencia: Ver Sección 4.4 (Email Notifications), Sprint 13-14
Criterios de aceptación (AC):

 AC1: Usuario recibe email de bienvenida al registrarse con template profesional
 AC2: Alertas critical generan email además de push notification
 AC3: Supervisores reciben email con resumen semanal cada lunes: trips completados, alertas, top drivers
 AC4: Todos los emails incluyen logo de empresa y colores personalizados
 AC5: Link "Unsubscribe" funcional en emails periódicos (no en transaccionales)
Checklist técnica (Tareas):

 T1: Crear cuenta SendGrid, obtener API key
 T2: Configurar API key en Firebase config: firebase functions:config:set sendgrid.api_key="..."
 T3: Instalar @sendgrid/mail en Cloud Functions: npm install @sendgrid/mail
 T4: Crear EmailService en /firebase/functions/src/services/emailService.ts
 T5: Diseñar template HTML para email de bienvenida con placeholders: {{user_name}}, {{company_name}}
 T6: Implementar sendWelcomeEmail(user) que envía email al registrarse
 T7: Modificar onAlertCreated: si severity=critical, llamar sendAlertEmail(alert, recipients)
 T8: Crear Cloud Function scheduled sendWeeklySummary (cron: monday at 9am)
 T9: Función agrega stats de semana anterior, genera HTML con template
 T10: Template incluye: total trips, distance, alerts count, top 3 drivers, chart image
 T11: Query company.email_settings para obtener logo_url, primary_color
 T12: Inyectar logo y colors en template HTML
 T13: Implementar unsubscribe: agregar link a email, manejar en Cloud Function que actualiza user.email_preferences
 T14: Usar SendGrid Event Webhook para track opens/clicks, almacenar en email_analytics collection
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:backend componente:notifications componente:email

Dependencias: US-044 (Sistema de alertas), US-055 (Scheduled reports)

Archivos/Carpetas relacionados:

/firebase/functions/src/services/emailService.ts
/firebase/functions/src/templates/emails/welcome.html
/firebase/functions/src/templates/emails/alert_critical.html
/firebase/functions/src/templates/emails/weekly_summary.html
/firebase/functions/src/scheduled/sendWeeklySummary.ts
Notas/Consideraciones:

SendGrid pricing: Free tier = 100 emails/día. Pro plan = $15/mes para 40,000 emails. Monitorear usage
Deliverability: Configurar SPF, DKIM, DMARC records en DNS para evitar spam folder
Template design: Usar inline CSS (no external stylesheets). Testear en múltiples clientes (Gmail, Outlook, Apple Mail)
Personalization: SendGrid soporta dynamic templates con Handlebars syntax: {{#if user.premium}}...{{/if}}
Unsubscribe: Requerido por GDPR para emails no-transaccionales. No incluir en password reset, alerts críticas
A/B testing: Probar subject lines diferentes para mejorar open rate (típicamente 20-30%)
Future: Email automation workflows (drip campaigns), rich emails con interactive elements, AMP for Email

---

Título: US-079: Implementar exportación de datos para compliance (GDPR/CCPA)

Descripción:

Resumen: Permitir a usuarios exportar todos sus datos personales en formato portable (JSON/CSV) para cumplir con regulaciones de privacidad GDPR y CCPA.
Detalle:
Endpoint "Exportar mis datos" en Settings
Genera archivo ZIP con todos los datos del usuario
Incluye: perfil, trips, ratings, feedback, notificaciones
Formato JSON para estructura completa + CSV para tablas
Notificación email cuando export está listo
Eliminación automática del archivo después de 7 días
Logs de auditoría de exports para compliance
Referencia: Ver Sección 11 (Privacy & Compliance), transversal
Criterios de aceptación (AC):

 AC1: Settings incluye botón "Exportar mis datos" que inicia proceso
 AC2: Cloud Function genera ZIP con archivos: profile.json, trips.csv, ratings.csv, notifications.csv
 AC3: ZIP almacenado en Cloud Storage con URL firmada válida por 7 días
 AC4: Usuario recibe email con link de descarga cuando export completa
 AC5: Colección data_exports registra todas las solicitudes con timestamp y status
Checklist técnica (Tareas):

 T1: Crear botón "Exportar mis datos" en SettingsPage (mobile y web)
 T2: Al presionar, crear documento en data_exports: { user_id, status: 'pending', requested_at }
 T3: Crear Cloud Function scheduled processDataExports (cron: every 10 minutes)
 T4: Función query data_exports donde status='pending'
 T5: Para cada request, query todos los datos del user: profile, trips, ratings, feedback, notifications
 T6: Generar profile.json con JSON.stringify(userData)
 T7: Generar trips.csv con headers y rows usando csv-writer package
 T8: Crear ZIP file usando archiver package: agregar todos JSON/CSV
 T9: Subir ZIP a Cloud Storage: /data-exports/{user_id}/{timestamp}.zip
 T10: Generar signed URL válida por 7 días: bucket.file().getSignedUrl()
 T11: Enviar email con link de descarga usando SendGrid
 T12: Actualizar data_exports: { status: 'completed', download_url, completed_at }
 T13: Crear Cloud Function scheduled deleteExpiredExports (cron: daily) que elimina archivos >7 días
 T14: Probar flujo completo y validar que ZIP contiene todos los datos
Estimación: 13 SP / 21h

Prioridad: Alta

Etiquetas (labels): tipo:feature fase:transversal componente:backend componente:compliance componente:privacy

Dependencias: US-001 (Firebase setup), US-078 (Email notifications)

Archivos/Carpetas relacionados:

/firebase/functions/src/scheduled/processDataExports.ts
/firebase/functions/src/scheduled/deleteExpiredExports.ts
/lib/features/settings/presentation/pages/settings_page.dart
/web/lib/features/settings/presentation/pages/settings_page.dart
Notas/Consideraciones:

GDPR Article 20: Derecho a portabilidad de datos. Usuarios pueden solicitar sus datos en formato legible
Processing time: Exportar puede tomar varios minutos para usuarios con muchos trips. Procesar async, no bloquear UI
Data scope: Incluir TODO lo que el usuario generó: perfil, trips, ratings, feedback, alerts acknowledged. NO incluir: company data, other users data
Format: JSON es mejor para developers, CSV es mejor para usuarios no-técnicos. Proveer ambos
Security: Signed URLs expiran. No almacenar indefinidamente. Logs de quién descargó cuándo
CCPA: Similar a GDPR. California Consumer Privacy Act requiere mismo derecho
Future: Right to be forgotten (GDPR Article 17): botón "Eliminar mi cuenta" que anonimiza/elimina todos los datos, data rectification (corregir datos incorrectos)

---

Título: US-080: Implementar testing automatizado (unit, integration, e2e)

Descripción:

Resumen: Configurar suite de testing automatizado que cubre unit tests, integration tests y end-to-end tests para mobile, web y backend.
Detalle:
Unit tests para lógica de negocio (repositories, services, providers)
Integration tests para flujos completos (login, crear trip, tracking)
E2E tests con Patrol/integration_test para mobile
Tests de Cloud Functions con Firebase emulators
Code coverage target: >80%
Tests ejecutados automáticamente en CI pipeline
Referencia: Ver Sección 9 (Quality Assurance), transversal
Criterios de aceptación (AC):

 AC1: Unit tests cubren >80% de repositories, services y providers
 AC2: Integration tests validan flujos críticos: login → crear trip → iniciar tracking → completar
 AC3: E2E tests ejecutan en emulador validando UI completa de app móvil
 AC4: Cloud Functions tests usan Firebase emulators para testing offline
 AC5: GitHub Actions ejecuta todos los tests en cada PR y bloquea merge si fallan
Checklist técnica (Tareas):

 T1: Crear estructura /test con subdirectorios: unit/, integration/, e2e/
 T2: Escribir unit tests para critical services: AuthService, TrackingService, TripRepository
 T3: Usar mocktail para mocks: mock Firestore, mock GPS, mock FCM
 T4: Target: 100 unit tests mínimo cubriendo happy paths y edge cases
 T5: Crear integration tests: test/integration/trip_flow_test.dart
 T6: Test simula: crear trip → asignar vehículo → iniciar → generar GPS points → completar
 T7: Configurar patrol para E2E tests: patrol test --target integration_test/app_test.dart
 T8: E2E test navega por app: login → home → crear trip → tracking screen
 T9: Para Cloud Functions, configurar firebase emulators en package.json scripts
 T10: Tests de functions usan emulators: FIRESTORE_EMULATOR_HOST=localhost:8080
 T11: Crear test para onTripCreated, onAlertCreated, aggregateDailyMetrics
 T12: Configurar coverage en flutter test --coverage, generar HTML report
 T13: Integrar en CI: .github/workflows/ci.yml ejecuta flutter test y npm test
 T14: Bloquear PR si coverage <80% o si tests fallan
Estimación: 21 SP / 34h

Prioridad: Alta

Etiquetas (labels): tipo:testing fase:transversal componente:qa componente:mobile componente:backend

Dependencias: US-001 (Firebase setup), US-003 (Flutter setup), US-069 (CI/CD)

Archivos/Carpetas relacionados:

/test/unit/
/test/integration/
/integration_test/
/firebase/functions/test/
/.github/workflows/ci.yml
Notas/Consideraciones:

Test pyramid: Mayoría de tests deben ser unit (rápidos, baratos). Menos integration tests. Pocos E2E tests (lentos, frágiles)
Mocking: No testear dependencias externas (Firestore, APIs). Mockear para tests rápidos y determinísticos
Flaky tests: E2E tests pueden ser flaky (fallan aleatoriamente). Implementar retries y timeouts generosos
Coverage: 80% es balance entre quality y effort. 100% es overkill y ralentiza development
CI/CD: Tests DEBEN correr en CI. Tests que solo corren local no sirven
TDD: Considerar Test-Driven Development para features críticos. Escribir test primero, luego código
Future: Visual regression testing (detectar cambios UI no intencionados), performance testing (load tests), security testing (penetration tests)

---

Título: US-081: Implementar sistema de chat/mensajería entre supervisor y conductor

Descripción:

Resumen: Crear sistema de chat en tiempo real que permita comunicación directa entre supervisores y conductores durante viajes activos.
Detalle:
Chat 1-on-1 entre supervisor y conductor específico
Mensajes en tiempo real con Firestore onSnapshot
Notificaciones push cuando llega nuevo mensaje
Indicador de "escribiendo..." (typing indicator)
Historial de conversaciones persistido
Envío de ubicación actual desde mobile
Soporte para mensajes de texto e imágenes
Referencia: Ver Sección 4.8 (Communication), Sprint opcional Fase 2
Criterios de aceptación (AC):

 AC1: Supervisor puede abrir chat con conductor desde VehicleDetailPage
 AC2: Mensajes enviados aparecen instantáneamente en ambos dispositivos (<1s latency)
 AC3: Notificación push recibida cuando llega mensaje y app está en background
 AC4: Typing indicator visible cuando otra persona está escribiendo
 AC5: Historial completo de chat persistido y accesible desde ConversationsListPage
Checklist técnica (Tareas):

 T1: Crear colección conversations: { id, participants: [user_id1, user_id2], last_message, updated_at }
 T2: Crear subcollection messages: conversations/{id}/messages con { sender_id, text, timestamp, read }
 T3: Crear ChatScreen en mobile que escucha messages con onSnapshot
 T4: Implementar TextField con botón send que crea nuevo message document
 T5: Ordenar mensajes por timestamp desc para mostrar más recientes abajo
 T6: Implementar auto-scroll a último mensaje al abrir chat
 T7: Crear Cloud Function onMessageCreated que envía FCM notification a receptor
 T8: Implementar typing indicator: actualizar conversation.typing_user_id cuando usuario escribe
 T9: Mostrar "Juan está escribiendo..." si typing_user_id != null y no es current user
 T10: Implementar "Enviar ubicación": botón que envía message con type='location' y lat/lng
 T11: Renderizar message de ubicación como mini-mapa con pin
 T12: Crear ConversationsListPage mostrando todas las conversaciones con last_message preview
 T13: Badge con count de mensajes no leídos en cada conversación
 T14: Marcar mensajes como read cuando usuario abre chat
Estimación: 13 SP / 21h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:Fase2 componente:mobile componente:backend componente:communication

Dependencias: US-007 (Mobile auth), US-044 (Notificaciones)

Archivos/Carpetas relacionados:

/lib/features/chat/presentation/screens/chat_screen.dart
/lib/features/chat/presentation/pages/conversations_list_page.dart
/lib/features/chat/data/repositories/chat_repository.dart
/firebase/functions/src/triggers/onMessageCreated.ts
Notas/Consideraciones:

Scalability: Chat puede generar muchos documentos. Considerar límite de mensajes (últimos 100) y paginación
Read receipts: Almacenar read_at timestamp para mostrar checkmarks (enviado ✓, entregado ✓✓, leído ✓✓ azul)
Encryption: Mensajes no están encriptados. Para info sensible, considerar E2E encryption (complejo)
Multimedia: Soporte para imágenes requiere subir a Cloud Storage. Limitar tamaño <5MB
Moderation: Chat puede usarse inapropiadamente. Considerar logs de auditoría y reportar mensaje feature
Offline: Mensajes deben encolarse cuando offline y enviarse al recuperar conexión
Future: Chat grupal (supervisor + múltiples conductores), mensajes de voz, videollamadas (WebRTC), bot automático con respuestas predefinidas

---

Título: US-082: Implementar panel de administración super-admin multi-empresa

Descripción:

Resumen: Crear panel especial para super-admin que gestiona múltiples empresas, usuarios, y configuraciones globales del sistema.
Detalle:
Dashboard con lista de todas las empresas en la plataforma
Crear/editar/suspender empresas
Ver estadísticas agregadas: total trips, usuarios, vehículos
Impersonar usuario de cualquier empresa para soporte
Logs de auditoría de acciones de super-admin
Configuración de features flags por empresa
Billing y usage tracking por empresa
Referencia: Ver Sección 3.7 (Super Admin), transversal
Criterios de aceptación (AC):

 AC1: SuperAdminDashboard muestra lista de todas las companies con stats: users count, vehicles count, trips count
 AC2: Super-admin puede crear nueva empresa con form: nombre, admin email, plan (free/pro/enterprise)
 AC3: Super-admin puede suspender empresa marcando active: false (usuarios no pueden login)
 AC4: Botón "Impersonate" permite super-admin ver app como usuario específico
 AC5: AuditLogsPage muestra todas las acciones de super-admin con timestamp y detalles
Checklist técnica (Tareas):

 T1: Crear rol super_admin en sistema con permissions: ['*'] (todos los permisos)
 T2: Crear SuperAdminDashboard en web con tabla de companies
 T3: Query all companies (sin filtro de company_id) solo si user.role = super_admin
 T4: Mostrar stats por empresa: count users, count vehicles, count trips (últimos 30 días)
 T5: Form "Nueva Empresa": nombre, admin_email, plan, speed_limit_default
 T6: Al crear, generar company_id, crear company document, crear admin user con invite email
 T7: Implementar toggle "Activa/Suspendida" que actualiza company.active
 T8: Si company.active = false, bloquear login de todos sus usuarios en Cloud Function
 T9: Implementar "Impersonate": genera JWT temporal con user_id y company_id de target user
 T10: Al impersonate, super-admin ve app con permisos del usuario target (para debugging)
 T11: Crear colección super_admin_audit_logs: { admin_id, action, target_company_id, details, timestamp }
 T12: Log todas las acciones: create_company, suspend_company, impersonate_user, edit_company
 T13: Crear AuditLogsPage con filtros: fecha, admin, acción, empresa
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:transversal componente:web componente:backend componente:admin

Dependencias: US-073 (RBAC), US-066 (Multi-tenant)

Archivos/Carpetas relacionados:

/web/lib/features/super_admin/presentation/pages/super_admin_dashboard.dart
/web/lib/features/super_admin/presentation/pages/audit_logs_page.dart
/firebase/functions/src/http/impersonateUser.ts
/firebase/functions/src/middleware/requireSuperAdmin.ts
Notas/Consideraciones:

Security: Super-admin es extremadamente poderoso. Limitar acceso a 1-2 personas máximo. MFA obligatorio
Impersonation: Útil para debugging de issues reportados por clientes. Debe loggearse exhaustivamente
Billing: Integrar con Stripe para tracking de pagos por empresa. Ver usage para facturación mensual
Feature flags: Permitir habilitar/deshabilitar features experimentales por empresa (A/B testing)
Analytics: Dashboard debe mostrar métricas de plataforma: MAU, churn rate, ARPU (Average Revenue Per User)
Automation: Scripts para tareas comunes: migration de datos, backup masivo, envío de comunicados
Future: Herramientas de machine learning para detectar anomalías (fraude, abuso), customer health scores, automated onboarding

---

Título: US-083: Implementar integración con APIs externas (Google Maps, Weather, Fuel)

Descripción:

Resumen: Integrar APIs de terceros para enriquecer features: Google Maps Geocoding, Weather API para condiciones climáticas, APIs de precios de combustible.
Detalle:
Google Maps Geocoding para convertir coordenadas a direcciones
Weather API para obtener condiciones durante viaje
APIs de precios de combustible para calcular costos estimados
Reverse geocoding de puntos de inicio/fin de trip
Weather warnings en alertas si condiciones adversas
Fuel cost estimation por trip basado en distancia
Referencia: Ver Sección 8.3 (External Integrations), Sprint 21-22
Criterios de aceptación (AC):

 AC1: Al completar trip, sistema hace reverse geocoding de inicio/fin y almacena direcciones legibles
 AC2: Durante trip, si weather API reporta lluvia intensa, genera alert tipo adverse_weather
 AC3: Trip summary muestra costo estimado de combustible calculado con fuel price API
 AC4: Cloud Function usa Google Geocoding API con rate limiting (max 100 requests/día)
 AC5: Todas las API calls tienen error handling y fallback si API falla
Checklist técnica (Tareas):

 T1: Habilitar Google Maps Geocoding API en GCP Console
 T2: Obtener API key y configurar en Firebase config
 T3: Crear GeocodingService en Cloud Functions usando @googlemaps/google-maps-services-js
 T4: En onTripCompleted, hacer reverse geocoding de start_location y end_location
 T5: Guardar start_address y end_address en trip document
 T6: Registrarse en OpenWeather API (free tier: 60 calls/min)
 T7: Crear WeatherService que obtiene weather data por coordenadas
 T8: En tracking, cada 30 min verificar weather conditions en ubicación actual
 T9: Si weather.main = "Rain" y intensity > 50mm/h, generar alert tipo adverse_weather
 T10: Registrarse en fuel price API (ej. fueleconomy.gov o local API según país)
 T11: Crear FuelCostService que calcula: (distance_km / vehicle.fuel_efficiency_kml) * fuel_price_per_liter
 T12: Mostrar estimated_fuel_cost en TripSummaryScreen
 T13: Implementar rate limiting: cache API responses por 1 hora para reducir calls
 T14: Implementar error handling: si API falla, usar valores default o cached
Estimación: 13 SP / 21h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:Fase3 componente:backend componente:integrations

Dependencias: US-025 (Trip completion), US-044 (Sistema de alertas)

Archivos/Carpetas relacionados:

/firebase/functions/src/services/geocodingService.ts
/firebase/functions/src/services/weatherService.ts
/firebase/functions/src/services/fuelCostService.ts
/firebase/functions/src/triggers/onTripCompleted.ts
Notas/Consideraciones:

API costs: Google Geocoding = $5/1000 requests después de free tier. Weather API = gratis hasta 60 calls/min. Monitorear usage
Rate limiting: CRÍTICO. Exceder rate limits resulta en bloqueo de API. Implementar exponential backoff
Caching: Cache agresivo para reducir costos. Direcciones no cambian, cachear indefinidamente. Weather cachear 1 hora
Error handling: APIs externas pueden fallar. SIEMPRE tener fallback (valores default, cached data)
Privacy: Geocoding revela ubicación exacta. Considerar solo mostrar ciudad/región en vez de dirección completa
Localization: APIs pueden retornar en inglés. Especificar language=es en requests
Future: Traffic API para predicción de tráfico, Toll API para calcular peajes, Road quality API para detectar vías en mal estado

---

Título: US-084: Implementar webhooks para integraciones salientes

Descripción:

Resumen: Crear sistema de webhooks que notifica a sistemas externos cuando ocurren eventos importantes (trip completed, alert created, etc).
Detalle:
Configuración de webhook URLs por empresa
Eventos soportados: trip.created, trip.completed, alert.created, maintenance.due
Payload JSON con data completa del evento
Retry logic con exponential backoff si webhook falla
Logs de webhooks enviados con status codes
Verificación de seguridad con HMAC signatures
Testing de webhooks con webhook.site
Referencia: Ver Sección 8.2 (Webhooks), Sprint 21-22
Criterios de aceptación (AC):

 AC1: Company puede configurar webhook URLs en Settings con eventos a escuchar
 AC2: Al ocurrir evento, Cloud Function envía POST request a webhook URL con payload JSON
 AC3: Si webhook retorna 4xx/5xx, sistema reintenta 3 veces con exponential backoff
 AC4: WebhookLogsPage muestra historial de webhooks: evento, URL, status, timestamp, retries
 AC5: Payload incluye HMAC signature en header X-Signature para validar autenticidad
Checklist técnica (Tareas):

 T1: Agregar campo webhooks a Company model: [{ url, events: ['trip.completed', 'alert.created'], secret, active }]
 T2: Crear WebhooksConfigPage en web para configurar webhooks
 T3: Form permite agregar: URL (validar formato), seleccionar eventos (multi-select), generar secret
 T4: Crear Cloud Function sendWebhook(event_type, payload, webhook_config)
 T5: Función hace POST request a webhook.url con body: { event, data, timestamp }
 T6: Calcular HMAC signature: crypto.createHmac('sha256', secret).update(JSON.stringify(payload)).digest('hex')
 T7: Agregar header X-Signature con signature para que receptor valide
 T8: Si response status >= 400, marcar como failed y schedule retry
 T9: Implementar exponential backoff: retry después de 1min, 5min, 15min
 T10: Crear colección webhook_logs: { company_id, event, url, status, retries, timestamp }
 T11: Modificar triggers existentes (onTripCompleted, onAlertCreated) para enviar webhooks
 T12: Query company.webhooks donde event in events array, llamar sendWebhook
 T13: Crear WebhookLogsPage mostrando historial con filtros: evento, status, fecha
 T14: Implementar testing: botón "Test Webhook" que envía payload de prueba
Estimación: 13 SP / 21h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:Fase3 componente:backend componente:integrations componente:webhooks

Dependencias: US-025 (Trip completion), US-044 (Sistema de alertas)

Archivos/Carpetas relacionados:

/firebase/functions/src/services/webhookService.ts
/firebase/functions/src/triggers/onTripCompleted.ts
/web/lib/features/integrations/presentation/pages/webhooks_config_page.dart
/web/lib/features/integrations/presentation/pages/webhook_logs_page.dart
Notas/Consideraciones:

Security: HMAC signature previene spoofing. Receptor debe validar signature antes de procesar payload
Retry logic: 3 retries es suficiente. Si falla 3 veces, marcar como permanently_failed y alertar admin
Idempotency: Receptor debe manejar duplicados (puede recibir mismo evento 2 veces por retry). Incluir event_id único
Payload: Incluir toda la data necesaria (trip completo, no solo trip_id). Evita que receptor tenga que hacer API call back
Rate limiting: Si empresa tiene muchos eventos, puede saturar su webhook endpoint. Considerar batching
Monitoring: Track success rate de webhooks. Si <90%, alertar que hay problema con endpoint del cliente
Future: Webhook signatures con multiple algorithms (sha256, sha512), webhook versioning (v1, v2), webhook marketplace (pre-built integrations)

---

Título: US-085: Implementar sistema de cache distribuido con Redis

Descripción:

Resumen: Agregar Redis como cache layer para mejorar performance de queries frecuentes y reducir lecturas de Firestore.
Detalle:
Configurar Redis instance en Google Cloud Memorystore
Cachear datos frecuentemente accedidos: vehicles, drivers, geofences
TTL (time-to-live) configurado por tipo de dato
Cache invalidation strategy cuando datos cambian
Session storage en Redis para web dashboard
Rate limiting usando Redis counters
Analytics queries cacheadas por 1 hora
Referencia: Ver Sección 9 (Performance - Advanced), transversal opcional
Criterios de aceptación (AC):

 AC1: Redis instance configurado en Google Cloud Memorystore
 AC2: Queries de vehicles cacheados por 5 minutos, drivers por 5 minutos, geofences por 30 minutos
 AC3: Al actualizar vehicle en Firestore, cache se invalida automáticamente
 AC4: Web sessions almacenadas en Redis en vez de JWT (mejor security)
 AC5: Rate limiting de API usa Redis counters (más rápido que Firestore)
Checklist técnica (Tareas):

 T1: Crear Redis instance en Google Cloud Memorystore (1GB, us-central1)
 T2: Configurar VPC peering para que Cloud Functions accedan a Redis
 T3: Instalar redis client en Cloud Functions: npm install redis
 T4: Crear RedisService con métodos: get(key), set(key, value, ttl), del(key)
 T5: En getVehicles endpoint, verificar cache: redis.get('vehicles:company_id')
 T6: Si cache hit, retornar cached data. Si cache miss, query Firestore y cachear resultado
 T7: Configurar TTL: vehicles=5min, drivers=5min, geofences=30min, analytics=1hour
 T8: En onVehicleUpdated trigger, invalidar cache: redis.del('vehicles:company_id')
 T9: Implementar cache warming: pre-cachear datos frecuentes al iniciar Cloud Function
 T10: Migrar rate limiting a Redis: usar INCR command, más rápido que Firestore counter
 T11: Implementar session storage: almacenar session data en Redis con TTL=24h
 T12: Crear dashboard en Cloud Console para monitorear Redis: hit rate, memory usage
 T13: Implementar fallback: si Redis falla, continuar sin cache (degraded pero functional)
Estimación: 13 SP / 21h

Prioridad: Baja

Etiquetas (labels): tipo:optimization fase:transversal componente:backend componente:cache componente:performance

Dependencias: US-001 (Firebase setup), US-070 (Performance optimization)

Archivos/Carpetas relacionados:

/firebase/functions/src/services/redisService.ts
/firebase/functions/src/middleware/cacheMiddleware.ts
/docs/redis-architecture.md
Notas/Consideraciones:

Cost: Memorystore = $50-100/mes para 1GB instance. Justificar con reducción de Firestore reads (ahorro >$100/mes si app grande)
Cache invalidation: "There are only two hard things in Computer Science: cache invalidation and naming things" - Phil Karlton
Hit rate: Target >80% hit rate. Monitorear con Redis INFO command
Memory eviction: Configurar eviction policy: allkeys-lru (least recently used) cuando memoria llena
Persistence: Redis es in-memory, data se pierde si reinicia. OK para cache, NO para data crítica
Cluster: Para HA (high availability), usar Redis cluster con replication. Aumenta costo pero evita downtime
Future: Cache warming predictivo (ML predice qué cachear), distributed cache con multiple regions, cache compression para reducir memory usage

---

Título: US-086: Implementar módulo de dispatching y asignación automática de viajes

Descripción:

Resumen: Crear sistema de dispatching inteligente que asigna automáticamente viajes a conductores disponibles basado en ubicación, carga de trabajo y eficiencia.
Detalle:
Cola de trips pendientes de asignación
Algoritmo de matching: conductor más cercano + menor carga + mejor score
Asignación automática o manual por dispatcher
Notificación a conductor con trip details y opción aceptar/rechazar
Re-asignación automática si conductor rechaza
Dashboard de dispatching en tiempo real
Métricas de eficiencia: tiempo promedio de asignación, tasa de aceptación
Referencia: Ver Sección 4.9 (Dispatching), Sprint opcional Fase 2
Criterios de aceptación (AC):

 AC1: Trips creados con status "pending_assignment" aparecen en DispatchingDashboard
 AC2: Sistema automáticamente sugiere top 3 conductores óptimos basado en proximidad y availability
 AC3: Dispatcher puede asignar manualmente o dejar que sistema asigne automáticamente
 AC4: Conductor recibe notificación push con trip details y botones "Aceptar" / "Rechazar"
 AC5: Si conductor rechaza, trip se re-asigna al siguiente conductor disponible automáticamente
Checklist técnica (Tareas):

 T1: Agregar status "pending_assignment" a Trip model
 T2: Crear DispatchingDashboard en web mostrando trips pending_assignment
 T3: Para cada trip, mostrar card con: origen, destino, prioridad, tiempo de creación
 T4: Crear Cloud Function calculateOptimalDrivers(trip_id)
 T5: Función query drivers con status="available" y current_location != null
 T6: Calcular distance de cada driver a trip.start_location usando Haversine formula
 T7: Calcular score: (proximity_score * 0.5) + (driver_score * 0.3) + (workload_score * 0.2)
 T8: Retornar top 3 drivers ordenados por score desc
 T9: Mostrar sugerencias en dashboard con badges: "Más cercano", "Mejor score", "Menos ocupado"
 T10: Botón "Asignar" en dashboard actualiza trip: { assigned_driver_id, status: "assigned" }
 T11: Enviar FCM notification a driver con action buttons: "Aceptar" / "Rechazar"
 T12: Si driver presiona "Aceptar", actualizar trip: { status: "accepted", accepted_at }
 T13: Si driver presiona "Rechazar" o no responde en 5 min, re-ejecutar calculateOptimalDrivers
 T14: Implementar auto-assignment mode: si enabled, asigna automáticamente al driver con mejor score
Estimación: 21 SP / 34h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:web componente:backend componente:dispatching

Dependencias: US-021 (Trip creation), US-072 (Notification actions)

Archivos/Carpetas relacionados:

/firebase/functions/src/http/calculateOptimalDrivers.ts
/firebase/functions/src/triggers/onTripAssigned.ts
/web/lib/features/dispatching/presentation/pages/dispatching_dashboard.dart
/lib/features/trips/presentation/widgets/trip_assignment_notification.dart
Notas/Consideraciones:

Algorithm: Balance entre proximity (urgencia), driver_score (calidad), workload (equidad). Ajustar pesos según prioridades de negocio
Real-time: Ubicación de drivers debe actualizarse frecuentemente (cada 30s) para matching preciso
Acceptance rate: Trackear acceptance_rate por driver. Drivers con <70% pueden necesitar coaching
Timeout: 5 minutos para aceptar es generoso. Considerar reducir a 2 min en horas pico
Auto-assignment: Útil para operaciones grandes. Pequeñas operaciones prefieren control manual
Fairness: Evitar siempre asignar al mismo driver (cherry-picking). Rotar asignaciones para equidad
Future: ML para predecir probabilidad de aceptación, dynamic pricing (surge pricing en horas pico), multi-stop trips optimization

---

Título: US-087: Implementar módulo de planificación de rutas multi-destino

Descripción:

Resumen: Permitir crear trips con múltiples paradas (pickup/delivery) y optimizar orden de visitas usando algoritmo de optimización de rutas.
Detalle:
UI para agregar múltiples waypoints (paradas intermedias)
Algoritmo de optimización TSP (Traveling Salesman Problem)
Reordenamiento automático de paradas para minimizar distancia/tiempo
Tiempo estimado por parada configurable
Tracking de completado de cada parada
Proof of delivery: foto + firma en cada parada
Reporte de ruta completada con todas las paradas
Referencia: Ver Sección 4.10 (Multi-stop Routing), Sprint opcional Fase 3
Criterios de aceptación (AC):

 AC1: CreateTripScreen permite agregar múltiples waypoints (max 10) con drag-and-drop para reordenar
 AC2: Botón "Optimizar ruta" reordena waypoints para minimizar distancia total
 AC3: Durante tracking, conductor ve waypoints ordenados con checkboxes para marcar completados
 AC4: Al llegar a waypoint, app requiere proof of delivery: tomar foto + capturar firma
 AC5: Trip summary muestra todas las paradas con timestamps y POD (proof of delivery)
Checklist técnica (Tareas):

 T1: Modificar Trip model: agregar waypoints: [{ order, address, lat, lng, completed, completed_at, pod_photo_url, signature_url }]
 T2: En CreateTripScreen, agregar WaypointsBuilder widget con Add/Remove buttons
 T3: Cada waypoint tiene TextField para address + geocoding automático
 T4: Implementar drag-and-drop con ReorderableListView para manual reordering
 T5: Crear Cloud Function optimizeRoute(waypoints) usando OR-Tools o Google Directions Optimize
 T6: Función calcula distancia entre todos los pares de waypoints (distance matrix)
 T7: Ejecutar TSP solver para encontrar orden óptimo que minimiza distancia total
 T8: Retornar waypoints reordenados con distance_saved metric
 T9: Durante tracking, mostrar WaypointsChecklist con current waypoint highlighted
 T10: Al llegar a waypoint (GPS proximity <50m), mostrar ProofOfDeliveryDialog
 T11: Dialog requiere: tomar foto (image_picker), capturar firma (signature pad)
 T12: Subir foto y firma a Cloud Storage, guardar URLs en waypoint
 T13: Marcar waypoint.completed = true y continuar a siguiente
 T14: Al completar último waypoint, completar trip automáticamente
Estimación: 21 SP / 34h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:Fase3 componente:mobile componente:backend componente:routing

Dependencias: US-021 (Trip creation), US-064 (Route optimization)

Archivos/Carpetas relacionados:

/lib/features/trips/presentation/widgets/waypoints_builder.dart
/lib/features/trips/presentation/widgets/proof_of_delivery_dialog.dart
/firebase/functions/src/http/optimizeRoute.ts
/lib/features/tracking/presentation/widgets/waypoints_checklist.dart
Notas/Consideraciones:

TSP complexity: Problema NP-hard. Para >10 waypoints, usar heurísticas (nearest neighbor, 2-opt) en vez de solución exacta
Google OR-Tools: Librería de Google para optimization. Gratuita y muy eficiente. Alternativa: usar Google Directions API con waypoints optimization
POD: Proof of delivery es crítico para delivery/logistics. Protege contra fraude ("no recibí el paquete")
Signature: Usar signature_pad package. Exportar como imagen PNG
Time windows: Considerar agregar time_window a cada waypoint (ej. "entregar entre 9am-11am")
Priority: Algunos waypoints son urgentes. Permitir marcar prioridad (high/normal/low) que influye en optimization
Future: Real-time re-optimization (si tráfico cambia, recalcular ruta), customer notifications (SMS cuando conductor está cerca), live ETA updates

---

Título: US-088: Implementar módulo de combustible con registro de carga y análisis

Descripción:

Resumen: Gestionar registro de cargas de combustible por vehículo con análisis de consumo, eficiencia, y detección de anomalías.
Detalle:
Registro de carga: litros, costo, odómetro, estación
Cálculo automático de km/litro por vehículo
Dashboard de análisis de consumo con gráficos
Detección de anomalías: consumo excesivo, posible fraude
Integración con tarjetas de combustible (APIs externas)
Alertas de baja eficiencia
Comparación de costos entre vehículos
Referencia: Ver Sección 4.11 (Fuel Management), Sprint opcional Fase 2
Criterios de aceptación (AC):

 AC1: Conductor puede registrar carga de combustible desde mobile: litros, costo, odómetro actual, foto de recibo
 AC2: Sistema calcula automáticamente km/litro: (odometer_current - odometer_previous) / liters
 AC3: FuelAnalyticsDashboard muestra gráficos: consumo por vehículo, tendencia km/l, costo total mensual
 AC4: Alert generado si km/litro cae >20% vs promedio histórico (posible problema mecánico o fraude)
 AC5: Tabla compara eficiencia entre vehículos del mismo tipo
Checklist técnica (Tareas):

 T1: Crear colección fuel_records: { id, vehicle_id, company_id, liters, cost, odometer, station, receipt_photo_url, timestamp }
 T2: Crear FuelRegistrationScreen en mobile con form: liters, costo, odometer (auto-filled), station (optional)
 T3: Botón "Foto recibo" abre cámara, sube a Cloud Storage
 T4: Al guardar, crear Cloud Function calculateFuelEfficiency
 T5: Función query fuel_records anteriores del vehicle para obtener odometer_previous
 T6: Calcular km_per_liter = (odometer_current - odometer_previous) / liters
 T7: Actualizar fuel_record: { km_per_liter }
 T8: Calcular historical_avg_km_per_liter del vehículo (últimos 10 registros)
 T9: Si km_per_liter < historical_avg * 0.8, generar alert tipo fuel_efficiency_low
 T10: Crear FuelAnalyticsDashboard en web con charts: LineChart (km/l over time), BarChart (consumo por vehículo)
 T11: Mostrar cards: Total cost MTD, Avg km/l, Most efficient vehicle, Least efficient vehicle
 T12: Implementar filtros: vehículo, rango de fecha, estación
 T13: Exportar reporte de combustible a Excel
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:mobile componente:web componente:analytics componente:fuel

Dependencias: US-060 (TCO module), US-044 (Sistema de alertas)

Archivos/Carpetas relacionados:

/lib/features/fuel/presentation/screens/fuel_registration_screen.dart
/firebase/functions/src/triggers/calculateFuelEfficiency.ts
/web/lib/features/analytics/presentation/pages/fuel_analytics_dashboard.dart
Notas/Consideraciones:

Odometer validation: Validar que odometer_current > odometer_previous. Si no, probable error de entrada
Fraud detection: Consumo excesivo puede indicar fraude (combustible desviado para reventa). Revisar manualmente registros anómalos
Fuel cards: Integrar con APIs de tarjetas de combustible (Shell Fleet, Edenred) para registro automático sin input manual
Tax deduction: En muchos países, combustible es deducible de impuestos. Mantener registros precisos para auditorías
Efficiency standards: Comparar km/l con estándares del fabricante. Vehículo gastando 50% más puede necesitar mantenimiento
Regional prices: Precio de combustible varía por región/estación. Almacenar station_location para analytics de precios
Future: Predicción de próxima carga (ML basado en patterns), recomendación de estaciones más baratas, carbon footprint calculation

---

Título: US-089: Implementar módulo de multas y sanciones de tránsito

Descripción:

Resumen: Gestionar multas de tránsito asociadas a vehículos y conductores con registro, seguimiento, pagos y análisis de infracciones recurrentes.
Detalle:
Registro de multa: tipo, monto, fecha, ubicación, responsable
Asignación automática a conductor si se puede determinar por fecha/hora
Workflow de aprobación: supervisor revisa antes de descontar
Estados: pendiente, aprobada, pagada, apelada
Notificaciones a conductor de nueva multa
Dashboard de análisis: multas por conductor, por tipo, tendencias
Integración con APIs gubernamentales para consulta automática
Referencia: Ver Sección 4.12 (Fines Management), Sprint opcional Fase 2
Criterios de aceptación (AC):

 AC1: Web permite registrar multa: vehículo, tipo (speeding, parking, etc), monto, fecha, foto de multa
 AC2: Sistema busca trip activo del vehículo en fecha/hora de multa y asigna automáticamente a conductor
 AC3: Conductor recibe notificación con detalles de multa y opción "Apelar"
 AC4: Supervisor puede aprobar/rechazar multa desde FinesApprovalPage
 AC5: FinesAnalyticsDashboard muestra: total multas, monto total, top infractores, tipos más comunes
Checklist técnica (Tareas):

 T1: Crear colección fines: { id, vehicle_id, driver_id, company_id, type, amount, date, location, photo_url, status, notes }
 T2: Crear FinesRegistrationPage en web con form: vehículo, tipo, monto, fecha, location, upload foto
 T3: Al guardar, crear Cloud Function assignFineToDriver
 T4: Función query trips del vehículo donde trip.start_time <= fine.date <= trip.end_time
 T5: Si match encontrado, asignar fine.driver_id = trip.driver_id
 T6: Enviar notification a driver con tipo fine_assigned
 T7: Driver puede abrir FineDetailScreen y presionar "Apelar" que agrega nota y actualiza status='appealed'
 T8: Crear FinesApprovalPage para supervisores mostrando fines con status='pending'
 T9: Supervisor puede "Aprobar" (status='approved') o "Rechazar" (status='rejected') con comentario
 T10: Si aprobada, agregar a driver.total_fines_amount para tracking
 T11: Crear FinesAnalyticsDashboard con cards: Total fines, Total amount, Avg per driver
 T12: Charts: BarChart (fines por driver), PieChart (breakdown por tipo)
 T13: Implementar filtros: conductor, vehículo, tipo, rango de fecha, status
Estimación: 13 SP / 21h

Prioridad: Baja

Etiquetas (labels): tipo:feature fase:Fase2 componente:web componente:backend componente:compliance componente:fines

Dependencias: US-025 (Trip completion), US-044 (Sistema de alertas)

Archivos/Carpetas relacionados:

/web/lib/features/fines/presentation/pages/fines_registration_page.dart
/web/lib/features/fines/presentation/pages/fines_approval_page.dart
/firebase/functions/src/triggers/assignFineToDriver.ts
/web/lib/features/analytics/presentation/pages/fines_analytics_dashboard.dart
Notas/Consideraciones:

Legal: Descontar multas de salario puede tener restricciones legales. Consultar con legal antes de implementar payroll integration
Auto-assignment: Solo funciona si hay trip activo. Para multas de parking (vehículo estacionado), puede requerir asignación manual
Appeals: Proceso de apelación puede ser complejo (adjuntar evidencia, comunicación con autoridades). Mantener simple en MVP
Government APIs: Algunos países tienen APIs para consultar multas automáticamente (ej. Colombia: RUNT). Integrar si disponible
Prevention: Usar datos de multas para mejorar training de conductores (zonas con cámaras, horarios de fotomultas)
Payment tracking: Agregar payment_date, payment_receipt_url para tracking completo del lifecycle
Future: Predicción de multas (ML detecta zonas/conductores de alto riesgo), insurance integration (multas afectan prima), automated appeals

---

Título: US-090: Implementar sistema de gestión de incidentes y accidentes

Descripción:

Resumen: Registrar y gestionar incidentes/accidentes con workflow de investigación, documentación, y seguimiento de reclamos de seguros.
Detalle:
Registro inmediato de incidente desde app móvil
Tipos: accidente, robo, daño a terceros, falla mecánica
Captura de evidencia: fotos, videos, ubicación GPS, testigos
Workflow de investigación: reportar → investigar → resolver
Notificación automática a seguros y autoridades
Tracking de reclamos y costos
Dashboard de seguridad con análisis de incidentes
Referencia: Ver Sección 4.13 (Incidents Management), Sprint opcional Fase 2
Criterios de aceptación (AC):

 AC1: Durante trip, botón "Reportar Incidente" permite crear reporte con tipo, descripción, fotos
 AC2: Incidente captura automáticamente: ubicación GPS, timestamp, vehículo, conductor, trip_id
 AC3: Incidente crea alert critical que notifica inmediatamente a supervisor
 AC4: IncidentDetailPage permite agregar notas de investigación, actualizar status, upload documentos adicionales
 AC5: IncidentsDashboard muestra todos los incidentes con filtros y métricas de seguridad
Checklist técnica (Tareas):

 T1: Crear colección incidents: { id, trip_id, vehicle_id, driver_id, type, severity, description, location, timestamp, photos: [], status, investigation_notes }
 T2: En TripTrackingScreen, agregar botón flotante "Reportar Incidente" (color rojo)
 T3: Al presionar, abrir IncidentReportDialog con form: tipo, severity, descripción
 T4: Botón "Agregar fotos" permite seleccionar múltiples fotos (max 5)
 T5: Auto-capturar: GPS location, timestamp, vehicle_id, driver_id, trip_id
 T6: Al guardar, crear incident document y generar alert tipo incident_reported con severity=critical
 T7: Enviar notification a supervisor y admin inmediatamente
 T8: Crear IncidentDetailPage en web mostrando todos los detalles + timeline de investigación
 T9: Supervisor puede agregar investigation_notes, cambiar status (reported → investigating → resolved)
 T10: Upload additional documents (police report, insurance claim, witness statements)
 T11: Crear IncidentsDashboard con table de incidentes y filtros: tipo, severity, status, vehículo, conductor
 T12: Mostrar safety metrics: Total incidents, Incidents per 1000 km, Most common type, Trend (increasing/decreasing)
 T13: Implementar incident timeline view mostrando cronología de acciones
Estimación: 13 SP / 21h

Prioridad: Media

Etiquetas (labels): tipo:feature fase:Fase2 componente:mobile componente:web componente:safety componente:incidents

Dependencias: US-023 (Trip tracking), US-044 (Sistema de alertas)

Archivos/Carpetas relacionados:

/lib/features/incidents/presentation/dialogs/incident_report_dialog.dart
/web/lib/features/incidents/presentation/pages/incident_detail_page.dart
/web/lib/features/incidents/presentation/pages/incidents_dashboard.dart
/firebase/functions/src/triggers/onIncidentCreated.ts
Notas/Consideraciones:

Immediate response: Incidentes requieren acción inmediata. Notificaciones críticas deben tener sonido especial, vibración
Evidence: Fotos son críticas para reclamos de seguro. Instruir a conductores: fotos de vehículos, daños, ubicación, placas
Legal: Incidentes pueden tener implicaciones legales. Almacenar data de forma inmutable (no permitir editar después de 24h)
Insurance: Integrar con APIs de seguradoras para envío automático de reclamos (ej. Sura, Bolivar)
Safety training: Usar datos de incidentes para identificar gaps en training y prevenir futuros accidentes
Privacy: Fotos de incidentes pueden contener info sensible (personas, placas). Configurar permisos de acceso estrictos
Future: AI para clasificar severity automáticamente (analizando fotos), predictive analytics (conductores/rutas de alto riesgo), emergency services integration (botón "Llamar 911")

---

## **Título: US-091: Implementar SSO Corporativo con Google Workspace y Microsoft AD**

**Descripción:**

**Resumen:** Integrar autenticación SSO (Single Sign-On) corporativo permitiendo que empresas usen sus credenciales de Google Workspace o Microsoft Active Directory para login.

**Detalle:**
- Configurar Firebase Auth con proveedores OAuth 2.0 (Google, Microsoft)
- Implementar flujo de autenticación SSO en web y mobile
- Sincronizar usuarios automáticamente desde directorio empresarial
- Mantener mapeo entre usuarios SSO y usuarios de Firestore
- Configurar SAML 2.0 para empresas con LDAP custom
- Implementar JIT (Just-In-Time) provisioning de usuarios

**Referencia:** Ver Sección 2.2 (Stack Tecnológico: Firebase Auth + JWT custom) y Sección 3.1.1 (Features Avanzadas: SSO corporativo)

**Criterios de aceptación (AC):**
- AC1: Admin puede configurar SSO desde panel de empresa con credenciales OAuth
- AC2: Usuarios pueden hacer login con botón "Continuar con Google" o "Continuar con Microsoft"
- AC3: Primer login crea automáticamente usuario en Firestore con rol default
- AC4: Roles y permisos se sincronizan desde grupos del directorio empresarial
- AC5: Logout de SSO invalida sesión en SmartFleet y en proveedor OAuth

**Checklist técnica (Tareas):**
- T1: Configurar OAuth 2.0 credentials en Google Cloud Console y Azure AD
- T2: Implementar SignInWithGoogle() y SignInWithMicrosoft() en Firebase Auth
- T3: Crear Cloud Function onSSOLogin que crea/actualiza usuario en Firestore
- T4: Implementar UI de configuración SSO en panel admin (web)
- T5: Agregar botones de SSO en login screen (mobile y web)
- T6: Implementar mapeo de grupos AD/Google → roles SmartFleet (admin, supervisor, conductor)
- T7: Configurar SAML 2.0 para empresas enterprise con LDAP custom
- T8: Implementar JIT provisioning: auto-crear usuario si no existe en Firestore
- T9: Implementar token refresh automático antes de expiración
- T10: Testing: validar login/logout con cuentas Google Workspace y Microsoft 365
- T11: Implementar fallback a email/password si SSO falla
- T12: Agregar analytics: % usuarios que usan SSO vs email/password
- T13: Documentar proceso de configuración SSO en /docs/sso-setup.md
- T14: Crear video tutorial para admins sobre cómo activar SSO

**Estimación:** 13 SP / 21h

**Prioridad:** Media

**Etiquetas (labels):** tipo:feature fase:Fase-2 componente:auth componente:enterprise

**Dependencias:** US-007 (Login básico), US-011 (Login admin web)

**Archivos/Carpetas relacionados:**
- `/lib/features/auth/data/repositories/sso_auth_repository.dart`
- `/firebase/functions/src/triggers/onSSOLogin.ts`
- `/lib/features/admin/presentation/screens/sso_config_screen.dart`
- `/docs/sso-setup.md`

**Notas/Consideraciones:**
- **Enterprise-only**: Feature disponible solo en plan Enterprise y Enterprise Plus (validar subscription.plan)
- **Security**: Nunca almacenar OAuth tokens en Firestore. Solo usar para autenticación, luego generar JWT custom
- **Group sync**: Sincronizar grupos cada 24h con Cloud Scheduler para mantener roles actualizados
- **Multi-tenant**: Cada empresa tiene su propia configuración SSO (diferentes OAuth clients)
- **Onboarding**: Facilita enormemente onboarding de empresas grandes (100+ usuarios). Admin solo configura SSO una vez
- **Audit trail**: Loggear todos los logins SSO para compliance y auditoría

---

## **Título: US-092: Implementar MFA (Autenticación Multi-Factor) obligatoria para roles admin**

**Descripción:**

**Resumen:** Agregar autenticación de dos factores (2FA/MFA) obligatoria para Super Admin y Admin, y opcional para Supervisores y Conductores, usando TOTP (Google Authenticator) o SMS.

**Detalle:**
- Configurar Firebase Auth Multi-Factor Authentication
- Forzar MFA para roles admin y super_admin
- Permitir MFA opcional para otros roles
- Soportar TOTP (Time-based One-Time Password) con apps como Google Authenticator, Authy
- Soportar SMS como método alternativo (opcional, tiene costo)
- Generar códigos de recuperación (backup codes) en caso de pérdida de dispositivo

**Referencia:** Ver Sección 3.1.1 (Features Avanzadas: MFA obligatorio para Super Admin y Admin)

**Criterios de aceptación (AC):**
- AC1: Admin/Super Admin no puede completar login sin configurar MFA
- AC2: Flujo de setup MFA muestra QR code para escanear con Google Authenticator
- AC3: Validación de código TOTP de 6 dígitos antes de permitir acceso
- AC4: Generar 10 códigos de recuperación de un solo uso y mostrar para download/imprimir
- AC5: Opción de habilitar MFA por SMS (validar número de teléfono primero)

**Checklist técnica (Tareas):**
- T1: Habilitar Firebase Multi-Factor Authentication en consola
- T2: Implementar enrollment flow (configuración inicial de MFA) en web y mobile
- T3: Generar QR code con secret key TOTP usando librería `qr_flutter`
- T4: Implementar verificación de código TOTP de 6 dígitos
- T5: Crear Cloud Function que fuerza MFA setup para admin en primer login
- T6: Generar 10 backup codes aleatorios y encriptados en Firestore
- T7: Implementar flujo de recuperación usando backup codes
- T8: Implementar MFA por SMS con Firebase Phone Authentication (opcional)
- T9: Agregar opción "Confiar en este dispositivo por 30 días" (cookie segura)
- T10: Implementar UI de gestión de MFA en perfil de usuario (desactivar, regenerar códigos)
- T11: Enviar email de notificación cuando MFA es desactivado (seguridad)
- T12: Testing: validar con Google Authenticator, Authy, Microsoft Authenticator
- T13: Agregar logging de eventos MFA (setup, login, recuperación) para auditoría
- T14: Crear guía de usuario sobre cómo configurar MFA en /docs/mfa-guide.md

**Estimación:** 13 SP / 21h

**Prioridad:** Alta

**Etiquetas (labels):** tipo:security fase:Fase-2 componente:auth

**Dependencias:** US-007 (Login), US-011 (Login admin web)

**Archivos/Carpetas relacionados:**
- `/lib/features/auth/presentation/screens/mfa_setup_screen.dart`
- `/lib/features/auth/presentation/screens/mfa_verify_screen.dart`
- `/firebase/functions/src/triggers/enforceMFAForAdmins.ts`
- `/lib/features/profile/presentation/screens/mfa_management_screen.dart`
- `/docs/mfa-guide.md`

**Notas/Consideraciones:**
- **Compliance**: MFA es requisito para SOC 2, ISO 27001 y muchos clientes enterprise lo exigen
- **UX balance**: No hacer MFA tan molesto que usuarios busquen workarounds. "Confiar dispositivo 30 días" ayuda
- **SMS costs**: SMS tiene costo (~$0.01/SMS con Twilio). Ofrecer como opción premium o cobrar aparte
- **Backup codes**: Crítico tenerlos. Usuarios pierden celulares. Sin backup codes = lockout permanente
- **Admin lockout**: Si admin pierde acceso y no tiene backup codes, implementar proceso de verificación manual (support ticket)
- **Rate limiting**: Máximo 5 intentos de código incorrecto antes de bloqueo temporal (15 min) para prevenir brute force

---

## **Título: US-093: Implementar Replay de Viajes Premium con Timeline y Export**

**Descripción:**

**Resumen:** Crear feature premium de replay de viajes con timeline interactivo, controles de velocidad, overlay de eventos, y export a video MP4/PDF/GeoJSON.

**Detalle:**
- Vista timeline con slider de tiempo para ver cómo se movió el vehículo paso a paso
- Controles de reproducción: play/pause, 1x, 2x, 5x, 10x speed
- Overlay de eventos en mapa (alertas, paradas, cambios de velocidad)
- Gráficos sincronizados: velocidad vs tiempo, altitud vs tiempo
- Exportar replay como video MP4 (ruta animada en mapa)
- Exportar datos como GeoJSON, KML (Google Earth), PDF report

**Referencia:** Ver Sección 3.4.4 (Replay de Viajes - Feature Premium) y Sección 3.7.3 (Exportación de datos)

**Criterios de aceptación (AC):**
- AC1: Admin puede abrir replay de cualquier viaje completado desde historial
- AC2: Slider de timeline permite saltar a cualquier momento del viaje
- AC3: Controles de velocidad (1x, 2x, 5x, 10x) funcionan correctamente
- AC4: Eventos (alertas, paradas) se muestran como marcadores en timeline y mapa
- AC5: Export a MP4, GeoJSON, KML, PDF funcionan y se descargan correctamente

**Checklist técnica (Tareas):**
- T1: Crear componente ReplayMapWidget con Mapbox GL para renderizar ruta animada
- T2: Implementar slider de timeline con marcadores de eventos
- T3: Cargar route_points del viaje desde Firestore (puede ser muchos, paginar si >1000 puntos)
- T4: Implementar animación de marcador moviéndose sobre polyline
- T5: Agregar controles de velocidad (1x usa intervalo real, 10x acelera 10 veces)
- T6: Sincronizar gráficos de velocidad/altitud con posición en timeline
- T7: Implementar export a GeoJSON (formato estándar para SIG)
- T8: Implementar export a KML para visualización en Google Earth
- T9: Implementar generación de video MP4 usando ffmpeg o similar (backend)
- T10: Crear Cloud Function generateReplayVideo que renderiza frames y genera MP4
- T11: Implementar export a PDF con mapas estáticos (Mapbox Static Images API)
- T12: Agregar pantalla de loading "Generando video... puede tardar 2-3 min"
- T13: Implementar cache de videos generados (no regenerar cada vez, almacenar en Cloud Storage)
- T14: Feature flag: solo disponible para plan Professional y superior

**Estimación:** 21 SP / 34h

**Prioridad:** Baja (Feature Premium)

**Etiquetas (labels):** tipo:feature fase:Fase-2 componente:web componente:premium

**Dependencias:** US-022 (Historial de viajes), US-017 (Mapbox integrado)

**Archivos/Carpetas relacionados:**
- `/lib/features/trips/presentation/screens/trip_replay_screen.dart`
- `/lib/features/trips/presentation/widgets/replay_timeline_widget.dart`
- `/firebase/functions/src/services/videoGenerationService.ts`
- `/firebase/functions/src/utils/exportGeoJSON.ts`
- `/firebase/functions/src/utils/exportKML.ts`

**Notas/Consideraciones:**
- **Performance**: Viajes largos (10h = 2400 puntos GPS) pueden ser pesados. Implementar simplificación con Douglas-Peucker
- **Video generation**: Muy intensivo en CPU. Usar Cloud Functions con 2GB RAM y 540s timeout
- **Storage costs**: Videos MP4 ocupan espacio. Implementar TTL de 7 días (auto-eliminar después)
- **Pricing**: Feature premium que justifica upgrade a plan Professional ($15/veh/mes). Resaltar en marketing
- **Use cases**: Investigación de incidentes, disputas de clientes ("mi paquete llegó tarde"), training de conductores
- **Alternative**: En lugar de video MP4 (caro de generar), considerar GIF animado (más liviano) o link compartible a replay web

---

## **Título: US-094: Implementar i18n (Internacionalización) con soporte para Español, Portugués e Inglés**

**Descripción:**

**Resumen:** Agregar soporte multi-idioma completo en mobile y web con Español (default), Portugués (Brasil) e Inglés, incluyendo formatos de fecha/hora/moneda regionalizados.

**Detalle:**
- Configurar internacionalización con Flutter i18n (intl package)
- Traducir todas las strings de UI a ES, PT-BR, EN
- Formatear fechas/horas según locale (dd/MM/yyyy vs MM/dd/yyyy)
- Formatear números y moneda según región (1.000,50 vs 1,000.50)
- Unidades de medida configurables (km vs miles, litros vs galones)
- Detección automática de idioma del dispositivo
- Selector de idioma manual en configuración de usuario

**Referencia:** Ver Sección implícita en mercado objetivo (Colombia, Perú, Chile, Brasil) y expansión internacional

**Criterios de aceptación (AC):**
- AC1: App detecta idioma del dispositivo en primer inicio y usa ese idioma
- AC2: Usuario puede cambiar idioma manualmente desde Settings
- AC3: 100% de strings de UI están traducidas (no hardcoded strings)
- AC4: Fechas se muestran en formato local (Español: 20/11/2025, Inglés: 11/20/2025)
- AC5: Números se formatean correctamente (Español: 1.234,56 km, Inglés: 1,234.56 mi)

**Checklist técnica (Tareas):**
- T1: Configurar Flutter i18n con `intl` package y `flutter_localizations`
- T2: Crear archivos ARB (Application Resource Bundle) para cada idioma: es.arb, pt.arb, en.arb
- T3: Extraer todas las strings hardcoded y reemplazar con AppLocalizations.of(context).stringKey
- T4: Traducir strings a Portugués (Brasil) y validar con native speaker
- T5: Traducir strings a Inglés y validar
- T6: Implementar formateo de fechas con DateFormat.yMd(locale)
- T7: Implementar formateo de números con NumberFormat.decimalPattern(locale)
- T8: Agregar configuración de unidades de medida: km/miles, litros/galones (independiente de idioma)
- T9: Crear dropdown selector de idioma en Settings screen
- T10: Guardar preferencia de idioma en Firestore (users/{uid}/preferences.locale)
- T11: Implementar cambio de idioma en runtime (rebuild app con nuevo locale)
- T12: Traducir contenido dinámico de backend (nombres de alertas, mensajes de error)
- T13: Testing: validar en dispositivo configurado en ES, PT, EN
- T14: Agregar flag de idioma en analytics para entender distribución de usuarios

**Estimación:** 13 SP / 21h

**Prioridad:** Media

**Etiquetas (labels):** tipo:feature fase:Fase-2 componente:mobile componente:web componente:i18n

**Dependencias:** US-005 (Setup Flutter proyecto), US-006 (Design System)

**Archivos/Carpetas relacionados:**
- `/lib/l10n/app_es.arb`
- `/lib/l10n/app_pt.arb`
- `/lib/l10n/app_en.arb`
- `/lib/core/config/app_localizations.dart`
- `/lib/features/settings/presentation/screens/language_settings_screen.dart`

**Notas/Consideraciones:**
- **Market priority**: Español (Colombia, Perú, Chile), Portugués (Brasil es mercado enorme), Inglés (internacional)
- **RTL support**: No necesario para estos idiomas, pero si se expande a árabe/hebreo en futuro, agregar soporte RTL
- **Pluralization**: Manejar correctamente plurales ("1 vehículo" vs "5 vehículos") con Intl.plural()
- **Date formats**: Muy importante para UX. Usuarios confunden 01/02/2025 (¿Feb 1 o Ene 2?)
- **Currency**: Por ahora solo USD en pricing, pero preparar para COP, BRL, CLP, PEN
- **Content**: Términos de servicio, política de privacidad también deben traducirse (legal requirement)
- **SEO**: Web admin debe tener meta tags en idioma correcto para indexación

---

## **Título: US-095: Implementar Dark Mode con preferencia de usuario y modo automático**

**Descripción:**

**Resumen:** Agregar tema oscuro completo para reducir fatiga visual, con opción de activación manual o automática según hora del día, respetando preferencia del sistema operativo.

**Detalle:**
- Diseñar paleta de colores completa para dark mode siguiendo Material Design 3
- Implementar ThemeData para light y dark themes en Flutter
- Detectar preferencia del sistema operativo (MediaQuery.platformBrightness)
- Permitir al usuario elegir: Light, Dark, Auto (sigue sistema), Auto por horario
- Modo automático por horario: dark mode de 8pm-6am, light mode de 6am-8pm
- Persistir preferencia de tema en Firestore

**Referencia:** Ver Sección 5 (UI/UX) y mejora de accesibilidad

**Criterios de aceptación (AC):**
- AC1: App detecta preferencia de dark mode del sistema operativo en primer inicio
- AC2: Usuario puede cambiar tema desde Settings: Light, Dark, Auto (Sistema), Auto (Horario)
- AC3: Todos los componentes se ven correctamente en dark mode (texto legible, contrastes apropiados)
- AC4: Transición entre light/dark es smooth (animación de 300ms)
- AC5: Preferencia de tema persiste tras cerrar y reabrir app

**Checklist técnica (Tareas):**
- T1: Diseñar paleta de colores dark mode (background, surface, primary, secondary, etc.)
- T2: Crear darkTheme en AppTheme class con ColorScheme.dark()
- T3: Validar contraste de colores en dark mode con WCAG 2.1 AA (4.5:1 mínimo)
- T4: Implementar detección de MediaQuery.of(context).platformBrightness
- T5: Crear ThemeProvider con Riverpod para gestionar estado de tema
- T6: Implementar opciones de tema en Settings screen (4 opciones: Light, Dark, Auto Sistema, Auto Horario)
- T7: Implementar lógica de auto horario (usar hora local del dispositivo)
- T8: Guardar preferencia en Firestore: users/{uid}/preferences.theme_mode
- T9: Aplicar tema con MaterialApp.theme y MaterialApp.darkTheme
- T10: Implementar smooth transition entre temas con AnimatedTheme
- T11: Revisar todos los componentes custom y asegurar que funcionen en dark mode
- T12: Testing en iOS (respeta preferencia de sistema desde iOS 13)
- T13: Testing en Android (respeta preferencia desde Android 10)
- T14: Agregar ilustraciones/screenshots de dark mode en docs y marketing

**Estimación:** 8 SP / 13h

**Prioridad:** Baja

**Etiquetas (labels):** tipo:feature fase:Fase-2 componente:mobile componente:ui

**Dependencias:** US-006 (Design System)

**Archivos/Carpetas relacionados:**
- `/lib/shared/theme/dark_theme.dart`
- `/lib/shared/providers/theme_provider.dart`
- `/lib/features/settings/presentation/screens/theme_settings_screen.dart`

**Notas/Consideraciones:**
- **Battery saving**: Dark mode en pantallas OLED (iPhone X+, Samsung) ahorra batería significativamente (negro puro = píxeles apagados)
- **Eye strain**: Conductores usan app en jornadas largas (10h). Dark mode reduce fatiga visual en horarios nocturnos
- **Mapbox dark style**: Mapbox tiene estilos dark predefinidos. Cambiar a "mapbox://styles/mapbox/dark-v11" cuando dark mode activo
- **Marketing**: Feature "nice to have" que suma puntos en reviews ("la app tiene dark mode ⭐⭐⭐⭐⭐")
- **Accessibility**: Combinar con modo alto contraste para usuarios con baja visión
- **Future**: Permitir dark mode solo en ciertas secciones (ej: mapa siempre dark, dashboard configurable)

---

## **Título: US-096: Implementar Sistema de Email Transaccional con templates y notificaciones automáticas**

**Descripción:**

**Resumen:** Configurar sistema completo de emails transaccionales usando SendGrid o Firebase Extensions para enviar bienvenida, reportes, alertas críticas, documentos por vencer, y notificaciones automáticas.

**Detalle:**
- Integrar SendGrid o Firebase Email Trigger Extension
- Crear templates HTML responsive para cada tipo de email
- Enviar email de bienvenida al registrarse
- Enviar reportes semanales/mensuales automáticamente
- Enviar alertas críticas por email (además de push)
- Notificar documentos próximos a vencer (30, 15, 7 días)
- Implementar sistema de preferencias de email (qué notificaciones recibir)

**Referencia:** Ver Sección 3.7.3 (Reportes automáticos) y comunicaciones en README

**Criterios de aceptación (AC):**
- AC1: Nuevo usuario recibe email de bienvenida con instrucciones de setup
- AC2: Admin recibe reporte semanal automático cada lunes a las 8am con resumen de flota
- AC3: Alertas críticas (colisión, pánico) envían email inmediato a admin y supervisor
- AC4: Email de documentos por vencer llega 30, 15, 7 días antes con listado completo
- AC5: Usuario puede configurar preferencias de email (desactivar reportes pero mantener alertas)

**Checklist técnica (Tareas):**
- T1: Configurar cuenta SendGrid o instalar Firebase Email Extension
- T2: Crear API key de SendGrid y guardar en Firebase Functions config
- T3: Diseñar template HTML base responsive (header, footer, botón CTA)
- T4: Crear template de email de bienvenida con links a guías de inicio
- T5: Crear template de reporte semanal con tabla de KPIs y gráficos embebidos
- T6: Crear template de alerta crítica con detalles del evento y link a dashboard
- T7: Crear template de documentos por vencer con listado y fechas
- T8: Implementar Cloud Function sendWelcomeEmail trigger en user creation
- T9: Implementar Cloud Scheduler para reportes semanales (cron: "0 8 * * MON")
- T10: Implementar Cloud Function sendCriticalAlertEmail trigger en alertas severity: critical
- T11: Implementar Cloud Scheduler para check de documentos por vencer (cron diario)
- T12: Crear UI de preferencias de email en Settings (checkboxes por tipo de email)
- T13: Guardar preferencias en Firestore: users/{uid}/preferences.email_notifications
- T14: Implementar unsubscribe link en footer de emails (compliance con CAN-SPAM Act)
- T15: Agregar analytics de emails: sent, opened, clicked (SendGrid proporciona esto)
- T16: Testing: enviar emails de prueba y validar renderizado en Gmail, Outlook, Apple Mail

**Estimación:** 13 SP / 21h

**Prioridad:** Media

**Etiquetas (labels):** tipo:feature fase:Fase-2 componente:backend componente:comunicaciones

**Dependencias:** US-008 (Registro de usuarios), US-053 (Reportes)

**Archivos/Carpetas relacionados:**
- `/firebase/functions/src/services/emailService.ts`
- `/firebase/functions/src/templates/email/welcome.html`
- `/firebase/functions/src/templates/email/weekly-report.html`
- `/firebase/functions/src/templates/email/critical-alert.html`
- `/firebase/functions/src/templates/email/documents-expiring.html`
- `/lib/features/settings/presentation/screens/email_preferences_screen.dart`

**Notas/Consideraciones:**
- **SendGrid vs Firebase Extension**: SendGrid tiene mejor analytics y deliverability. Firebase Extension es más simple pero limitado
- **Deliverability**: Configurar SPF, DKIM, DMARC records para evitar spam folder
- **Costs**: SendGrid gratis hasta 100 emails/día. Plan esencial $20/mes para 50K emails
- **Compliance**: CAN-SPAM Act requiere unsubscribe link visible y dirección física en footer
- **Personalization**: Usar variables {{driver_name}}, {{company_name}} en templates para personalización
- **Attachments**: Reportes PDF como attachment (limitado a 10MB por SendGrid)
- **i18n**: Templates en español, portugués, inglés según preferencia de usuario
- **Testing**: Usar Mailtrap.io o similar para testing sin enviar emails reales

---

## **Título: US-097: Implementar Sistema de Feedback In-App y Bug Reporting**

**Descripción:**

**Resumen:** Agregar funcionalidad de feedback in-app para que usuarios (conductores y admins) puedan enviar sugerencias, reportar bugs, y calificar features directamente desde la aplicación.

**Detalle:**
- Botón de feedback flotante o en menú de settings
- Formulario de feedback con categorías: Bug, Feature Request, Mejora, Otro
- Captura automática de contexto (versión app, dispositivo, pantalla actual)
- Opción de adjuntar screenshot
- Rating de satisfacción con features específicas (1-5 estrellas)
- Envío a Firestore collection "feedback" y notificación a equipo de producto

**Referencia:** Ver mejoras de UX y comunicación con usuarios en README

**Criterios de aceptación (AC):**
- AC1: Usuario puede acceder a formulario de feedback desde menú o botón flotante
- AC2: Formulario permite elegir categoría, escribir texto, y adjuntar screenshot
- AC3: Al enviar feedback, se captura automáticamente: versión app, OS, dispositivo, usuario
- AC4: Feedback se guarda en Firestore y envía notificación a Slack/Email del equipo
- AC5: Usuario ve mensaje de confirmación "Gracias por tu feedback. Lo revisaremos pronto."

**Checklist técnica (Tareas):**
- T1: Crear collection "feedback" en Firestore con schema adecuado
- T2: Diseñar UI de formulario de feedback (mobile y web)
- T3: Implementar dropdown de categorías: Bug, Feature Request, Mejora, Pregunta, Otro
- T4: Implementar text area para descripción (máximo 500 caracteres)
- T5: Agregar botón "Adjuntar Screenshot" que abre image picker
- T6: Capturar contexto automáticamente: app version, OS, device model, screen name
- T7: Implementar upload de screenshot a Cloud Storage
- T8: Guardar feedback en Firestore: feedback/{feedback_id} con todos los datos
- T9: Crear Cloud Function onFeedbackCreated que envía notificación a Slack webhook
- T10: Implementar rating de features (mostrar lista de features y pedir rating 1-5)
- T11: Agregar analytics: % usuarios que envían feedback, categorías más comunes
- T12: Crear dashboard admin para revisar feedback (filtrar por categoría, fecha, usuario)
- T13: Implementar estado de feedback: Nuevo, Revisado, En Progreso, Resuelto
- T14: Testing: enviar feedback de prueba y verificar que llega a Slack/Email

**Estimación:** 8 SP / 13h

**Prioridad:** Baja

**Etiquetas (labels):** tipo:feature fase:Fase-2 componente:mobile componente:web componente:ux

**Dependencias:** US-005 (Setup Flutter proyecto)

**Archivos/Carpetas relacionados:**
- `/lib/features/feedback/presentation/screens/feedback_screen.dart`
- `/lib/features/feedback/data/repositories/feedback_repository.dart`
- `/firebase/functions/src/triggers/onFeedbackCreated.ts`
- `/lib/features/admin/presentation/screens/feedback_dashboard_screen.dart`

**Notas/Consideraciones:**
- **User voice**: Feedback directo de usuarios es oro para priorizar roadmap. Strava mejoró mucho por escuchar feedback
- **Bug reproduction**: Screenshot + contexto automático facilita enormemente reproducir bugs
- **Spam prevention**: Limitar a 5 feedbacks por usuario por día para evitar spam
- **Response**: Considerar responder a usuarios (especialmente bugs críticos) para mostrar que escuchamos
- **Feature voting**: En futuro, permitir que usuarios voten por feature requests (upvote system)
- **Alternative**: Usar herramientas third-party como UserVoice, Canny, o integrar con Sentry para bugs

---

## **Título: US-098: Implementar Testing Automatizado Completo (Unit, Integration, E2E)**

**Descripción:**

**Resumen:** Configurar suite completa de testing automatizado con unit tests, integration tests y E2E tests, integrados en CI/CD para ejecutarse en cada PR y deploy.

**Detalle:**
- Setup framework de testing (flutter_test, mockito, integration_test)
- Escribir unit tests para lógica de negocio crítica (>80% coverage)
- Escribir integration tests para flujos principales
- Configurar E2E tests con Flutter Driver o Patrol
- Integrar tests en GitHub Actions (ejecutar en cada PR)
- Configurar code coverage reporting (codecov.io)
- Implementar visual regression testing para UI

**Referencia:** Ver Sección 10 (Testing y QA) mencionada en README

**Criterios de aceptación (AC):**
- AC1: Unit tests cubren >80% del código de lógica de negocio
- AC2: Integration tests validan flujos: login, inicio viaje, alertas, reportes
- AC3: E2E tests simulan usuario real en app mobile y web
- AC4: Tests se ejecutan automáticamente en cada PR y fallan build si hay errores
- AC5: Code coverage report se genera y sube a Codecov en cada commit

**Checklist técnica (Tareas):**
- T1: Configurar flutter_test y mockito para unit testing
- T2: Escribir unit tests para repositories, use cases, providers
- T3: Configurar test coverage con `flutter test --coverage`
- T4: Escribir integration tests para flujos críticos (login, trip lifecycle, alerts)
- T5: Configurar integration_test package para testing en device/emulador
- T6: Escribir E2E tests con Patrol (mejor DX que Flutter Driver)
- T7: Configurar Firebase Test Lab para ejecutar tests en múltiples dispositivos reales
- T8: Agregar step de testing en GitHub Actions workflow
- T9: Configurar Codecov.io y subir coverage report en cada commit
- T10: Implementar golden tests para visual regression (flutter_test goldens)
- T11: Crear mock data factories para facilitar testing
- T12: Configurar Firebase Emulator Suite para testing de Cloud Functions
- T13: Implementar performance tests para validar consumo de batería y memoria
- T14: Documentar en /docs/testing-guide.md cómo escribir y ejecutar tests

**Estimación:** 21 SP / 34h

**Prioridad:** Alta

**Etiquetas (labels):** tipo:infra fase:Fase-1 componente:testing componente:ci-cd

**Dependencias:** US-004 (CI/CD setup), US-005 (Flutter proyecto)

**Archivos/Carpetas relacionados:**
- `/test/unit/` (unit tests)
- `/test/integration/` (integration tests)
- `/integration_test/` (E2E tests)
- `/.github/workflows/test.yml`
- `/docs/testing-guide.md`

**Notas/Consideraciones:**
- **ROI**: Testing ahorra tiempo a largo plazo. Cada bug encontrado en testing es 10x más barato que en producción
- **Coverage target**: 80% es balance entre effort y valor. 100% es overkill y difícil de mantener
- **Flaky tests**: E2E tests son propensos a fallar intermitentemente. Implementar retries y timeouts apropiados
- **Firebase Emulator**: Crítico para testing de Cloud Functions sin tocar producción
- **Performance**: Tests deben ejecutarse rápido (<5 min total) para no bloquear desarrollo
- **Mocking**: Usar mockito para mockear Firebase Auth, Firestore, etc en unit tests
- **Golden tests**: Screenshots de UI que se comparan pixel-by-pixel. Detectan cambios visuales no intencionados

---

## **Título: US-099: Implementar Training Pipeline Automatizado para Modelos de Machine Learning**

**Descripción:**

**Resumen:** Crear pipeline automatizado de entrenamiento de modelos ML en BigQuery ML con reentrenamiento mensual, A/B testing, model versioning y rollback capability.

**Detalle:**
- Configurar BigQuery ML para entrenar modelos en la nube
- Implementar pipeline de ETL: Firestore → BigQuery
- Automatizar entrenamiento mensual con Cloud Scheduler
- Implementar A/B testing de modelos (70% tráfico a modelo actual, 30% a nuevo)
- Versionado de modelos con métricas de performance
- Rollback automático si nuevo modelo tiene peor performance
- Dashboard de monitoreo de modelos (accuracy, precision, recall)

**Referencia:** Ver Sección 3.5.5 (ML para predicción de incidentes) y Fase 3 (Sprints 17-18)

**Criterios de aceptación (AC):**
- AC1: Pipeline ETL sincroniza datos de Firestore a BigQuery cada 15 minutos
- AC2: Modelo de predicción de incidentes se reentrena automáticamente cada mes
- AC3: Nuevo modelo se valida contra test set antes de deploy
- AC4: A/B testing permite comparar modelo actual vs nuevo con tráfico real
- AC5: Dashboard muestra métricas de performance de cada versión de modelo

**Checklist técnica (Tareas):**
- T1: Configurar BigQuery dataset para ML: smartfleet_ml
- T2: Crear Cloud Function para ETL: Firestore → BigQuery (incremental sync)
- T3: Configurar Cloud Scheduler para ejecutar ETL cada 15 min
- T4: Escribir query SQL de entrenamiento en BigQuery ML (CREATE MODEL)
- T5: Implementar feature engineering: calcular features agregados de conductores
- T6: Configurar Cloud Scheduler para reentrenamiento mensual (primer día de mes)
- T7: Implementar validación de modelo: calcular accuracy, precision, recall en test set
- T8: Crear tabla de versiones de modelos con métricas: ml_models_versions
- T9: Implementar lógica de A/B testing: asignar 30% tráfico a nuevo modelo
- T10: Implementar comparación de métricas: si nuevo modelo <5% mejor, rollback
- T11: Crear Cloud Function getModelPrediction que rutea a modelo según A/B test
- T12: Implementar monitoreo de predicciones en tiempo real (Prometheus metrics)
- T13: Crear dashboard en Looker Studio con métricas de modelos
- T14: Documentar arquitectura de ML pipeline en /docs/ml-pipeline.md

**Estimación:** 21 SP / 34h

**Prioridad:** Baja (Fase 3)

**Etiquetas (labels):** tipo:feature fase:Fase-3 componente:ml componente:backend

**Dependencias:** US-061 (TensorFlow Lite setup), US-062 (Detección de comportamiento), US-054 (BigQuery integration)

**Archivos/Carpetas relacionados:**
- `/firebase/functions/src/etl/firestoreToBigQuery.ts`
- `/bigquery/sql/train_incident_prediction_model.sql`
- `/bigquery/sql/evaluate_model.sql`
- `/firebase/functions/src/ml/modelRouter.ts`
- `/docs/ml-pipeline.md`

**Notas/Consideraciones:**
- **Data quality**: Garbage in, garbage out. Validar calidad de datos antes de entrenar (sin nulls, outliers)
- **Feature importance**: Analizar qué features son más importantes para mejorar modelo (SHAP values)
- **Overfitting**: Modelo puede memorizar training data. Validar con test set completamente separado
- **Cold start**: Nuevos conductores sin historial no tienen features. Usar modelo default o clustering
- **Costs**: BigQuery ML cobra por TB procesado. Optimizar queries para reducir costos
- **Monitoring**: Detectar model drift (cuando real world data cambia y modelo empeora)
- **Ethics**: Asegurar que modelo no discrimina por edad, género, u otros factores protegidos

---

## **Título: US-100: Implementar Conectores Pre-built para Integraciones ERP/TMS (SAP, Oracle, Odoo)**

**Descripción:**

**Resumen:** Crear conectores pre-built para integración con sistemas ERP y TMS empresariales más comunes (SAP, Oracle NetSuite, Odoo, QuickBooks) permitiendo sincronización bidireccional de datos.

**Detalle:**
- Diseñar arquitectura de conectores con abstraction layer
- Implementar conector para SAP ERP (sync de vehículos, conductores, viajes)
- Implementar conector para Oracle NetSuite
- Implementar conector para Odoo (open-source ERP)
- Implementar conector para QuickBooks (sync de costos, facturas)
- Sincronización bidireccional: SmartFleet ↔ ERP
- Configuración de mapping de campos custom por cliente

**Referencia:** Ver Sección 7.4 Sprint 21-22 (Marketplace de Integraciones) y Tier Enterprise features

**Criterios de aceptación (AC):**
- AC1: Admin puede configurar conector SAP desde panel con credenciales de API
- AC2: Vehículos creados en SAP se sincronizan automáticamente a SmartFleet
- AC3: Viajes completados en SmartFleet se envían a ERP como registros de servicio
- AC4: Costos de combustible/mantenimiento se sincronizan a QuickBooks para facturación
- AC5: Errores de sincronización se loggean y notifican a admin

**Checklist técnica (Tareas):**
- T1: Diseñar interfaz IERPConnector con métodos: syncVehicles, syncDrivers, syncTrips
- T2: Implementar SAPConnector usando SAP Business One API
- T3: Implementar OracleNetSuiteConnector usando SuiteScript API
- T4: Implementar OdooConnector usando Odoo XML-RPC API
- T5: Implementar QuickBooksConnector usando QuickBooks Online API
- T6: Crear UI de configuración de conectores en admin panel
- T7: Implementar OAuth 2.0 authentication para cada conector
- T8: Implementar field mapping configurado: permitir mapear campos SmartFleet ↔ ERP
- T9: Crear Cloud Function syncToERP que ejecuta sincronización cada hora
- T10: Implementar error handling y retry con exponential backoff
- T11: Crear tabla de sync logs: integration_sync_logs para auditoría
- T12: Implementar webhook endpoints para recibir updates desde ERP (bidireccional)
- T13: Documentar proceso de configuración de cada conector en /docs/integrations/
- T14: Testing: validar sync con instancias de prueba de SAP, Oracle, Odoo, QuickBooks

**Estimación:** 34 SP / 55h

**Prioridad:** Baja (Enterprise Feature, Fase 3)

**Etiquetas (labels):** tipo:feature fase:Fase-3 componente:integrations componente:enterprise

**Dependencias:** US-083 (API REST pública), US-082 (Super-admin panel)

**Archivos/Carpetas relacionados:**
- `/firebase/functions/src/integrations/connectors/IERPConnector.ts`
- `/firebase/functions/src/integrations/connectors/SAPConnector.ts`
- `/firebase/functions/src/integrations/connectors/OracleConnector.ts`
- `/firebase/functions/src/integrations/connectors/OdooConnector.ts`
- `/firebase/functions/src/integrations/connectors/QuickBooksConnector.ts`
- `/lib/features/admin/presentation/screens/integrations_config_screen.dart`
- `/docs/integrations/sap-connector.md`
- `/docs/integrations/oracle-connector.md`

**Notas/Consideraciones:**
- **Complexity**: Integraciones ERP son complejas. Cada sistema tiene su API y quirks. Estimar 2-3 semanas por conector
- **Enterprise-only**: Feature exclusiva de plan Enterprise Plus. Justifica pricing alto ($10K+ setup fee)
- **Custom development**: Muchas empresas requieren customización. Ofrecer como servicio profesional adicional
- **Data ownership**: Clarificar quién es source of truth (SmartFleet vs ERP) para evitar conflictos
- **Performance**: Sincronización de miles de registros puede ser lenta. Implementar sync incremental (solo cambios)
- **Security**: APIs de ERP tienen credenciales sensibles. Almacenar encriptadas en Secret Manager
- **Revenue stream**: Cobrar por conector activado (~$500/mes por integración) o incluir en Enterprise Plus
- **Marketplace**: En futuro, permitir partners crear sus propios conectores y publicar en marketplace

---

## **Título: US-101: Implementar 5 Dashboards de Looker Studio con Métricas Detalladas**

**Descripción:**

**Resumen:** Crear 5 dashboards completos en Looker Studio conectados a BigQuery con métricas específicas: Operaciones en Vivo, Análisis de Conductores, Eficiencia de Flota, Cumplimiento y Seguridad, y Análisis Financiero.

**Detalle:**
- Dashboard 1: Operaciones en Vivo (actualización cada 5 min)
- Dashboard 2: Análisis de Conductores (actualización diaria)
- Dashboard 3: Eficiencia de Flota (actualización diaria)
- Dashboard 4: Cumplimiento y Seguridad (actualización diaria)
- Dashboard 5: Análisis Financiero (actualización semanal)
- Configurar data sources desde BigQuery
- Implementar filtros interactivos por empresa, sucursal, fecha
- Embedir dashboards en panel web admin con iframe

**Referencia:** Ver Sección 3.7.2 (Dashboards de Looker Studio) con definición completa de cada dashboard

**Criterios de aceptación (AC):**
- AC1: 5 dashboards creados en Looker Studio con diseño profesional y branding SmartFleet
- AC2: Datos se actualizan automáticamente desde BigQuery según frecuencia definida
- AC3: Filtros permiten segmentar por empresa, sucursal, rango de fechas
- AC4: Dashboards embebidos en panel web admin funcionan correctamente
- AC5: Admin puede exportar cada dashboard a PDF directamente desde Looker

**Checklist técnica (Tareas):**
- T1: Configurar BigQuery data sources en Looker Studio para cada dashboard
- T2: **Dashboard 1 - Operaciones en Vivo**: mapa de calor, vehículos activos, alertas, viajes en curso, ETA próximos
- T3: **Dashboard 2 - Conductores**: ranking driver score, distribución de alertas, horas conducidas, top performers
- T4: **Dashboard 3 - Eficiencia**: utilización de flota, km por vehículo, tiempo muerto, combustible, costo por km
- T5: **Dashboard 4 - Cumplimiento**: documentos vencidos, capacitaciones, horas de conducción, IPOs completadas
- T6: **Dashboard 5 - Financiero**: costos totales, ROI de flota, TCO por vehículo, proyección gastos
- T7: Implementar queries SQL optimizadas en BigQuery para cada métrica
- T8: Configurar refresh automático de data sources (5 min para Dashboard 1, diario para 2-4, semanal para 5)
- T9: Diseñar layout responsive para cada dashboard (funciona en desktop y tablet)
- T10: Implementar filtros globales: company_id, branch, date_range
- T11: Agregar branding: logo SmartFleet, colores corporativos, footer con copyright
- T12: Configurar permisos de acceso: cada empresa solo ve sus datos (filter by company_id)
- T13: Embedir dashboards en panel web admin usando Looker Studio embed URLs
- T14: Testing: validar que datos mostrados coinciden con Firestore/BigQuery
- T15: Documentar cómo crear custom dashboards en /docs/looker-studio-guide.md

**Estimación:** 21 SP / 34h

**Prioridad:** Media

**Etiquetas (labels):** tipo:feature fase:Fase-2 componente:analytics componente:web

**Dependencias:** US-054 (BigQuery integration), US-053 (Analytics dashboard base)

**Archivos/Carpetas relacionados:**
- `/bigquery/views/dashboard_operations_live.sql`
- `/bigquery/views/dashboard_drivers_analysis.sql`
- `/bigquery/views/dashboard_fleet_efficiency.sql`
- `/bigquery/views/dashboard_compliance.sql`
- `/bigquery/views/dashboard_financial.sql`
- `/lib/features/admin/presentation/screens/looker_dashboards_screen.dart`
- `/docs/looker-studio-guide.md`

**Notas/Consideraciones:**
- **Looker Studio**: Gratis y muy potente. Conecta directamente a BigQuery sin costo adicional
- **Performance**: Queries en BigQuery deben estar optimizadas. Usar vistas materializadas para dashboards que consultan mucho data
- **Real-time**: Dashboard 1 actualiza cada 5 min porque Looker no soporta true real-time. Para real-time usar websockets en panel web
- **Custom dashboards**: Empresas enterprise pueden solicitar dashboards custom. Cobrar como servicio profesional ($2K-5K)
- **Sharing**: Admin puede compartir link público de dashboard (útil para presentaciones a stakeholders)
- **Mobile**: Looker Studio funciona en mobile pero UX no es óptima. Recomendar usar desde desktop
- **Data governance**: Asegurar que filtro de company_id está siempre aplicado para multi-tenancy

---

## **Título: US-102: Implementar Modo Alto Contraste y Ajustes de Accesibilidad Completos**

**Descripción:**

**Resumen:** Agregar suite completa de features de accesibilidad incluyendo modo alto contraste, ajuste de tamaño de fuente, reducción de animaciones, navegación por teclado, y compatibilidad con screen readers.

**Detalle:**
- Modo alto contraste WCAG AAA (ratio 7:1)
- Ajuste de tamaño de fuente (80%, 100%, 125%, 150%)
- Reducir/eliminar animaciones (respect prefers-reduced-motion)
- Navegación completa por teclado en web
- Labels descriptivos para screen readers (TalkBack, VoiceOver)
- Textos alternativos para todas las imágenes
- Estados de foco visibles y claros

**Referencia:** Ver Sección 4.4 (Features de Accesibilidad) en README

**Criterios de aceptación (AC):**
- AC1: Usuario puede activar modo alto contraste desde Settings y colores cumplen WCAG AAA
- AC2: Slider de tamaño de fuente ajusta todo el texto de la app (80%-150%)
- AC3: Opción "Reducir animaciones" desactiva todas las animaciones no esenciales
- AC4: Web dashboard es navegable 100% por teclado (Tab, Enter, Esc)
- AC5: TalkBack (Android) y VoiceOver (iOS) leen correctamente todos los elementos

**Checklist técnica (Tareas):**
- T1: Diseñar paleta de alto contraste con ratios 7:1 (WCAG AAA)
- T2: Crear HighContrastTheme con colores validados (usar herramienta de contrast checker)
- T3: Implementar toggle de alto contraste en Settings
- T4: Crear slider de tamaño de fuente con opciones: 80%, 100%, 125%, 150%
- T5: Implementar MediaQuery textScaleFactor para aplicar tamaño globalmente
- T6: Detectar prefers-reduced-motion del sistema operativo
- T7: Implementar toggle manual "Reducir animaciones" en Settings
- T8: Envolver animaciones en conditional: if (!reduceMotion) AnimatedWidget()
- T9: Agregar Semantics widgets a todos los componentes custom para screen readers
- T10: Implementar Focus management en web con FocusNode y requestFocus()
- T11: Agregar keyboard shortcuts en web: Ctrl+K para buscar, Esc para cerrar modales
- T12: Validar orden de tab en formularios (lógico y predecible)
- T13: Agregar alt text a todas las imágenes (Image.network(..., semanticLabel: 'description'))
- T14: Testing con TalkBack activado en Android y VoiceOver en iOS
- T15: Testing de navegación por teclado en web (sin usar mouse)
- T16: Documentar features de accesibilidad en /docs/accessibility.md

**Estimación:** 13 SP / 21h

**Prioridad:** Media

**Etiquetas (labels):** tipo:feature fase:Fase-2 componente:mobile componente:web componente:accessibility

**Dependencias:** US-006 (Design System), US-095 (Dark mode)

**Archivos/Carpetas relacionados:**
- `/lib/shared/theme/high_contrast_theme.dart`
- `/lib/shared/providers/accessibility_provider.dart`
- `/lib/features/settings/presentation/screens/accessibility_settings_screen.dart`
- `/docs/accessibility.md`

**Notas/Consideraciones:**
- **Legal compliance**: En algunos países (USA, EU) accesibilidad es requisito legal para apps públicas (ADA, EAA)
- **Market expansion**: Accesibilidad abre mercado a usuarios con discapacidades visuales (8% de población)
- **Elderly users**: Tamaño de fuente ajustable es crucial para usuarios mayores (supervisores típicamente 45+ años)
- **Testing**: Contratar tester con discapacidad visual para validación real (mejor que testing técnico)
- **Screen reader**: Priorizar mensajes importantes. Evitar leer todo ("Alert: speed exceeded" vs "Alert speed exceeded 120 km/h in zone...")
- **Color-blind**: Validar que UI no depende solo de color (usar íconos + texto además de color)
- **WCAG levels**: AA es estándar (4.5:1), AAA es gold standard (7:1). Aspirar a AAA para competitive advantage

---

## **Título: US-103: Implementar Navegación Turn-by-Turn con Instrucciones de Voz**

**Descripción:**

**Resumen:** Integrar navegación turn-by-turn usando Mapbox Navigation SDK con instrucciones de voz en tiempo real, recalculo automático por tráfico, y vista de carril.

**Detalle:**
- Integrar Mapbox Navigation SDK para Android e iOS
- Mostrar ruta en mapa con instrucciones turn-by-turn
- Síntesis de voz con instrucciones ("En 200 metros, gire a la derecha")
- Recalculo automático de ruta cuando conductor se desvía
- Actualización de ETA en tiempo real según tráfico
- Vista de carril para intersecciones complejas
- Modo day/night automático según hora

**Referencia:** Ver Sprint 19-20 (Optimización de Rutas + IA) en Sección 7.4 del README

**Criterios de aceptación (AC):**
- AC1: Conductor puede iniciar navegación desde pantalla de viaje asignado
- AC2: Instrucciones de voz se reproducen automáticamente en momentos apropiados
- AC3: Si conductor se desvía de ruta, se recalcula automáticamente en 3-5 segundos
- AC4: ETA se actualiza cada minuto según condiciones de tráfico
- AC5: Vista de carril se muestra 500m antes de intersecciones complejas

**Checklist técnica (Tareas):**
- T1: Agregar Mapbox Navigation SDK dependency en pubspec.yaml
- T2: Configurar Mapbox Navigation tokens para Android e iOS
- T3: Implementar NavigationScreen con MapboxNavigation widget
- T4: Calcular ruta con Mapbox Directions API (truck profile)
- T5: Iniciar navegación con startNavigation() y route geometry
- T6: Configurar text-to-speech (TTS) para instrucciones de voz en español
- T7: Implementar callback onRouteProgressChanged para actualizar UI
- T8: Detectar desvío de ruta y triggear recalculo con reroute()
- T9: Actualizar ETA cada minuto usando real-time traffic data
- T10: Implementar vista de carril con lane guidance banners
- T11: Configurar estilo de mapa day/night según hora (6am-6pm day, 6pm-6am night)
- T12: Implementar control de volumen de instrucciones de voz (configurable en Settings)
- T13: Agregar botón "Detener navegación" que finaliza y vuelve a mapa normal
- T14: Testing: simular rutas largas con route simulation mode
- T15: Testing: validar recalculo de ruta en situaciones reales (desvíos, tráfico)

**Estimación:** 21 SP / 34h

**Prioridad:** Media (Fase 2-3)

**Etiquetas (labels):** tipo:feature fase:Fase-2 componente:mobile componente:navigation

**Dependencias:** US-017 (Mapbox integrado), US-086 (Dispatching asigna rutas)

**Archivos/Carpetas relacionados:**
- `/lib/features/navigation/presentation/screens/turn_by_turn_screen.dart`
- `/lib/features/navigation/data/services/mapbox_navigation_service.dart`
- `/android/app/src/main/AndroidManifest.xml` (permisos de navegación)
- `/ios/Runner/Info.plist` (permisos de ubicación en background)

**Notas/Consideraciones:**
- **Mapbox Navigation SDK**: Más caro que Directions API. $0.06/sesión vs $0.006/request. Validar ROI
- **Offline**: Mapbox Navigation soporta offline maps (descargar regiones). Útil para zonas rurales sin 4G
- **Voice**: TTS quality varía por idioma. Validar que español suena natural (usar Google TTS como fallback)
- **Battery**: Navegación consume batería (pantalla siempre on + GPS high-accuracy). Advertir a usuarios
- **Truck routing**: Critical usar truck profile para evitar rutas prohibidas (peso, altura)
- **Alternative**: Google Maps Navigation API es opción pero no tiene truck routing
- **Competitive edge**: Waze tiene gran UX de navegación. Aprender de sus patterns

---

## **Título: US-104: Implementar Optimización de Rutas Multi-Parada con Algoritmo TSP**

**Descripción:**

**Resumen:** Crear optimizador de rutas que resuelve problema del viajante (TSP) para determinar orden óptimo de visitas a múltiples paradas minimizando distancia y tiempo total.

**Detalle:**
- Algoritmo de optimización de rutas multi-parada (hasta 25 paradas)
- Resolver Traveling Salesman Problem (TSP) con heurística eficiente
- Considerar restricciones: ventanas horarias, prioridades, capacidad de vehículo
- Visualización de ruta optimizada en mapa
- Comparación: ruta manual vs ruta optimizada (ahorro estimado)
- Reasignación dinámica si conductor no puede completar ruta

**Referencia:** Ver US-087 mencionado en resumen de issues faltantes y Sección 7.4 (Optimización de rutas)

**Criterios de aceptación (AC):**
- AC1: Admin puede ingresar lista de hasta 25 paradas y sistema calcula orden óptimo
- AC2: Algoritmo considera ventanas horarias ("entregar entre 9am-11am")
- AC3: Ruta optimizada se muestra en mapa con orden numerado de paradas
- AC4: Sistema muestra ahorro estimado vs ruta no optimizada (km, tiempo, combustible)
- AC5: Admin puede ajustar manualmente orden y re-optimizar

**Checklist técnica (Tareas):**
- T1: Implementar algoritmo Nearest Neighbor para TSP (baseline rápido)
- T2: Implementar algoritmo 2-opt para mejorar solución (local optimization)
- T3: Integrar con Mapbox Optimization API (alternativa a implementación propia)
- T4: Crear modelo de datos para paradas: address, lat/lng, time_window, priority, service_duration
- T5: Implementar matriz de distancias entre todas las paradas (N×N matrix)
- T6: Calcular tiempo de viaje entre paradas usando Mapbox Directions API
- T7: Implementar restricción de ventanas horarias (no llegar antes/después de tiempo permitido)
- T8: Implementar restricción de capacidad de vehículo (peso/volumen total)
- T9: Crear UI de planificador de rutas: arrastrar/soltar paradas, definir orden
- T10: Visualizar ruta optimizada en mapa con marcadores numerados
- T11: Calcular métricas: distancia total, tiempo total, costo combustible estimado
- T12: Comparar ruta optimizada vs ruta manual (mostrar % de ahorro)
- T13: Implementar "Re-optimizar desde parada actual" si conductor va retrasado
- T14: Testing: validar con casos reales de 10, 15, 20, 25 paradas
- T15: Documentar algoritmo y limitaciones en /docs/route-optimization.md

**Estimación:** 21 SP / 34h

**Prioridad:** Media (Fase 3)

**Etiquetas (labels):** tipo:feature fase:Fase-3 componente:backend componente:optimization

**Dependencias:** US-017 (Mapbox), US-086 (Dispatching), US-103 (Navegación)

**Archivos/Carpetas relacionados:**
- `/firebase/functions/src/services/routeOptimizationService.ts`
- `/firebase/functions/src/algorithms/tsp_nearest_neighbor.ts`
- `/firebase/functions/src/algorithms/tsp_2opt.ts`
- `/lib/features/trips/presentation/screens/route_planner_screen.dart`
- `/docs/route-optimization.md`

**Notas/Consideraciones:**
- **Complexity**: TSP es NP-hard. Para 25 paradas hay 15 septillones de permutaciones. Usar heurísticas (no solución exacta)
- **Mapbox Optimization API**: Resuelve TSP hasta 12 paradas. Para >12 usar implementación propia
- **OR-Tools**: Google OR-Tools tiene excelente solver para vehicle routing. Considerar como alternativa
- **Time windows**: Complica problema significativamente. Puede no haber solución factible si ventanas muy estrictas
- **Real-world**: Agregar tiempo de servicio en cada parada (ej: 10 min para descarga). No asumir que llegada = salida
- **Dynamic re-routing**: Si conductor se atrasa, re-optimizar ruta restante (puede cambiar orden de paradas futuras)
- **ROI**: Ahorro de 10-15% en combustible/tiempo justifica inversión en este feature

---

## **Título: US-105: Implementar Marketplace de Integraciones con Portal de Desarrolladores**

**Descripción:**

**Resumen:** Crear marketplace de integraciones donde partners pueden publicar sus conectores, apps y extensiones, con portal de desarrolladores que incluye documentación API, sandbox, y revenue sharing.

**Detalle:**
- Portal de desarrolladores con documentación completa de API
- Sandbox environment para testing de integraciones
- Marketplace web donde se listan integraciones disponibles
- Sistema de review y rating de integraciones
- Revenue sharing: 70% partner, 30% SmartFleet
- OAuth 2.0 para autorización de apps de terceros
- Analytics de uso de cada integración

**Referencia:** Ver Sección 7.4 Sprint 21-22 (Marketplace de Integraciones) y modelo de negocio (revenue stream adicional)

**Criterios de aceptación (AC):**
- AC1: Developer puede registrarse en portal y obtener API key de sandbox
- AC2: Documentación de API está completa con ejemplos de código en 3+ lenguajes
- AC3: Marketplace muestra integraciones disponibles con descripción, precio, ratings
- AC4: Admin puede instalar integración desde marketplace con 1 click
- AC5: Revenue sharing funciona: 70% va a partner, 30% a SmartFleet

**Checklist técnica (Tareas):**
- T1: Crear sitio web de developer portal (puede ser Flutter Web o Next.js)
- T2: Implementar registro de developers y generación de API keys
- T3: Crear documentación interactiva de API con Swagger/OpenAPI UI
- T4: Generar code examples automáticamente en Python, JavaScript, PHP, Java, C#
- T5: Configurar sandbox environment (Firestore dev, API keys limitadas)
- T6: Crear collection "marketplace_apps" en Firestore con schema de apps
- T7: Implementar UI de marketplace con grid de apps (card con logo, nombre, descripción)
- T8: Agregar filtros: categoría (Analytics, CRM, ERP, etc), precio, rating
- T9: Implementar sistema de reviews (1-5 estrellas + comentarios)
- T10: Implementar OAuth 2.0 flow para apps de terceros (authorization code grant)
- T11: Crear panel de developer analytics: requests/día, errores, latencia
- T12: Implementar billing de integraciones: cobrar a empresa, pagar a developer
- T13: Configurar Stripe Connect para revenue sharing (70/30 split automático)
- T14: Implementar webhook system para notificar a partners de eventos
- T15: Testing: publicar 2-3 integraciones de ejemplo (ej: conector Google Sheets, Slack)
- T16: Documentar proceso de publicación de apps en /docs/marketplace-publish-guide.md

**Estimación:** 34 SP / 55h

**Prioridad:** Baja (Fase 3, Post-MVP)

**Etiquetas (labels):** tipo:feature fase:Fase-3 componente:marketplace componente:api componente:business

**Dependencias:** US-083 (API REST pública), US-084 (Webhooks), US-100 (Conectores ERP)

**Archivos/Carpetas relacionados:**
- `/developer-portal/` (sitio separado, puede ser Next.js)
- `/lib/features/marketplace/presentation/screens/marketplace_screen.dart`
- `/firebase/functions/src/marketplace/appInstaller.ts`
- `/firebase/functions/src/billing/revenueSharing.ts`
- `/docs/api/openapi.yaml`
- `/docs/marketplace-publish-guide.md`

**Notas/Consideraciones:**
- **Inspiration**: Geotab Marketplace tiene 430+ apps. Modelo exitoso de ecosystem de partners
- **Quality control**: Revisar apps antes de publicar (approval process). No permitir apps maliciosas o spam
- **Revenue model**: 70/30 split es estándar (Apple/Google usan 70/30, Shopify usa 80/20)
- **API versioning**: Mantener backwards compatibility. Versionar API (v1, v2) para no romper integraciones
- **Rate limiting**: Apps de terceros deben tener rate limits para proteger infraestructura
- **Security**: Apps pueden acceder a datos sensibles. Implementar OAuth scopes granulares (read:trips, write:vehicles)
- **Marketing**: Marketplace atrae developers que traen sus propios clientes. Win-win
- **Future**: Developer conference anual para promover ecosystem (inspirado en Salesforce Dreamforce)

---

## **Título: US-106: Implementar Optimización Avanzada de Batería con Geofencing Inteligente**

**Descripción:**

**Resumen:** Mejorar consumo de batería del tracking GPS implementando geofencing inteligente, motion detection adaptativo, batch upload con WiFi, y compression con algoritmo Douglas-Peucker para reducir consumo a <8% en jornada de 10h.

**Detalle:**
- Geofencing inteligente: pausar tracking en zonas de descanso (terminales, talleres)
- Motion detection: si acelerómetro detecta 0 movimiento por 5 min, pausar GPS
- Cambiar a low-power mode (WiFi/Cell tower location) cuando detenido
- Batch upload: almacenar puntos offline y subir en bulk al conectar WiFi
- Compression: simplificar rutas con algoritmo Douglas-Peucker (reducir 60-70% puntos)
- Intervalos adaptativos: más frecuente en movimiento, menos en detenido

**Referencia:** Ver Sección 3.3.2 (Optimización de Batería) con meta de <8% consumo en 10h

**Criterios de aceptación (AC):**
- AC1: Tracking consume <8% de batería en jornada de 10h (validado en dispositivos reales)
- AC2: Sistema detecta zonas de descanso (geocercas) y pausa tracking automáticamente
- AC3: Motion detection pausa GPS tras 5 min sin movimiento
- AC4: Puntos GPS se almacenan offline y suben en batch al conectar WiFi
- AC5: Algoritmo Douglas-Peucker reduce 60-70% puntos sin pérdida de precisión significativa

**Checklist técnica (Tareas):**
- T1: Implementar detección de entrada a zona de descanso (geocercas pre-configuradas)
- T2: Pausar location stream al entrar en zona de descanso, reactivar al salir
- T3: Integrar acelerómetro con sensors_plus package
- T4: Detectar 0 movimiento por 5 min consecutivos (threshold: <0.1 m/s²)
- T5: Cambiar a LocationAccuracy.low cuando vehículo detenido (ahorra 50% batería)
- T6: Reactivar LocationAccuracy.high al detectar movimiento
- T7: Implementar offline storage de puntos GPS con Hive (NoSQL local)
- T8: Detectar conexión WiFi con connectivity_plus package
- T9: Subir batch de puntos a Firestore al conectar WiFi (WriteBatch de hasta 500 docs)
- T10: Implementar algoritmo Douglas-Peucker para simplificación de polylines
- T11: Aplicar D-P con epsilon = 0.0001 (balance entre precisión y reducción)
- T12: Implementar intervalos adaptativos: 10s en movimiento, 20s lento, 60s detenido
- T13: Agregar analytics de consumo de batería (battery_plus package)
- T14: Testing: medir consumo real en dispositivos iOS/Android con battery profiler
- T15: Documentar optimizaciones en /docs/battery-optimization.md

**Estimación:** 13 SP / 21h

**Prioridad:** Alta

**Etiquetas (labels):** tipo:feature fase:Fase-1 componente:mobile componente:tracking componente:performance

**Dependencias:** US-013 (Tracking GPS), US-014 (Sincronización Firestore), US-031 (Motion detection)

**Archivos/Carpetas relacionados:**
- `/lib/features/tracking/data/services/battery_optimized_gps_service.dart`
- `/lib/features/tracking/data/services/motion_detector.dart`
- `/lib/features/tracking/data/services/offline_storage_service.dart`
- `/lib/features/tracking/utils/douglas_peucker.dart`
- `/docs/battery-optimization.md`

**Notas/Consideraciones:**
- **Critical for adoption**: Si app consume mucha batería, conductores la desinstalan o desactivan tracking
- **Benchmarking**: Apps de tracking promedio consumen 12-18% batería. Meta de <8% es competitive advantage
- **Douglas-Peucker**: Algoritmo geométrico que elimina puntos redundantes en línea recta. Esencial para reducir storage/bandwidth
- **WiFi upload**: Mayoría de conductores tienen WiFi en terminal al final de jornada. Batch upload ahorra mucho data móvil
- **iOS vs Android**: iOS es más restrictivo con background location. Validar que optimizaciones funcionan en ambos
- **Testing methodology**: Usar dispositivos reales en viajes simulados de 10h (no confiar solo en emulador)
- **Trade-offs**: Menos frecuencia = menos batería pero menos precisión. Encontrar balance óptimo

---

## **Título: US-107: Implementar GraphQL API además de REST para Queries Complejas**

**Descripción:**

**Resumen:** Agregar endpoint GraphQL junto a API REST existente para permitir queries complejas con fetching selectivo de campos, reducir over-fetching, y mejorar performance de integraciones.

**Detalle:**
- Setup GraphQL server con Apollo Server en Cloud Functions
- Definir schema GraphQL completo (types, queries, mutations)
- Implementar resolvers para todas las entidades principales
- Soportar queries anidadas y relaciones (trips → driver → vehicle)
- Implementar DataLoader para batch loading y evitar N+1 queries
- GraphQL Playground para testing interactivo
- Autenticación con JWT en headers

**Referencia:** Ver Sección 7.4 Sprint 21-22 (API pública REST + GraphQL) en README

**Criterios de aceptación (AC):**
- AC1: GraphQL endpoint funcionando en /graphql con schema completo
- AC2: Developer puede consultar solo los campos que necesita (no over-fetching)
- AC3: Queries anidadas funcionan: trip { driver { name } vehicle { plate } }
- AC4: GraphQL Playground disponible para explorar schema y testing
- AC5: Autenticación JWT funciona y valida permisos por recurso

**Checklist técnica (Tareas):**
- T1: Instalar Apollo Server y graphql packages en Firebase Functions
- T2: Crear schema.graphql con types: User, Vehicle, Trip, Alert, etc
- T3: Definir queries: getTrip, listTrips, getDriver, listVehicles, etc
- T4: Definir mutations: createTrip, updateTrip, deleteTrip, etc
- T5: Implementar resolvers para cada query y mutation
- T6: Integrar DataLoader para batch loading de relaciones (evitar N+1)
- T7: Implementar autenticación: validar JWT en context de cada request
- T8: Implementar autorización: validar company_id y roles en resolvers
- T9: Configurar GraphQL Playground (solo en dev/staging, no en prod)
- T10: Implementar pagination con cursor-based (usar after/first/last/before)
- T11: Agregar error handling consistente (GraphQL errors con extensions)
- T12: Implementar rate limiting por API key (misma lógica que REST)
- T13: Documentar schema y queries en /docs/api/graphql-guide.md
- T14: Generar ejemplos de queries complejas para documentación
- T15: Testing: validar performance vs REST (GraphQL debe ser más eficiente)

**Estimación:** 21 SP / 34h

**Prioridad:** Media (Fase 3)

**Etiquetas (labels):** tipo:feature fase:Fase-3 componente:api componente:backend

**Dependencias:** US-083 (API REST pública)

**Archivos/Carpetas relacionados:**
- `/firebase/functions/src/graphql/schema.graphql`
- `/firebase/functions/src/graphql/resolvers/tripResolvers.ts`
- `/firebase/functions/src/graphql/resolvers/driverResolvers.ts`
- `/firebase/functions/src/graphql/dataloaders.ts`
- `/firebase/functions/src/graphql/server.ts`
- `/docs/api/graphql-guide.md`

**Notas/Consideraciones:**
- **Why GraphQL**: Permite a clients pedir exactamente lo que necesitan. REST tiende a over-fetch (traer datos innecesarios)
- **Performance**: Con DataLoader, GraphQL puede ser más eficiente que REST (batch N requests en 1 database call)
- **Learning curve**: GraphQL tiene curva de aprendizaje. Proveer buenos ejemplos y documentation
- **Versioning**: GraphQL no necesita versioning como REST (/v1, /v2). Schema evoluciona con deprecation de campos
- **Subscriptions**: GraphQL soporta real-time subscriptions (WebSockets). Considerar para Fase 3+
- **Alternative**: tRPC es alternativa moderna a REST/GraphQL con mejor type-safety (TypeScript end-to-end)
- **Cost**: Cloud Functions tiene cold starts. GraphQL puede ser más lento en first request (1-2 seg)

---

## **Título: US-108: Implementar GDPR/LGPD Data Export y Right to be Forgotten**

**Descripción:**

**Resumen:** Implementar compliance completo con GDPR (Europa) y LGPD (Brasil) incluyendo data portability (export de datos en formato estándar), right to be forgotten (eliminación completa), consent management, y privacy policy generator.

**Detalle:**
- Export de todos los datos personales en formato JSON/CSV
- Eliminación completa de usuario y todos sus datos (cascada)
- Consent management: usuario acepta términos y política de privacidad
- Privacy policy generator con templates legales
- Audit trail de accesos a datos personales
- Anonimización de datos en analytics (no PII)
- Cookie consent banner (web)

**Referencia:** Ver Sección 5.2 (Privacidad del Conductor) y compliance mencionado en README

**Criterios de aceptación (AC):**
- AC1: Usuario puede exportar todos sus datos desde Settings en formato JSON y CSV
- AC2: Usuario puede solicitar eliminación de cuenta y todos los datos se borran en 30 días
- AC3: Sistema requiere consent explícito a términos y privacidad antes de usar app
- AC4: Audit log registra todos los accesos a datos personales de usuarios
- AC5: Web admin muestra cookie consent banner en primera visita

**Checklist técnica (Tareas):**
- T1: Crear endpoint /api/users/{uid}/export que genera archivo con todos los datos
- T2: Implementar exportData() que consulta todas las collections relacionadas al usuario
- T3: Generar JSON con estructura clara: user, trips, alerts, documents, etc
- T4: Generar CSV alternativo (más fácil de importar a Excel)
- T5: Implementar "Solicitar eliminación de cuenta" en Settings
- T6: Crear Cloud Function scheduleAccountDeletion que marca cuenta para borrar en 30 días
- T7: Implementar Cloud Scheduler que ejecuta deleteMarkedAccounts() diariamente
- T8: Borrar cascada: user → trips → route_points → alerts → documents (todo)
- T9: Anonimizar en lugar de borrar si dato es necesario para integridad (ej: viajes históricos)
- T10: Implementar consent screen en primer uso: "Acepto términos" + "Acepto privacidad"
- T11: Guardar consent en Firestore: users/{uid}/consent con timestamps
- T12: Crear privacy policy y términos de servicio (contratar abogado o usar templates)
- T13: Implementar audit log: registrar quién accedió a datos de quién y cuándo
- T14: Agregar cookie consent banner en web (usar librería como cookiebot o custom)
- T15: Documentar proceso de GDPR compliance en /docs/gdpr-compliance.md

**Estimación:** 13 SP / 21h

**Prioridad:** Alta (Legal requirement para EU/Brasil)

**Etiquetas (labels):** tipo:compliance fase:Fase-2 componente:backend componente:legal

**Dependencias:** US-008 (Registro de usuarios)

**Archivos/Carpetas relacionados:**
- `/firebase/functions/src/api/exportUserData.ts`
- `/firebase/functions/src/scheduler/deleteMarkedAccounts.ts`
- `/lib/features/settings/presentation/screens/data_export_screen.dart`
- `/lib/features/auth/presentation/screens/consent_screen.dart`
- `/web/index.html` (cookie banner)
- `/docs/privacy-policy.md`
- `/docs/terms-of-service.md`
- `/docs/gdpr-compliance.md`

**Notas/Consideraciones:**
- **Legal requirement**: GDPR en Europa y LGPD en Brasil son LAW. Multas pueden ser hasta €20M o 4% revenue (lo que sea mayor)
- **30 days grace period**: Dar 30 días antes de borrar permite que usuario cambie de opinión
- **Anonymization vs Deletion**: Algunos datos deben conservarse por ley (ej: facturas por 7 años). Anonimizar en lugar de borrar
- **Right to rectification**: GDPR también requiere que usuario pueda corregir datos incorrectos (implementar edición de perfil)
- **Breach notification**: Si hay data breach, notificar a usuarios afectados en 72 horas (implementar plan de incident response)
- **DPO**: Empresas grandes necesitan Data Protection Officer. SmartFleet debe designar uno si procesa >100K usuarios
- **Privacy by design**: Pensar en privacidad desde diseño, no agregar después como "parche"

---

## **Título: US-109: Implementar Modelo Predictivo de Fallas con BigQuery ML y Alertas Proactivas**

**Descripción:**

**Resumen:** Crear modelo de machine learning en BigQuery ML que predice probabilidad de falla mecánica de cada vehículo en próximos 30 días basado en telemetría, historial de mantenimiento y patrones de conducción, enviando alertas proactivas.

**Detalle:**
- Modelo ML entrenado en BigQuery ML con datos históricos de mantenimiento
- Features: km acumulados, eventos de conducción, vibración, edad vehículo
- Predecir probabilidad de falla en próximos 7, 15, 30 días
- Clasificar por tipo de componente: motor, frenos, transmisión, suspensión
- Enviar alerta proactiva a mecánico y admin cuando probabilidad >70%
- Dashboard predictivo mostrando vehículos en riesgo

**Referencia:** Ver Sección 3.10.2 (Mantenimiento Predictivo con Machine Learning - Fase 3) y US-063 mencionado

**Criterios de aceptación (AC):**
- AC1: Modelo ML predice probabilidad de falla con >75% accuracy en test set
- AC2: Sistema genera score de riesgo (0-100) para cada vehículo diariamente
- AC3: Alertas proactivas se envían cuando score >70 (alto riesgo)
- AC4: Dashboard muestra top 10 vehículos en riesgo con componente específico
- AC5: Modelo se reentrena mensualmente con nuevos datos de mantenimiento

**Checklist técnica (Tareas):**
- T1: Crear dataset de entrenamiento en BigQuery: maintenance_history + telemetry + driving_events
- T2: Feature engineering: calcular km_since_last_service, avg_harsh_braking_per_day, vibration_score
- T3: Escribir query SQL para entrenar modelo de clasificación binaria (CREATE MODEL)
- T4: Entrenar modelo con algoritmo Logistic Regression (baseline) o DNN Classifier
- T5: Evaluar modelo con ML.EVALUATE() y validar accuracy >75%, precision >70%
- T6: Implementar ML.PREDICT() para generar predicciones diarias de toda la flota
- T7: Crear Cloud Function dailyFailurePrediction que ejecuta predicción y guarda en Firestore
- T8: Configurar Cloud Scheduler para ejecutar predicción diariamente a las 6am
- T9: Crear collection predictive_maintenance con schema: vehicle_id, risk_score, predicted_component, probability
- T10: Implementar Cloud Function sendProactiveMaintAlert trigger cuando risk_score >70
- T11: Enviar notificación push + email a mecánico y admin con detalles de vehículo
- T12: Crear dashboard predictivo en Looker Studio o panel web admin
- T13: Mostrar lista de vehículos ordenados por risk_score descendente
- T14: Implementar explicabilidad: mostrar qué features contribuyeron más a predicción (SHAP values)
- T15: Documentar modelo y features en /docs/predictive-maintenance-ml.md

**Estimación:** 21 SP / 34h

**Prioridad:** Media (Fase 3)

**Etiquetas (labels):** tipo:feature fase:Fase-3 componente:ml componente:maintenance

**Dependencias:** US-056 (Mantenimiento preventivo), US-054 (BigQuery integration), US-099 (ML training pipeline)

**Archivos/Carpetas relacionados:**
- `/bigquery/sql/train_failure_prediction_model.sql`
- `/bigquery/sql/predict_failures_daily.sql`
- `/firebase/functions/src/ml/dailyFailurePrediction.ts`
- `/firebase/functions/src/triggers/sendProactiveMaintAlert.ts`
- `/lib/features/maintenance/presentation/screens/predictive_dashboard_screen.dart`
- `/docs/predictive-maintenance-ml.md`

**Notas/Consideraciones:**
- **ROI**: Prevenir 1 falla catastrófica (motor) puede ahorrar $5K-10K. Modelo se paga solo con pocas predicciones correctas
- **Data quality**: Modelo solo es bueno si data es buena. Requiere historial de al menos 50+ mantenimientos con outcomes
- **Cold start**: Vehículos nuevos no tienen historial. Usar modelo general o cluster similar vehicles
- **False positives**: Alertar innecesariamente genera fatiga. Calibrar threshold (70% es balance razonable)
- **Interpretability**: Mecánicos confían más en predicciones si entienden el "por qué". Mostrar features importantes
- **Component-specific**: Frenos vs motor tienen diferentes patterns. Entrenar modelos separados puede mejorar accuracy
- **Competitive advantage**: Geotab, Samsara tienen predictive maintenance. Es feature esperado en soluciones enterprise

---

## **Título: US-110: Implementar White-Label Completo con Branding Personalizado y Dominio Custom**

**Descripción:**

**Resumen:** Crear sistema de white-label completo para plan Enterprise Plus que permite personalizar branding (logo, colores, nombre), dominio custom (fleet.empresa.com), email templates personalizados, y app móvil con branding custom.

**Detalle:**
- Configuración de branding por empresa: logo, colores primarios/secundarios, nombre
- Dominio custom para dashboard web (ej: fleet.tuempresa.com)
- Email templates con branding de la empresa
- App móvil con branding custom (nombre, íconos, splash screen)
- Whitelabel completo: sin mencionar "SmartFleet" en ningún lado
- Generación automática de builds de app por empresa (iOS/Android)

**Referencia:** Ver Tier 4 Enterprise Plus (White-label) en Sección 1.5 del README

**Criterios de aceptación (AC):**
- AC1: Super admin puede configurar branding desde panel: subir logo, elegir colores, definir nombre
- AC2: Dashboard web muestra logo y colores de la empresa (no SmartFleet)
- AC3: Dominio custom funciona: fleet.empresa.com apunta a dashboard con branding correcto
- AC4: Emails usan template con logo y colores de la empresa
- AC5: App móvil puede generarse con branding custom (manual por ahora, automatizado en futuro)

**Checklist técnica (Tareas):**
- T1: Crear collection company_branding en Firestore con schema: logo_url, primary_color, secondary_color, company_name
- T2: Implementar UI de configuración de branding en super-admin panel
- T3: Permitir upload de logo a Cloud Storage (validar formato PNG/SVG, tamaño <500KB)
- T4: Implementar color picker para primary_color y secondary_color
- T5: Aplicar branding dinámicamente en web dashboard usando ThemeData custom
- T6: Cargar logo desde company_branding y mostrarlo en AppBar/Sidebar
- T7: Configurar DNS custom: crear CNAME record que apunte a Firebase Hosting
- T8: Implementar multi-site hosting en Firebase: cada empresa tiene su subdirectorio
- T9: Servir dashboard correcto según hostname (fleet.empresa1.com vs fleet.empresa2.com)
- T10: Personalizar email templates con logo y colores de empresa (SendGrid dynamic templates)
- T11: Implementar generación de builds custom de app móvil (script automatizado)
- T12: Modificar pubspec.yaml, AndroidManifest, Info.plist con nombre y colores custom
- T13: Generar íconos de app con logo custom usando flutter_launcher_icons
- T14: Documentar proceso de white-label setup en /docs/whitelabel-guide.md
- T15: Crear checklist de deploy de app white-label a App Store/Play Store

**Estimación:** 34 SP / 55h

**Prioridad:** Baja (Enterprise Plus only, Fase 3)

**Etiquetas (labels):** tipo:feature fase:Fase-3 componente:enterprise componente:branding

**Dependencias:** US-082 (Super-admin panel), US-010 (Web dashboard)

**Archivos/Carpetas relacionados:**
- `/lib/features/admin/presentation/screens/branding_config_screen.dart`
- `/lib/core/theme/dynamic_theme_provider.dart`
- `/firebase/hosting/public/` (multi-site config)
- `/scripts/generate_whitelabel_build.sh`
- `/docs/whitelabel-guide.md`

**Notas/Consideraciones:**
- **Pricing**: White-label es premium feature. Cobrar setup fee ($5K-10K) + mensualidad alta ($500+/mes)
- **DNS setup**: Cliente debe crear CNAME en su DNS apuntando a Firebase. Proveer instrucciones claras
- **SSL certificates**: Firebase Hosting genera SSL automáticamente para custom domains (usando Let's Encrypt)
- **App Store**: Publicar app white-label requiere cuenta de App Store/Play Store del cliente ($99/año Apple, $25 one-time Google)
- **Maintenance**: Cada app white-label necesita updates. Automatizar con CI/CD para reducir overhead
- **Alternative**: Para web-only, white-label es más simple (solo DNS + branding). Mobile es complejo
- **CodePush**: Usar CodePush o similar para hot-updates de apps white-label sin pasar por App Store review
- **Future**: Automatizar generación de builds con Codemagic o Bitrise (CI/CD específico para Flutter)