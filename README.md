# smartfleetpro

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


📘 DOCUMENTO MAESTRO v2.0
Sistema Integral de Gestión y Control de Flotas Logísticas (SmartFleet Pro)
Stack Tecnológico: Flutter (Mobile & Web) • Firebase • Mapbox • BigQuery • Looker Studio • TensorFlow Lite
Enfoque: App móvil (conductores) + Dashboard web (administradores) + API REST
Hardware: Smartphone únicamente (sin dispositivos GPS externos)
Mercado objetivo: Empresas de transporte pesado en Latinoamérica (Fase 1: Colombia, Perú, Chile)

🎯 1. VISIÓN GENERAL EXPANDIDA
1.1. Propuesta de Valor
SmartFleet Pro es una plataforma de clase empresarial para gestión inteligente de flotas de transporte pesado y logística de carga que compite directamente con soluciones como Geotab, Samsara y PowerFleet, pero con ventajas competitivas clave:
Diferenciadores principales:

✅ Sin hardware adicional: Usa el smartphone del conductor (ahorro de $200-500 USD por vehículo)
✅ Pricing flexible: Modelo freemium + planes por flota (vs. contratos anuales de competidores)
✅ Onboarding en < 48h: Sin instalación física, solo descarga de app
✅ Optimizado para Latam: Soporte offline robusto, consumo mínimo de datos (< 50MB/mes)
✅ AI Edge: Procesamiento en dispositivo para alertas instantáneas sin latencia
✅ Gamificación: Sistema de scoring y reconocimiento para conductores (inspirado en Strava)

1.2. Problema que Resuelve
Dolor principal de las empresas de transporte:

Falta de visibilidad en tiempo real de su operación (¿Dónde está cada camión? ¿Llegará a tiempo?)
Costos operativos elevados por ineficiencias (combustible, tiempos muertos, rutas no óptimas)
Riesgos de seguridad (exceso de velocidad, fatiga del conductor, robos)
Compliance regulatorio (PESV en Colombia, horas de conducción, mantenimiento obligatorio)
Alto costo de entry de soluciones enterprise ($50-150 USD/vehículo/mes + hardware)

Lo que los líderes del mercado hacen bien (y nosotros adoptamos):

Geotab tiene marketplace con 430+ integraciones partner PR Newswire → Adoptamos arquitectura modular con API abierta
Samsara destaca en UX con 84% satisfacción vs 76% de Geotab Samsara → Priorizamos diseño intuitivo mobile-first
AI detecta comportamiento peligroso con 99% precisión Expert MarketMotive → Implementamos TensorFlow Lite on-device
Strava logra 35+ sesiones/mes por engagement social Sensor Tower → Agregamos leaderboards y retos entre conductores

1.3. Usuarios Target
Perfil de Cliente Ideal (ICP):

Empresas con 10-500 vehículos de carga pesada
Facturación anual: $500K - $50M USD
Industrias: Logística, distribución, construcción, minería, alimentos
Geografía: Colombia (MVP), expansión a Perú, Chile, México
Pain point crítico: No tienen visibilidad en tiempo real o usan planillas Excel

Roles dentro del cliente:

Gerente de Operaciones (tomador de decisiones): Necesita dashboards, reportes, ROI
Supervisor de Flota: Usa el sistema diariamente, monitorea conductores
Conductor: Necesita app simple, no intrusiva, que no consuma batería
Gerente de Mantenimiento: Busca predictibilidad, evitar paradas no planeadas
Gerente HSE/Seguridad: Compliance PESV, reducción de incidentes

1.4. Métricas de Éxito (North Star Metrics)
Para el Negocio:

Tasa de adopción: % de conductores que usan la app diariamente (Meta: >85%)
Retención mensual: % clientes que renuevan (Meta: >90%)
NPS (Net Promoter Score): Satisfacción del cliente (Meta: >50)
Payback period: Tiempo para recuperar inversión del cliente (Meta: < 6 meses)

Para el Usuario Final (Conductor):

Engagement: Sesiones por semana (Meta: >15)
Tiempo en app: < 5 min/día (lo menos intrusivo posible)
Batería consumida: < 8% en jornada de 10h

Para el Cliente (Empresa):

Reducción de combustible: 10-15% (por optimización de rutas)
Reducción de accidentes: 20-30% (por alertas comportamiento)
Aumento productividad: 15% (menos tiempo muerto)
Cumplimiento normativo: 100% (documentación automática)

1.5. Modelo de Negocio
Estrategia de Monetización (Inspirada en Strava + Samsara):
Strava tiene 80% market share con modelo freemium NextSprints → Aplicamos estrategia similar:
Tier 1: BÁSICO (Freemium)

Gratis hasta 3 vehículos
Tracking en vivo
Reportes básicos (últimos 7 días)
1 usuario administrador
Propósito: Hook para empresas pequeñas, evangelizar el mercado

Tier 2: PROFESIONAL ($15 USD/vehículo/mes)

Tracking ilimitado
Historial completo (90 días)
Alertas avanzadas (geocercas, velocidad)
Reportes exportables
Hasta 5 usuarios admin
Soporte email 24/7
Target: Flotas de 5-50 vehículos

Tier 3: ENTERPRISE ($10 USD/vehículo/mes, mínimo 50 vehículos)

Todo lo anterior +
AI predictivo (mantenimiento, comportamiento)
Dashboard Looker Studio personalizado
Integraciones API (ERP, TMS)
Usuarios ilimitados
Soporte dedicado + onboarding
SLA 99.5% uptime
Target: Flotas >50 vehículos

Tier 4: ENTERPRISE PLUS (Cotización personalizada)

White-label
Despliegue on-premise
Desarrollo de features custom
Target: Flotas >500 vehículos, multipaís

Revenue Streams Adicionales:

Marketplace de integraciones (comisión 20-30% sobre ventas de partners)
Servicios profesionales (implementación, capacitación)
Data analytics as a service (venta de insights de industria anonimizados)

Proyección Financiera (5 años):
Año 1: 50 clientes × 25 veh promedio × $12 USD/mes = $180K ARR
Año 2: 200 clientes × 30 veh × $12 = $864K ARR
Año 3: 500 clientes × 35 veh × $12 = $2.5M ARR
Año 5: 1,500 clientes × 40 veh × $12 = $8.6M ARR
1.6. Ventaja Competitiva Sostenible
¿Por qué no nos van a copiar fácilmente?

Network effects: Mientras más conductores, mejores datos de tráfico y benchmarks
Data moat: Mercado de AI automotriz llegará a $405B para 2032 Intelliarts → Nuestros modelos mejoran con cada viaje
Switching costs: Una vez integrado al workflow diario, cambiar es doloroso
Expertise local: Entendemos regulaciones, carreteras y cultura de Latam
Tecnología propietaria: Algoritmo de tracking en background que consume <8% batería (vs 15-20% competencia)


🏗️ 2. ARQUITECTURA TÉCNICA COMPLETA
2.1. Vista de Alto Nivel (Diagrama Conceptual)
┌─────────────────────────────────────────────────────────┐
│                    CAPA DE USUARIOS                      │
├──────────────────┬──────────────────┬───────────────────┤
│  App Conductor   │  Dashboard Web   │   API Pública     │
│   (Flutter)      │ (Flutter Web)    │   (REST/GraphQL)  │
└────────┬─────────┴────────┬─────────┴─────────┬─────────┘
         │                  │                    │
         └──────────────────┼────────────────────┘
                            │
                ┌───────────▼───────────┐
                │   FIREBASE SERVICES   │
                ├───────────────────────┤
                │ • Authentication      │
                │ • Firestore (NoSQL)   │
                │ • Cloud Functions     │
                │ • Cloud Storage       │
                │ • Cloud Messaging     │
                └───────────┬───────────┘
                            │
         ┌──────────────────┼──────────────────┐
         │                  │                  │
    ┌────▼────┐      ┌─────▼─────┐    ┌──────▼──────┐
    │ Mapbox  │      │ BigQuery  │    │ TF Lite     │
    │ APIs    │      │ Analytics │    │ (On-device) │
    └─────────┘      └─────┬─────┘    └─────────────┘
                           │
                    ┌──────▼──────┐
                    │Looker Studio│
                    └─────────────┘
2.2. Stack Tecnológico Detallado
ComponenteTecnologíaJustificaciónFrontend MobileFlutter 3.24+Single codebase iOS/Android, performance nativo, hot reloadFrontend WebFlutter Web o ReactFlutter Web para consistencia, React si necesitamos más ecosistemaBackend-as-a-ServiceFirebase (Firestore, Auth, Functions, Storage)Time-to-market rápido, escalable, sin opsBase de Datos PrincipalFirestore (NoSQL)Real-time sync, offline-first, escalable automáticoBase de Datos AnalíticaBigQueryQuery petabytes, integración nativa con LookerMapas y RoutingMapbox GLMejor que Google Maps para truck routing, pricing competitivoMachine LearningTensorFlow LiteOn-device inference, privacidad, latencia <100msNotificaciones PushFirebase Cloud Messaging (FCM)Gratis, confiable, multiplataformaBI y DashboardsLooker Studio (ex Data Studio)Gratis, integrado con BigQuery, compartibleCI/CDGitHub Actions + FastlaneAutomatización deploys iOS/AndroidMonitoreoFirebase Crashlytics + PerformanceGratis, insights en tiempo realAutenticaciónFirebase Auth + JWT customSSO, MFA, integración con LDAP empresarial
Alternativas evaluadas y por qué NO las elegimos:

❌ AWS Amplify: Más complejo, vendor lock-in similar pero menos maduro para mobile
❌ Google Maps Platform: $7/1000 requests vs Mapbox $0.6/1000, no tiene truck routing
❌ PostgreSQL + PostGIS: Requiere gestión de servidores, overhead operacional (posible migración Fase 3)
❌ Supabase: Open-source atractivo pero menos maduro que Firebase en real-time sync

2.3. Decisiones Arquitectónicas Clave (ADRs)
ADR-001: ¿Por qué Firebase sobre backend custom?

Contexto: Necesitamos MVP en 8-12 semanas con equipo pequeño
Decisión: Firebase como BaaS
Consecuencias:

✅ 60% menos código backend
✅ $0 infra costs hasta 50K DAU
❌ Vendor lock-in (mitigable con abstraction layer)
❌ Queries complejas limitadas (solucionado con BigQuery)



ADR-002: ¿Tracking en device o en servidor?

Contexto: Edge processing permite feedback instantáneo Motive
Decisión: Hybrid approach - tracking básico en device, procesamiento pesado en Cloud Functions
Consecuencias:

✅ Alertas instantáneas (velocidad, frenado brusco)
✅ Funciona offline
❌ Más complejidad en sincronización
✅ Consumo de batería optimizado



ADR-003: ¿Flutter para web o React separado?

Decisión: Flutter Web para dashboard admin (fase MVP), migrar a React si crece complejidad
Razón: Reutilizar 70% del código UI mobile, equipo único
Trade-off: SEO limitado (no importa, es dashboard privado), bundle size mayor (aceptable en web)


¿Te parece bien el nivel de detalle? ¿Sigo con la PARTE 2 (Módulos y Features Detallados) o querés que ajuste algo primero? 🚀RetryHme parece perfecto el nivel de detalle si puedes aun mejorar el detalles para esta segunda parte estaria mejorAmplificó detalles técnicos y profundizó análisis de módulos.Perfecto, el usuario está contento con el nivel de detalle y quiere que continúe con la PARTE 2 (Módulos y Features Detallados) pero con AÚN MÁS detalle. Voy a profundizar mucho más en:

Cada módulo con user stories completas
Flujos de usuario detallados
Reglas de negocio específicas
Edge cases y manejo de errores
Consideraciones de UX específicas
Integraciones con otras partes del sistema
Métricas de éxito por feature
Referencias a mejores prácticas de la industria

Voy a hacer una investigación adicional sobre features específicos que mencioné para darle más profundidad técnica y de producto.¡Perfecto! Voy a investigar más detalles específicos de features avanzadas para darte una PARTE 2 súper completa. Dame un segundo...4 stepsgeofencing fleet management use cases best practices 202510 resultsHow to use geofencing in fleet management [detailed guide for 2025] | Volpisvolpis.comGeofencing in Fleet Management: Best Practices You Should Followgocodes.comGeofencing in Fleet managementsimplyfleet.appWhat is a geofence and how is it used in fleet management?gomotive.com8 ways to use geofencing in fleet management | Motivegomotive.comDecoding Geo-Fencing: Practical Use Cases for Reducing Fuel Costs - NextBillion.ainextbillion.aiGeofencing for Fleets: How It Works + Best Practicesautopi.ioGeofencing for Fleet Management: Boost Security & Efficiencyfleetpins.comProtect Your Fleet with Geofencing & Real-Time Alertsezlogz.comWhat is geofencing? How it works and why it matters | Geotabgeotab.comConsolidó información y estructuró mejora detallada.Excelente! Ya tengo información completa sobre:

Driver scoring y gamificación
Mantenimiento predictivo
Geofencing y geocercas

Ahora tengo toda la información necesaria para crear la PARTE 2 COMPLETA y MEJORADA con muchísimo más detalle. Voy a estructurar los módulos principales con:

User stories detalladas
Reglas de negocio específicas
Features inspirados en los líderes
Métricas de éxito
Consideraciones técnicas
Edge cases
¡Perfecto! Ya investigué a fondo. Ahora te presento la PARTE 2 COMPLETA Y MEJORADA con nivel de detalle máximo:

🧩 3. MÓDULOS PRINCIPALES (DETALLADOS)
3.1. Autenticación y Gestión de Accesos
3.1.1. Arquitectura de Autenticación
Stack:

Firebase Authentication (primario)
JWT Custom Tokens (para integración con sistemas enterprise)
OAuth 2.0 (futuro: SSO corporativo con Google Workspace, Microsoft AD)

Roles y Permisos (RBAC - Role-Based Access Control):
RolPermisosCasos de UsoSuper AdminAcceso total, configuración de empresa, billingDueño de la empresa, CTOAdministradorCRUD usuarios/vehículos, ver todos los datos, exportar reportesGerente de OperacionesSupervisorVer flota en tiempo real, enviar alertas, revisar reportes de su zonaSupervisor de turno, coordinadorConductorVer su vehículo asignado, iniciar/terminar viajes, ver su scoreChofer de camiónMecánicoVer historial de mantenimiento, marcar tareas completadasTécnico de tallerAuditor (Read-only)Solo lectura de reportes y dashboardsHSE, compliance, aseguradora
Features Avanzadas:

Multi-tenant Architecture

Una empresa puede tener múltiples "sucursales" o "divisiones"
Cada supervisor solo ve sus vehículos asignados
Datos completamente aislados entre empresas (data segregation)


Autenticación Adaptativa

MFA obligatorio para Super Admin y Admin
Biometría (huella, Face ID) opcional para conductores
Detección de dispositivos nuevos → requiere verificación adicional


Session Management

Sesiones de conductor: 12 horas (jornada laboral típica)
Sesiones de administrador: 8 horas
Auto-logout después de 30 min inactividad
Single-device policy para conductores (no puede loguearse en 2 celulares simultáneamente)


Password Policies

Mínimo 8 caracteres, 1 mayúscula, 1 número
Cambio obligatorio cada 90 días para admins
No permitir últimas 5 contraseñas



3.1.2. User Stories
US-001: Conductor inicia sesión por primera vez
Como conductor nuevo
Quiero activar mi cuenta con un código QR enviado por mi supervisor
Para empezar a usar la app sin complicaciones

Criterios de aceptación:
- Escanea QR desde email o WhatsApp
- Crea contraseña de 6+ caracteres (o PIN de 4 dígitos)
- Acepta permisos de ubicación "Siempre"
- Ve tutorial de 3 pasos (< 45 segundos)
- Queda logueado automáticamente
US-002: Admin gestiona múltiples empresas (White-label)
Como proveedor de servicios de logística
Quiero gestionar flotas de 5 clientes diferentes desde una cuenta
Para ofrecer servicios de monitoreo a mis clientes

Criterios de aceptación:
- Puedo cambiar entre empresas con dropdown
- Datos completamente segregados
- Cada empresa tiene su propio branding (logo, colores)
- Facturo por empresa independientemente

3.2. Gestión de Usuarios y Vehículos
3.2.1. Módulo de Conductores
Datos del Conductor (Firestore Document):
json{
  "driver_id": "DRV-2025-0001",
  "personal_info": {
    "full_name": "Juan Pérez García",
    "dni": "12345678",
    "phone": "+51987654321",
    "email": "juan.perez@empresa.com",
    "date_of_birth": "1985-03-15",
    "address": "Av. Lima 123, San Isidro",
    "emergency_contact": {
      "name": "María Pérez",
      "phone": "+51987654322",
      "relationship": "Esposa"
    }
  },
  "employment": {
    "employee_id": "EMP-1234",
    "hire_date": "2023-01-15",
    "contract_type": "permanente", // o "temporal", "freelance"
    "branch": "Lima Norte",
    "shift": "mañana" // "tarde", "noche", "rotativo"
  },
  "documents": [
    {
      "type": "licencia_conducir",
      "number": "A2b-12345678",
      "category": "A-IIIc", // Licencia para camiones pesados en Perú
      "issue_date": "2022-01-10",
      "expiry_date": "2027-01-10",
      "file_url": "gs://bucket/licenses/driver_123.pdf",
      "verified": true,
      "verified_by": "admin_001",
      "verified_date": "2023-01-20"
    },
    {
      "type": "certificado_salud",
      "expiry_date": "2025-06-30",
      "file_url": "...",
      "verified": true
    },
    {
      "type": "antecedentes_penales",
      "issue_date": "2024-11-01",
      "file_url": "...",
      "verified": true
    }
  ],
  "training": [
    {
      "course": "Conducción Defensiva",
      "date": "2024-03-10",
      "certificate": "...",
      "valid_until": "2026-03-10"
    },
    {
      "course": "PESV - Manejo de Fatiga",
      "date": "2024-08-15",
      "certificate": "..."
    }
  ],
  "assigned_vehicle": "VEH-2025-0042",
  "status": "activo", // "inactivo", "suspendido", "vacaciones"
  "driver_score": {
    "current": 87,
    "history_30d": [85, 86, 88, 87],
    "ranking_position": 12, // de 150 conductores
    "percentile": 92 // mejor que el 92% de la flota
  },
  "stats": {
    "total_trips": 1247,
    "total_km": 125430,
    "total_hours": 3200,
    "incidents_count": 3,
    "last_incident_date": "2024-09-12"
  },
  "created_at": "2023-01-15T10:30:00Z",
  "updated_at": "2025-11-06T14:22:00Z"
}
```

**Validaciones Automáticas:**
- Sistema alerta 30 días antes del vencimiento de documentos 
- Conductor con licencia vencida → bloqueado para iniciar viajes
- Conductor sin certificado de salud vigente → warning (no bloqueante)
- Conductor con >3 infracciones graves en 30 días → revisión obligatoria con supervisor

**Gamificación del Conductor (Inspirado en Strava + Samsara):**

Samsara permite a conductores ver su Safety Score en tiempo real desde el móvil 

**Driver Score Algorithm (SmartFleet Pro):**

Azuga calcula score composite basado en frenado, velocidad, aceleración e inactividad, considerando duración, magnitud, frecuencia y condiciones climáticas 

**Fórmula SmartFleet Pro (ponderada):**
```
Driver Score = (
  Velocidad (30%) +
  Frenado Suave (25%) +
  Aceleración Progresiva (20%) +
  Eficiencia Combustible (15%) +
  Cumplimiento de Rutas (10%)
) × Multiplicador Contextual
Multiplicador Contextual:

Lluvia intensa: -10% tolerancia en velocidad
Noche (10pm-5am): +5% bonus por mayor dificultad
Zona urbana congestionada: +3% bonus
Carretera vacía: scoring estándar

Rangos de Score:

90-100: 🏆 Élite (Verde oscuro)
80-89: ⭐ Excelente (Verde)
70-79: ✅ Bueno (Amarillo)
60-69: ⚠️ Mejorable (Naranja)
<60: 🚨 Requiere coaching (Rojo)

Leaderboards:
Samsara usa leaderboards semanales que se resetean para mantener motivación G2

Global (toda la empresa): Top 10 de la semana
Por sucursal: Fomenta competencia sana entre zonas
Por tipo de vehículo: Camiones vs camionetas (no comparar manzanas con peras)
Más mejorado: Quién subió más puntos esta semana

Sistema de Badges/Logros:

🎯 "100 Viajes Sin Incidentes"
🌟 "Score >90 por 30 días consecutivos"
⚡ "Eficiencia de Combustible +15% vs promedio"
🏁 "1,000 km en rutas montañosas sin alertas"
🛡️ "Campeón de Seguridad del Mes"

Recompensas Tangibles (Configurables por Empresa):

Puntos canjeables por: Gift cards, día libre, bono monetario
Azuga permite enviar gift cards desde el dashboard web a la app del conductor SelectHub
Certificado digital descargable para portafolio personal
Mención en reunión mensual / newsletter interna


3.2.2. Módulo de Vehículos
Datos del Vehículo (Firestore Document):
json{
  "vehicle_id": "VEH-2025-0042",
  "basic_info": {
    "plate": "ABC-123",
    "brand": "Volvo",
    "model": "FH16",
    "year": 2021,
    "type": "trailer", // "camion", "camioneta", "furgon"
    "sub_type": "semi_remolque_refrigerado",
    "color": "Blanco",
    "vin": "YV2AQ50D5LA123456"
  },
  "specifications": {
    "capacity_kg": 28000,
    "capacity_m3": 80,
    "axles": 5,
    "fuel_type": "diesel",
    "tank_capacity_liters": 400,
    "engine_hp": 540,
    "transmission": "automatica_12_vel"
  },
  "dimensions": {
    "length_m": 16.5,
    "width_m": 2.55,
    "height_m": 4.0,
    "weight_empty_kg": 12000
  },
  "ownership": {
    "status": "propio", // "alquilado", "leasing"
    "purchase_date": "2021-03-15",
    "purchase_price_usd": 85000,
    "leasing_company": null,
    "insurance_company": "Rimac Seguros",
    "policy_number": "POL-987654321",
    "insurance_expiry": "2026-03-15"
  },
  "operation": {
    "assigned_driver": "DRV-2025-0001",
    "branch": "Lima Norte",
    "operational_status": "activo", // "mantenimiento", "inactivo", "vendido"
    "current_odometer_km": 125430,
    "last_trip_id": "TRIP-20251106-0245"
  },
  "maintenance": {
    "last_service_date": "2025-10-15",
    "last_service_km": 123000,
    "next_service_km": 133000, // cada 10,000 km
    "next_service_date": "2026-01-15", // cada 3 meses
    "maintenance_plan": "preventivo_intensivo",
    "preferred_workshop": "Taller Central - Av. Industrial"
  },
  "documents": [
    {
      "type": "soat",
      "number": "SOAT-2025-123456",
      "expiry_date": "2026-03-20",
      "file_url": "...",
      "verified": true
    },
    {
      "type": "revision_tecnica",
      "expiry_date": "2025-12-15",
      "file_url": "...",
      "verified": true
    },
    {
      "type": "certificado_gps", // Algunos países lo requieren
      "expiry_date": "2026-06-30",
      "verified": true
    }
  ],
  "health_score": 92, // Score de salud del vehículo (predictivo)
  "predicted_issues": [ // ML inference
    {
      "component": "frenos_traseros",
      "probability": 0.67,
      "predicted_failure_km": 128000,
      "recommended_action": "Inspección programada en próximo servicio"
    }
  ],
  "telemetry_device": {
    "type": "smartphone", // o "obd2_dongle", "hardwired_gps"
    "device_id": "PHONE-android-abc123",
    "last_seen": "2025-11-06T14:20:00Z",
    "battery_level": 78,
    "connection_quality": "excellent"
  },
  "created_at": "2021-03-15T09:00:00Z",
  "updated_at": "2025-11-06T14:22:00Z"
}
```

**Smart Alerts de Documentos:**
- 60 días antes: Email a admin
- 30 días antes: Email + notificación push a admin y conductor
- 15 días antes: Alerta diaria + banner en dashboard
- Vencido: Vehículo bloqueado para nuevos viajes (seguridad y compliance)

**Health Score del Vehículo (Inspirado en Mantenimiento Predictivo):**

Sensores IoT monitorean temperatura del motor, presión de neumáticos, eficiencia de combustible y desgaste de frenos 

**En SmartFleet Pro (sin sensores externos, solo smartphone):**

Datos que SÍ podemos capturar del smartphone:
- ✅ Aceleraciones bruscas (acelerómetro)
- ✅ Frenadas fuertes (acelerómetro)
- ✅ Giros bruscos (giroscopio)
- ✅ Velocidad excesiva (GPS)
- ✅ Vibraciones anómalas (acelerómetro de alta frecuencia)
- ✅ Patrones de uso (km/día, horas motor encendido estimado)

**Algoritmo Proxy de Health Score:**
```
Health Score = 100 - (
  Desgaste estimado por km (20%) +
  Eventos de conducción brusca acumulados (30%) +
  Días desde último mantenimiento (25%) +
  Incidentes reportados (15%) +
  Edad del vehículo (10%)
)
Ejemplos:

Vehículo nuevo, bien conducido, mantenido: 95-100
Vehículo con 200k km, conductor agresivo, mantenimiento retrasado: 60-70
Vehículo con alerta de vibración anómala detectada: -15 puntos temporales

Predicción de Mantenimiento (Machine Learning - Fase 3):
Algoritmos ML analizan temperatura, vibración, presión y consumo para predecir fallos antes de que ocurran VolpisMICHELIN Connected Fleet
En SmartFleet Pro, usaremos:

TensorFlow Lite on-device para detección de patrones anómalos
BigQuery ML para análisis histórico de toda la flota
Modelo entrenado con: Tipo de vehículo + km + eventos de conducción + historial de mantenimiento

Alertas Predictivas:

"⚠️ Frenos del VEH-042 muestran patrón de desgaste acelerado. Recomendamos inspección en próximos 500 km"
"🔧 Motor del VEH-018 ha tenido 12 arranques en frío últimos 7 días. Revisar batería"
"📊 VEH-067 tiene 18% más consumo de combustible vs promedio flota. Posible problema en inyectores"


3.3. Tracking y Telemetría Móvil Avanzada
3.3.1. Arquitectura de Tracking en Background
Desafío principal: El procesamiento edge permite feedback instantáneo sin latencia Motive
Nuestra solución híbrida:

Capa 1: Captura de Datos (Flutter Background Service)

flutter_background_service + geolocator
Intervalo adaptativo:

Vehículo en movimiento >20 km/h: cada 10 segundos
Vehículo lento 5-20 km/h: cada 20 segundos
Vehículo detenido: cada 60 segundos (para ahorrar batería)
Viaje no iniciado: cada 5 minutos (location tracking pasivo)




Capa 2: Procesamiento Local (TensorFlow Lite)

Modelo on-device (<5MB) para detectar:

Exceso de velocidad (compara GPS speed vs límite de zona)
Frenado brusco (aceleración < -0.4g)
Aceleración agresiva (>0.3g)
Giro brusco (>0.35g lateral)


Latencia: <100ms
Genera alerta instantánea en el dispositivo (haptic feedback + sonido)


Capa 3: Upload Batch a Firestore

Buffer local: almacena hasta 50 puntos GPS
Upload cuando:

Buffer lleno (50 puntos)
Han pasado 2 minutos desde último upload
Evento crítico detectado (alerta de seguridad)
Conexión WiFi disponible (para bulk upload)


Retry con exponential backoff si falla


Capa 4: Cloud Functions (Procesamiento Secundario)

Triggers en Firestore al recibir batch de puntos
Procesa:

Geocercas (entrada/salida de zonas)
Análisis de ruta (¿se desvió de la ruta asignada?)
Cálculo de estadísticas de viaje
Envío de notificaciones a supervisores





Datos capturados por punto GPS:
json{
  "trip_id": "TRIP-20251106-0245",
  "vehicle_id": "VEH-2025-0042",
  "driver_id": "DRV-2025-0001",
  "timestamp": "2025-11-06T14:35:22.543Z",
  "location": {
    "lat": -12.0464,
    "lng": -77.0428,
    "accuracy_m": 8.5,
    "altitude_m": 154,
    "bearing_degrees": 235, // dirección del movimiento
    "speed_mps": 16.67 // 60 km/h
  },
  "device_sensors": {
    "acceleration": {
      "x": 0.12,
      "y": -0.08,
      "z": 9.81
    },
    "gyroscope": {
      "x": 0.01,
      "y": -0.02,
      "z": 0.05
    }
  },
  "device_status": {
    "battery_level": 78,
    "is_charging": false,
    "network_type": "4G",
    "signal_strength": -75 // dBm
  },
  "events": [
    {
      "type": "harsh_brake",
      "severity": "medium",
      "value": -0.45 // g-force
    }
  ],
  "context": {
    "road_type": "highway", // inferido de Mapbox
    "speed_limit": 100, // límite de zona
    "weather": "clear", // desde API externa
    "time_of_day": "afternoon"
  }
}
3.3.2. Optimización de Batería (Crítico para Adopción)
Meta: <8% consumo de batería en jornada de 10 horas
Estrategias:

Geofencing Inteligente

Cuando vehículo entra en "zona de descanso" (terminal, taller): desactivar tracking activo
Cuando sale: reactivar


Motion Detection

Si acelerómetro detecta 0 movimiento por 5 min → pausar GPS high-accuracy
Cambiar a low-power mode (solo WiFi/Cell tower location)
Al detectar movimiento → reactivar GPS


Batch Upload con WiFi

Almacenar tracks offline
Al conectarse a WiFi del terminal → subir todo en bulk
Ahorra datos móviles y batería


Compression

Algoritmo Douglas-Peucker para simplificar rutas
Elimina puntos redundantes (ej: 10 puntos en línea recta → 2 puntos)
Reduce 60-70% el tamaño de datos sin pérdida de precisión significativa



Benchmarks de Competencia:

App promedio de tracking: 12-18% batería en 10h
SmartFleet Pro target: <8% (vs 15-20% estándar)


3.4. Gestión de Viajes (Trips) con Inteligencia
3.4.1. Ciclo de Vida de un Viaje
Estados:

Planeado → Admin crea viaje desde dashboard
Asignado → Conductor recibe notificación
Iniciado → Conductor presiona "Iniciar Viaje"
En Curso → Tracking activo
Pausado → Conductor hace break (opcional)
Completado → Conductor presiona "Finalizar Viaje"
Validado → Admin revisa y aprueba
Archivado → Después de 90 días

Inicio Automático vs Manual:
Sistema puede detectar inicio de viaje automáticamente por movimiento detectado SelectHub
SmartFleet Pro Hybrid:

Manual (default): Conductor presiona "Iniciar Viaje"

Ventaja: Control total, evita falsos positivos
Desventaja: Conductor puede olvidar


Auto-start (opcional, configurable):

Detector de movimiento (velocidad >15 km/h por 2 minutos)
Muestra notificación: "¿Iniciaste un viaje? [Sí] [No]"
Si no responde en 30 seg → inicia automáticamente
Si responde "No" → no inicia (falso positivo)



Cierre Automático de Viajes Huérfanos:

Si viaje en curso y vehículo detenido >10 min en ubicación final esperada → popup "¿Finalizar viaje?"
Si viaje en curso y >24 horas sin actividad → auto-finalizar + flag para revisión manual

3.4.2. Datos del Viaje
json{
  "trip_id": "TRIP-20251106-0245",
  "status": "en_curso",
  "planning": {
    "planned_start": "2025-11-06T06:00:00Z",
    "planned_end": "2025-11-06T18:00:00Z",
    "planned_route": "ROUTE-LIM-CUZ-001",
    "cargo_description": "40 pallets de alimentos refrigerados",
    "cargo_weight_kg": 18000,
    "priority": "alta", // "normal", "baja"
    "customer": "Supermercados Wong",
    "order_number": "ORD-2025-98765"
  },
  "assignment": {
    "driver_id": "DRV-2025-0001",
    "vehicle_id": "VEH-2025-0042",
    "assigned_by": "admin_002",
    "assigned_at": "2025-11-05T20:30:00Z"
  },
  "execution": {
    "actual_start": "2025-11-06T06:12:00Z",
    "actual_end": null,
    "current_location": {
      "lat": -12.0464,
      "lng": -77.0428,
      "timestamp": "2025-11-06T14:35:22Z"
    },
    "waypoints": [
      {
        "type": "pickup",
        "name": "Almacén Central",
        "location": {"lat": -12.0431, "lng": -77.0282},
        "planned_arrival": "2025-11-06T06:00:00Z",
        "actual_arrival": "2025-11-06T06:12:00Z",
        "actual_departure": "2025-11-06T06:45:00Z",
        "status": "completado",
        "notes": "Carga completa, sin novedades"
      },
      {
        "type": "delivery",
        "name": "Wong - San Isidro",
        "location": {"lat": -12.0982, "lng": -77.0364},
        "planned_arrival": "2025-11-06T18:00:00Z",
        "actual_arrival": null,
        "status": "pendiente"
      }
    ],
    "route_history": [
      // Array de 5000+ puntos GPS
    ]
  },
  "statistics": {
    "distance_km": 342.5,
    "distance_planned_km": 350,
    "deviation_km": 7.5, // se desvió 7.5 km de la ruta planeada
    "duration_minutes": 505,
    "duration_planned_minutes": 480,
    "delay_minutes": 25,
    "average_speed_kmh": 40.6,
    "max_speed_kmh": 95,
    "fuel_consumed_liters": 68, // estimado
    "fuel_efficiency_km_per_liter": 5.04,
    "stops_count": 3,
    "idle_time_minutes": 45
  },
  "events": [
    {
      "type": "harsh_brake",
      "timestamp": "2025-11-06T08:23:15Z",
      "location": {"lat": -12.1234, "lng": -77.0567},
      "severity": "medium",
      "value": -0.45
    },
    {
      "type": "speeding",
      "timestamp": "2025-11-06T10:15:30Z",
      "location": {"lat": -12.2345, "lng": -77.1234},
      "severity": "low",
      "speed_kmh": 108,
      "limit_kmh": 100,
      "duration_seconds": 45
    },
    {
      "type": "geofence_entry",
      "timestamp": "2025-11-06T06:12:00Z",
      "geofence_id": "GEO-ALMACEN-CENTRAL",
      "geofence_name": "Almacén Central"
    }
  ],
  "alerts_generated": [
    "ALERT-20251106-001",
    "ALERT-20251106-023"
  ],
  "driver_score_impact": -2, // este viaje bajó score del conductor en 2 puntos
  "created_at": "2025-11-05T20:30:00Z",
  "updated_at": "2025-11-06T14:35:30Z"
}
```

#### 3.4.3. Routing Inteligente con Mapbox Truck API

Geofencing permite optimizar rutas evitando zonas congestionadas y ofreciendo tiempos de entrega precisos 

**Mapbox Directions API - Truck Profile:**
- Considera: altura, peso, ancho, número de ejes del vehículo
- Evita: Túneles bajos, puentes con restricción de peso, calles angostas
- Optimiza: Para minimizar combustible (no siempre la ruta más corta)

**Request Example:**
```
GET https://api.mapbox.com/directions/v5/mapbox/driving-traffic/{coords}
?access_token=...
&vehicle_max_height=4.0
&vehicle_max_weight=28000
&vehicle_width=2.55
&vehicle_axles=5
&overview=full
&geometries=polyline6
Comparación de Rutas:

Ruta más rápida (ETA)
Ruta más corta (km)
Ruta más económica (combustible estimado)
Ruta más segura (evita zonas peligrosas - dato custom de la empresa)

Actualizaciones en Tiempo Real:

Mapbox Traffic API cada 5 minutos
Si detecta congestión adelante → recalcular ruta
Notificación al conductor: "Ruta alternativa disponible, ahorra 15 min"

3.4.4. Replay de Viajes (Feature Premium)
Vista Timeline:

Slider de tiempo (drag para ver cómo se movió el vehículo)
Speed controls: 1x, 2x, 5x, 10x
Overlay de eventos (alertas, paradas, cambios de velocidad)
Gráficos sincronizados:

Velocidad vs tiempo
Altitud vs tiempo (para ver subidas/bajadas)
Eventos críticos marcados



Export Options:

Video MP4 (ruta animada en mapa)
GeoJSON file (para análisis externo)
KML file (para Google Earth)
PDF report con mapas, estadísticas y gráficos


¿Te parece bien este nivel de detalle? Esto es solo la PRIMERA MITAD de la Parte 2. Aún me faltan:
Secciones pendientes:

3.5. Alertas y Seguridad (con ML edge)
3.6. Geocercas avanzadas
3.7. Reportes y analítica con Looker
3.8. Panel web (dashboard)
3.9. P.E.S.V. (Plan Estratégico Seguridad Vial)
3.10. Mantenimiento Predictivo

¿Continúo con la SEGUNDA MITAD de la Parte 2 con este mismo nivel de detalle máximo? 🚀RetryHcontinua pasame la segunda mitad¡Perfecto! Aquí va la SEGUNDA MITAD DE LA PARTE 2 con máximo detalle:

3.5. Alertas y Seguridad Avanzada
3.5.1. Motor de Alertas en Tiempo Real
Arquitectura de 3 Capas:
┌─────────────────────────────────────────────────────┐
│        CAPA 1: EDGE (On-Device - TF Lite)           │
│  • Exceso de velocidad                              │
│  • Frenado/Aceleración brusca                       │
│  • Giros peligrosos                                 │
│  → Latencia: <100ms                                 │
│  → Feedback inmediato al conductor                  │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│     CAPA 2: CLOUD FUNCTIONS (Firebase)              │
│  • Geocercas (entrada/salida)                       │
│  • Desvío de ruta                                   │
│  • Pérdida de señal GPS                             │
│  • Batería crítica (<15%)                           │
│  • Tiempo de conducción excedido                    │
│  → Latencia: 2-5 segundos                           │
│  → Notificación push a supervisor                   │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│   CAPA 3: BIGQUERY ML (Batch Processing)           │
│  • Patrones de fatiga del conductor                 │
│  • Predicción de incidentes                         │
│  • Anomalías en comportamiento                      │
│  → Latencia: 1-24 horas                             │
│  → Reportes preventivos semanales                   │
└─────────────────────────────────────────────────────┘
3.5.2. Taxonomía Completa de Alertas
CATEGORÍA A: SEGURIDAD CRÍTICA (Rojo 🚨)
AI detecta comportamiento inseguro con 99% precisión Expert Market
AlertaTriggerAcción AutomáticaNotifica aExceso de velocidad extremoVelocidad >130 km/h en carretera o >80 km/h en ciudadSonido de alarma en app + vibración + log en expediente del conductorConductor + Supervisor + Admin (inmediato)Frenado de emergenciaDesaceleración < -0.6gRegistro de evento + verificación de dañosConductor + SupervisorColisión detectadaImpacto > 2g en cualquier ejeAuto-llamada a emergencias + envío de ubicación + foto automática si disponibleTodos los roles + EmergenciasSalida de zona segura no autorizadaVehículo fuera de geocerca operativa en horario laboralBloqueo de carga/descarga hasta justificaciónSupervisor + AdminBotón de pánico activadoConductor presiona SOSAlerta máxima + tracking cada 5 seg + llamada automática a seguridadTodos + Autoridades (si configurado)Fatiga extrema detectada>10h de conducción sin descansoBloqueo suave del viaje (requiere confirmación para continuar)Conductor + Supervisor
CATEGORÍA B: OPERACIONAL (Naranja ⚠️)
AlertaTriggerAcción AutomáticaNotifica aDesvío de ruta>2 km fuera de ruta planeada por >10 minPregunta al conductor razón del desvíoSupervisorParada prolongada no programadaDetenido >30 min fuera de waypointsVerificación de estado del conductorSupervisorRetraso en ETA>20% retraso vs ETA originalRecalcular ruta + notificar a clienteAdmin + Cliente (si integrado)Consumo anómalo de combustible>25% sobre baseline del vehículoFlag para revisión técnicaMecánico + AdminMúltiples eventos de conducción brusca>5 eventos en 1 horaCoaching digital al conductorConductor + SupervisorEntrada a zona de riesgoGeocerca marcada como "peligrosa" (robos frecuentes)Activar tracking intensivo (cada 5 seg) + alertar a seguridadConductor + Supervisor + Seguridad
CATEGORÍA C: MANTENIMIENTO (Amarillo 🔧)
AlertaTriggerAcción AutomáticaNotifica aMantenimiento próximoFaltan <500 km o <7 días para servicio programadoProgramar cita en calendarioMecánico + Admin + ConductorMantenimiento vencidoSuperó fecha/km de servicioBloquear nuevos viajes hasta mantenimientoAdmin + MecánicoVibración anómala detectadaPatrón inusual en acelerómetro (posible problema mecánico)Sugerir inspecciónConductor + MecánicoTemperatura ambiente extrema>40°C o <0°C (impacta motor y carga)Ajustar comportamiento de conducción recomendadoConductor
CATEGORÍA D: ADMINISTRATIVA (Azul ℹ️)
AlertaTriggerAcción AutomáticaNotifica aDocumento próximo a vencer<30 días para vencimiento (licencia, SOAT, etc.)Email recordatorioAdmin + ConductorBajo uso de vehículo<3 viajes en últimos 7 díasSugerir reasignación o mantenimiento preventivoAdminConductor sin capacitación vigenteCertificado de capacitación vencidoBloquear viajes hasta renovaciónAdmin + RRHH
3.5.3. Notificaciones Push Inteligentes
Priorización (para no saturar al usuario):
Sistema debe balancear alertas críticas con notificaciones informativas para evitar fatiga de alerta SelectHub
Niveles de Prioridad (Firebase Cloud Messaging):

Crítica (sound + vibration + heads-up): Seguridad inmediata
Alta (sound + notification badge): Operacional urgente
Media (silent + badge): Información relevante
Baja (silent, solo en app): Recordatorios

Quiet Hours:

No enviar alertas no críticas entre 10pm-6am (a menos que conductor esté en viaje activo)
Modo "No Molestar" para supervisores (solo alertas críticas)

Agregación Inteligente:

Si hay 5+ alertas del mismo tipo en 10 min → agrupar en una sola notificación: "5 eventos de velocidad en últimos 10 min"
Si conductor ya fue notificado de velocidad hace <5 min → no re-notificar

Personalización por Rol:
json{
  "role": "supervisor",
  "notification_preferences": {
    "critical_security": {
      "enabled": true,
      "channels": ["push", "email", "sms"],
      "quiet_hours": false
    },
    "operational_warnings": {
      "enabled": true,
      "channels": ["push"],
      "quiet_hours": true,
      "threshold": "only_if_>3_events_in_1h"
    },
    "maintenance": {
      "enabled": true,
      "channels": ["email"],
      "frequency": "daily_digest"
    },
    "administrative": {
      "enabled": false
    }
  }
}
```

#### 3.5.4. Dashboard de Alertas (Web)

**Vista en Tiempo Real:**
- Mapa con íconos de alertas activas (clustering si hay muchas)
- Panel lateral con lista de alertas (más recientes arriba)
- Filtros:
  - Por tipo de alerta
  - Por severidad
  - Por conductor/vehículo
  - Por zona geográfica
  - Por rango de tiempo
  
**Acciones Rápidas del Supervisor:**
- ✅ **Marcar como revisada** (cambia color)
- 📞 **Llamar al conductor** (click-to-call si integrado con VoIP)
- 💬 **Enviar mensaje pre-definido** ("¿Todo bien? Reporta tu situación")
- 🚫 **Descartar** (si es falsa alarma)
- 📝 **Agregar nota** ("Conductor reportó vía alterna por accidente")
- 🔔 **Escalar** (notificar a nivel superior)

**Análisis de Alertas (Vista Semanal/Mensual):**
- Heatmap de alertas por hora del día y día de la semana
- Ranking de conductores por alertas generadas
- Tipos de alerta más frecuentes
- Zonas geográficas con más incidentes (hotspots)
- Tendencia temporal (¿están mejorando o empeorando?)

**Gráficos Clave:**
```
📊 Alertas por Tipo (Pie Chart)
   - Velocidad: 45%
   - Frenado brusco: 30%
   - Desvío de ruta: 15%
   - Otros: 10%

📈 Tendencia Semanal (Line Chart)
   - Semana 1: 120 alertas
   - Semana 2: 105 alertas (-12.5%)
   - Semana 3: 95 alertas (-9.5%)
   - Semana 4: 88 alertas (-7.4%)

🗺️ Mapa de Calor
   - Zona Av. Javier Prado: 45 alertas/mes (velocidad)
   - Zona Carretera Central Km 15-20: 32 alertas/mes (curvas peligrosas)
3.5.5. Machine Learning para Predicción de Incidentes
Modelo Predictivo (BigQuery ML - Fase 3):
ML analiza patrones para predecir fallos antes de que ocurran VolpisMICHELIN Connected Fleet
Features del Modelo:
python# Variables de entrada para predicción de incidente
features = [
    'driver_score_last_30d',
    'alerts_count_last_7d',
    'alerts_count_last_30d',
    'harsh_events_last_7d',
    'hours_driving_today',
    'hours_since_last_break',
    'time_of_day', # 0-23
    'day_of_week', # 0-6
    'weather_condition', # clear, rain, fog
    'road_type', # highway, urban, rural
    'vehicle_age_months',
    'vehicle_health_score',
    'driver_experience_months',
    'driver_age',
    'cargo_weight_kg',
    'previous_incidents_count'
]

# Variable de salida
target = 'incident_next_24h' # 0 o 1
Output del Modelo:
json{
  "driver_id": "DRV-2025-0001",
  "vehicle_id": "VEH-2025-0042",
  "incident_probability": 0.67, // 67% probabilidad
  "risk_level": "high",
  "contributing_factors": [
    {
      "factor": "hours_driving_today",
      "value": 9.5,
      "impact": 0.35 // 35% de la probabilidad
    },
    {
      "factor": "weather_condition",
      "value": "heavy_rain",
      "impact": 0.20
    },
    {
      "factor": "driver_score_last_30d",
      "value": 68,
      "impact": 0.12
    }
  ],
  "recommendation": "Sugerir descanso de 30 min antes de continuar viaje. Considerar reasignar ruta a conductor alternativo.",
  "predicted_at": "2025-11-06T14:00:00Z"
}
Acciones Preventivas:

Alertar a supervisor: "⚠️ Conductor DRV-001 tiene alto riesgo de incidente. Recomendamos descanso."
Ofrecer incentivo al conductor: "Toma un break de 30 min, gana +10 puntos de score"
Bloqueo suave: "Para tu seguridad, recomendamos descansar antes de continuar" (puede omitir pero queda registrado)


3.6. Geocercas y Zonas Operativas Avanzadas
3.6.1. Tipos de Geocercas
Geofencing optimiza rutas evitando congestión y permite tracking de tiempo en sitio SQ MagazineSensor Tower
TipoDescripciónUso ComúnAcción AutomáticaZona OperativaÁrea donde la empresa opera normalmenteTodo Lima MetropolitanaAlerta si sale sin autorizaciónTerminal/BasePunto de partida/llegada de viajesAlmacén CentralAuto-pausar tracking al entrarClienteUbicación de entrega/recogidaSupermercado Wong San IsidroRegistrar hora de llegada/salidaZona de DescansoParadero autorizado para breaksGrifo/Restaurante en Km 45Permitir parada sin alertasZona RestringidaProhibido entrar (riesgo, regulación)Zona residencial, túnel bajoAlerta crítica + log en expedienteZona de TráficoÁrea con congestión frecuenteCentro de Lima 8am-10amSugerir ruta alternativaZona de RiesgoAlto índice de robos/asaltosCarretera Central Km 30-35 nocheTracking intensivo + alerta a seguridadZona de PeajePunto de cobro en carreteraPeaje Puente PiedraAuto-registrar gastoZona de PesajeBalanza obligatoriaBalanza MTC Km 50Recordar detención obligatoriaZona de Restricción VehicularPico y Placa, restricción por tipoLima centro 7am-10amPrevenir viajes en horarios prohibidos
3.6.2. Diseño de Geocercas (Dashboard Web)
Herramientas de Creación:

Por Dirección

Ingresar dirección → Mapbox Geocoding API
Definir radio (50m - 5km)
Preview en mapa


Por Dibujo Libre

Herramienta de polígonos (estilo Google Maps)
Click para agregar vértices
Área calculada automáticamente
Límite: 50 vértices por geocerca (performance)


Por Importación

Upload de archivo KML/GeoJSON
Útil para zonas complejas (ej: todo un distrito)
Validación de formato y límites


Por Template

Biblioteca de geocercas pre-definidas:

"Todos los Wongs de Lima"
"Terminales de buses interprovinciales"
"Grifos autorizados"


Click para aplicar



Configuración Avanzada de Geocerca:
json{
  "geofence_id": "GEO-WONG-SANISIDRO-001",
  "name": "Wong San Isidro - Av. Conquistadores",
  "type": "cliente",
  "geometry": {
    "type": "circle", // o "polygon"
    "center": {"lat": -12.0982, "lng": -77.0364},
    "radius_m": 100
  },
  "schedule": {
    "active_days": ["monday", "tuesday", "wednesday", "thursday", "friday"],
    "active_hours": {
      "start": "06:00",
      "end": "22:00"
    }
  },
  "rules": {
    "on_entry": {
      "actions": [
        "log_event",
        "notify_supervisor",
        "start_timer" // para medir tiempo en sitio
      ],
      "message_to_driver": "Has llegado a Wong San Isidro. Registra tu descarga."
    },
    "on_exit": {
      "actions": [
        "log_event",
        "stop_timer",
        "require_proof_of_delivery" // foto o firma
      ],
      "message_to_driver": "Saliendo de Wong. ¿Descarga completada?"
    },
    "max_dwell_time_minutes": 120, // 2 horas máximo
    "alert_if_exceeds": true
  },
  "metadata": {
    "customer_id": "CUST-WONG-001",
    "customer_name": "Supermercados Wong",
    "contact_phone": "+51987654321",
    "special_instructions": "Descargar por puerta lateral, tocar timbre 3 veces"
  },
  "status": "activa",
  "created_by": "admin_002",
  "created_at": "2025-01-15T10:00:00Z"
}
```

**Geocercas Dinámicas (Feature Avanzada):**

Geofencing moderno permite zonas que cambian según contexto 

**Ejemplo: Zona de Tráfico Dinámica**
- Integración con Mapbox Traffic API
- Si detecta congestión >60 min en Av. Javier Prado → activar geocerca de "evitar zona"
- Al mejorar tráfico → desactivar automáticamente
- Recalcular rutas activas para evitar la zona

**Ejemplo: Zona de Riesgo por Clima**
- Integración con API de clima (OpenWeatherMap)
- Si detecta lluvia intensa + neblina en carretera de montaña → marcar como "zona de riesgo temporal"
- Alertar a conductores en ruta: "Condición climática adversa adelante. Reducir velocidad."

#### 3.6.3. Análisis de Cumplimiento de Zonas

**Dashboard de Geocercas:**

**Métricas Clave:**
```
📍 Geocercas Activas: 47
   - Clientes: 28
   - Zonas de descanso: 12
   - Zonas restringidas: 5
   - Zonas de riesgo: 2

📊 Cumplimiento Últimos 30 Días:
   - Entradas registradas: 1,247
   - Salidas registradas: 1,239
   - Violaciones (entrada no autorizada): 3
   - Tiempo promedio en sitio de cliente: 45 min

⚠️ Violaciones Recientes:
   - VEH-042 entró a zona restringida (Túnel bajo) - 2025-11-05 14:30
   - VEH-018 excedió tiempo en cliente (3h 20min) - 2025-11-04 16:45
```

**Reportes Automáticos:**
- Reporte semanal de cumplimiento por conductor
- Ranking de conductores con más violaciones
- Zonas con mayor tiempo de permanencia (eficiencia)
- Zonas con menor cumplimiento (necesitan atención)

**Alertas Predictivas:**
- "VEH-042 se dirige hacia zona restringida, ETA 10 min. ¿Alertar al conductor?"

---

### 3.7. Reportes y Analítica con Looker Studio

#### 3.7.1. Pipeline de Datos
```
Firestore (real-time) 
    → Cloud Functions (trigger on write)
        → BigQuery (data warehouse)
            → Looker Studio (visualización)
```

**Tablas en BigQuery:**

1. **trips** (Fact Table)
   - trip_id, driver_id, vehicle_id, start_time, end_time
   - distance_km, duration_min, fuel_consumed, avg_speed
   - alerts_count, events_count, driver_score_impact

2. **trip_points** (GPS Tracking)
   - point_id, trip_id, timestamp, lat, lng, speed, accuracy
   - Particionada por date (para queries rápidas)

3. **alerts** (Eventos)
   - alert_id, trip_id, driver_id, type, severity, timestamp
   - description, location, resolved_by, resolved_at

4. **drivers** (Dimension Table)
   - driver_id, name, hire_date, branch, experience_level
   - current_score, total_trips, total_km

5. **vehicles** (Dimension Table)
   - vehicle_id, plate, type, year, capacity_kg
   - health_score, maintenance_status

6. **maintenance_records**
   - record_id, vehicle_id, date, type, cost, notes

**ETL Automatizado:**
- Cloud Function se ejecuta cada 15 min
- Agrega datos de Firestore → BigQuery
- Elimina duplicados
- Calcula métricas agregadas (sum, avg, percentiles)

#### 3.7.2. Dashboards de Looker Studio

**DASHBOARD 1: Operaciones en Vivo (Actualización cada 5 min)**

Analytics self-serve aumentó eficiencia del equipo 3x 

**Componentes:**
```
┌─────────────────────────────────────────────────────┐
│  📊 KPIs Principales (Scorecards)                   │
├──────────────┬──────────────┬──────────────────────┤
│ Vehículos    │ Viajes       │ Alertas             │
│ Activos      │ en Curso     │ Últimas 24h         │
│   85 / 120   │     42       │      23             │
│   (71%)      │              │   ↓ 12% vs ayer     │
└──────────────┴──────────────┴──────────────────────┘

┌─────────────────────────────────────────────────────┐
│  🗺️ Mapa en Vivo (Geo Chart)                        │
│  • Vehículos activos (íconos verdes)                │
│  • Vehículos detenidos (íconos amarillos)           │
│  • Alertas activas (íconos rojos parpadeantes)      │
│  • Geocercas (polígonos azules)                     │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📈 Gráficos de Tendencia                            │
├───────────────────────┬─────────────────────────────┤
│ Viajes por Hora (Bar) │ Dist. Recorrida (Line)      │
│ 6am:  8 viajes        │ Hoy:    3,450 km            │
│ 7am: 15 viajes        │ Ayer:   3,200 km (+7.8%)    │
│ 8am: 22 viajes        │ Prom 7d: 3,100 km           │
└───────────────────────┴─────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  ⚠️ Alertas Recientes (Table)                        │
│  Hora   | Vehículo | Conductor | Tipo      | Estado │
│  14:32  | VEH-042  | Juan P.   | Velocidad | ✅     │
│  14:15  | VEH-018  | María G.  | Desvío    | 🔄     │
│  13:58  | VEH-067  | Carlos M. | Geocerca  | ✅     │
└─────────────────────────────────────────────────────┘
```

**Filtros Interactivos:**
- Rango de fechas (hoy, últimos 7 días, mes actual, custom)
- Sucursal / Zona geográfica
- Tipo de vehículo
- Conductor específico
- Tipo de alerta

---

**DASHBOARD 2: Análisis de Conductores (Actualización diaria)**
```
┌─────────────────────────────────────────────────────┐
│  🏆 Ranking de Conductores (Scoreboard)             │
│  #  | Nombre        | Score | Viajes | Alertas     │
│  1  | Pedro López   |  96   |  124   |   2         │
│  2  | Ana Torres    |  94   |  118   |   3         │
│  3  | Luis Martínez |  92   |  131   |   5         │
│  ...                                                 │
│  50 | Carlos Vega   |  68   |   89   |  28         │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📊 Distribución de Scores (Histogram)              │
│       |                                              │
│  25 ┤     ██                                         │
│  20 ┤     ██                                         │
│  15 ┤  ██ ██ ██                                      │
│  10 ┤  ██ ██ ██ ██                                   │
│   5 ┤  ██ ██ ██ ██ ██                                │
│   0 └────────────────────                            │
│      60  70  80  90 100                              │
│  Promedio: 82 | Mediana: 84                          │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📈 Evolución de Score por Conductor (Line Chart)   │
│  [Selector multi-conductor para comparar]           │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  ⚠️ Conductores en Riesgo (Table)                    │
│  Score <70 O >5 alertas/semana O >2 incidentes/mes  │
│  → Requieren coaching o capacitación                │
└─────────────────────────────────────────────────────┘
```

---

**DASHBOARD 3: Eficiencia de Flota (Actualización diaria)**
```
┌─────────────────────────────────────────────────────┐
│  ⛽ Consumo de Combustible                           │
├───────────────────────┬─────────────────────────────┤
│ Consumo Total Mes     │ Eficiencia Promedio         │
│   12,450 litros       │   5.2 km/litro              │
│   ↓ 8% vs mes pasado  │   ↑ 6% vs mes pasado        │
└───────────────────────┴─────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  🚛 Top 10 Vehículos Eficientes (Bar Chart)         │
│  VEH-042: 6.1 km/L ████████████████                 │
│  VEH-018: 5.9 km/L ██████████████                   │
│  VEH-067: 5.7 km/L ████████████                     │
│  ...                                                 │
│  🚨 Bottom 3 (necesitan revisión)                    │
│  VEH-089: 3.8 km/L ██████                           │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  ⏱️ Utilización de Flota (Stacked Bar)              │
│  % de tiempo en:                                     │
│  • En movimiento: 45%                                │
│  • Detenido (carga/descarga): 30%                    │
│  • Inactivo (base): 20%                              │
│  • Mantenimiento: 5%                                 │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  💰 Costo por Kilómetro (Scatter Plot)              │
│  [Vehículos plotted por km recorridos vs costo]     │
│  Identifica vehículos costosos de operar            │
└─────────────────────────────────────────────────────┘

DASHBOARD 4: Cumplimiento y Seguridad (Actualización diaria)
┌─────────────────────────────────────────────────────┐
│  📋 PESV - Cumplimiento Normativo                    │
├───────────────────────┬─────────────────────────────┤
│ Conductores con       │ Vehículos con               │
│ Capacitación Vigente  │ Documentos al Día           │
│   118 / 120 (98%)     │   115 / 120 (96%)           │
└───────────────────────┴─────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  ⚠️ Documentos por Vencer (30 días) - Table         │
│  Tipo          | Vehículo | Fecha Venc. | Días Rest.│
│  SOAT          | VEH-042  | 2025-12-06  |    30     │
│  Revisión Téc. | VEH-018  | 2025-12-15  |    39     │
│  Licencia      | DRV-089  | 2025-12-01  |    25     │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📊 IncidentesRetryHContinue┌─────────────────────────────────────────────────────┐
│  📊 Incidentes por Tipo (Pie Chart)                 │
│  • Velocidad: 45% (28 incidentes)                   │
│  • Frenado brusco: 30% (19 incidentes)              │
│  • Desvío de ruta: 15% (9 incidentes)               │
│  • Geocercas: 10% (6 incidentes)                    │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  🗺️ Mapa de Calor de Incidentes (Heat Map)          │
│  Zonas geográficas con mayor concentración          │
│  → Permite identificar tramos peligrosos            │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📈 Tendencia de Seguridad (Line Chart - 12 meses)  │
│  • Incidentes/1000 km                               │
│  • Meta: <2 incidentes/1000 km                      │
│  • Actual: 1.8 (✅ dentro de meta)                  │
└─────────────────────────────────────────────────────┘

DASHBOARD 5: Análisis Financiero (Actualización semanal)
┌─────────────────────────────────────────────────────┐
│  💰 Costos Operacionales - Mes Actual               │
├───────────────────────┬─────────────────────────────┤
│ Combustible           │ $28,450                     │
│ Mantenimiento         │ $12,300                     │
│ Peajes                │ $3,200                      │
│ Salarios conductores  │ $45,000                     │
│ Seguros               │ $8,500                      │
│ ─────────────────────────────────────────────       │
│ TOTAL                 │ $97,450                     │
│ Costo/km              │ $1.52                       │
│ Costo/viaje           │ $234                        │
└───────────────────────┴─────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📊 Comparativo Mensual (Bar Chart)                  │
│  Últimos 6 meses de costos operacionales            │
│  → Identifica tendencias al alza                    │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  ⛽ Ahorro de Combustible por Optimización           │
│  Ahorro estimado vs rutas no optimizadas:           │
│  • Mes actual: $3,450 (12%)                         │
│  • Año a la fecha: $38,200                          │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📈 ROI de SmartFleet Pro                            │
│  Costo plataforma: $1,800/mes (120 vehículos)      │
│  Ahorro combustible: $3,450/mes                     │
│  Reducción incidentes: $2,100/mes (menos seguros)  │
│  Aumento productividad: $4,200/mes (15% más viajes)│
│  ─────────────────────────────────────────────      │
│  ROI Neto: +$7,950/mes (+441%)                      │
│  Payback period: 2.3 meses                          │
└─────────────────────────────────────────────────────┘
3.7.3. Reportes Automáticos Programados
Frecuencias:

Diario (8am): Resumen de actividad del día anterior (email a admins)
Semanal (lunes 9am): Análisis de conductores + ranking (email + PDF descargable)
Mensual (día 1, 10am): Reporte ejecutivo completo (PowerPoint generado automáticamente)
Trimestral: Análisis de tendencias y recomendaciones estratégicas

Contenido del Reporte Semanal (Email):
📧 SmartFleet Pro - Resumen Semanal
Para: gerente.operaciones@empresa.com
Semana: 28 Oct - 03 Nov 2025

────────────────────────────────────────────────
📊 MÉTRICAS CLAVE

Viajes completados: 417 (↑ 8% vs semana anterior)
Kilómetros totales: 24,350 km (↑ 12%)
Promedio por viaje: 58.4 km
Combustible consumido: 4,680 litros
Eficiencia: 5.2 km/L (↑ 0.3 vs semana pasada)

────────────────────────────────────────────────
🏆 TOP 3 CONDUCTORES

1. Pedro López - Score: 96 (35 viajes, 0 alertas)
2. Ana Torres - Score: 94 (31 viajes, 1 alerta)
3. Luis Martínez - Score: 92 (38 viajes, 2 alertas)

────────────────────────────────────────────────
⚠️ ATENCIÓN REQUERIDA

- 3 conductores con score <70 necesitan coaching
- VEH-089: Consumo anómalo (3.8 km/L) - revisar motor
- 2 licencias vencen en próximos 15 días

────────────────────────────────────────────────
📈 TENDENCIAS

✅ Alertas de velocidad: ↓ 18% vs semana pasada
✅ Cumplimiento de rutas: 94% (meta: 90%)
⚠️ Tiempo promedio en entregas: ↑ 12 min (congestión)

────────────────────────────────────────────────
📎 ADJUNTO: Reporte_detallado_semana_44_2025.pdf

Ver dashboard completo: [Link al Looker Studio]
3.7.4. Exportación de Datos
Formatos disponibles:

📄 PDF: Reporte con gráficos embebidos (imprimible)
📊 Excel: Datos crudos + tablas dinámicas pre-configuradas
📈 CSV: Para análisis externo (ej: importar a otro sistema)
🗺️ KML/GeoJSON: Rutas para visualizar en Google Earth / QGIS
📹 MP4: Video replay de viajes (feature premium)

API de Exportación (para integraciones):
javascript// Ejemplo: Exportar datos de viajes del último mes
GET /api/v1/trips/export
Headers: 
  Authorization: Bearer {jwt_token}
Query params:
  start_date=2025-10-01
  end_date=2025-10-31
  format=json
  include=driver,vehicle,alerts,route_points

Response:
{
  "export_id": "EXP-20251106-0001",
  "status": "processing",
  "estimated_completion": "2025-11-06T14:45:00Z",
  "download_url": null // disponible cuando status = "completed"
}
```

---

### 3.8. Panel de Administración Web (Dashboard)

#### 3.8.1. Arquitectura de la Interfaz

**Stack Frontend:**
- **Framework**: Flutter Web (MVP) → React + TypeScript (si escala complejidad)
- **State Management**: Riverpod (Flutter) o Redux Toolkit (React)
- **UI Components**: Material Design 3 con customización
- **Mapas**: Mapbox GL JS
- **Charts**: Recharts (React) o fl_chart (Flutter)
- **Real-time**: Firestore listeners + WebSocket (futuro)

**Diseño Responsive:**
- Desktop (>1280px): Layout con sidebar + mapa central + panel lateral
- Tablet (768-1280px): Sidebar colapsable, mapa + panel stack vertical
- Mobile (< 768px): Navegación bottom tabs, vistas en pestañas

#### 3.8.2. Estructura de Navegación
```
┌─────────────────────────────────────────────────────┐
│  🏢 SmartFleet Pro          [🔔 3] [👤 Admin] [⚙️]  │
├──────────┬──────────────────────────────────────────┤
│          │                                           │
│  📊 Home │  🗺️ MAPA EN TIEMPO REAL                  │
│          │                                           │
│  🗺️ Mapa │  ┌─────────────────────────────────────┐│
│  en Vivo │  │                                       ││
│          │  │    [Vehículos en movimiento]         ││
│  🚛 Flotas│  │                                       ││
│          │  │    • Filtros: [Todos] [En ruta]      ││
│  👥 Conductores  │           [Detenidos] [Alertas]  ││
│          │  │                                       ││
│  📍 Viajes│  │    • Capas: ☑️ Vehículos ☑️ Geocercas││
│          │  │              ☑️ Tráfico ☐ Clima       ││
│  ⚠️ Alertas│  └─────────────────────────────────────┘│
│          │                                           │
│  📊 Reportes│  Panel lateral: Lista de vehículos    │
│          │  [VEH-042] Juan P. | 85 km/h | ✅        │
│  🔧 Mantenimiento [VEH-018] María G. | Detenido | ⚠️ │
│          │  [VEH-067] Carlos M. | 72 km/h | ✅       │
│  📋 PESV │                                           │
│          │  [Ver todos: 85 vehículos activos]       │
│  ⚙️ Config│                                          │
│          │                                           │
└──────────┴──────────────────────────────────────────┘
```

#### 3.8.3. Vista de Mapa en Vivo (Feature Principal)

**Elementos del Mapa:**

1. **Íconos de Vehículos (Dinámicos)**
```
   Estados visuales:
   • 🟢 En movimiento (ícono camión verde + dirección)
   • 🟡 Detenido (ícono amarillo)
   • 🔴 Alerta activa (ícono rojo parpadeante)
   • ⚫ Offline (ícono gris, última posición conocida)
   • 🔧 En mantenimiento (ícono con llave inglesa)
```

2. **Clustering Inteligente**
   - Si hay >20 vehículos en misma área → agrupar en círculo con número
   - Click en cluster → zoom in para expandir
   - Clustering desactivado en zoom >14 (nivel de calle)

3. **Tooltip al Hover**
```
   ┌─────────────────────────┐
   │ VEH-042 | Volvo FH16     │
   │ Conductor: Juan Pérez    │
   │ Velocidad: 85 km/h       │
   │ Score: 87/100            │
   │ Última actualización: 5s │
   │ [Ver detalles →]         │
   └─────────────────────────┘
```

4. **Panel Lateral de Detalles (al hacer click)**
```
   ┌─────────────────────────────────────┐
   │ 🚛 VEH-042 - Volvo FH16             │
   ├─────────────────────────────────────┤
   │ 👤 Conductor: Juan Pérez            │
   │ 📞 +51 987 654 321 [Llamar]         │
   │                                     │
   │ 📍 Ubicación Actual:                │
   │    Av. Javier Prado Este Km 4.5    │
   │    San Isidro, Lima                 │
   │                                     │
   │ 🎯 Viaje Actual:                    │
   │    TRIP-20251106-0245               │
   │    Destino: Wong San Isidro         │
   │    ETA: 15 min (14:50)              │
   │    Progreso: ████████░░ 78%         │
   │                                     │
   │ ⚡ Estado:                           │
   │    Velocidad: 85 km/h               │
   │    Batería: 78%                     │
   │    Señal: ████░ Buena               │
   │                                     │
   │ 📊 Métricas de Hoy:                 │
   │    Distancia: 245 km                │
   │    Tiempo: 6h 15min                 │
   │    Score: 87/100                    │
   │    Alertas: 2 (velocidad)           │
   │                                     │
   │ 🔔 Acciones:                        │
   │    [📞 Llamar] [💬 Mensaje]         │
   │    [🚨 Enviar alerta]               │
   │    [📍 Ver historial]               │
   │    [🎯 Asignar nuevo viaje]         │
   └─────────────────────────────────────┘
```

5. **Trazado de Ruta (Polyline)**
   - Ruta planeada: Línea azul punteada
   - Ruta recorrida: Línea verde sólida
   - Desvíos: Línea roja (cuando se sale de ruta planeada)
   - Animación: Línea se va "dibujando" en tiempo real

6. **Geocercas (Polígonos)**
   - Clientes: Verde claro (fill: rgba(0,255,0,0.1), stroke: green)
   - Zonas restringidas: Rojo (fill: rgba(255,0,0,0.2), stroke: red)
   - Zonas de riesgo: Naranja parpadeante
   - Hover en geocerca → muestra nombre y detalles

7. **Capa de Tráfico**
   - Verde: Fluido
   - Amarillo: Lento
   - Rojo: Congestionado
   - Toggle on/off desde sidebar

8. **Capa de Clima** (Integración con OpenWeatherMap)
   - Íconos de lluvia, nieve, niebla sobre zonas afectadas
   - Alertas visuales si hay condiciones adversas en ruta activa

#### 3.8.4. Filtros y Búsqueda Avanzada

**Barra de Búsqueda Global:**
```
🔍 Buscar vehículo, conductor, viaje...
```
- Autocompletado inteligente
- Busca por: Placa, nombre conductor, ID de viaje, ubicación
- Resultados en tiempo real (< 200ms)

**Panel de Filtros:**
```
┌─────────────────────────────────┐
│ 🔧 FILTROS                      │
├─────────────────────────────────┤
│ Estado:                         │
│ ☑️ En movimiento (42)            │
│ ☑️ Detenido (31)                 │
│ ☑️ Con alertas (8)               │
│ ☐ Offline (4)                   │
│                                 │
│ Sucursal:                       │
│ ☑️ Todas                         │
│ ☐ Lima Norte                    │
│ ☐ Lima Sur                      │
│ ☐ Callao                        │
│                                 │
│ Tipo de vehículo:               │
│ ☑️ Todos                         │
│ ☐ Trailer                       │
│ ☐ Camión                        │
│ ☐ Camioneta                     │
│                                 │
│ Score del conductor:            │
│ ▓▓▓▓▓▓▓▓░░ 70-100               │
│                                 │
│ [Aplicar filtros] [Limpiar]    │
└─────────────────────────────────┘
```

**Filtros Guardados (Presets):**
- "Vehículos con alertas críticas"
- "Flotas de Lima Norte"
- "Conductores en capacitación"
- "Vehículos próximos a mantenimiento"
- Usuario puede crear y guardar sus propios filtros

#### 3.8.5. Vista de Lista (Alternativa al Mapa)

**Tabla Interactiva:**
```
┌────────────────────────────────────────────────────────────────────────────┐
│ Vehículo | Conductor    | Estado      | Velocidad | Viaje      | Score | ⚙️│
├──────────┼──────────────┼─────────────┼───────────┼────────────┼───────┼──┤
│ VEH-042  │ Juan Pérez   │ 🟢 En ruta  │ 85 km/h   │ TRIP-0245  │  87   │⋮ │
│ VEH-018  │ María García │ 🟡 Detenido │ 0 km/h    │ TRIP-0246  │  92   │⋮ │
│ VEH-067  │ Carlos Díaz  │ 🔴 Alerta   │ 105 km/h  │ TRIP-0247  │  68   │⋮ │
│ VEH-089  │ Luis Torres  │ 🟢 En ruta  │ 72 km/h   │ TRIP-0248  │  91   │⋮ │
│ VEH-123  │ Ana López    │ ⚫ Offline   │ --        │ --         │  84   │⋮ │
└──────────┴──────────────┴─────────────┴───────────┴────────────┴───────┴──┘

Mostrando 5 de 85 vehículos | [◀ Anterior] [1] [2] [3] ... [17] [Siguiente ▶]
```

**Features:**
- Ordenar por cualquier columna (click en header)
- Búsqueda en tabla (search box)
- Exportar tabla a Excel/CSV
- Menú contextual (⋮) con acciones rápidas:
  - Ver en mapa
  - Ver historial
  - Enviar mensaje
  - Asignar viaje

#### 3.8.6. Historial de Rutas (Replay)

**Selector de Fecha/Hora:**
```
┌─────────────────────────────────────────┐
│ Ver historial de: VEH-042               │
├─────────────────────────────────────────┤
│ Desde: [2025-11-06] [06:00]             │
│ Hasta: [2025-11-06] [14:30]             │
│                                         │
│ [🔍 Buscar rutas]                       │
└─────────────────────────────────────────┘
```

**Controles de Replay:**
```
┌─────────────────────────────────────────────────────┐
│  ◀◀  ▶️ || ▶▶   [Timeline]     🐌 1x 🐇            │
│                                                     │
│  ═══════════●═════════════════════════════         │
│  06:00      08:23              14:30               │
│                                                     │
│  📍 Ubicación: Av. Javier Prado Este               │
│  🕐 Hora: 08:23:15                                 │
│  🚗 Velocidad: 85 km/h                             │
│  📊 Score en este punto: 87                        │
│  ⚠️ Eventos: Frenado brusco detectado              │
└─────────────────────────────────────────────────────┘

3.9. P.E.S.V. (Plan Estratégico de Seguridad Vial)
3.9.1. Contexto Regulatorio
¿Qué es PESV?
En Colombia (Ley 1503/2011) y varios países de Latinoamérica, empresas con flotas deben implementar un Plan Estratégico de Seguridad Vial que incluye:

Capacitación obligatoria de conductores
Control de horas de conducción
Registro de incidentes y accidentes
Inspección pre-operacional de vehículos
Mantenimiento preventivo
Gestión del riesgo (identificar conductores/vehículos de alto riesgo)

SmartFleet Pro como Herramienta de Compliance:
Automatiza >80% de las tareas de documentación y seguimiento requeridas por ley.
3.9.2. Módulo de Capacitaciones
Gestión de Cursos:
json{
  "course_id": "CURSO-2025-001",
  "name": "Conducción Defensiva - Nivel Avanzado",
  "type": "obligatorio", // o "recomendado"
  "duration_hours": 8,
  "valid_for_months": 24,
  "provider": "Instituto de Seguridad Vial",
  "cost_per_person": 150,
  "topics": [
    "Técnicas de frenado en emergencia",
    "Manejo en condiciones climáticas adversas",
    "Prevención de colisiones",
    "Fatiga y descanso obligatorio"
  ],
  "required_for_vehicles": ["trailer", "camion"], // no para camionetas
  "schedule": [
    {
      "date": "2025-11-15",
      "time": "08:00-17:00",
      "location": "Sede Lima Norte",
      "instructor": "Ing. Roberto Mendoza",
      "capacity": 20,
      "enrolled": 12,
      "status": "open"
    }
  ]
}
```

**Asignación Automática:**
- Sistema detecta conductor sin capacitación vigente
- Genera tarea para admin: "Inscribir a Juan Pérez en curso antes del 2025-12-01"
- Envía reminder al conductor 7 días antes del curso
- Post-curso: Subir certificado y actualizar perfil

**Dashboard de Capacitaciones:**
```
┌─────────────────────────────────────────────────────┐
│  📚 Estado de Capacitaciones                         │
├──────────────────────────┬──────────────────────────┤
│ Con capacitación vigente │ 118 / 120 (98%)          │
│ Próximas a vencer (30d)  │ 8 conductores            │
│ Vencidas                 │ 2 conductores ⚠️         │
└──────────────────────────┴──────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📅 Próximos Cursos Programados                      │
│  • 15 Nov: Conducción Defensiva (12 inscritos)      │
│  • 22 Nov: Manejo de Cargas Peligrosas (5 inscritos)│
│  • 29 Nov: Primeros Auxilios (8 inscritos)          │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  👥 Conductores Requieren Capacitación Urgente      │
│  • Carlos Vega - Conducción Def. vencida (15 días)  │
│  • María Torres - PESV Básico vencido (3 días)      │
│  [Inscribir automáticamente] [Notificar supervisor]  │
└─────────────────────────────────────────────────────┘
3.9.3. Control de Horas de Conducción
Regulación típica (varía por país):

Máximo 10 horas de conducción diaria
Descanso obligatorio de 30 min cada 4 horas
Entre jornadas: mínimo 8 horas de descanso
Máximo 60 horas semanales

Algoritmo de Monitoreo:
javascript// Pseudocódigo
function checkDriverFatigue(driver_id, current_trip) {
  const today_driving_hours = getTodayDrivingHours(driver_id);
  const hours_since_last_break = getHoursSinceLastBreak(driver_id);
  const week_driving_hours = getWeekDrivingHours(driver_id);
  
  if (today_driving_hours >= 10) {
    return {
      severity: "critical",
      action: "block_new_trips",
      message: "Límite diario alcanzado. Debe descansar mínimo 8h."
    };
  }
  
  if (hours_since_last_break >= 4) {
    return {
      severity: "high",
      action: "suggest_break",
      message: "Llevas 4h continuas. Toma un descanso de 30 min."
    };
  }
  
  if (week_driving_hours >= 60) {
    return {
      severity: "critical",
      action: "block_new_trips",
      message: "Límite semanal alcanzado. Contacta a tu supervisor."
    };
  }
  
  return { severity: "ok" };
}
```

**Notificaciones Proactivas:**
- 3h 45min de conducción → Notificación: "En 15 min debes tomar un descanso obligatorio"
- 9h de conducción → Notificación: "En 1 hora termina tu jornada máxima permitida"
- Intento de iniciar viaje con horas excedidas → Bloqueado con mensaje explicativo

**Registro de Descansos:**
- Conductor marca "Inicio de descanso" en app
- Sistema pausa tracking intensivo
- Temporizador visual: "Descanso: 15 min / 30 min"
- Al completar 30 min → "Descanso completado. Puedes continuar."

**Dashboard de Cumplimiento:**
```
┌─────────────────────────────────────────────────────┐
│  ⏱️ Horas de Conducción - Semana Actual             │
├─────────────────────────────────────────────────────┤
│  Conductor        │ Horas │ Descansos │ Cumplimiento│
│  Juan Pérez       │ 48/60 │ 12/12     │ ✅ 100%     │
│  María García     │ 52/60 │ 13/13     │ ✅ 100%     │
│  Carlos Díaz      │ 58/60 │ 14/15     │ ⚠️ 93%      │
│  Luis Torres      │ 61/60 │ 15/15     │ 🚨 Excedido │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📊 Cumplimiento de Descansos (Gauge Chart)         │
│                                                     │
│          ┌─────────┐                                │
│          │   96%   │  ✅ Dentro de norma            │
│          └─────────┘                                │
│      Meta: >95%                                     │
└─────────────────────────────────────────────────────┘
```

#### 3.9.4. Registro de Incidentes y Accidentes

**Formulario de Reporte (App Conductor):**
```
┌─────────────────────────────────────┐
│ 🚨 Reportar Incidente/Accidente    │
├─────────────────────────────────────┤
│ Tipo:                               │
│ ○ Accidente de tránsito             │
│ ● Incidente (sin colisión)          │
│ ○ Falla mecánica                    │
│ ○ Robo/Intento de robo              │
│ ○ Otro                              │
│                                     │
│ Gravedad:                           │
│ ● Leve (sin lesiones ni daños)      │
│ ○ Moderado (daños materiales)       │
│ ○ Grave (lesiones o daños mayores)  │
│                                     │
│ Descripción:                        │
│ [Frenado de emergencia por vehículo│
│  que invadió mi carril en curva]    │
│                                     │
│ Ubicación:                          │
│ 📍 Av. Javier Prado Este Km 4.5    │
│ [Usar ubicación actual] [Cambiar]   │
│                                     │
│ Fotos: (opcional)                   │
│ [📷 Agregar fotos]                  │
│ [IMG_001.jpg] [IMG_002.jpg]         │
│                                     │
│ Testigos: (opcional)                │
│ Nombre: [Carlos Mendoza]            │
│ Teléfono: [+51987654321]            │
│ [+ Agregar otro testigo]            │
│                                     │
│ ¿Requiere asistencia inmediata?     │
│ ☐ Sí (enviar alerta a emergencias)  │
│                                     │
│ [Enviar reporte]                    │
└─────────────────────────────────────┘
Workflow de Gestión:

Conductor envía reporte
Supervisor recibe notificación inmediata
Supervisor llama al conductor para validar situación
Si es accidente grave → activar protocolo de emergencia:

Notificar a seguro
Enviar grúa si es necesario
Documentar para auditoría


Admin hace seguimiento hasta cierre del caso
Incidente queda en expediente del conductor (pero no af
RetryHContinueecta score si no fue su culpa)
Dashboard de Incidentes:
┌─────────────────────────────────────────────────────┐
│  🚨 Incidentes - Últimos 30 Días                     │
├──────────────────────────┬──────────────────────────┤
│ Total incidentes         │ 12                       │
│ Accidentes de tránsito   │ 2 (grave: 0, leve: 2)    │
│ Fallas mecánicas         │ 5                        │
│ Robos/Intentos           │ 0                        │
│ Otros                    │ 5                        │
└──────────────────────────┴──────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📋 Incidentes Abiertos (Tabla)                      │
│  ID    | Fecha  | Conductor | Tipo      | Estado    │
│  INC-1 | 05-Nov | Juan P.   | Mecánico  | En revisión│
│  INC-2 | 04-Nov | Carlos D. | Accidente | Pendiente │
│  [Ver todos los incidentes →]                        │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📊 Incidentes por Causa Raíz (Pareto Chart)         │
│  1. Condiciones de la vía: 35%                       │
│  2. Falla mecánica: 25%                              │
│  3. Error humano: 20%                                │
│  4. Condiciones climáticas: 15%                      │
│  5. Otros: 5%                                        │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  🗺️ Mapa de Puntos Negros (Hotspots)                │
│  Zonas con mayor concentración de incidentes:       │
│  • Av. Javier Prado Km 4-6: 3 incidentes            │
│  • Carretera Central Km 28-30: 2 incidentes         │
│  → Acciones sugeridas: Reforzar capacitación,       │
│     alertar conductores al aproximarse               │
└─────────────────────────────────────────────────────┘
3.9.5. Inspección Pre-Operacional (IPO)
Checklist Digital en App:
Antes de cada viaje, el conductor debe completar:
┌─────────────────────────────────────┐
│ ✅ Inspección Pre-Operacional       │
│ VEH-042 | Juan Pérez | 06-Nov-2025 │
├─────────────────────────────────────┤
│ EXTERIOR                            │
│ ☑️ Luces (delanteras, traseras)     │
│ ☑️ Espejos retrovisores              │
│ ☑️ Llantas (presión, profundidad)   │
│ ☑️ Parabrisas (sin grietas)          │
│ ☑️ Carrocería (sin daños mayores)    │
│                                     │
│ MOTOR                               │
│ ☑️ Nivel de aceite                   │
│ ☑️ Nivel de refrigerante             │
│ ☑️ Nivel de líquido de frenos        │
│ ☑️ Batería (sin fugas)               │
│                                     │
│ INTERIOR                            │
│ ☑️ Cinturón de seguridad             │
│ ☑️ Bocina                            │
│ ☑️ Limpiaparabrisas                  │
│ ☑️ Freno de mano                     │
│                                     │
│ DOCUMENTOS                          │
│ ☑️ SOAT vigente                      │
│ ☑️ Revisión técnica vigente          │
│ ☑️ Licencia de conducir vigente      │
│                                     │
│ SEGURIDAD                           │
│ ☑️ Botiquín de primeros auxilios     │
│ ☑️ Extintor (carga vigente)          │
│ ☑️ Kit de herramientas básicas       │
│ ☑️ Triángulos de seguridad           │
│                                     │
│ ¿Encontraste alguna anomalía?       │
│ ○ No, todo en orden                 │
│ ● Sí (describir abajo)              │
│                                     │
│ Descripción:                        │
│ [Llanta trasera izquierda muestra  │
│  desgaste irregular, requiere       │
│  revisión urgente]                  │
│                                     │
│ Fotos de evidencia: (opcional)      │
│ [📷 Agregar fotos]                  │
│                                     │
│ [Enviar inspección]                 │
│                                     │
│ ⚠️ Si hay problemas críticos,       │
│ no podrás iniciar viaje hasta       │
│ que se resuelvan.                   │
└─────────────────────────────────────┘
Lógica de Validación:

Si todos los items están OK → Viaje aprobado automáticamente
Si hay problemas menores (ej: espejo desajustado) → Warning, pero puede continuar
Si hay problemas críticos (ej: frenos defectuosos) → Viaje bloqueado

Notificación al mecánico: "VEH-042 requiere revisión urgente antes de operar"
Supervisor debe autorizar manualmente si conductor puede usar vehículo alternativo



Historial de IPOs:
┌─────────────────────────────────────────────────────┐
│  📋 Historial de Inspecciones - VEH-042             │
│  Fecha     | Conductor | Resultado | Anomalías      │
│  06-Nov    | Juan P.   | ⚠️ Con obs.| Llanta desgaste│
│  05-Nov    | Juan P.   | ✅ OK      | Ninguna        │
│  04-Nov    | María G.  | ✅ OK      | Ninguna        │
│  03-Nov    | Juan P.   | 🚨 Crítico | Frenos ruido   │
│  [Ver más →]                                         │
└─────────────────────────────────────────────────────┘
Análisis Predictivo:

Si 3+ inspecciones consecutivas reportan mismo problema → Alerta mantenimiento preventivo
Si conductor siempre marca "todo OK" sin fotos → Flag para auditoría (posible fraude)

3.9.6. Matriz de Riesgos
Identificación Automática de Conductores de Alto Riesgo:
javascript// Algoritmo de scoring de riesgo
function calculateRiskScore(driver) {
  let risk = 0;
  
  // Factor 1: Driver Score
  if (driver.score < 70) risk += 30;
  else if (driver.score < 80) risk += 15;
  
  // Factor 2: Incidentes
  risk += driver.incidents_last_12m * 10;
  
  // Factor 3: Alertas recientes
  risk += driver.alerts_last_30d * 2;
  
  // Factor 4: Capacitación vencida
  if (driver.training_expired) risk += 20;
  
  // Factor 5: Experiencia (menos experiencia = más riesgo)
  if (driver.experience_months < 6) risk += 25;
  else if (driver.experience_months < 12) risk += 10;
  
  // Factor 6: Horas de conducción excesivas
  if (driver.week_hours > 55) risk += 15;
  
  return Math.min(risk, 100); // Cap en 100
}
```

**Matriz de Riesgo (Dashboard PESV):**
```
┌─────────────────────────────────────────────────────┐
│  🎯 Matriz de Riesgo - Conductores                   │
│                                                     │
│        Alto │ ████ (8)                              │
│   Riesgo    │                                       │
│             │                                       │
│      Medio  │ ██████████ (23)                       │
│             │                                       │
│             │                                       │
│       Bajo  │ ████████████████████████████ (89)    │
│             └───────────────────────────────        │
│              Bajo    Medio    Alto                  │
│                   Frecuencia                        │
│                                                     │
│  🚨 Conductores de Alto Riesgo:                     │
│  1. Carlos Vega - Score: 68, Incidentes: 3         │
│     Acción: Capacitación obligatoria + seguimiento │
│  2. Luis Díaz - Score: 65, Alertas: 28/mes         │
│     Acción: Coaching 1-on-1 con supervisor         │
│  [Ver plan de acción →]                             │
└─────────────────────────────────────────────────────┘
```

**Plan de Acción Automatizado:**
- **Riesgo Alto (>70)**: Suspensión temporal + capacitación obligatoria
- **Riesgo Medio (40-70)**: Coaching + monitoreo intensivo (tracking cada 5 seg)
- **Riesgo Bajo (<40)**: Monitoreo estándar

#### 3.9.7. Reportes de Auditoría PESV

**Reporte Trimestral para Autoridades:**

Generado automáticamente y exportable a PDF oficial:
```
═══════════════════════════════════════════════════════
    REPORTE PESV - TRIMESTRE Q4 2025
    Empresa: Transportes SmartFleet S.A.C.
    RUC: 20123456789
    Fecha de generación: 06-Nov-2025
═══════════════════════════════════════════════════════

1. INDICADORES DE GESTIÓN

   Tasa de accidentalidad:
   • Accidentes/100,000 km: 0.42 (↓ 35% vs trimestre anterior)
   • Meta: <0.5 ✅ CUMPLIDA

   Cumplimiento de capacitaciones:
   • Conductores capacitados: 118/120 (98.3%)
   • Meta: >95% ✅ CUMPLIDA

   Cumplimiento de mantenimiento preventivo:
   • Vehículos al día: 115/120 (95.8%)
   • Meta: >95% ✅ CUMPLIDA

   Control de horas de conducción:
   • Cumplimiento semanal: 96.2%
   • Meta: >90% ✅ CUMPLIDA

2. INCIDENTES Y ACCIDENTES

   Total de incidentes: 38
   • Leves: 32 (84%)
   • Moderados: 5 (13%)
   • Graves: 1 (3%)

   Causas principales:
   1. Condiciones de la vía: 40%
   2. Falla mecánica: 30%
   3. Error humano: 20%
   4. Clima adverso: 10%

   Acciones correctivas implementadas:
   • Refuerzo de capacitación en conducción defensiva
   • Incremento de frecuencia de mantenimiento preventivo
   • Alertas tempranas en zonas identificadas como peligrosas

3. CONDUCTORES DE ALTO RIESGO

   Identificados: 8 conductores (6.7% de la flota)
   
   Acciones tomadas:
   • 8/8 asistieron a capacitación adicional
   • 5/8 mejoraron su score a rango aceptable
   • 3/8 en proceso de coaching 1-on-1

4. AUDITORÍAS Y MEJORAS

   Auditorías internas realizadas: 3
   No conformidades encontradas: 2
   • NC-001: 2 conductores con capacitación vencida (CERRADA)
   • NC-002: 5 vehículos con SOAT próximo a vencer (CERRADA)

   Mejoras implementadas:
   • Sistema automático de alertas de documentos por vencer
   • Dashboard en tiempo real para supervisores

5. INVERSIÓN EN SEGURIDAD VIAL

   Total invertido: $42,500 USD
   • Capacitaciones: $18,000
   • Mantenimiento preventivo: $21,000
   • Tecnología (SmartFleet Pro): $3,500

   ROI estimado:
   • Reducción de accidentes: $85,000 ahorrados (seguros)
   • Reducción de combustible: $12,600 (eficiencia)
   • Total: $97,600 vs $42,500 invertidos = 130% ROI

6. COMPROMISOS PRÓXIMO TRIMESTRE

   ✅ Mantener tasa de accidentalidad <0.5
   ✅ Alcanzar 100% de conductores con capacitación vigente
   ✅ Implementar sistema de reconocimiento para conductores élite
   ✅ Reducir incidentes por falla mecánica en 20%

═══════════════════════════════════════════════════════
Firma digital:
Gerente de Operaciones: [Firma electrónica]
Responsable PESV: [Firma electrónica]
Fecha: 06-Nov-2025
═══════════════════════════════════════════════════════
```

**Exportación:**
- PDF con sello digital (validez legal)
- Excel con datos crudos (para análisis externo)
- Envío automático a correo de autoridades (si hay integración)

---

### 3.10. Mantenimiento Predictivo Avanzado

#### 3.10.1. Sistema de Alertas Preventivas

**Niveles de Alerta:**

| Nivel | Trigger | Acción | Ejemplo |
|-------|---------|--------|---------|
| 🟢 **Verde** | >1000 km para próximo servicio | Recordatorio informativo | "VEH-042: 1,200 km para mantenimiento" |
| 🟡 **Amarillo** | 500-1000 km para servicio | Alerta en dashboard + email | "VEH-042: 750 km para mantenimiento. Programar." |
| 🟠 **Naranja** | <500 km o <7 días | Notificación push diaria + flag en mapa | "VEH-042: 300 km para mantenimiento. URGENTE." |
| 🔴 **Rojo** | Servicio vencido | Bloqueo de nuevos viajes + alerta crítica | "VEH-042: Mantenimiento vencido. Vehículo bloqueado." |

#### 3.10.2. Gestión de Órdenes de Trabajo

**Workflow Completo:**

1. **Detección Automática**
```
   Sistema detecta: VEH-042 alcanzó 9,800 km (próximo servicio: 10,000 km)
   → Genera automáticamente Orden de Trabajo (OT)

Creación de OT

json   {
     "ot_id": "OT-2025-1234",
     "vehicle_id": "VEH-042",
     "type": "preventivo", // o "correctivo"
     "priority": "normal", // "bajo", "normal", "alto", "crítico"
     "status": "pendiente",
     "created_at": "2025-11-06T14:00:00Z",
     "created_by": "system_auto",
     "scheduled_date": "2025-11-10T08:00:00Z",
     "estimated_duration_hours": 4,
     "tasks": [
       {
         "task": "Cambio de aceite y filtro",
         "parts_required": ["Aceite 15W40 x20L", "Filtro aceite #OF-123"],
         "estimated_cost": 120
       },
       {
         "task": "Rotación de llantas",
         "parts_required": [],
         "estimated_cost": 0
       },
       {
         "task": "Inspección de frenos",
         "parts_required": [],
         "estimated_cost": 0
       },
       {
         "task": "Revisión de luces",
         "parts_required": [],
         "estimated_cost": 0
       }
     ],
     "assigned_to": "mechanic_005",
     "workshop": "Taller Central",
     "notes": "Servicio preventivo cada 10,000 km según plan del fabricante"
   }
```

3. **Notificaciones**
   - Admin: Email con OT generada + link para aprobar
   - Mecánico: Notificación push "Nueva OT asignada: VEH-042"
   - Conductor: "VEH-042 entrará a mantenimiento el 10-Nov. Coordinar con supervisor."

4. **Ejecución**
```
   Mecánico abre OT en su tablet/móvil:
   
   ┌─────────────────────────────────────┐
   │ 🔧 OT-2025-1234                     │
   │ VEH-042 | Volvo FH16 | ABC-123      │
   ├─────────────────────────────────────┤
   │ Tareas:                             │
   │ ☑️ Cambio de aceite y filtro         │
   │    Iniciado: 08:15 | Finalizado: 09:00│
   │    Repuestos usados: ✅              │
   │                                     │
   │ ☑️ Rotación de llantas               │
   │    Iniciado: 09:05 | Finalizado: 09:45│
   │                                     │
   │ ☑️ Inspección de frenos              │
   │    Iniciado: 09:50 | Finalizado: 10:30│
   │    ⚠️ Pastillas traseras al 40%     │
   │    Recomendación: Cambio en próximo │
   │    servicio o antes de 5,000 km     │
   │                                     │
   │ ☑️ Revisión de luces                 │
   │    Iniciado: 10:35 | Finalizado: 10:50│
   │    🔴 Luz trasera derecha quemada   │
   │    Repuesto: Foco LED instalado     │
   │                                     │
   │ Tiempo total: 2h 35min              │
   │                                     │
   │ Costo total:                        │
   │ • Repuestos: $145                   │
   │ • Mano de obra: $80 (2.5h × $32/h)  │
   │ • Total: $225                       │
   │                                     │
   │ Firma del mecánico:                 │
   │ [✍️ Firmar digitalmente]            │
   │                                     │
   │ Fotos de evidencia:                 │
   │ [📷 Agregar fotos]                  │
   │ [IMG_001.jpg - Pastillas de freno]  │
   │ [IMG_002.jpg - Nueva luz instalada] │
   │                                     │
   │ [Finalizar OT]                      │
   └─────────────────────────────────────┘
```

5. **Cierre y Documentación**
   - OT cerrada automáticamente actualiza:
     - Odómetro del próximo servicio: +10,000 km
     - Historial de mantenimiento del vehículo
     - Inventario de repuestos (resta los usados)
     - Health Score del vehículo (recalcula según hallazgos)
   - Notificación al conductor: "VEH-042 listo para operar. Mantenimiento completado."

#### 3.10.3. Inventario de Repuestos

**Sistema Integrado:**
```
┌─────────────────────────────────────────────────────┐
│  📦 Inventario de Repuestos                          │
├─────────────────────────────────────────────────────┤
│  Repuesto             | Stock | Min | Estado        │
│  Aceite 15W40 (20L)   | 45    | 20  | ✅ OK         │
│  Filtro aceite #OF-123| 18    | 15  | ✅ OK         │
│  Pastillas freno tras.| 8     | 10  | ⚠️ Reabastecer│
│  Focos LED traseros   | 3     | 5   | ⚠️ Reabastecer│
│  Llantas 295/80R22.5  | 2     | 4   | 🚨 Crítico    │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  🔔 Alertas de Reabastecimiento                      │
│  • Pastillas de freno: Stock bajo (8 < 10)          │
│    Acción: Orden de compra automática generada      │
│  • Llantas: Stock crítico (2 < 4)                   │
│    Acción: Alerta urgente a compras                 │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📊 Consumo de Repuestos (Últimos 30 días)          │
│  • Aceite: 180 litros (9 cambios)                   │
│  • Filtros: 9 unidades                              │
│  • Pastillas freno: 4 juegos                        │
│  Costo total: $2,450                                │
└─────────────────────────────────────────────────────┘
Integración con Proveedores (Fase 3):

Orden de compra automática cuando stock < mínimo
API para consultar disponibilidad en tiempo real
Comparador de precios entre proveedores

3.10.4. Predicción con Machine Learning
Modelo Predictivo de Fallas (BigQuery ML - Fase 3):
ML analiza temperatura, vibración, presión y consumo para predecir fallos VolpisMICHELIN Connected Fleet
Features del Modelo:
pythonfeatures = [
    # Datos del vehículo
    'vehicle_age_months',
    'total_km',
    'km_since_last_maintenance',
    'vehicle_type',
    
    # Datos de uso
    'avg_daily_km_last_30d',
    'harsh_events_count_last_30d',
    'avg_load_weight_kg',
    'terrain_type_distribution', // % highway, urban, mountain
    
    # Datos de sensores (proxy desde smartphone)
    'vibration_anomalies_count',
    'acceleration_variance',
    'fuel_efficiency_trend', // mejorando o empeorando
    
    # Historial de mantenimiento
    'days_since_last_service',
    'corrective_maintenance_count_last_12m',
    'parts_replaced_last_12m',
    
    # Datos contextuales
    'avg_temperature_last_30d',
    'rainy_days_last_30d'
]

target = 'failure_next_30d' // 0 o 1
Output del Modelo:
json{
  "vehicle_id": "VEH-042",
  "predictions": [
    {
      "component": "sistema_frenos",
      "failure_probability": 0.78,
      "predicted_failure_date": "2025-11-25",
      "confidence": 0.85,
      "contributing_factors": [
        {"factor": "harsh_braking_events", "impact": 0.45},
        {"factor": "km_since_last_service", "impact": 0.25},
        {"factor": "vehicle_age", "impact": 0.08}
      ],
      "recommendation": "Inspeccionar frenos en próximos 7 días. Probable necesidad de cambio de pastillas."
    },
    {
      "component": "suspension",
      "failure_probability": 0.34,
      "predicted_failure_date": null,
      "confidence": 0.72,
      "recommendation": "Monitoreo estándar. Sin acción inmediata requerida."
    }
  ],
  "overall_health_score": 72,
  "risk_level": "medium"
}
```

**Dashboard Predictivo:**
```
┌─────────────────────────────────────────────────────┐
│  🔮 Predicción de Mantenimiento (30 días)            │
├─────────────────────────────────────────────────────┤
│  Vehículo | Componente      | Prob. | Acción        │
│  VEH-042  | Frenos          | 78%   | 🚨 Inspeccionar│
│  VEH-018  | Batería         | 65%   | ⚠️ Monitorear  │
│  VEH-067  | Neumáticos      | 52%   | ⚠️ Monitorear  │
│  VEH-089  | Sistema eléctrico| 45%  | ✅ OK          │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  💰 Ahorro Estimado por Mantenimiento Predictivo     │
│  Costos evitados (últimos 6 meses):                 │
│  • Fallas mayores prevenidas: 8                     │
│  • Ahorro en reparaciones: $12,400                  │
│  • Ahorro en tiempo de inactividad: $8,600          │
│  • Total: $21,000                                   │
│                                                     │
│  vs Costo de SmartFleet Pro: $2,100 (6 meses)      │
│  ROI: 900%                                          │
└─────────────────────────────────────────────────────┘
```

#### 3.10.5. Historial Completo del Vehículo

**Ficha Técnica Digital:**
```
┌─────────────────────────────────────────────────────┐
│  🚛 VEH-042 - Volvo FH16 (ABC-123)                  │
├─────────────────────────────────────────────────────┤
│  📊 Estadísticas Generales                           │
│  • Edad: 4 años 8 meses                             │
│  • Kilometraje total: 325,430 km                    │
│  • Km promedio/día: 190 km                          │
│  • Health Score: 87/100                             │
│  • Valor residual estimado: $52,000                 │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  🔧 Historial de Mantenimiento (Últimos 12 meses)   │
│  Fecha     | Tipo       | Costo  | Detalles         │
│  06-Nov-25 | Preventivo | $225   | Cambio aceite    │
│  15-Oct-25 | Correctivo | $890   | Reemplazo batería│
│  20-Sep-25 | Preventivo | $245   | Servicio 10k     │
│  10-Ago-25 | Correctivo | $1,240 | Cambio embrague  │
│  [Ver historial completo: 38 registros →]           │
│                                                     │
│  Costo total últimos 12m: $8,450                    │
│  Costo/km: $0.026                                   │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  ⚠️ Incidentes y Accidentes                          │
│  • Total en vida útil: 5                            │
│  • Últimos 12 meses: 1 (leve)                       │
│  • Último incidente: 12-Sep-25 (frenado emergencia) │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📈 Gráficos de Tendencias                           │
│                                                     │
│  Costo de Mantenimiento Mensual (Line Chart)        │
│  $│                                                  │
│ 1k│         ●                                        │
│   │    ●          ●                                  │
│500│  ●   ●   ●       ●   ●   ●   ●                  │
│   └────────────────────────────────                 │
│    E F M A M J J A S O N D                          │
│                                                     │
│  Eficiencia de Combustible (Line Chart)             │
│ km│                                                  │
│/L │  5.4  5.2  5.3  5.1  5.0  4.8 ⚠️ (deterioro)    │
│   └────────────────────────────────                 │
│    Jul Ago Sep Oct Nov Dic                          │
│    Acción: Revisar inyectores en próximo servicio   │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  📄 Documentos Adjuntos                              │
│  • Manual del fabricante.pdf                        │
│  • SOAT_2025.pdf (vigente hasta 15-Mar-2026)        │
│  • Revisión_técnica_2025.pdf (vence 10-Dic-2025)    │
│  • Facturas_mantenimiento/ (38 archivos)            │
│  • Fotos_inspecciones/ (124 imágenes)               │
└─────────────────────────────────────────────────────┘

🎨 4. ESPECIFICACIONES DE UI/UX
4.1. Design System
Paleta de Colores (Configurable por Empresa):
Colores Primarios:
- Primary: #1976D2 (AzRetryHContinue1 / 2ul corporativo)

Primary Dark: #115293
Primary Light: #4791DB
Secondary: #FF9800 (Naranja para acciones/alertas)
Secondary Dark: #C77700
Secondary Light: #FFB333

Estados y Feedback:

Success: #4CAF50 (Verde - operaciones OK)
Warning: #FF9800 (Naranja - atención requerida)
Error: #F44336 (Rojo - crítico)
Info: #2196F3 (Azul - información)

Neutros:

Background: #F5F5F5 (Gris muy claro)
Surface: #FFFFFF (Blanco)
Text Primary: #212121 (Negro casi)
Text Secondary: #757575 (Gris medio)
Divider: #BDBDBD (Gris claro)

Mapas y Tracking:

Vehicle Active: #4CAF50 (Verde brillante)
Vehicle Stopped: #FFC107 (Amarillo)
Vehicle Alert: #F44336 (Rojo parpadeante)
Vehicle Offline: #9E9E9E (Gris)
Route Planned: #2196F3 (Azul)
Route Traveled: #4CAF50 (Verde)
Route Deviation: #F44336 (Rojo)
Geofence Safe: rgba(76, 175, 80, 0.2) (Verde transparente)
Geofence Restricted: rgba(244, 67, 54, 0.3) (Rojo transparente)


**Tipografía:**
Font Family: 'Inter' (Google Fonts) - excelente legibilidad en pantallas
Jerarquía:

H1: 32px, Bold, Letter-spacing: -0.5px (Títulos principales)
H2: 24px, SemiBold, Letter-spacing: -0.25px (Secciones)
H3: 20px, SemiBold (Subsecciones)
H4: 18px, Medium (Títulos de tarjetas)
Body1: 16px, Regular (Texto principal)
Body2: 14px, Regular (Texto secundario)
Caption: 12px, Regular (Metadatos, timestamps)
Button: 14px, Medium, Uppercase (Botones principales)

Line-height:

Títulos: 1.2
Texto: 1.5


**Espaciado (Sistema de 8px):**

XXS: 4px (espacios muy ajustados)
XS: 8px (espacios entre elementos relacionados)
S: 16px (separación estándar)
M: 24px (separación entre secciones)
L: 32px (separación grande)
XL: 48px (separación entre bloques principales)
XXL: 64px (márgenes de página)


**Elevaciones (Sombras):**
```css
/* Material Design elevation system */
.elevation-1 { 
  box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
}
.elevation-2 { 
  box-shadow: 0 3px 6px rgba(0,0,0,0.15), 0 2px 4px rgba(0,0,0,0.12);
}
.elevation-3 { 
  box-shadow: 0 10px 20px rgba(0,0,0,0.15), 0 3px 6px rgba(0,0,0,0.10);
}
.elevation-4 { 
  box-shadow: 0 15px 25px rgba(0,0,0,0.15), 0 5px 10px rgba(0,0,0,0.05);
}
```

**Border Radius:**

Small: 4px (chips, badges)
Medium: 8px (botones, cards)
Large: 16px (modales, paneles laterales)
XLarge: 24px (elementos destacados)
Circle: 50% (avatares, íconos circulares)


### 4.2. Componentes Clave (App Móvil - Conductor)

#### 4.2.1. Pantalla Principal (Home)
┌─────────────────────────────────────────────────────┐
│  ☰  SmartFleet Pro          [🔔 2]  [Score: 87]    │
├─────────────────────────────────────────────────────┤
│                                                     │
│  👋 Hola, Juan                                      │
│  Buen día! Tienes 1 viaje asignado                  │
│                                                     │
│  ┌───────────────────────────────────────────────┐ │
│  │ 🚛 TU VEHÍCULO HOY                            │ │
│  │                                               │ │
│  │  VEH-042 | Volvo FH16 | ABC-123               │ │
│  │  Estado: ✅ Listo para operar                 │ │
│  │                                               │ │
│  │  Odómetro: 325,430 km                         │ │
│  │  Próximo servicio en: 4,570 km                │ │
│  │  Documentos: ✅ Todos vigentes                │ │
│  │                                               │ │
│  │  [Ver detalles del vehículo →]                │ │
│  └───────────────────────────────────────────────┘ │
│                                                     │
│  ┌───────────────────────────────────────────────┐ │
│  │ 📍 VIAJE ASIGNADO                             │ │
│  │                                               │ │
│  │  Destino: Wong San Isidro                     │ │
│  │  Dirección: Av. Conquistadores 1228           │ │
│  │  Distancia: 12.5 km | ETA: 25 min             │ │
│  │  Carga: 40 pallets (18 ton)                   │ │
│  │  Hora programada: 15:00 hrs                   │ │
│  │                                               │ │
│  │  [🗺️ Ver ruta]  [🚀 INICIAR VIAJE]           │ │
│  └───────────────────────────────────────────────┘ │
│                                                     │
│  ┌───────────────────────────────────────────────┐ │
│  │ 📊 TUS ESTADÍSTICAS HOY                       │ │
│  │                                               │ │
│  │  🚗 Viajes completados: 2                     │ │
│  │  📏 Distancia recorrida: 85 km                │ │
│  │  ⏱️ Tiempo de conducción: 3h 15min            │ │
│  │  ⚡ Score promedio: 89/100                    │ │
│  │  ⚠️ Alertas: 1 (velocidad leve)               │ │
│  └───────────────────────────────────────────────┘ │
│                                                     │
│  ┌───────────────────────────────────────────────┐ │
│  │ 🏆 TU RANKING                                 │ │
│  │                                               │ │
│  │  Posición: #12 de 120 conductores             │ │
│  │  Percentil: Top 10% 🌟                        │ │
│  │  [Ver leaderboard →]                          │ │
│  └───────────────────────────────────────────────┘ │
│                                                     │
│  [⚙️ Configuración]  [📞 Soporte]                  │
│                                                     │
└─────────────────────────────────────────────────────┘

**Interacciones:**
- Pull-to-refresh para actualizar datos
- Tap en tarjeta de vehículo → Ver detalles completos + historial
- Tap en "INICIAR VIAJE" → Flujo de inicio (IPO + confirmación)
- Tap en "Ver ruta" → Abrir mapa con ruta trazada
- Tap en Score → Ver desglose detallado de puntuación

#### 4.2.2. Flujo de Inicio de Viaje

**PASO 1: Inspección Pre-Operacional**
┌─────────────────────────────────────────────────────┐
│  ← SmartFleet Pro                                   │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ✅ Inspección Pre-Operacional                      │
│  VEH-042 | 06-Nov-2025 14:35                        │
│                                                     │
│  Antes de iniciar tu viaje, verifica:              │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  EXTERIOR                                    3/5    │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  ✅ Luces (delanteras, traseras, direccionales)    │
│  ✅ Espejos retrovisores                            │
│  ✅ Llantas (presión, profundidad, desgaste)       │
│  ☐ Parabrisas (sin grietas)                        │
│  ☐ Carrocería (sin daños mayores)                  │
│                                                     │
│  [Continuar →]                                      │
│                                                     │
│  💡 Tip: Si encuentras algún problema, repórtalo   │
│  inmediatamente antes de continuar.                 │
│                                                     │
└─────────────────────────────────────────────────────┘

**Animaciones:**
- Checkboxes con animación de "check" al marcar
- Barra de progreso animada (3/5, 4/5, 5/5)
- Confetti celebration al completar toda la inspección

**PASO 2: Problemas Encontrados (Opcional)**
┌─────────────────────────────────────────────────────┐
│  ← Inspección                                       │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ⚠️ Reportar Problema                               │
│                                                     │
│  Selecciona el tipo de problema:                   │
│                                                     │
│  ○ Problema menor (puedo continuar)                │
│  ● Problema moderado (requiere atención)            │
│  ○ Problema crítico (no puedo operar)              │
│                                                     │
│  Describe el problema:                             │
│  ┌─────────────────────────────────────────────┐   │
│  │ Espejo retrovisor derecho está suelto,     │   │
│  │ se mueve con el viento. Requiere ajuste.   │   │
│  │                                             │   │
│  └─────────────────────────────────────────────┘   │
│                                                     │
│  📸 Agregar fotos (opcional):                       │
│  [📷 Tomar foto]  [🖼️ Desde galería]               │
│                                                     │
│  [IMG_001.jpg] ×                                    │
│                                                     │
│  [Enviar reporte]                                   │
│                                                     │
└─────────────────────────────────────────────────────┘

**PASO 3: Confirmación de Inicio**
┌─────────────────────────────────────────────────────┐
│                                                     │
│              🚀 ¿Iniciar Viaje?                     │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  Destino: Wong San Isidro                          │
│  Dirección: Av. Conquistadores 1228                │
│  Distancia estimada: 12.5 km                       │
│  Tiempo estimado: 25 min                           │
│                                                     │
│  Carga: 40 pallets de alimentos refrigerados       │
│  Peso: 18,000 kg                                   │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  ✅ Inspección pre-operacional completada          │
│  ✅ Documentos vigentes                             │
│  ✅ Vehículo en buen estado                         │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  Al iniciar, se activará el tracking en            │
│  tiempo real y comenzará el registro del viaje.    │
│                                                     │
│                                                     │
│         [Cancelar]    [🚀 INICIAR VIAJE]           │
│                                                     │
└─────────────────────────────────────────────────────┘

**PASO 4: Viaje en Curso**
┌─────────────────────────────────────────────────────┐
│  ☰  Viaje en Curso                    Score: 87 🟢 │
├─────────────────────────────────────────────────────┤
│                                                     │
│  🗺️ [MAPA EN TIEMPO REAL - PANTALLA COMPLETA]      │
│                                                     │
│  • Tu ubicación (ícono camión azul)                │
│  • Ruta trazada (línea azul)                       │
│  • Destino (pin rojo)                              │
│  • Tráfico overlay                                 │
│                                                     │
│  ┌─────────────────────────────────────────────┐   │
│  │ Panel info flotante (bottom)                │   │
│  │                                             │   │
│  │ 📍 Destino: Wong San Isidro                 │   │
│  │ 🚗 8.2 km restantes | ETA 14:58 (18 min)    │   │
│  │ 🚦 Tráfico: Moderado                        │   │
│  │                                             │   │
│  │ ━━━━━━━━━━━━━━━━━━●━━━━━━━━━━              │   │
│  │ 65% completado                              │   │
│  │                                             │   │
│  │ [🔄 Recalcular ruta] [⏸️ Pausar] [🏁 Finalizar]│
│  └─────────────────────────────────────────────┘   │
│                                                     │
│  ┌─────────────────────────────────────────────┐   │
│  │ Métricas en tiempo real (colapsable)       │   │
│  │                                             │   │
│  │ 🚗 Velocidad actual: 65 km/h                │   │
│  │ ⚡ Score del viaje: 89/100                  │   │
│  │ ⏱️ Tiempo de conducción: 1h 15min           │   │
│  │ 📏 Distancia recorrida: 4.3 km              │   │
│  │ ⚠️ Eventos: 0                               │   │
│  └─────────────────────────────────────────────┘   │
│                                                     │
└─────────────────────────────────────────────────────┘

**Features en pantalla:**
- Botón flotante para recentralizar mapa en tu ubicación
- Modo navegación por voz (integrado con Google/Apple Maps)
- Alertas visuales si excedes velocidad (borde rojo parpadeante)
- Notificación cuando te acercas al destino (500m antes)

**PASO 5: Llegada al Destino**
┌─────────────────────────────────────────────────────┐
│                                                     │
│              🎯 Has llegado a tu destino            │
│                                                     │
│  Wong San Isidro                                   │
│  Av. Conquistadores 1228                           │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  📊 Resumen del viaje:                             │
│  • Distancia: 12.7 km                              │
│  • Duración: 28 min                                │
│  • Score: 89/100 ⭐                                 │
│  • Eventos: 0                                      │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  ¿Qué deseas hacer?                                │
│                                                     │
│  [⏸️ Pausar viaje]                                  │
│  (Para carga/descarga)                             │
│                                                     │
│  [🏁 Finalizar viaje]                               │
│  (Si completaste la entrega)                       │
│                                                     │
└─────────────────────────────────────────────────────┘

**PASO 6: Confirmación de Entrega**
┌─────────────────────────────────────────────────────┐
│  ← Finalizar Viaje                                  │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ✅ Confirmar Entrega                               │
│                                                     │
│  Cliente: Supermercados Wong                       │
│  Dirección: Av. Conquistadores 1228                │
│  Fecha/Hora: 06-Nov-2025 14:58                     │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  📦 Carga entregada:                               │
│  ☑️ 40 pallets de alimentos refrigerados            │
│  ☑️ Todos los sellos intactos                       │
│  ☑️ Cliente conforme                                │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  📸 Prueba de entrega (requerida):                  │
│  [📷 Tomar foto de descarga]                        │
│  [IMG_001.jpg - Descarga completada] ×              │
│                                                     │
│  ✍️ Firma del cliente (opcional):                   │
│  [Canvas para firma digital]                        │
│  ┌─────────────────────────────────────────────┐   │
│  │                                             │   │
│  │        [Área de firma]                      │   │
│  │                                             │   │
│  └─────────────────────────────────────────────┘   │
│  [Limpiar firma]                                   │
│                                                     │
│  📝 Notas adicionales (opcional):                   │
│  ┌─────────────────────────────────────────────┐   │
│  │ Entrega sin novedades. Cliente solicitó    │   │
│  │ dejar carga en rampa 3.                     │   │
│  └─────────────────────────────────────────────┘   │
│                                                     │
│  [Finalizar y enviar →]                            │
│                                                     │
└─────────────────────────────────────────────────────┘

**PASO 7: Resumen Final y Gamificación**
┌─────────────────────────────────────────────────────┐
│                                                     │
│              🎉 ¡Viaje Completado!                  │
│                                                     │
│  ⭐⭐⭐⭐⭐                                           │
│  Score del viaje: 89/100                           │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  📊 Estadísticas:                                  │
│  • Distancia: 12.7 km                              │
│  • Duración: 28 min                                │
│  • Velocidad promedio: 27 km/h                     │
│  • Frenados suaves: ✅                             │
│  • Aceleración progresiva: ✅                      │
│  • Sin desvíos de ruta: ✅                         │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  🏆 Logros desbloqueados:                          │
│  ✨ "10 Viajes Sin Alertas" (+50 pts)              │
│  🎯 "Puntualidad Perfecta" (+25 pts)               │
│                                                     │
│  Tu nuevo score general: 87 → 89 (+2) 📈          │
│  Posición en ranking: #12 → #10 🎉                 │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  💬 "¡Excelente trabajo, Juan! Sigue así."         │
│                                                     │
│  [Ver detalles completos]  [Volver al inicio]     │
│                                                     │
└─────────────────────────────────────────────────────┘

**Animaciones post-viaje:**
- Confetti animation al mostrar score alto (>85)
- Contador animado de puntos ganados
- Badge aparece con animación de "pop"
- Sonido de notificación suave (configurable)

#### 4.2.3. Pantalla de Score Personal
┌─────────────────────────────────────────────────────┐
│  ← Tu Score                                         │
├─────────────────────────────────────────────────────┤
│                                                     │
│         ┌─────────────────────┐                     │
│         │                     │                     │
│         │        87/100       │                     │
│         │      ⭐ Excelente    │                     │
│         │                     │                     │
│         └─────────────────────┘                     │
│                                                     │
│  Tu posición: #10 de 120 conductores               │
│  Mejor que el 92% de la flota 🎯                    │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  📊 Desglose de tu Score:                          │
│                                                     │
│  🚗 Velocidad adecuada          90/100             │
│  ████████████████████░░                            │
│                                                     │
│  🛑 Frenado suave                92/100             │
│  ██████████████████████░                           │
│                                                     │
│  ⚡ Aceleración progresiva       88/100             │
│  ████████████████████░░                            │
│                                                     │
│  ⛽ Eficiencia de combustible    82/100             │
│  ████████████████░░░░░                             │
│  ⚠️ Puedes mejorar aquí                            │
│                                                     │
│  🎯 Cumplimiento de rutas        95/100             │
│  ███████████████████████░                          │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  📈 Tendencia (Últimos 30 días):                   │
│  [Gráfico de línea mostrando score diario]        │
│   Score│                                            │
│   100  │           ●─●                             │
│    90  │     ●─●─●     ●─●                         │
│    80  │   ●               ●─●                     │
│    70  │                                            │
│        └─────────────────────────                  │
│         5 Oct          20 Oct      5 Nov           │
│                                                     │
│  💡 Consejo: Mantén velocidad constante para       │
│  mejorar tu eficiencia de combustible.             │
│                                                     │
│  [Ver análisis completo →]                         │
│                                                     │
└─────────────────────────────────────────────────────┘

---

### 4.3. Componentes Clave (Dashboard Web - Admin)

#### 4.3.1. Layout Principal
┌────────────────────────────────────────────────────────────────────┐
│ 🏢 SmartFleet Pro  [🔍 Buscar...]  [🔔 5] [👤 Admin ▾] [⚙️]       │
├──────────┬─────────────────────────────────────────────────────────┤
│          │                                                         │
│ 📊 Home  │  🗺️ MAPA EN TIEMPO REAL                                │
│          │  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│ 🗺️ Live  │                                                         │
│   Map    │  [Mapa Mapbox con vehículos, rutas, geocercas]         │
│          │                                                         │
│ 🚛 Flota │  Controles:                                             │
│   • Veh  │  [🔍 Buscar] [🏷️ Filtros] [🗺️ Capas] [📍 Geocercas]   │
│   • Cond │                                                         │
│          │  ┌─────────────────────────────────────────────────┐  │
│ 📍 Viajes│  │ Panel Lateral (derecha, colapsable)            │  │
│          │  │                                                 │  │
│ ⚠️ Alert │  │ 85 vehículos activos                            │  │
│          │  │                                                 │  │
│ 📊 Report│  │ [VEH-042] Juan P. 🟢                            │  │
│   • Oper │  │ 85 km/h | Score: 87                             │  │
│   • Cond │  │ Destino: Wong SI | ETA: 15 min                  │  │
│   • Flot │  │ [Ver detalles →]                                │  │
│          │  │                                                 │  │
│ 🔧 Mant  │  │ [VEH-018] María G. 🟡                           │  │
│          │  │ Detenido | Score: 92                            │  │
│ 📋 PESV  │  │ Ubicación: Terminal Central                     │  │
│          │  │ [Ver detalles →]                                │  │
│ ⚙️ Config│  │                                                 │  │
│          │  │ [VEH-067] Carlos D. 🔴                          │  │
│          │  │ 105 km/h | Score: 68 | ⚠️ ALERTA                │  │
│──────────│  │ [Ver detalles →] [Llamar] [Enviar mensaje]      │  │
│          │  │                                                 │  │
│ Stats:   │  │ [Ver todos →]                                   │  │
│ 🟢 85    │  └─────────────────────────────────────────────────┘  │
│ 🟡 31    │                                                         │
│ 🔴 8     │                                                         │
│ ⚫ 4     │                                                         │
│          │                                                         │
└──────────┴─────────────────────────────────────────────────────────┘

#### 4.3.2. Dashboard de KPIs Principales
┌─────────────────────────────────────────────────────┐
│  📊 Dashboard - Operaciones                         │
│  [Hoy] [Últimos 7 días] [Mes actual] [Custom]      │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━RetryHContinue━━━━━━━━ │
│  KPIS PRINCIPALES                                   │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  ┌──────────────┬──────────────┬──────────────┐    │
│  │ 🚛 Vehículos │ 📍 Viajes    │ 📏 Distancia │    │
│  │   Activos    │   Hoy        │   Total      │    │
│  │              │              │              │    │
│  │     85       │     127      │  8,450 km    │    │
│  │   de 120     │   (+12%)     │  (+8%)       │    │
│  │              │              │              │    │
│  │   🟢 71%     │   vs ayer    │  vs ayer     │    │
│  └──────────────┴──────────────┴──────────────┘    │
│                                                     │
│  ┌──────────────┬──────────────┬──────────────┐    │
│  │ ⚠️ Alertas   │ ⭐ Score     │ ⛽ Eficiencia │    │
│  │   Activas    │   Promedio   │   Promedio   │    │
│  │              │              │              │    │
│  │      23      │    84/100    │  5.2 km/L    │    │
│  │   (↓ 12%)   │   (Bueno)    │  (↑ 0.3)     │    │
│  │              │              │              │    │
│  │   vs ayer    │   vs sem.    │  vs semana   │    │
│  └──────────────┴──────────────┴──────────────┘    │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  GRÁFICOS DE TENDENCIA                              │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  Viajes por Hora (Últimas 24h)                     │
│  ┌─────────────────────────────────────────────┐   │
│  │ 30│                                         │   │
│  │ 25│           ██                            │   │
│  │ 20│       ██  ██  ██                        │   │
│  │ 15│   ██  ██  ██  ██  ██                    │   │
│  │ 10│   ██  ██  ██  ██  ██  ██  ██            │   │
│  │  5│   ██  ██  ██  ██  ██  ██  ██  ██        │   │
│  │  0└───────────────────────────────────      │   │
│  │    06 08 10 12 14 16 18 20 22 00 02 04     │   │
│  │    Pico: 10am (28 viajes)                   │   │
│  └─────────────────────────────────────────────┘   │
│                                                     │
│  Alertas por Tipo (Últimos 7 días)                 │
│  ┌─────────────────────────────────────────────┐   │
│  │ • Velocidad: ████████████ 45% (156)         │   │
│  │ • Frenado brusco: ████████ 30% (104)        │   │
│  │ • Desvío de ruta: ████ 15% (52)             │   │
│  │ • Geocercas: ██ 10% (35)                    │   │
│  └─────────────────────────────────────────────┘   │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  TOP & BOTTOM PERFORMERS                            │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  🏆 Top 5 Conductores (Score)                      │
│  1. Pedro López - 96 ⭐⭐⭐                         │
│  2. Ana Torres - 94 ⭐⭐⭐                          │
│  3. Luis Martínez - 92 ⭐⭐                        │
│  4. Carmen Vega - 91 ⭐⭐                          │
│  5. Roberto Silva - 90 ⭐⭐                        │
│                                                     │
│  ⚠️ Requieren Atención (Score <70)                 │
│  • Carlos Díaz - 68 (28 alertas este mes)          │
│  • Juan Vargas - 65 (2 incidentes recientes)       │
│  • Luis Torres - 63 (capacitación vencida)         │
│  [Ver plan de acción →]                            │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  ALERTAS RECIENTES                                  │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  🔴 14:45 | VEH-067 | Carlos D. | Exceso velocidad │
│  "105 km/h en zona de 80 km/h"                     │
│  [Ver detalles] [Llamar] [Marcar como revisada]    │
│                                                     │
│  🟠 14:32 | VEH-018 | María G. | Desvío de ruta    │
│  "2.5 km fuera de ruta planificada"                │
│  [Ver detalles] [Contactar]                        │
│                                                     │
│  🟡 14:15 | VEH-042 | Juan P. | Mantenimiento      │
│  "Faltan 450 km para próximo servicio"             │
│  [Programar mantenimiento]                         │
│                                                     │
│  [Ver todas las alertas →]                         │
│                                                     │
└─────────────────────────────────────────────────────┘

#### 4.3.3. Vista de Detalle de Vehículo
┌─────────────────────────────────────────────────────┐
│  ← Volver                   VEH-042 | ABC-123       │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌─────────────────────────────────────────────┐   │
│  │ 🚛 Volvo FH16 (2021)                        │   │
│  │ Health Score: 87/100 ✅                     │   │
│  │ Estado: 🟢 En ruta                          │   │
│  └─────────────────────────────────────────────┘   │
│                                                     │
│  [📊 General] [📍 En Vivo] [📈 Historial] [🔧 Mant]│
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  INFORMACIÓN GENERAL                                │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  Conductor asignado: Juan Pérez                    │
│  📞 +51 987 654 321                                │
│  [Llamar] [Enviar mensaje] [Ver perfil]            │
│                                                     │
│  Especificaciones:                                 │
│  • Capacidad: 28,000 kg                            │
│  • Tipo: Semi-remolque refrigerado                 │
│  • Ejes: 5                                         │
│  • Combustible: Diesel                             │
│  • Kilometraje: 325,430 km                         │
│                                                     │
│  Documentos:                                       │
│  • SOAT: ✅ Vigente hasta 15-Mar-2026              │
│  • Rev. Técnica: ✅ Vigente hasta 10-Dic-2025      │
│  • Seguro: ✅ Vigente hasta 15-Mar-2026            │
│  [Ver todos los documentos →]                      │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  UBICACIÓN EN TIEMPO REAL                           │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  [Mini mapa mostrando ubicación actual]            │
│                                                     │
│  📍 Av. Javier Prado Este Km 4.5                   │
│     San Isidro, Lima                               │
│     Última actualización: hace 8 seg               │
│                                                     │
│  🚗 Velocidad: 65 km/h                             │
│  🧭 Dirección: Suroeste                            │
│  🎯 Destino: Wong San Isidro                       │
│  ⏱️ ETA: 14:58 (15 min)                            │
│                                                     │
│  Viaje actual: TRIP-20251106-0245                  │
│  Progreso: ████████████░░░░ 65%                    │
│                                                     │
│  [Ver en mapa completo →]                          │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  MÉTRICAS DE HOY                                    │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  ┌────────────┬────────────┬────────────┐          │
│  │ Viajes     │ Distancia  │ Tiempo     │          │
│  │   2        │  85 km     │ 3h 15min   │          │
│  └────────────┴────────────┴────────────┘          │
│                                                     │
│  ┌────────────┬────────────┬────────────┐          │
│  │ Score      │ Alertas    │ Eficiencia │          │
│  │  89/100    │     1      │ 5.4 km/L   │          │
│  └────────────┴────────────┴────────────┘          │
│                                                     │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  ACCIONES RÁPIDAS                                   │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                     │
│  [📞 Llamar conductor]                             │
│  [💬 Enviar mensaje]                               │
│  [🚨 Enviar alerta]                                │
│  [🎯 Asignar nuevo viaje]                          │
│  [🔧 Programar mantenimiento]                      │
│  [⚠️ Reportar incidente]                           │
│  [📊 Ver reporte completo]                         │
│                                                     │
└─────────────────────────────────────────────────────┘

### 4.4. Micro-interacciones y Animaciones

**Principios de UX:**
- **Feedback inmediato**: Toda acción debe tener respuesta visual en <100ms
- **Animaciones sutiles**: Duración 200-400ms (no más de 500ms)
- **Progressive disclosure**: Mostrar información gradualmente según necesidad
- **Error prevention**: Confirmaciones para acciones destructivas
- **Offline-first**: App funciona sin internet, sincroniza después

**Animaciones Clave:**

1. **Loading States**
Skeleton screens (no spinners genéricos):
┌─────────────────────────────────┐
│ ▓▓▓▓▓▓▓▓░░░░░░░░░░░░           │ (animación shimmer)
│ ▓▓▓▓░░░░░░░░░░                  │
│ ▓▓▓▓▓▓░░░░░░░░░                 │
└─────────────────────────────────┘

2. **Success Feedback**
   - Checkmark animado (trazo progresivo)
   - Haptic feedback suave
   - Color transition (neutral → green)

3. **Error States**
   - Shake animation (3 frames, 200ms total)
   - Haptic feedback fuerte
   - Border rojo con fade in

4. **Pull to Refresh**
   - Custom animation con logo de la empresa rotando
   - Progress indicator circular

5. **Card Interactions**
   - Hover: Elevation +2, border glow sutil
   - Click: Scale 0.98, ripple effect
   - Drag: Elevation +4, semi-transparente

6. **Map Markers**
   - Vehículo en movimiento: Pulsación sutil (scale 1.0 → 1.1 → 1.0)
   - Nueva alerta: Pop in + bounce effect
   - Cluster expansion: Markers se separan en arco

7. **Score Changes**
   - Contador animado (incremental)
   - Confetti si sube a nuevo nivel
   - Color transition gradual

8. **Notificaciones**
   - Slide in from top (300ms ease-out)
   - Auto-dismiss después 5 seg con progress bar
   - Swipe to dismiss

### 4.5. Estados de Error y Empty States

**Empty States (cuando no hay datos):**
┌─────────────────────────────────────┐
│                                     │
│         🚛                          │
│                                     │
│    No hay viajes activos            │
│                                     │
│    Todos los conductores han        │
│    completado sus entregas hoy.     │
│                                     │
│    [Asignar nuevo viaje]            │
│                                     │
└─────────────────────────────────────┘

**Error States:**
┌─────────────────────────────────────┐
│                                     │
│         ⚠️                          │
│                                     │
│    No se pudo cargar los datos      │
│                                     │
│    Por favor, verifica tu conexión  │
│    a internet e intenta de nuevo.   │
│                                     │
│    [🔄 Reintentar]                  │
│                                     │
└─────────────────────────────────────┘

**Offline Mode:**
┌─────────────────────────────────────┐
│ ⚠️ Modo offline - Datos guardados   │
│    localmente, se sincronizarán     │
│    cuando vuelva la conexión        │
└─────────────────────────────────────┘

### 4.6. Accesibilidad (A11y)

**Requisitos WCAG 2.1 AA:**
- Contraste mínimo 4.5:1 para texto normal
- Contraste mínimo 3:1 para texto grande (18pt+)
- Todos los elementos interactivos con mínimo 44x44 px
- Navegación completa por teclado (web)
- Screen reader friendly (labels descriptivos)
- Textos alternativos para todas las imágenes
- Formularios con labels explícitos
- Estados de foco visibles

**Features de Accesibilidad:**
- Modo alto contraste
- Ajuste de tamaño de fuente (80%-150%)
- Reducir animaciones (respect prefers-reduced-motion)
- Soporte para TalkBack (Android) y VoiceOver (iOS)

---

## 🔒 5. SEGURIDAD Y PRIVACIDAD

### 5.1. Seguridad de Datos

**Encriptación:**
- **En tránsito**: TLS 1.3 para todas las comunicaciones
- **En reposo**: AES-256 para datos sensibles en Firestore
- **Coordenadas GPS**: Encriptadas antes de upload
- **Tokens**: JWT con RS256, rotación cada 24h

**Reglas de Firestore (Security Rules):**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Users solo pueden leer su propia info
    match /users/{userId} {
      allow read: if request.auth.uid == userId 
                  || isAdmin(request.auth.uid);
      allow write: if isAdmin(request.auth.uid);
    }
    
    // Trips: conductor lee los suyos, admin lee todos
    match /trips/{tripId} {
      allow read: if isDriver(resource.data.driver_id) 
                  || isSupervisor() 
                  || isAdmin();
      allow create: if isAdmin() || isSupervisor();
      allow update: if isDriver(resource.data.driver_id) 
                    || isAdmin();
    }
    
    // Alertas: solo lectura para conductores
    match /alerts/{alertId} {
      allow read: if isDriver(resource.data.driver_id) 
                  || isSupervisor() 
                  || isAdmin();
      allow write: if false; // Solo Cloud Functions crean alertas
    }
    
    // Funciones helper
    function isAdmin() {
      return get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
    
    function isSupervisor() {
      return get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role in ['supervisor', 'admin'];
    }
    
    function isDriver(driverId) {
      return request.auth.uid == driverId;
    }
  }
}
```

### 5.2. Privacidad del Conductor

**Transparencia:**
- Conductor ve en todo momento cuando está siendo trackeado
- Indicador persistente en app: "🔴 Tracking activo"
- Puede ver su propio historial de ubicaciones
- Política de privacidad clara y accesible

**Controles:**
- Opción "Pausar tracking" durante breaks (con aprobación supervisor)
- Modo "Fuera de servicio" (desactiva tracking completamente)
- Eliminación automática de datos personales después de 90 días (configurable)
- GDPR/LGPD compliant (para expansión internacional)

**Anonimización:**
- Datos analíticos agregados son anónimos
- Reportes externos no incluyen nombres, solo IDs
- Benchmarks de industria son completamente anónimos

### 5.3. Protección contra Fraude

**Detección de GPS Spoofing:**
- Validación de coherencia de coordenadas (velocidad imposible = alerta)
- Comparación con torres celulares (triangulación)
- Detección de "teleport" (salto instantáneo de ubicación)
- Machine learning para detectar patrones anómalos

**Prevención de Manipulación:**
- Inspecciones pre-operacionales con timestamp del servidor (no del dispositivo)
- Fotos con metadatos EXIF validados
- Firmas digitales con geolocalización embebida
- Blockchain opcional para pruebas de entrega (Fase 3)

---

**FIN DE LA PARTE 2 - SEGUNDA MITAD**

---

¿Te parece bien este nivel de detalle? He cubierto:
- ✅ Alertas y seguridad avanzada (con ML edge)
- ✅ Geocercas inteligentes y dinámicas
- ✅ Reportes y analítica con Looker Studio (5 dashboards completos)
- ✅ Panel web (arquitectura, navegación, vistas detalladas)
- ✅ PESV completo (capacitaciones, horas, incidentes, IPO, matriz de riesgo, auditoría)
- ✅ Mantenimiento predictivo con ML
- ✅ UI/UX detallado (design system, flows, componentes mobile y web, animaciones)
- ✅ Seguridad y privacidad

**¿Qué sigue?** ¿Quieres que continúe con la **PARTE 3**? Esta incluiría:

- **6. Base de Datos Detallada** (esquemas completos de todas las colecciones Firestore con índices)
- **7. Fases de Desarrollo** (roadmap detallado con sprints, features por fase, estimaciones)
- **8. Costos y Escalabilidad** (proyecciones de infra, ROI, breakeven)
- **9. Integraciones** (APIs de terceros, webhooks, marketplace de partners)
- **10. Testing y QA** (estrategia de pruebas, casos de uso, CI/CD)
- **11. Go-to-Market** (estrategia comercial, pricing, marketing, ventas)

¿Continúo con la Parte 3? 🚀RetryHContinue¡Perfecto! Aquí va la PARTE 3 COMPLETA con máximo detalle:

💾 6. BASE DE DATOS DETALLADA
6.1. Arquitectura de Datos
Decisión: Hybrid Database Architecture
┌─────────────────────────────────────────────────────┐
│           CAPA DE APLICACIÓN                        │
├─────────────────────────────────────────────────────┤
│  Flutter App (Mobile) + Flutter Web (Dashboard)     │
└──────────────────┬──────────────────────────────────┘
                   │
    ┌──────────────┼──────────────┐
    │              │              │
┌───▼────┐  ┌─────▼─────┐  ┌────▼─────┐
│Firebase│  │ BigQuery  │  │PostgreSQL│
│Firestore│  │(Analytics)│  │(Fase 3)  │
└────────┘  └───────────┘  └──────────┘
   │               │              │
   │ Real-time     │ OLAP         │ Geospatial
   │ OLTP          │ Reportes     │ + Relacional
   │ NoSQL         │ ML           │ + PostGIS
Estrategia de Particionamiento:

Firestore: Datos operacionales (últimos 90 días)
BigQuery: Datos históricos + analytics (todo el histórico)
PostgreSQL (Fase 3): Queries complejos + geoespaciales avanzados

6.2. Esquemas de Firestore (Colecciones Principales)
6.2.1. Collection: companies
javascript// Estructura multi-tenant
companies/{company_id}
{
  company_id: "COMP-2025-001",
  name: "Transportes SmartFleet S.A.C.",
  legal_name: "Transportes SmartFleet Sociedad Anónima Cerrada",
  tax_id: "20123456789", // RUC en Perú
  country: "PE",
  
  subscription: {
    plan: "enterprise", // "basic", "professional", "enterprise"
    status: "active", // "trial", "active", "suspended", "cancelled"
    start_date: "2025-01-15T00:00:00Z",
    renewal_date: "2026-01-15T00:00:00Z",
    vehicle_limit: 120,
    vehicle_count: 85,
    features: [
      "real_time_tracking",
      "advanced_analytics",
      "predictive_maintenance",
      "api_access",
      "white_label"
    ]
  },
  
  billing: {
    plan_price_usd: 1200.00, // $10/veh × 120
    payment_method: "bank_transfer",
    billing_email: "facturacion@transportes.com",
    next_invoice_date: "2025-12-01",
    auto_renew: true
  },
  
  contact: {
    primary_contact: {
      name: "Carlos Rodríguez",
      title: "Gerente de Operaciones",
      email: "carlos.r@transportes.com",
      phone: "+51987654321"
    },
    technical_contact: {
      name: "Ana López",
      email: "ana.l@transportes.com",
      phone: "+51987654322"
    }
  },
  
  settings: {
    timezone: "America/Lima",
    language: "es",
    currency: "PEN",
    units: {
      distance: "km",
      fuel: "liters",
      weight: "kg"
    },
    working_hours: {
      start: "06:00",
      end: "22:00"
    },
    thresholds: {
      speed_limit_tolerance_percent: 10,
      harsh_brake_g: -0.4,
      harsh_acceleration_g: 0.3,
      idle_time_max_minutes: 10
    }
  },
  
  branding: {
    logo_url: "gs://bucket/companies/COMP-2025-001/logo.png",
    primary_color: "#1976D2",
    secondary_color: "#FF9800"
  },
  
  branches: [
    {
      branch_id: "BR-LIMA-NORTE",
      name: "Lima Norte",
      address: "Av. Túpac Amaru 2850, Independencia",
      lat: -12.0231,
      lng: -77.0512,
      manager_name: "Luis Torres",
      manager_phone: "+51987654323"
    },
    {
      branch_id: "BR-LIMA-SUR",
      name: "Lima Sur",
      address: "Av. Defensores del Morro 1234, Chorrillos",
      lat: -12.1892,
      lng: -77.0156,
      manager_name: "María García",
      manager_phone: "+51987654324"
    }
  ],
  
  created_at: "2025-01-15T10:00:00Z",
  updated_at: "2025-11-06T15:30:00Z",
  created_by: "admin_001"
}

// Índices compuestos necesarios:
// - status + renewal_date (para avisos de renovación)
// - country + plan (para analytics por mercado)
6.2.2. Collection: users
javascriptusers/{user_id}
{
  user_id: "USR-2025-0001",
  company_id: "COMP-2025-001",
  
  // Auth info (sincronizado con Firebase Auth)
  auth_uid: "firebase_auth_uid_abc123",
  email: "juan.perez@transportes.com",
  phone: "+51987654321",
  email_verified: true,
  phone_verified: true,
  
  // Personal info
  personal: {
    first_name: "Juan",
    last_name: "Pérez García",
    full_name: "Juan Pérez García",
    dni: "12345678",
    date_of_birth: "1985-03-15",
    gender: "M",
    nationality: "PE",
    photo_url: "gs://bucket/users/USR-2025-0001/photo.jpg",
    
    address: {
      street: "Av. Lima 123",
      district: "San Isidro",
      city: "Lima",
      state: "Lima",
      postal_code: "15073",
      country: "PE"
    },
    
    emergency_contact: {
      name: "María Pérez",
      relationship: "Esposa",
      phone: "+51987654322",
      email: "maria.p@gmail.com"
    }
  },
  
  // Employment info (solo para conductores/staff)
  employment: {
    employee_id: "EMP-1234",
    role: "conductor", // "admin", "supervisor", "conductor", "mecanico", "auditor"
    status: "activo", // "activo", "inactivo", "suspendido", "vacaciones", "incapacitado"
    hire_date: "2023-01-15",
    termination_date: null,
    contract_type: "permanente", // "temporal", "freelance"
    branch_id: "BR-LIMA-NORTE",
    shift: "mañana", // "tarde", "noche", "rotativo"
    salary_currency: "PEN",
    salary_amount: 2500.00, // Privado, solo admin
  },
  
  // Permissions & roles
  permissions: {
    can_view_all_vehicles: false,
    can_edit_vehicles: false,
    can_assign_trips: false,
    can_view_reports: false,
    can_manage_users: false,
    can_manage_billing: false,
    restricted_to_branches: ["BR-LIMA-NORTE"], // null = todas
    restricted_to_vehicles: null, // ["VEH-001", "VEH-002"] o null
  },
  
  // Driver-specific data
  driver_data: {
    license_number: "A2b-12345678",
    license_category: "A-IIIc", // Categoría profesional pesado
    license_issue_date: "2022-01-10",
    license_expiry_date: "2027-01-10",
    license_country: "PE",
    license_file_url: "gs://bucket/licenses/USR-2025-0001.pdf",
    
    assigned_vehicle_id: "VEH-2025-0042",
    preferred_vehicle_types: ["trailer", "camion"],
    
    experience_months: 36, // Calculado automáticamente
    languages: ["es", "qu"], // español, quechua
    
    certifications: [
      {
        type: "conduccion_defensiva",
        name: "Conducción Defensiva Avanzada",
        issuer: "Instituto de Seguridad Vial",
        issue_date: "2024-03-10",
        expiry_date: "2026-03-10",
        certificate_url: "gs://bucket/certs/USR-2025-0001-cd.pdf",
        verified: true
      },
      {
        type: "carga_peligrosa",
        name: "Manejo de Cargas Peligrosas",
        issuer: "MTC Perú",
        issue_date: "2024-08-15",
        expiry_date: "2026-08-15",
        certificate_url: "gs://bucket/certs/USR-2025-0001-cp.pdf",
        verified: true
      }
    ],
    
    medical_certificate: {
      issue_date: "2025-05-15",
      expiry_date: "2026-05-15",
      file_url: "gs://bucket/medical/USR-2025-0001.pdf",
      verified: true,
      restrictions: [] // ["no_conduccion_nocturna", "uso_lentes_obligatorio"]
    },
    
    background_check: {
      check_date: "2024-11-01",
      status: "approved", // "approved", "pending", "rejected"
      file_url: "gs://bucket/background/USR-2025-0001.pdf"
    }
  },
  
  // Performance metrics
  metrics: {
    driver_score: {
      current: 87,
      previous: 85,
      history_30d: [85, 86, 88, 87, 89, 87], // últimos 30 días
      all_time_high: 96,
      all_time_low: 72,
      components: {
        speed: 90,
        braking: 92,
        acceleration: 88,
        fuel_efficiency: 82,
        route_compliance: 95
      }
    },
    
    ranking: {
      position: 12,
      total_drivers: 120,
      percentile: 92, // top 8%
      branch_position: 3,
      branch_total: 25
    },
    
    stats: {
      total_trips: 1247,
      total_km: 125430,
      total_hours: 3200,
      avg_trips_per_day: 3.2,
      avg_km_per_trip: 100.6,
      
      // Últimos 30 días
      trips_last_30d: 94,
      km_last_30d: 9450,
      hours_last_30d: 240,
      
      // Este mes
      trips_this_month: 32,
      km_this_month: 3200,
      hours_this_month: 85
    },
    
    incidents: {
      total_count: 3,
      last_incident_date: "2024-09-12",
      by_severity: {
        leve: 2,
        moderado: 1,
        grave: 0
      }
    },
    
    alerts: {
      total_count: 28,
      last_30d_count: 12,
      by_type: {
        velocidad: 8,
        frenado_brusco: 3,
        desvio_ruta: 1
      }
    },
    
    badges_earned: [
      {
        badge_id: "100_trips_no_incidents",
        name: "100 Viajes Sin Incidentes",
        earned_date: "2025-08-15",
        icon_url: "..."
      },
      {
        badge_id: "score_90_30d",
        name: "Score >90 por 30 días",
        earned_date: "2025-10-01",
        icon_url: "..."
      }
    ],
    
    rewards_points: 2450,
    rewards_redeemed: 500
  },
  
  // Notification preferences
  notifications: {
    push_enabled: true,
    email_enabled: true,
    sms_enabled: false,
    
    preferences: {
      trip_assignments: { push: true, email: true },
      maintenance_reminders: { push: true, email: true },
      performance_reports: { push: false, email: true },
      company_announcements: { push: true, email: true },
      badge_achievements: { push: true, email: false }
    },
    
    quiet_hours: {
      enabled: true,
      start: "22:00",
      end: "06:00",
      timezone: "America/Lima",
      allow_critical: true // alertas críticas sí se envían
    }
  },
  
  // App settings
  app_settings: {
    language: "es",
    theme: "light", // "light", "dark", "auto"
    map_style: "streets", // "streets", "satellite", "traffic"
    voice_navigation: true,
    battery_saver_mode: false,
    offline_maps_enabled: true
  },
  
  // Device info (último dispositivo usado)
  last_device: {
    device_id: "DEVICE-android-abc123",
    platform: "android",
    os_version: "13",
    app_version: "2.1.5",
    manufacturer: "Samsung",
    model: "Galaxy A54",
    last_seen: "2025-11-06T15:30:00Z",
    fcm_token: "fcm_token_xyz789" // Para notificaciones push
  },
  
  // Metadata
  status: "activo",
  created_at: "2023-01-15T10:00:00Z",
  updated_at: "2025-11-06T15:30:00Z",
  created_by: "admin_001",
  last_login: "2025-11-06T06:15:00Z",
  login_count: 543
}

// Índices compuestos necesarios:
// - company_id + role + status (para listar usuarios activos por rol)
// - company_id + driver_data.assigned_vehicle_id (para lookup rápido)
// - company_id + metrics.driver_score.current DESC (para rankings)
// - company_id + employment.branch_id + role (para filtros por sucursal)
6.2.3. Collection: vehicles
javascriptvehicles/{vehicle_id}
{
  vehicle_id: "VEH-2025-0042",
  company_id: "COMP-2025-001",
  
  // Basic info
  basic: {
    plate: "ABC-123",
    vin: "YV2AQ50D5LA123456",
    brand: "Volvo",
    model: "FH16",
    year: 2021,
    color: "Blanco",
    
    type: "trailer", // "camion", "camioneta", "furgon", "trailer"
    sub_type: "semi_remolque_refrigerado",
    
    engine_number: "D16K750-123456",
    chassis_number: "CHASSIS-123456"
  },
  
  // Specifications
  specs: {
    capacity_kg: 28000,
    capacity_m3: 80,
    axles: 5,
    
    fuel_type: "diesel",
    tank_capacity_liters: 400,
    fuel_consumption_baseline_km_per_liter: 5.2,
    
    engine_hp: 540,
    engine_displacement_liters: 16.1,
    transmission: "automatica_12_vel",
    
    dimensions: {
      length_m: 16.5,
      width_m: 2.55,
      height_m: 4.0,
      weight_empty_kg: 12000
    },
    
    features: [
      "ABS",
      "control_traccion",
      "refrigeracion",
      "frenos_aire",
      "suspension_neumatica",
      "control_crucero"
    ]
  },
  
  // Ownership & financial
  ownership: {
    status: "propio", // "alquilado", "leasing", "renting"
    acquisition_date: "2021-03-15",
    acquisition_price_usd: 85000,
    current_value_usd: 52000, // Depreciación
    depreciation_method: "linear",
    useful_life_years: 10,
    
    leasing_company: null,
    leasing_contract_number: null,
    leasing_monthly_payment: null,
    leasing_end_date: null,
    
    insurance: {
      company: "Rimac Seguros",
      policy_number: "POL-987654321",
      policy_type: "todo_riesgo",
      coverage_amount_usd: 85000,
      deductible_usd: 1500,
      premium_annual_usd: 3200,
      issue_date: "2025-03-15",
      expiry_date: "2026-03-15",
      file_url: "gs://bucket/insurance/VEH-2025-0042.pdf",
      verified: true
    }
  },
  
  // Operation
  operation: {
    assigned_driver_id: "USR-2025-0001",
    assigned_driver_name: "Juan Pérez",
    assignment_date: "2023-02-01",
    
    branch_id: "BR-LIMA-NORTE",
    branch_name: "Lima Norte",
    
    operational_status: "activo", // "activo", "mantenimiento", "inactivo", "vendido", "siniestrado"
    availability_status: "en_ruta", // "disponible", "en_ruta", "carga", "descarga", "mantenimiento"
    
    usage_restriction: null, // "solo_urbano", "solo_interprovincial", "carga_liviana"
    
    current_trip_id: "TRIP-20251106-0245",
    last_trip_end: "2025-11-06T12:30:00Z"
  },
  
  // Odometer & usage
  odometer: {
    current_km: 325430,
    last_update: "2025-11-06T15:30:00Z",
    
    at_acquisition_km: 0,
    total_km_with_company: 325430,
    
    avg_km_per_day: 190,
    avg_km_per_month: 5700,
    
    // Histórico mensual (últimos 12 meses)
    monthly_km: [
      { month: "2024-12", km: 5850 },
      { month: "2025-01", km: 5920 },
      { month: "2025-02", km: 5100 },
      { month: "2025-03", km: 5680 },
      { month: "2025-04", km: 5950 },
      { month: "2025-05", km: 6200 },
      { month: "2025-06", km: 5780 },
      { month: "2025-07", km: 5450 },
      { month: "2025-08", km: 5900 },
      { month: "2025-09", km: 6100 },
      { month: "2025-10", km: 5820 },
      { month: "2025-11", km: 3200 } // parcial
    ]
  },
  
  // Documents
  documents: [
    {
      type: "soat",
      number: "SOAT-2025-123456",
      issuer: "Rimac Seguros",
      issue_date: "2025-03-20",
      expiry_date: "2026-03-20",
      file_url: "gs://bucket/docs/VEH-2025-0042-soat.pdf",
      verified: true,
      verified_by: "admin_001",
      verified_date: "2025-03-21"
    },
    {
      type: "revision_tecnica",
      number: "RT-2025-987654",
      issuer: "CDA Lima Norte",
      issue_date: "2025-06-15",
      expiry_date: "2025-12-15",
      result: "aprobado",
      observations: "Vehículo en óptimas condiciones",
      file_url: "gs://bucket/docs/VEH-2025-0042-rt.pdf",
      verified: true
    },
    {
      type: "tarjeta_propiedad",
      number: "TP-ABC123",
      file_url: "gs://bucket/docs/VEH-2025-0042-tp.pdf",
      verified: true
    }
  ],
  
  // Maintenance
  maintenance: {
    plan: "preventivo_intensivo", // "basico", "preventivo", "preventivo_intensivo"
    service_interval_km: 10000,
    service_interval_days: 90,
    
    last_service: {
      date: "2025-10-15",
      km_at_service: 315000,
      type: "preventivo",
      cost_usd: 450,
      workshop: "Taller Central - Av. Industrial",
      ot_id: "OT-2025-1150"
    },
    
    next_service: {
      due_km: 325000,
      due_date: "2026-01-15",
      km_remaining: -430, // negativo = vencido!
      days_remaining: 70,
      status: "vencido" // "on_time", "due_soon", "vencido"
    },
    
    total_maintenance_cost_12m: 5400,
    avg_monthly_maintenance_cost: 450
  },
  
  // Health & performance
  health: {
    health_score: 87, // 0-100
    last_calculated: "2025-11-06T15:00:00Z",
    
    risk_level: "low", // "low", "medium", "high", "critical"
    
    components_status: {
      motor: { score: 92, status: "good", last_check: "2025-10-15" },
      transmision: { score: 88, status: "good", last_check: "2025-10-15" },
      frenos: { score: 78, status: "attention_required", last_check: "2025-10-15", notes: "Pastillas traseras al 40%" },
      suspension: { score: 85, status: "good", last_check: "2025-10-15" },
      neumaticos: { score: 90, status: "good", last_check: "2025-11-01" },
      sistema_electrico: { score: 94, status: "excellent", last_check: "2025-10-15" },
      refrigeracion: { score: 96, status: "excellent", last_check: "2025-10-15" }
    },
    
    predicted_issues: [
      {
        component: "frenos_traseros",
        probability: 0.67,
        predicted_failure_km: 328000,
        predicted_failure_date: "2025-11-25",
        confidence: 0.85,
        recommendation: "Inspeccionar frenos en próximos 7 días. Probable cambio de pastillas necesario."
      }
    ],
    
    alerts_last_30d: 12,
    incidents_last_12m: 1
  },
  
  // Performance metrics
  metrics: {
    fuel_efficiency: {
      current_km_per_liter: 4.8,
      baseline_km_per_liter: 5.2,
      deviation_percent: -7.7, // está consumiendo 7.7% más
      trend: "declining", // "improving", "stable", "declining"
      
      monthly_average: [
        { month: "2025-09", km_per_liter: 5.1 },
        { month: "2025-10", km_per_liter: 4.9 },
        { month: "2025-11", km_per_liter: 4.8 }
      ]
    },
    
    utilization: {
      days_active_last_30d: 28,
      utilization_rate_percent: 93.3,
      avg_hours_per_day: 8.5,
      idle_time_percent: 18
    },
    
    cost_per_km: {
      fuel: 0.45,
      maintenance: 0.026,
      insurance: 0.012,
      depreciation: 0.08,
      total: 0.568
    }
  },
  
  // Telemetry device
  telemetry: {
    device_type: "smartphone", // "smartphone", "obd2_dongle", "hardwired_gps"
    device_id: "PHONE-android-abc123",
    device_imei: "123456789012345",
    
    last_seen: "2025-11-06T15:30:00Z",
    connection_status: "online", // "online", "offline"
    connection_quality: "excellent", // "excellent", "good", "fair", "poor"
    
    battery_level: 78,
    is_charging: false,
    signal_strength_dbm: -75,
    network_type: "4G"
  },
  
  // Current location (cache for quick access)
  current_location: {
    lat: -12.0464,
    lng: -77.0428,
    address: "Av. Javier Prado Este Km 4.5, San Isidro",
    speed_kmh: 65,
    bearing_degrees: 235,
    accuracy_m: 8.5,
    timestamp: "2025-11-06T15:30:15Z"
  },
  
  // Photos
  photos: [
    {
      type: "exterior_front",
      url: "gs://bucket/vehicles/VEH-2025-0042/front.jpg",
      uploaded_date: "2021-03-15"
    },
    {
      type: "exterior_back",
      url: "gs://bucket/vehicles/VEH-2025-0042/back.jpg",
      uploaded_date: "2021-03-15"
    },
    {
      type: "interior",
      url: "gs://bucket/vehicles/VEH-2025-0042/interior.jpg",
      uploaded_date: "2021-03-15"
    }
  ],
  
  // Metadata
  status: "activo",
  created_at: "2021-03-15T09:00:00Z",
  updated_at: "2025-11-06T15:30:00Z",
  created_by: "admin_001"
}

// Índices compuestos necesarios:
// - company_id + operation.operational_status + operation.availability_status
// - company_id + operation.assigned_driver_id
// - company_id + operation.branch_id + operation.operational_status
// - company_id + health.health_score ASC (para identificar vehículos problemáticos)
// - company_id + maintenance.next_service.status (para alertas de mantenimiento)
// - documents.type + documents.expiry_date ASC (para alertas de documentos)
¿Continúo con las colecciones restantes (trips, alerts, geofences, maintenance_records, etc.)? O prefieres que pase directamente a la Sección 7: Fases de Desarrollo? 🚀RetryHcontinua¡Perfecto! Continúo con las colecciones restantes:

6.2.4. Collection: trips
javascripttrips/{trip_id}
{
  trip_id: "TRIP-20251106-0245",
  company_id: "COMP-2025-001",
  
  // Assignment
  driver_id: "USR-2025-0001",
  driver_name: "Juan Pérez",
  vehicle_id: "VEH-2025-0042",
  vehicle_plate: "ABC-123",
  
  // Status & lifecycle
  status: "en_curso", // "planeado", "asignado", "iniciado", "en_curso", "pausado", "completado", "cancelado"
  
  lifecycle: {
    created_at: "2025-11-05T20:30:00Z",
    created_by: "admin_002",
    assigned_at: "2025-11-05T20:30:00Z",
    accepted_at: "2025-11-05T21:15:00Z",
    started_at: "2025-11-06T06:12:00Z",
    paused_at: null,
    resumed_at: null,
    completed_at: null,
    cancelled_at: null,
    cancel_reason: null
  },
  
  // Planning
  planning: {
    planned_start: "2025-11-06T06:00:00Z",
    planned_end: "2025-11-06T18:00:00Z",
    planned_duration_minutes: 720,
    
    route_id: "ROUTE-LIM-CUZ-001",
    route_name: "Lima Centro - Cusco",
    route_distance_km: 350,
    
    cargo: {
      description: "40 pallets de alimentos refrigerados",
      weight_kg: 18000,
      volume_m3: 65,
      value_usd: 25000,
      temperature_required_celsius: 4,
      fragile: false,
      hazardous: false,
      requires_escort: false
    },
    
    priority: "alta", // "baja", "normal", "alta", "urgente"
    
    customer: {
      customer_id: "CUST-WONG-001",
      name: "Supermercados Wong",
      contact_name: "Roberto Mendoza",
      contact_phone: "+51987654325",
      contact_email: "logistica@wong.com.pe"
    },
    
    order_reference: {
      order_number: "ORD-2025-98765",
      po_number: "PO-WONG-2025-1234",
      external_reference: "REF-ABC-123"
    }
  },
  
  // Waypoints (origen, destino, paradas intermedias)
  waypoints: [
    {
      waypoint_id: "WP-001",
      sequence: 1,
      type: "pickup", // "pickup", "delivery", "rest_stop", "fuel", "inspection"
      
      name: "Almacén Central",
      address: "Av. Argentina 2850, Callao",
      location: {
        lat: -12.0431,
        lng: -77.0282
      },
      geofence_id: "GEO-ALMACEN-CENTRAL",
      
      planned_arrival: "2025-11-06T06:00:00Z",
      planned_departure: "2025-11-06T06:30:00Z",
      
      actual_arrival: "2025-11-06T06:12:00Z",
      actual_departure: "2025-11-06T06:45:00Z",
      
      dwell_time_minutes: 33,
      planned_dwell_minutes: 30,
      
      status: "completado", // "pendiente", "en_curso", "completado", "omitido"
      
      tasks: [
        {
          task: "Carga de 40 pallets",
          status: "completado",
          completed_by: "USR-2025-0001",
          completed_at: "2025-11-06T06:40:00Z",
          notes: "Carga completa, sin novedades"
        }
      ],
      
      proof_of_completion: {
        signature_url: null,
        photo_urls: [
          "gs://bucket/trips/TRIP-20251106-0245/wp001-photo1.jpg"
        ],
        notes: "Carga sellada, temperatura verificada: 4°C"
      }
    },
    {
      waypoint_id: "WP-002",
      sequence: 2,
      type: "rest_stop",
      
      name: "Paradero Km 150",
      address: "Carretera Central Km 150",
      location: {
        lat: -11.8234,
        lng: -76.8912
      },
      
      planned_arrival: "2025-11-06T10:30:00Z",
      planned_departure: "2025-11-06T11:00:00Z",
      
      actual_arrival: null,
      actual_departure: null,
      
      status: "pendiente"
    },
    {
      waypoint_id: "WP-003",
      sequence: 3,
      type: "delivery",
      
      name: "Wong San Isidro",
      address: "Av. Conquistadores 1228, San Isidro",
      location: {
        lat: -12.0982,
        lng: -77.0364
      },
      geofence_id: "GEO-WONG-SANISIDRO-001",
      
      planned_arrival: "2025-11-06T18:00:00Z",
      planned_departure: "2025-11-06T19:00:00Z",
      
      actual_arrival: null,
      actual_departure: null,
      
      status: "pendiente",
      
      delivery_instructions: "Descargar en rampa 3. Tocar timbre 3 veces. Verificar temperatura antes de descargar.",
      
      contact: {
        name: "Carlos Ruiz",
        phone: "+51987654326",
        role: "Supervisor de Recepción"
      }
    }
  ],
  
  // Execution (datos reales)
  execution: {
    actual_start: "2025-11-06T06:12:00Z",
    actual_end: null,
    
    current_waypoint_sequence: 2,
    next_waypoint_sequence: 3,
    
    current_location: {
      lat: -12.0464,
      lng: -77.0428,
      address: "Av. Javier Prado Este Km 4.5",
      timestamp: "2025-11-06T15:30:15Z",
      speed_kmh: 65,
      bearing_degrees: 235
    },
    
    progress: {
      waypoints_completed: 1,
      waypoints_total: 3,
      percent_complete: 65,
      
      distance_traveled_km: 4.3,
      distance_remaining_km: 8.2,
      
      eta_current_waypoint: "2025-11-06T15:48:00Z",
      eta_final_destination: "2025-11-06T18:15:00Z",
      
      on_time_status: "delayed", // "early", "on_time", "delayed", "significantly_delayed"
      delay_minutes: 15
    }
  },
  
  // Route tracking (puntos GPS - subcolección separada por volumen)
  // Ver subcollection: trips/{trip_id}/route_points/{point_id}
  route_summary: {
    points_count: 1247,
    first_point_timestamp: "2025-11-06T06:12:00Z",
    last_point_timestamp: "2025-11-06T15:30:15Z",
    
    simplified_polyline: "encoded_polyline_string_here...", // Google Polyline Algorithm
    
    // Puntos clave para replay rápido (cada 1 km aprox)
    key_points: [
      { lat: -12.0431, lng: -77.0282, timestamp: "2025-11-06T06:12:00Z", km: 0 },
      { lat: -12.0495, lng: -77.0335, timestamp: "2025-11-06T06:25:00Z", km: 1 },
      { lat: -12.0564, lng: -77.0389, timestamp: "2025-11-06T06:38:00Z", km: 2 },
      // ... hasta el punto actual
    ]
  },
  
  // Statistics
  statistics: {
    distance_km: 4.3, // hasta ahora
    distance_planned_km: 12.7,
    distance_deviation_km: -8.4,
    
    duration_minutes: 318, // 5h 18min hasta ahora
    duration_planned_minutes: 720,
    
    moving_time_minutes: 248,
    stopped_time_minutes: 70,
    
    average_speed_kmh: 40.6,
    max_speed_kmh: 95,
    
    fuel_consumed_liters: 17.5, // estimado
    fuel_efficiency_km_per_liter: 4.9,
    estimated_fuel_cost_usd: 18.90,
    
    stops_count: 3,
    stops_duration_minutes: [33, 12, 25],
    
    idle_time_minutes: 15,
    idle_fuel_wasted_liters: 0.8
  },
  
  // Events & alerts
  events: [
    {
      event_id: "EVT-001",
      type: "harsh_brake",
      timestamp: "2025-11-06T08:23:15Z",
      location: { lat: -12.1234, lng: -77.0567 },
      severity: "medium", // "low", "medium", "high", "critical"
      
      details: {
        deceleration_g: -0.45,
        speed_before_kmh: 85,
        speed_after_kmh: 42,
        duration_seconds: 2.3
      },
      
      context: {
        road_type: "highway",
        weather: "clear",
        traffic: "moderate",
        time_of_day: "morning"
      },
      
      driver_score_impact: -2,
      
      reviewed: true,
      reviewed_by: "supervisor_003",
      reviewed_at: "2025-11-06T09:15:00Z",
      review_notes: "Frenado justificado, vehículo invadió carril"
    },
    {
      event_id: "EVT-002",
      type: "speeding",
      timestamp: "2025-11-06T10:15:30Z",
      location: { lat: -12.2345, lng: -77.1234 },
      severity: "low",
      
      details: {
        speed_kmh: 108,
        limit_kmh: 100,
        excess_kmh: 8,
        duration_seconds: 45
      },
      
      driver_score_impact: -1,
      
      reviewed: false
    },
    {
      event_id: "EVT-003",
      type: "geofence_entry",
      timestamp: "2025-11-06T06:12:00Z",
      location: { lat: -12.0431, lng: -77.0282 },
      severity: "info",
      
      details: {
        geofence_id: "GEO-ALMACEN-CENTRAL",
        geofence_name: "Almacén Central",
        action: "entry"
      },
      
      driver_score_impact: 0
    }
  ],
  
  // Alerts generated (referencias a collection alerts)
  alerts_generated: [
    "ALERT-20251106-001",
    "ALERT-20251106-023"
  ],
  
  // Performance scores
  scores: {
    overall: 89,
    
    speed_compliance: 90,
    smooth_braking: 92,
    smooth_acceleration: 88,
    fuel_efficiency: 82,
    route_compliance: 95,
    timeliness: 85,
    
    driver_score_change: +2 // impacto en el score del conductor
  },
  
  // Costs (estimados)
  costs: {
    fuel_usd: 18.90,
    tolls_usd: 12.50,
    parking_usd: 0,
    other_usd: 0,
    total_usd: 31.40,
    
    cost_per_km_usd: 0.73,
    
    revenue_usd: 150.00, // lo que cobra la empresa al cliente
    profit_usd: 118.60,
    margin_percent: 79.1
  },
  
  // Temperature monitoring (para carga refrigerada)
  temperature_log: [
    { timestamp: "2025-11-06T06:40:00Z", celsius: 4.2, location: "pickup" },
    { timestamp: "2025-11-06T09:00:00Z", celsius: 4.5, location: "en_ruta" },
    { timestamp: "2025-11-06T12:00:00Z", celsius: 4.8, location: "en_ruta" },
    { timestamp: "2025-11-06T15:00:00Z", celsius: 4.6, location: "en_ruta" }
  ],
  temperature_status: "ok", // "ok", "warning", "critical"
  temperature_alerts_count: 0,
  
  // Notes & communications
  notes: [
    {
      note_id: "NOTE-001",
      timestamp: "2025-11-06T08:30:00Z",
      author_id: "USR-2025-0001",
      author_name: "Juan Pérez",
      type: "driver_note",
      text: "Tráfico intenso en Av. Javier Prado. Tomé vía alterna por Av. Primavera.",
      location: { lat: -12.0892, lng: -77.0234 }
    },
    {
      note_id: "NOTE-002",
      timestamp: "2025-11-06T09:00:00Z",
      author_id: "supervisor_003",
      author_name: "María García",
      type: "supervisor_note",
      text: "Cliente confirmó recepción. Pueden proceder sin cambios."
    }
  ],
  
  // Proof of delivery (se completa al finalizar)
  pod: {
    signature_url: null,
    signature_name: null,
    signature_timestamp: null,
    
    photo_urls: [],
    
    delivery_notes: null,
    
    customer_rating: null, // 1-5 estrellas
    customer_feedback: null
  },
  
  // Weather conditions during trip
  weather_summary: {
    conditions: ["clear", "partly_cloudy"],
    rain_detected: false,
    fog_detected: false,
    temperature_avg_celsius: 22,
    temperature_min_celsius: 18,
    temperature_max_celsius: 26
  },
  
  // Metadata
  created_at: "2025-11-05T20:30:00Z",
  updated_at: "2025-11-06T15:30:15Z",
  last_location_update: "2025-11-06T15:30:15Z"
}

// Índices compuestos necesarios:
// - company_id + status + planning.planned_start DESC
// - company_id + driver_id + status
// - company_id + vehicle_id + status
// - company_id + execution.progress.on_time_status
// - company_id + planning.customer.customer_id
// - lifecycle.started_at DESC (para historial)
// - execution.progress.eta_final_destination ASC (para arrivals próximos)
6.2.5. Subcollection: trips/{trip_id}/route_points
javascript// Subcollection para no saturar el documento principal
trips/{trip_id}/route_points/{point_id}
{
  point_id: "PT-0001247", // auto-increment
  sequence: 1247,
  
  timestamp: "2025-11-06T15:30:15.543Z",
  
  location: {
    lat: -12.0464,
    lng: -77.0428,
    accuracy_m: 8.5,
    altitude_m: 154,
    bearing_degrees: 235,
    speed_mps: 18.06, // 65 km/h
    speed_kmh: 65.0
  },
  
  // Sensor data from smartphone
  sensors: {
    acceleration: {
      x: 0.12,
      y: -0.08,
      z: 9.81
    },
    gyroscope: {
      x: 0.01,
      y: -0.02,
      z: 0.05
    }
  },
  
  // Device status
  device: {
    battery_level: 78,
    is_charging: false,
    network_type: "4G",
    signal_strength_dbm: -75
  },
  
  // Movement detection
  movement: {
    is_moving: true,
    is_stopped: false,
    stopped_duration_seconds: 0
  },
  
  // Events detected at this point
  events: [], // ["harsh_brake"] si aplica
  
  // Simplified (para reducir tamaño)
  // Este punto será eliminado en simplificación Douglas-Peucker
  keep_in_simplification: false
}

// Particionamiento por fecha para queries eficientes
// TTL: Auto-delete después de 90 días (Firestore TTL policy)
6.2.6. Collection: alerts
javascriptalerts/{alert_id}
{
  alert_id: "ALERT-20251106-0245",
  company_id: "COMP-2025-001",
  
  // What happened
  type: "speeding", 
  /* Tipos posibles:
     - speeding (exceso velocidad)
     - harsh_brake (frenado brusco)
     - harsh_acceleration (aceleración brusca)
     - harsh_turn (giro brusco)
     - geofence_entry (entrada geocerca)
     - geofence_exit (salida geocerca)
     - route_deviation (desvío de ruta)
     - gps_loss (pérdida señal GPS)
     - low_battery (batería baja dispositivo)
     - excessive_idle (ralentí excesivo)
     - driving_time_exceeded (tiempo conducción excedido)
     - maintenance_due (mantenimiento pendiente)
     - document_expiring (documento por vencer)
     - temperature_alert (temperatura fuera rango)
     - panic_button (botón pánico activado)
     - collision_detected (colisión detectada)
  */
  
  severity: "medium", // "info", "low", "medium", "high", "critical"
  
  category: "seguridad", // "seguridad", "operacional", "mantenimiento", "compliance"
  
  // Who & where
  driver_id: "USR-2025-0001",
  driver_name: "Juan Pérez",
  vehicle_id: "VEH-2025-0042",
  vehicle_plate: "ABC-123",
  trip_id: "TRIP-20251106-0245",
  
  location: {
    lat: -12.2345,
    lng: -77.1234,
    address: "Carretera Central Km 28",
    accuracy_m: 8.5
  },
  
  timestamp: "2025-11-06T10:15:30Z",
  
  // Details específicos según tipo
  details: {
    // Para speeding:
    speed_kmh: 108,
    limit_kmh: 100,
    excess_kmh: 8,
    excess_percent: 8,
    duration_seconds: 45,
    distance_km: 0.33,
    
    // Contexto
    road_type: "highway",
    weather: "clear",
    traffic: "light",
    time_of_day: "morning",
    
    // Si es zona escolar, hospital, etc
    sensitive_zone: false
  },
  
  // Impact on driver score
  driver_score_impact: -1,
  
  // Notification status
  notifications: {
    driver: {
      sent: true,
      sent_at: "2025-11-06T10:15:31Z",
      method: "push",
      read: true,
      read_at: "2025-11-06T10:15:45Z"
    },
    supervisor: {
      sent: true,
      sent_at: "2025-11-06T10:15:32Z",
      method: "push",
      read: false,
      read_at: null
    },
    admin: {
      sent: false // solo severidad high/critical
    }
  },
  
  // Review & resolution
  status: "open", // "open", "acknowledged", "resolved", "dismissed"
  
  acknowledged_by: null,
  acknowledged_at: null,
  
  resolved_by: null,
  resolved_at: null,
  resolution_notes: null,
  
  dismissed_by: null,
  dismissed_at: null,
  dismiss_reason: null, // "false_positive", "justified", "other"
  
  // Actions taken
  actions_taken: [],
  /* Ejemplos:
     - "driver_contacted"
     - "warning_issued"
     - "coaching_scheduled"
     - "vehicle_inspection_ordered"
  */
  
  // Related alerts (si hay patrón)
  related_alerts: [], // ["ALERT-20251106-0123", "ALERT-20251106-0189"]
  
  is_repeat_offense: false,
  repeat_count_30d: 0,
  
  // Escalation
  escalated: false,
  escalated_to: null,
  escalated_at: null,
  escalation_reason: null,
  
  // Metadata
  created_at: "2025-11-06T10:15:30Z",
  updated_at: "2025-11-06T10:15:30Z",
  
  // Auto-archive después de 90 días
  ttl: "2026-02-04T10:15:30Z"
}

// Índices compuestos necesarios:
// - company_id + status + severity DESC + timestamp DESC
// - company_id + driver_id + timestamp DESC
// - company_id + vehicle_id + timestamp DESC
// - company_id + trip_id + timestamp DESC
// - company_id + type + timestamp DESC
// - timestamp DESC (para cleanup de TTL)
6.2.7. Collection: geofences
javascriptgeofences/{geofence_id}
{
  geofence_id: "GEO-WONG-SANISIDRO-001",
  company_id: "COMP-2025-001",
  
  // Basic info
  name: "Wong San Isidro - Av. Conquistadores",
  description: "Punto de entrega para Supermercados Wong - Sede San Isidro",
  
  type: "cliente", 
  /* Tipos:
     - zona_operativa (área general de operación)
     - terminal (base/almacén)
     - cliente (punto entrega/recogida)
     - zona_descanso (paradero autorizado)
     - zona_restringida (prohibido entrar)
     - zona_trafico (congestión frecuente)
     - zona_riesgo (robos/asaltos)
     - zona_peaje
     - zona_pesaje
     - zona_restriccion_vehicular (pico y placa)
  */
  
  // Geometry
  geometry: {
    type: "circle", // "circle", "polygon"
    
    // Para circle:
    center: {
      lat: -12.0982,
      lng: -77.0364
    },
    radius_m: 100,
    
    // Para polygon:
    vertices: null,
    /* Ejemplo para polygon:
    vertices: [
      { lat: -12.0982, lng: -77.0364 },
      { lat: -12.0992, lng: -77.0374 },
      { lat: -12.0972, lng: -77.0354 },
      { lat: -12.0982, lng: -77.0364 } // cierra el polígono
    ]
    */
    
    area_m2: 31415.93 // π × 100²
  },
  
  // Address
  address: {
    street: "Av. Conquistadores 1228",
    district: "San Isidro",
    city: "Lima",
    state: "Lima",
    country: "PE",
    postal_code: "15073"
  },
  
  // Schedule (cuándo está activa)
  schedule: {
    enabled: true,
    
    active_days: [
      "monday",
      "tuesday",
      "wednesday",
      "thursday",
      "friday"
    ], // null = todos los días
    
    active_hours: {
      start: "06:00",
      end: "22:00",
      timezone: "America/Lima"
    }, // null = 24/7
    
    exceptions: [
      {
        date: "2025-12-25",
        reason: "Navidad - Cerrado",
        active: false
      }
    ]
  },
  
  // Rules & actions
  rules: {
    on_entry: {
      enabled: true,
      actions: [
        "log_event",
        "notify_supervisor",
        "start_dwell_timer"
      ],
      notification_message: "{{driver_name}} ha llegado a {{geofence_name}}",
      notification_recipients: ["supervisor_003"],
      
      custom_message_to_driver: "Has llegado a Wong San Isidro. Registra tu descarga.",
      play_sound: true,
      haptic_feedback: true
    },
    
    on_exit: {
      enabled: true,
      actions: [
        "log_event",
        "stop_dwell_timer",
        "require_pod" // proof of delivery
      ],
      notification_message: "{{driver_name}} salió de {{geofence_name}}",
      
      custom_message_to_driver: "Saliendo de Wong. ¿Descarga completada?",
      require_confirmation: true
    },
    
    max_dwell_time_minutes: 120,
    alert_if_exceeds_dwell: true,
    alert_threshold_minutes: 120,
    
    min_dwell_time_minutes: 15, // alerta si sale antes de tiempo
    alert_if_too_short: false,
    
    unauthorized_entry_alert: false, // si vehículo entra sin tener viaje asignado aquí
    
    speed_limit_inside_kmh: 20,
    alert_on_speeding_inside: true
  },
  
  // Associations
  associations: {
    customer_id: "CUST-WONG-001",
    customer_name: "Supermercados Wong",
    
    contact: {
      name: "Carlos Ruiz",
      title: "Supervisor de Recepción",
      phone: "+51987654326",
      email: "carlos.ruiz@wong.com.pe"
    },
    
    allowed_vehicle_types: null, // ["trailer", "camion"] o null = todos
    allowed_vehicles: null, // ["VEH-001", "VEH-002"] o null = todos
    allowed_drivers: null,
    
    restricted_vehicles: [], // vehículos específicos NO permitidos
    restricted_drivers: []
  },
  
  // Special instructions
  instructions: {
    entry_instructions: "Ingresar por puerta lateral. Tocar timbre 3 veces.",
    exit_instructions: "Verificar que no queden pertenencias en el área de descarga.",
    parking_instructions: "Estacionar en zona de maniobras, rampa 3.",
    safety_notes: "Usar chaleco reflectivo. Área vigilada 24/7.",
    contact_on_arrival: true
  },
  
  // Statistics
  stats: {
    total_entries: 247,
    total_exits: 245, // 2 vehículos actualmente dentro
    
    avg_dwell_time_minutes: 45,
    max_dwell_time_minutes: 180,
    min_dwell_time_minutes: 20,
    
    last_entry: {
      timestamp: "2025-11-06T14:30:00Z",
      vehicle_id: "VEH-2025-0042",
      driver_id: "USR-2025-0001"
    },
    
    vehicles_inside_now: [
      {
        vehicle_id: "VEH-2025-0042",
        entry_time: "2025-11-06T14:30:00Z",
        dwell_minutes: 60
      }
    ],
    
    violations_count: 3, // entradas no autorizadas, exceso de tiempo, etc
    
    // Estadísticas mensuales
    monthly_traffic: [
      { month: "2025-09", entries: 82 },
      { month: "2025-10", entries: 89 },
      { month: "2025-11", entries: 36 } // parcial
    ]
  },
  
  // Visual customization (en mapa)
  display: {
    color: "#4CAF50", // verde para clientes
    opacity: 0.2,
    stroke_color: "#2E7D32",
    stroke_width: 2,
    
    icon_url: "https://cdn.smartfleet.com/icons/customer.png",
    
    show_label: true,
    label_position: "center", // "center", "top", "bottom"
    
    z_index: 10 // para capas superpuestas
  },
  
  // Metadata
  status: "activa", // "activa", "inactiva", "archivada"
  
  created_at: "2025-01-20T10:00:00Z",
  updated_at: "2025-10-15T14:30:00Z",
  created_by: "admin_002",
  
  // Tags for easy filtering
  tags: ["cliente", "lima", "wong", "refrigerado"],
  
  // Notes
  notes: "Cliente VIP. Prioridad alta. Siempre confirmar temperatura de carga antes de descargar."
}

// Índices compuestos necesarios:
// - company_id + type + status
// - company_id + associations.customer_id
// - company_id + tags (array-contains)
// - geometry.center (geohash index para queries espaciales)
6.2.8. Collection: maintenance_records
javascriptmaintenance_records/{record_id}
{
  record_id: "MAINT-2025-1234",
  company_id: "COMP-2025-001",
  
  // OT (Orden de Trabajo) reference
  ot_id: "OT-2025-1234",
  ot_number: "OT-001234",
  
  // Vehicle
  vehicle_id: "VEH-2025-0042",
  vehicle_plate: "ABC-123",
  vehicle_brand: "Volvo",
  vehicle_model: "FH16",
  
  // Type & category
  type: "preventivo", // "preventRetryHContinueivo", "correctivo", "predictivo", "emergencia", "inspeccion"
category: "servicio_rutinario",
/* Categorías:
- servicio_rutinario (cambio aceite, filtros)
- sistema_frenos
- sistema_suspension
- sistema_electrico
- sistema_refrigeracion
- neumaticos
- motor
- transmision
- carroceria
- equipamiento_especial (refrigeración, GPS, etc)
*/
priority: "normal", // "bajo", "normal", "alto", "critico", "emergencia"
// Scheduling
scheduled: {
is_scheduled: true,
scheduled_date: "2025-11-10T08:00:00Z",
scheduled_by: "admin_002",
scheduled_at: "2025-11-03T10:00:00Z",
trigger_type: "kilometraje", // "kilometraje", "tiempo", "evento", "prediccion_ml"
trigger_value: "10,000 km interval reached",

urgency_reason: null // si es emergencia: "motor_overheating", "brake_failure", etc
},
// Execution
execution: {
status: "completado", // "planeado", "en_espera_repuestos", "en_progreso", "completado", "cancelado"
started_at: "2025-11-10T08:15:00Z",
completed_at: "2025-11-10T10:50:00Z",

duration_planned_hours: 4.0,
duration_actual_hours: 2.6,

vehicle_km_at_service: 325000,

downtime_hours: 2.6, // tiempo que estuvo fuera de servicio
downtime_cost_usd: 156.00 // costo de oportunidad
},
// Workshop & technician
workshop: {
type: "interno", // "interno", "externo", "concesionario"
name: "Taller Central - Av. Industrial",
address: "Av. Industrial 2850, Lima",
contact_phone: "+51987654330",
technician_id: "TECH-005",
technician_name: "Roberto Silva",
technician_certification: "Certificado Volvo Trucks",

supervisor_id: "TECH-001",
supervisor_name: "Luis Ramírez"
},
// Tasks performed
tasks: [
{
task_id: "TASK-001",
description: "Cambio de aceite y filtro de motor",
  category: "motor",
  
  status: "completado",
  started_at: "2025-11-10T08:15:00Z",
  completed_at: "2025-11-10T09:00:00Z",
  duration_hours: 0.75,
  
  parts_used: [
    {
      part_id: "PART-OIL-15W40",
      part_name: "Aceite 15W40",
      part_number: "OIL-15W40-20L",
      quantity: 20,
      unit: "liters",
      unit_cost_usd: 4.50,
      total_cost_usd: 90.00,
      supplier: "Lubricantes del Perú"
    },
    {
      part_id: "PART-FILTER-OIL",
      part_name: "Filtro de aceite",
      part_number: "OF-123456",
      quantity: 1,
      unit: "piece",
      unit_cost_usd: 25.00,
      total_cost_usd: 25.00,
      supplier: "Repuestos Volvo"
    }
  ],
  
  labor_cost_usd: 24.00, // 0.75h × $32/h
  
  findings: "Aceite usado en condiciones normales. Sin contaminación detectada.",
  
  recommendations: null,
  
  next_service_km: 335000,
  next_service_date: "2026-02-10"
},
{
  task_id: "TASK-002",
  description: "Rotación de neumáticos",
  
  category: "neumaticos",
  
  status: "completado",
  started_at: "2025-11-10T09:05:00Z",
  completed_at: "2025-11-10T09:45:00Z",
  duration_hours: 0.67,
  
  parts_used: [],
  
  labor_cost_usd: 21.44,
  
  findings: "Neumáticos con desgaste uniforme. Presión ajustada a especificaciones.",
  
  recommendations: null
},
{
  task_id: "TASK-003",
  description: "Inspección de sistema de frenos",
  
  category: "sistema_frenos",
  
  status: "completado",
  started_at: "2025-11-10T09:50:00Z",
  completed_at: "2025-11-10T10:30:00Z",
  duration_hours: 0.67,
  
  parts_used: [],
  
  labor_cost_usd: 21.44,
  
  findings: "Pastillas de freno traseras al 40% de vida útil. Discos en buen estado.",
  
  recommendations: "Programar cambio de pastillas traseras en próximo servicio o antes de 5,000 km.",
  
  severity: "medium", // si hay hallazgos importantes
  requires_follow_up: true,
  follow_up_km: 330000
},
{
  task_id: "TASK-004",
  description: "Revisión de sistema de luces",
  
  category: "sistema_electrico",
  
  status: "completado",
  started_at: "2025-11-10T10:35:00Z",
  completed_at: "2025-11-10T10:50:00Z",
  duration_hours: 0.25,
  
  parts_used: [
    {
      part_id: "PART-BULB-LED",
      part_name: "Foco LED trasero",
      part_number: "LED-TAIL-24V",
      quantity: 1,
      unit: "piece",
      unit_cost_usd: 15.00,
      total_cost_usd: 15.00,
      supplier: "Iluminación Truck"
    }
  ],
  
  labor_cost_usd: 8.00,
  
  findings: "Luz trasera derecha quemada. Reemplazada por foco LED nuevo.",
  
  recommendations: null
}
],
// Costs summary
costs: {
parts_total_usd: 145.00,
labor_total_usd: 74.88,
external_services_usd: 0, // si se subcontrató algo

subtotal_usd: 219.88,
tax_percent: 18, // IGV en Perú
tax_usd: 39.58,

total_usd: 259.46,

// Breakdown por categoría
by_category: {
  motor: 115.00,
  neumaticos: 21.44,
  sistema_frenos: 21.44,
  sistema_electrico: 23.00
}
},
// Odometer & intervals
odometer: {
at_service: 325000,
since_last_service: 10000,
next_service_due: 335000,
km_to_next_service: 10000
},
// Findings & diagnostics
overall_findings: {
critical_issues: 0,
warnings: 1, // frenos al 40%
summary: "Servicio preventivo completado exitosamente. Se detectó desgaste en pastillas de freno traseras que requiere atención en próximo servicio.",

recommendations: [
  "Programar cambio de pastillas de freno traseras en próximo servicio",
  "Continuar monitoreando presión de neumáticos semanalmente",
  "Revisar nivel de refrigerante cada 1,000 km"
],

vehicle_condition_after_service: "excelente" // "excelente", "bueno", "regular", "malo"
},
// Quality control
quality_check: {
performed: true,
performed_by: "supervisor_001",
performed_at: "2025-11-10T11:00:00Z",
checklist: [
  { item: "Nivel de fluidos verificado", ok: true },
  { item: "Sin fugas detectadas", ok: true },
  { item: "Luces funcionando correctamente", ok: true },
  { item: "Frenos probados", ok: true },
  { item: "Test drive realizado", ok: true }
],

all_passed: true,

notes: "Vehículo listo para operación. Sin observaciones adicionales."
},
// Documentation
documentation: {
invoice_number: "FACT-2025-5678",
invoice_url: "gs://bucket/invoices/MAINT-2025-1234.pdf",
work_order_url: "gs://bucket/work_orders/OT-2025-1234.pdf",

photos: [
  {
    type: "before",
    description: "Estado de filtro de aceite antes del cambio",
    url: "gs://bucket/maintenance/MAINT-2025-1234/photo1.jpg",
    timestamp: "2025-11-10T08:20:00Z"
  },
  {
    type: "parts",
    description: "Repuestos utilizados",
    url: "gs://bucket/maintenance/MAINT-2025-1234/photo2.jpg",
    timestamp: "2025-11-10T09:00:00Z"
  },
  {
    type: "after",
    description: "Motor después del servicio",
    url: "gs://bucket/maintenance/MAINT-2025-1234/photo3.jpg",
    timestamp: "2025-11-10T10:50:00Z"
  }
],

technician_signature_url: "gs://bucket/signatures/TECH-005-MAINT-2025-1234.png",
supervisor_signature_url: "gs://bucket/signatures/TECH-001-MAINT-2025-1234.png"
},
// Parts inventory impact
inventory_transactions: [
{
part_id: "PART-OIL-15W40",
quantity: -20,
transaction_type: "used",
timestamp: "2025-11-10T09:00:00Z"
},
{
part_id: "PART-FILTER-OIL",
quantity: -1,
transaction_type: "used",
timestamp: "2025-11-10T09:00:00Z"
},
{
part_id: "PART-BULB-LED",
quantity: -1,
transaction_type: "used",
timestamp: "2025-11-10T10:50:00Z"
}
],
// Impact on vehicle health score
vehicle_health_impact: {
score_before: 85,
score_after: 92,
improvement: +7,
components_improved: ["motor", "sistema_electrico"]
},
// Warranty info (si aplica)
warranty: {
under_warranty: false,
warranty_claim_number: null,
warranty_coverage_percent: 0,
warranty_amount_usd: 0
},
// Approval workflow
approval: {
required: true, // para costos >$200
requested_by: "supervisor_001",
requested_at: "2025-11-03T10:00:00Z",

approved_by: "admin_002",
approved_at: "2025-11-03T14:30:00Z",

rejection_reason: null
},
// Follow-up
follow_up: {
required: true,
tasks: [
  {
    description: "Cambiar pastillas de freno traseras",
    due_km: 330000,
    due_date: "2025-12-15",
    priority: "high",
    estimated_cost_usd: 280
  }
]
},
// Metadata
created_at: "2025-11-03T10:00:00Z",
updated_at: "2025-11-10T11:00:00Z",
created_by: "admin_002",
tags: ["preventivo", "rutinario", "aceite", "filtros"],
notes: "Servicio de rutina sin complicaciones. Vehículo regresó a operación el mismo día."
}
// Índices compuestos necesarios:
// - company_id + vehicle_id + execution.completed_at DESC
// - company_id + type + execution.status
// - company_id + execution.completed_at DESC (para historial)
// - vehicle_id + odometer.at_service DESC
// - company_id + follow_up.required + follow_up.tasks.due_date ASC

#### 6.2.9. Collection: `reports`
```javascript
reports/{report_id}
{
  report_id: "RPT-2025-W45",
  company_id: "COMP-2025-001",
  
  // Type & metadata
  type: "semanal", // "diario", "semanal", "mensual", "trimestral", "anual", "custom"
  
  category: "operacional", 
  /* Categorías:
     - operacional (viajes, km, horas)
     - conductores (scores, ranking, incidentes)
     - flota (utilización, costos, mantenimiento)
     - financiero (ingresos, costos, ROI)
     - seguridad (alertas, incidentes, compliance)
     - pesv (compliance regulatorio)
     - ejecutivo (resumen alto nivel)
  */
  
  name: "Reporte Operacional Semanal - Semana 45 2025",
  description: "Resumen de actividad operacional del 04 al 10 de Noviembre 2025",
  
  // Period covered
  period: {
    start_date: "2025-11-04T00:00:00Z",
    end_date: "2025-11-10T23:59:59Z",
    
    type: "week", // "day", "week", "month", "quarter", "year"
    
    label: "Semana 45, 2025",
    iso_week: 45,
    year: 2025,
    month: 11
  },
  
  // Filters applied
  filters: {
    branches: null, // null = todas, o ["BR-LIMA-NORTE"]
    vehicle_types: null,
    drivers: null,
    
    custom_filter: null
  },
  
  // Generation info
  generation: {
    status: "completed", // "pending", "generating", "completed", "failed"
    
    generated_at: "2025-11-11T06:00:00Z",
    generated_by: "system_auto", // o user_id si manual
    
    generation_method: "scheduled", // "scheduled", "manual", "on_demand"
    
    processing_time_seconds: 45.3,
    
    error: null
  },
  
  // Data & metrics
  data: {
    // KPIs principales
    kpis: {
      total_trips: 417,
      trips_completed: 412,
      trips_cancelled: 5,
      completion_rate_percent: 98.8,
      
      total_distance_km: 24350,
      total_duration_hours: 1280,
      total_fuel_liters: 4680,
      
      avg_trips_per_day: 59.6,
      avg_distance_per_trip_km: 58.4,
      avg_fuel_efficiency_km_per_liter: 5.2,
      
      vehicles_active: 85,
      vehicles_total: 120,
      utilization_rate_percent: 70.8,
      
      drivers_active: 89,
      avg_driver_score: 84,
      
      alerts_total: 156,
      alerts_critical: 8,
      
      incidents: 3,
      accidents: 0,
      
      total_cost_usd: 12450,
      cost_per_km_usd: 0.511,
      
      revenue_usd: 45600,
      profit_usd: 33150,
      margin_percent: 72.7
    },
    
    // Comparisons
    comparisons: {
      vs_previous_period: {
        trips: { value: 417, previous: 385, change: +32, change_percent: +8.3 },
        distance_km: { value: 24350, previous: 22100, change: +2250, change_percent: +10.2 },
        fuel_efficiency: { value: 5.2, previous: 5.0, change: +0.2, change_percent: +4.0 },
        driver_score: { value: 84, previous: 82, change: +2, change_percent: +2.4 },
        alerts: { value: 156, previous: 178, change: -22, change_percent: -12.4 }
      },
      
      vs_same_period_last_year: {
        trips: { value: 417, last_year: 320, change: +97, change_percent: +30.3 },
        distance_km: { value: 24350, last_year: 18900, change: +5450, change_percent: +28.8 }
      },
      
      vs_target: {
        trips: { value: 417, target: 400, achievement_percent: 104.3 },
        driver_score: { value: 84, target: 85, achievement_percent: 98.8 }
      }
    },
    
    // Trends
    trends: {
      daily_trips: [
        { date: "2025-11-04", trips: 58, distance_km: 3420 },
        { date: "2025-11-05", trips: 62, distance_km: 3680 },
        { date: "2025-11-06", trips: 64, distance_km: 3890 },
        { date: "2025-11-07", trips: 61, distance_km: 3550 },
        { date: "2025-11-08", trips: 57, distance_km: 3310 },
        { date: "2025-11-09", trips: 59, distance_km: 3420 },
        { date: "2025-11-10", trips: 56, distance_km: 3080 }
      ],
      
      hourly_distribution: [
        { hour: "06:00-07:00", trips: 8 },
        { hour: "07:00-08:00", trips: 15 },
        { hour: "08:00-09:00", trips: 22 },
        { hour: "09:00-10:00", trips: 28 },
        // ... resto de horas
      ]
    },
    
    // Rankings
    rankings: {
      top_drivers: [
        {
          driver_id: "USR-2025-0001",
          name: "Pedro López",
          score: 96,
          trips: 24,
          distance_km: 2850,
          alerts: 1
        },
        {
          driver_id: "USR-2025-0002",
          name: "Ana Torres",
          score: 94,
          trips: 22,
          distance_km: 2640,
          alerts: 2
        },
        // ... top 10
      ],
      
      bottom_drivers: [
        {
          driver_id: "USR-2025-0089",
          name: "Carlos Vega",
          score: 68,
          trips: 18,
          distance_km: 1980,
          alerts: 18
        },
        // ... bottom 5
      ],
      
      top_vehicles: [
        {
          vehicle_id: "VEH-2025-0042",
          plate: "ABC-123",
          trips: 28,
          distance_km: 3120,
          fuel_efficiency: 6.1,
          utilization_percent: 95
        },
        // ... top 10
      ]
    },
    
    // Alerts breakdown
    alerts_breakdown: {
      by_type: {
        speeding: 70,
        harsh_brake: 47,
        harsh_acceleration: 25,
        route_deviation: 9,
        geofence_violation: 5
      },
      
      by_severity: {
        critical: 8,
        high: 23,
        medium: 78,
        low: 47
      },
      
      by_driver: [
        { driver_id: "USR-2025-0067", driver_name: "Carlos Díaz", count: 18 },
        { driver_id: "USR-2025-0089", driver_name: "Luis Torres", count: 15 },
        // ... top 10
      ]
    },
    
    // Costs breakdown
    costs_breakdown: {
      fuel: { amount_usd: 7200, percent: 57.8 },
      maintenance: { amount_usd: 1850, percent: 14.9 },
      tolls: { amount_usd: 980, percent: 7.9 },
      salaries: { amount_usd: 2250, percent: 18.1 },
      other: { amount_usd: 170, percent: 1.4 }
    },
    
    // Geographic distribution
    geographic: {
      by_region: [
        { region: "Lima Metropolitana", trips: 245, distance_km: 12800, percent: 58.8 },
        { region: "Callao", trips: 89, distance_km: 4250, percent: 21.3 },
        { region: "Lima Provincias", trips: 83, distance_km: 7300, percent: 19.9 }
      ],
      
      top_routes: [
        {
          route: "Lima Centro - Callao",
          trips: 67,
          avg_distance_km: 18.5,
          avg_duration_min: 45
        },
        {
          route: "Lima Norte - San Isidro",
          trips: 52,
          avg_distance_km: 12.3,
          avg_duration_min: 32
        },
        // ... top 10
      ]
    }
  },
  
  // Insights & recommendations (generados por ML - Fase 3)
  insights: [
    {
      type: "positive",
      category: "eficiencia",
      title: "Mejora significativa en eficiencia de combustible",
      description: "La eficiencia promedio aumentó 4% respecto a semana anterior, principalmente por mejora en comportamiento de conductores.",
      impact: "high",
      metrics: { fuel_saved_liters: 180, cost_saved_usd: 270 }
    },
    {
      type: "attention",
      category: "seguridad",
      title: "Aumento de alertas de velocidad en horario nocturno",
      description: "Se detectó incremento de 25% en alertas de velocidad entre 10pm-6am. Conductores: Carlos Díaz, Luis Torres.",
      impact: "medium",
      recommended_actions: [
        "Reforzar capacitación en conducción nocturna",
        "Implementar sistema de alertas preventivas"
      ]
    },
    {
      type: "opportunity",
      category: "optimizacion",
      title: "5 vehículos con baja utilización",
      description: "VEH-089, VEH-102, VEH-115, VEH-118, VEH-120 tuvieron <50% utilización. Potencial de reasignación.",
      impact: "medium",
      potential_benefit_usd: 1250
    }
  ],
  
  // Action items
  action_items: [
    {
      priority: "high",
      category: "seguridad",
      description: "Programar coaching para conductores con score <70",
      assigned_to: "supervisor_003",
      due_date: "2025-11-17",
      status: "pending"
    },
    {
      priority: "medium",
      category: "mantenimiento",
      description: "5 vehículos requieren mantenimiento preventivo próxima semana",
      assigned_to: "mechanic_team",
      due_date: "2025-11-17",
      status: "pending"
    }
  ],
  
  // Files & exports
  files: {
    pdf_url: "gs://bucket/reports/RPT-2025-W45.pdf",
    excel_url: "gs://bucket/reports/RPT-2025-W45.xlsx",
    
    pdf_size_mb: 2.4,
    excel_size_mb: 1.8,
    
    generated_at: "2025-11-11T06:00:45Z"
  },
  
  // Distribution
  distribution: {
    auto_send: true,
    
    recipients: [
      {
        user_id: "admin_001",
        email: "gerente.operaciones@transportes.com",
        delivery_method: "email",
        sent_at: "2025-11-11T06:01:00Z",
        opened_at: "2025-11-11T08:15:00Z"
      },
      {
        user_id: "admin_002",
        email: "supervisor@transportes.com",
        delivery_method: "email",
        sent_at: "2025-11-11T06:01:00Z",
        opened_at: null
      }
    ],
    
    link_sharing: {
      enabled: true,
      public_link: "https://smartfleet.app/reports/share/abc123def456",
      expires_at: "2025-12-11T06:00:00Z",
      password_protected: false,
      views_count: 3
    }
  },
  
  // Metadata
  created_at: "2025-11-11T06:00:00Z",
  updated_at: "2025-11-11T06:00:45Z",
  
  tags: ["semanal", "operacional", "noviembre", "2025"],
  
  archived: false,
  archive_date: null
}

// Índices compuestos necesarios:
// - company_id + type + period.start_date DESC
// - company_id + category + generation.status
// - company_id + archived + period.start_date DESC
```

#### 6.2.10. Collection: `notifications`
```javascript
notifications/{notification_id}
{
  notification_id: "NOTIF-20251106-0845",
  company_id: "COMP-2025-001",
  
  // Recipient
  user_id: "USR-2025-0001",
  user_name: "Juan Pérez",
  user_role: "conductor",
  
  // Type & category
  type: "alert", 
  /* Tipos:
     - alert (alerta operacional)
     - reminder (recordatorio)
     - announcement (anuncio empresa)
     - achievement (logro/badge ganado)
     - trip_assignment (viaje asignado)
     - maintenance_scheduled (mantenimiento programado)
     - document_expiring (documento por vencer)
     - message (mensaje de supervisor)
  */
  
  category: "seguridad", // "seguridad", "operacional", "admin", "personal"
  
  priority: "high", // "low", "medium", "high", "critical"
  
  // Content
  title: "Alerta de velocidad",
  body: "Detectamos exceso de velocidad (108 km/h en zona de 100 km/h). Por favor modera tu velocidad.",
  
  icon: "speed_warning",
  color: "#FF9800",
  
  // Rich content (opcional)
  image_url: null,
  action_url: null, // deep link dentro de la app
  
  // Data payload (para procesar en app)
  data: {
    alert_id: "ALERT-20251106-0245",
    trip_id: "TRIP-20251106-0245",
    vehicle_id: "VEH-2025-0042",
    speed_kmh: 108,
    limit_kmh: 100,
    location: {
      lat: -12.2345,
      lng: -77.1234
    }
  },
  
  // Actions (botones en la notificación)
  actions: [
    {
      action_id: "acknowledge",
      label: "Entendido",
      type: "primary"
    },
    {
      action_id: "view_details",
      label: "Ver detalles",
      type: "secondary",
      deep_link: "smartfleet://alerts/ALERT-20251106-0245"
    }
  ],
  
  // Delivery
  channels: {
    push: {
      enabled: true,
      sent: true,
      sent_at: "2025-11-06T10:15:32Z",
      
      fcm_message_id: "fcm_msg_xyz789",
      
      delivered: true,
      delivered_at: "2025-11-06T10:15:33Z",
      
      failed: false,
      error: null
    },
    
    email: {
      enabled: false,
      sent: false
    },
    
    sms: {
      enabled: false,
      sent: false
    },
    
    in_app: {
      enabled: true, // siempre se guarda en BD para historial in-app
      displayed: true
    }
  },
  
  // User interaction
  interaction: {
    read: true,
    read_at: "2025-11-06T10:15:45Z",
    
    clicked: true,
    clicked_at: "2025-11-06T10:15:50Z",
    
    action_taken: "acknowledge",
    action_taken_at: "2025-11-06T10:15:52Z",
    
    dismissed: false,
    dismissed_at: null
  },
  
  // Grouping (para agrupar notificaciones similares)
  group_key: "alerts_speeding",
  
  // Related entities
  related: {
    alert_id: "ALERT-20251106-0245",
    trip_id: "TRIP-20251106-0245",
    vehicle_id: "VEH-2025-0042"
  },
  
  // Expiration
  expires_at: "2025-11-13T10:15:31Z", // 7 días después
  
  // Metadata
  created_at: "2025-11-06T10:15:31Z",
  sent_by: "system_auto",
  
  // TTL para auto-delete
  ttl: "2025-12-06T10:15:31Z" // 30 días
}

// Índices compuestos necesarios:
// - user_id + interaction.read + created_at DESC
// - user_id + type + created_at DESC
// - company_id + type + priority DESC + created_atRetryHContinueDESC
// - expires_at ASC (para cleanup de notificaciones vencidas)
// - user_id + group_key + created_at DESC (para agrupar)

---

### 6.3. Estrategia de Migración a BigQuery

**Pipeline ETL Automatizado:**
```javascript
// Cloud Function que se ejecuta cada 15 minutos
exports.syncToBigQuery = functions.pubsub
  .schedule('every 15 minutes')
  .onRun(async (context) => {
    
    const collections = [
      'trips',
      'alerts', 
      'maintenance_records',
      'users',
      'vehicles'
    ];
    
    for (const collection of collections) {
      // 1. Query documentos actualizados desde último sync
      const lastSync = await getLastSyncTimestamp(collection);
      
      const snapshot = await db.collection(collection)
        .where('updated_at', '>', lastSync)
        .get();
      
      if (snapshot.empty) continue;
      
      // 2. Transform data para BigQuery schema
      const rows = snapshot.docs.map(doc => transformForBigQuery(doc.data()));
      
      // 3. Insert/Update en BigQuery
      await bigquery
        .dataset('smartfleet_prod')
        .table(collection)
        .insert(rows, { skipInvalidRows: false });
      
      // 4. Actualizar timestamp de último sync
      await updateLastSyncTimestamp(collection, new Date());
      
      console.log(`Synced ${rows.length} rows to ${collection}`);
    }
    
    return null;
  });
```

**Esquemas BigQuery (Ejemplos):**
```sql
-- Table: trips
CREATE TABLE `smartfleet_prod.trips` (
  trip_id STRING NOT NULL,
  company_id STRING NOT NULL,
  driver_id STRING,
  driver_name STRING,
  vehicle_id STRING,
  vehicle_plate STRING,
  
  status STRING,
  
  planned_start TIMESTAMP,
  planned_end TIMESTAMP,
  actual_start TIMESTAMP,
  actual_end TIMESTAMP,
  
  origin_lat FLOAT64,
  origin_lng FLOAT64,
  origin_name STRING,
  
  destination_lat FLOAT64,
  destination_lng FLOAT64,
  destination_name STRING,
  
  distance_km FLOAT64,
  duration_minutes INT64,
  
  average_speed_kmh FLOAT64,
  max_speed_kmh FLOAT64,
  
  fuel_consumed_liters FLOAT64,
  fuel_efficiency_km_per_liter FLOAT64,
  
  score_overall INT64,
  score_speed INT64,
  score_braking INT64,
  score_acceleration INT64,
  
  events_count INT64,
  alerts_count INT64,
  
  cost_fuel_usd FLOAT64,
  cost_tolls_usd FLOAT64,
  cost_total_usd FLOAT64,
  
  revenue_usd FLOAT64,
  profit_usd FLOAT64,
  
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  
  -- Particionamiento por fecha para queries eficientes
  PARTITION BY DATE(actual_start)
  CLUSTER BY company_id, driver_id, vehicle_id
);

-- Table: trip_events (eventos granulares)
CREATE TABLE `smartfleet_prod.trip_events` (
  event_id STRING NOT NULL,
  trip_id STRING NOT NULL,
  company_id STRING NOT NULL,
  
  event_type STRING, -- 'harsh_brake', 'speeding', etc
  severity STRING,
  
  timestamp TIMESTAMP,
  
  lat FLOAT64,
  lng FLOAT64,
  
  speed_kmh FLOAT64,
  acceleration_g FLOAT64,
  
  driver_id STRING,
  vehicle_id STRING,
  
  PARTITION BY DATE(timestamp)
  CLUSTER BY company_id, event_type, severity
);

-- Table: driver_daily_stats (agregados diarios)
CREATE TABLE `smartfleet_prod.driver_daily_stats` (
  company_id STRING NOT NULL,
  driver_id STRING NOT NULL,
  date DATE NOT NULL,
  
  trips_count INT64,
  distance_km FLOAT64,
  duration_hours FLOAT64,
  
  avg_score INT64,
  alerts_count INT64,
  
  fuel_efficiency FLOAT64,
  
  PARTITION BY date
  CLUSTER BY company_id, driver_id
);
```

**Queries de Análisis (Ejemplos):**
```sql
-- 1. Top 10 conductores por eficiencia de combustible (último mes)
SELECT 
  driver_id,
  driver_name,
  COUNT(*) as trips_count,
  SUM(distance_km) as total_km,
  AVG(fuel_efficiency_km_per_liter) as avg_fuel_efficiency,
  RANK() OVER (ORDER BY AVG(fuel_efficiency_km_per_liter) DESC) as rank
FROM `smartfleet_prod.trips`
WHERE 
  company_id = 'COMP-2025-001'
  AND actual_start >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY)
  AND status = 'completado'
GROUP BY driver_id, driver_name
ORDER BY avg_fuel_efficiency DESC
LIMIT 10;

-- 2. Patrón de alertas por hora del día (últimos 3 meses)
SELECT 
  EXTRACT(HOUR FROM timestamp) as hour_of_day,
  event_type,
  COUNT(*) as event_count,
  AVG(speed_kmh) as avg_speed
FROM `smartfleet_prod.trip_events`
WHERE 
  company_id = 'COMP-2025-001'
  AND timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
  AND event_type IN ('speeding', 'harsh_brake', 'harsh_acceleration')
GROUP BY hour_of_day, event_type
ORDER BY hour_of_day, event_count DESC;

-- 3. Predicción de mantenimiento con ML (BigQuery ML)
CREATE OR REPLACE MODEL `smartfleet_prod.maintenance_prediction`
OPTIONS(
  model_type='LOGISTIC_REG',
  input_label_cols=['failure_next_30d']
) AS
SELECT
  v.vehicle_age_months,
  v.total_km,
  v.km_since_last_maintenance,
  ds.avg_harsh_events_30d,
  ds.avg_fuel_efficiency_30d,
  m.corrective_maintenance_count_12m,
  
  -- Label: 1 si hubo falla en próximos 30 días, 0 si no
  IF(TIMESTAMP_DIFF(m.next_failure_date, v.current_date, DAY) <= 30, 1, 0) as failure_next_30d
  
FROM `smartfleet_prod.vehicles` v
JOIN `smartfleet_prod.driver_stats_30d` ds ON v.assigned_driver_id = ds.driver_id
LEFT JOIN `smartfleet_prod.maintenance_history` m ON v.vehicle_id = m.vehicle_id;

-- 4. Scoring de conductores con percentiles
SELECT 
  driver_id,
  driver_name,
  avg_score,
  PERCENT_RANK() OVER (ORDER BY avg_score) as percentile,
  NTILE(10) OVER (ORDER BY avg_score) as decile
FROM (
  SELECT 
    driver_id,
    driver_name,
    AVG(score_overall) as avg_score
  FROM `smartfleet_prod.trips`
  WHERE 
    company_id = 'COMP-2025-001'
    AND actual_start >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY)
  GROUP BY driver_id, driver_name
)
ORDER BY avg_score DESC;
```

---

### 6.4. Índices de Firestore (Composite Indexes)

**firestore.indexes.json:**
```json
{
  "indexes": [
    {
      "collectionGroup": "users",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "company_id", "order": "ASCENDING" },
        { "fieldPath": "employment.role", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "users",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "company_id", "order": "ASCENDING" },
        { "fieldPath": "metrics.driver_score.current", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "vehicles",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "company_id", "order": "ASCENDING" },
        { "fieldPath": "operation.operational_status", "order": "ASCENDING" },
        { "fieldPath": "operation.availability_status", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "vehicles",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "company_id", "order": "ASCENDING" },
        { "fieldPath": "health.health_score", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "trips",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "company_id", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "planning.planned_start", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "trips",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "company_id", "order": "ASCENDING" },
        { "fieldPath": "driver_id", "order": "ASCENDING" },
        { "fieldPath": "lifecycle.started_at", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "alerts",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "company_id", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "severity", "order": "DESCENDING" },
        { "fieldPath": "timestamp", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "alerts",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "company_id", "order": "ASCENDING" },
        { "fieldPath": "driver_id", "order": "ASCENDING" },
        { "fieldPath": "timestamp", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "geofences",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "company_id", "order": "ASCENDING" },
        { "fieldPath": "type", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "maintenance_records",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "company_id", "order": "ASCENDING" },
        { "fieldPath": "vehicle_id", "order": "ASCENDING" },
        { "fieldPath": "execution.completed_at", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "notifications",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "user_id", "order": "ASCENDING" },
        { "fieldPath": "interaction.read", "order": "ASCENDING" },
        { "fieldPath": "created_at", "order": "DESCENDING" }
      ]
    }
  ],
  "fieldOverrides": [
    {
      "collectionGroup": "geofences",
      "fieldPath": "tags",
      "indexes": [
        { "queryScope": "COLLECTION", "order": "ASCENDING" },
        { "queryScope": "COLLECTION", "arrayConfig": "CONTAINS" }
      ]
    }
  ]
}
```

---

### 6.5. Optimizaciones de Rendimiento

#### 6.5.1. Caching Strategy
┌─────────────────────────────────────────────────────┐
│           CAPA 1: Client-side Cache                 │
│  • Flutter: Hive/SharedPreferences                  │
│  • Web: IndexedDB / LocalStorage                    │
│  • TTL: 5-60 min según tipo de dato                 │
└──────────────────┬──────────────────────────────────┘
│
┌──────────────────▼──────────────────────────────────┐
│         CAPA 2: CDN / Edge Cache                    │
│  • Cloudflare CDN                                   │
│  • Assets estáticos: imágenes, JS, CSS              │
│  • TTL: 24h                                         │
└──────────────────┬──────────────────────────────────┘
│
┌──────────────────▼──────────────────────────────────┐
│       CAPA 3: Firebase Hosting Cache                │
│  • Web app bundle                                   │
│  • TTL: 1h                                          │
└──────────────────┬──────────────────────────────────┘
│
┌──────────────────▼──────────────────────────────────┐
│         CAPA 4: Firestore (Source)                  │
│  • Real-time listeners para datos críticos          │
│  • Polling para datos menos críticos                │
└─────────────────────────────────────────────────────┘

**Estrategia por Tipo de Dato:**

| Tipo de Dato | Frecuencia Actualización | Cache TTL | Estrategia |
|-------------|-------------------------|-----------|------------|
| Ubicación en vivo | 10-15 seg | No cache | Real-time listener |
| Alertas activas | 30 seg | 30 seg | Listener + cache |
| Lista de vehículos | 5 min | 5 min | Cache + periodic refresh |
| Perfil de usuario | 1h | 1h | Cache + invalidation on edit |
| Reportes históricos | 24h | 24h | Aggressive caching |
| Assets estáticos | Permanente | 30 días | CDN + versioning |

#### 6.5.2. Query Optimization Patterns

**Patrón 1: Denormalización Estratégica**
```javascript
// ❌ MAL: Multiple queries para mostrar lista de viajes
const trips = await db.collection('trips').where('driver_id', '==', driverId).get();

for (const trip of trips.docs) {
  const driver = await db.doc(`users/${trip.data().driver_id}`).get();
  const vehicle = await db.doc(`vehicles/${trip.data().vehicle_id}`).get();
  // N+1 queries problem!
}

// ✅ BIEN: Denormalizar datos frecuentes
trips/{trip_id}
{
  driver_id: "USR-2025-0001",
  driver_name: "Juan Pérez", // ⬅️ Denormalizado
  vehicle_id: "VEH-2025-0042",
  vehicle_plate: "ABC-123", // ⬅️ Denormalizado
  // ...
}
```

**Patrón 2: Subcollections para Datos Grandes**
```javascript
// ❌ MAL: Guardar 5000 puntos GPS en array dentro del documento
trips/{trip_id}
{
  route_points: [ /* 5000 objetos */ ] // ⚠️ Documento > 1MB!
}

// ✅ BIEN: Subcollection para datos volumétricos
trips/{trip_id}/route_points/{point_id}
{
  lat: -12.0464,
  lng: -77.0428,
  // ...
}
```

**Patrón 3: Aggregation Fields**
```javascript
// ❌ MAL: Contar documentos cada vez
const alertsSnapshot = await db.collection('alerts')
  .where('driver_id', '==', driverId)
  .where('status', '==', 'open')
  .get();

const count = alertsSnapshot.size; // Costoso

// ✅ BIEN: Mantener contador agregado
users/{user_id}
{
  metrics: {
    alerts: {
      total_count: 28,
      open_count: 12, // ⬅️ Actualizado con Cloud Function trigger
      resolved_count: 16
    }
  }
}
```

**Patrón 4: Batch Reads**
```javascript
// ❌ MAL: Múltiples reads individuales
for (const vehicleId of vehicleIds) {
  const vehicle = await db.doc(`vehicles/${vehicleId}`).get();
}

// ✅ BIEN: Batch read (máximo 500 docs por batch)
const vehicleRefs = vehicleIds.map(id => db.doc(`vehicles/${id}`));
const vehicles = await db.getAll(...vehicleRefs);
```

---

## 🚀 7. FASES DE DESARROLLO (ROADMAP DETALLADO)

### 7.1. Metodología: Agile con Sprints de 2 Semanas

**Equipo Recomendado (MVP):**
- 1 Tech Lead / Arquitecto (full-time)
- 2 Desarrolladores Flutter (full-time)
- 1 Desarrollador Backend / DevOps (full-time)
- 1 UI/UX Designer (part-time, 50%)
- 1 QA Engineer (full-time desde Sprint 4)
- 1 Product Manager (part-time, 50%)

**Total:** 5.5 FTE (Full-Time Equivalents)

---

### 7.2. FASE 1: MVP Funcional (12 semanas - 6 sprints)

**Objetivo:** Producto mínimo viable para piloto con 10 vehículos

#### Sprint 1-2 (Semanas 1-4): Fundamentos + Autenticación

**Backend:**
- [ ] Setup Firebase proyecto (Firestore, Auth, Storage, Functions)
- [ ] Configurar ambientes: dev, staging, production
- [ ] Definir colecciones base en Firestore
- [ ] Implementar Firebase Security Rules básicas
- [ ] Setup CI/CD con GitHub Actions

**Mobile (Flutter):**
- [ ] Setup proyecto Flutter con arquitectura limpia (Clean Architecture)
- [ ] Configurar state management (Riverpod)
- [ ] Implementar Design System base (colores, tipografía, componentes)
- [ ] Pantalla de Login / Registro
- [ ] Integración Firebase Auth
- [ ] Manejo de sesiones persistentes

**Web (Flutter Web):**
- [ ] Setup proyecto Flutter Web
- [ ] Layout base con sidebar navegación
- [ ] Login admin

**User Stories Completadas:**
- ✅ Como conductor, puedo crear mi cuenta y hacer login
- ✅ Como admin, puedo acceder al dashboard web

**Entregable:** App y web con autenticación funcional

---

#### Sprint 3-4 (Semanas 5-8): Tracking GPS + Mapa Básico

**Mobile:**
- [ ] Solicitar permisos de ubicación
- [ ] Implementar tracking GPS en foreground (Geolocator)
- [ ] Enviar coordenadas a Firestore cada 15 seg
- [ ] Pantalla de mapa con ubicación actual del conductor
- [ ] Integración Mapbox SDK
- [ ] Indicadores de estado: GPS, batería, conectividad

**Backend:**
- [ ] Cloud Function para recibir y procesar coordenadas
- [ ] Estructura de datos para trip_points
- [ ] Detección básica de movimiento vs detenido

**Web:**
- [ ] Mapa en vivo con Mapbox GL JS
- [ ] Mostrar vehículos activos en tiempo real
- [ ] Panel lateral con lista de vehículos
- [ ] Filtros básicos (estado, sucursal)

**User Stories Completadas:**
- ✅ Como conductor, veo mi ubicación actual en el mapa
- ✅ Como admin, veo todos los vehículos activos en tiempo real
- ✅ Como admin, puedo filtrar vehículos por estado

**Entregable:** Tracking en vivo funcional

---

#### Sprint 5-6 (Semanas 9-12): Gestión de Viajes + CRUD Básico

**Mobile:**
- [ ] Pantalla de inicio con viaje asignado
- [ ] Flujo: Iniciar Viaje → En Curso → Finalizar Viaje
- [ ] Registro de waypoints (origen, destino)
- [ ] Cálculo básico de distancia y duración
- [ ] Notificaciones push (Firebase Cloud Messaging)

**Backend:**
- [ ] CRUD de trips en Firestore
- [ ] Cloud Function para calcular estadísticas de viaje
- [ ] Triggers para notificaciones automáticas

**Web:**
- [ ] CRUD de conductores (crear, editar, desactivar)
- [ ] CRUD de vehículos
- [ ] Asignar vehículo a conductor
- [ ] Crear y asignar viajes manualmente
- [ ] Vista de detalle de viaje
- [ ] Historial de viajes

**User Stories Completadas:**
- ✅ Como admin, puedo crear conductores y vehículos
- ✅ Como admin, puedo asignar un viaje a un conductor
- ✅ Como conductor, puedo ver mi viaje asignado e iniciarlo
- ✅ Como conductor, recibo notificación cuando me asignan un viaje
- ✅ Como admin, veo el progreso del viaje en tiempo real

**Entregable:** Gestión completa de viajes básica

**✅ FIN DE FASE 1 - MVP LISTO PARA PILOTO**

**Métricas de Éxito Fase 1:**
- App móvil instalada y funcionando en 10 dispositivos
- 100% de viajes trackeados correctamente
- Latencia de actualización de ubicación < 20 seg
- 0 crashes críticos en 1 semana de piloto
- Feedback positivo de 8/10 conductores

---

### 7.3. FASE 2: Features Intermedias (16 semanas - 8 sprints)

**Objetivo:** Producto completo para escalar a 50-100 vehículos

#### Sprint 7-8 (Semanas 13-16): Tracking Avanzado + Offline

**Mobile:**
- [ ] Background service (flutter_background_service)
- [ ] Tracking en segundo plano
- [ ] Optimización de batería (intervalos adaptativos)
- [ ] Almacenamiento offline (Hive)
- [ ] Sincronización automática al reconectar
- [ ] Indicador visual de "modo offline"

**Backend:**
- [ ] Queue de procesamiento para uploads masivos
- [ ] Detección de GPS spoofing básica
- [ ] Validación de coherencia de datos

**Métricas:**
- Consumo de batería < 10% en 10h
- Sincronización offline exitosa en 100% de casos

---

#### Sprint 9-10 (Semanas 17-20): Alertas Inteligentes + Geocercas

**Mobile:**
- [ ] Detección local de exceso de velocidad
- [ ] Detección de frenado/aceleración brusca (acelerómetro)
- [ ] Alertas visuales y sonoras al conductor
- [ ] Haptic feedback

**Backend:**
- [ ] Cloud Functions para alertas avanzadas
- [ ] Cálculo de geocercas (entrada/salida)
- [ ] Sistema de notificaciones por severidad
- [ ] Agregación de alertas (evitar spam)

**Web:**
- [ ] Dashboard de alertas en tiempo real
- [ ] Creador de geocercas (dibujar en mapa)
- [ ] Configuración de reglas por geocerca
- [ ] Historial de alertas por conductor

---

#### Sprint 11-12 (Semanas 21-24): Sistema de Scoring + Gamificación

**Mobile:**
- [ ] Pantalla de Score personal con desglose
- [ ] Gráfico de evolución (últimos 30 días)
- [ ] Leaderboard (global y por sucursal)
- [ ] Sistema de badges
- [ ] Notificaciones de logros

**Backend:**
- [ ] Algoritmo de cálculo de Driver Score
- [ ] Cloud Function para actualizar scores diariamente
- [ ] Sistema de badges y achievements
- [ ] Cálculo de rankings

**Web:**
- [ ] Dashboard de conductores con ranking
- [ ] Vista de perfil completo de conductor
- [ ] Análisis de comportamiento (gráficos)

---

#### Sprint 13-14 (Semanas 25-28): Reportes Automáticos

**Backend:**
- [ ] Integración con BigQuery
- [ ] ETL automatizado (Firestore → BigQuery cada 15 min)
- [ ] Scheduled Cloud Functions para reportes
- [ ] Templates de reportes en Looker Studio

**Web:**
- [ ] Conexión con Looker Studio (iframe embebido)
- [ ] Exportación de reportes a PDF/Excel
- [ ] Programación de reportes automáticos
- [ ] Email de reportes semanales/mensuales

---

#### Sprint 15-16 (Semanas 29-32): Mantenimiento + PESV Básico

**Mobile:**
- [ ] Inspección Pre-Operacional digital (IPO)
- [ ] Checklist interactivo
- [ ] Captura de fotos de evidencia
- [ ] Reporte de problemas

**Backend:**
- [ ] Lógica de mantenimiento preventivo
- [ ] Alertas automáticas por kilometraje/tiempo
- [ ] Cloud Function para calcular próximos servicios

**Web:**
- [ ] CRUD de mantenimientos
- [ ] Gestión de órdenes de trabajo
- [ ] Dashboard de mantenimiento predictivo
- [ ] Control de documentos (licencias, SOAT, etc)
- [ ] Alertas de documentos por vencer
- [ ] Registro de capacitaciones
- [ ] Control de horas de conducción

**✅ FIN DE FASE 2 - PRODUCTO ENTERPRISE-READY**

**Métricas de Éxito Fase 2:**
- 50-100 vehículos activos
- Driver Score calculado para 100% de conductores
- Alertas con <5% falsos positivos
- Reportes automáticos enviados semanalmente
- 95% de IPOs completadas antes de viajes
- 100% de documentos monitoreados automáticamente

---

### 7.4. FASE 3: IA y Escalabilidad (12 semanas - 6 sprints)

**Objetivo:** Inteligencia artificial + escalar a 500+ vehículos

#### Sprint 17-18 (Semanas 33-36): Machine Learning On-Device

**Mobile:**
- [ ] Integración TensorFlow Lite
- [ ] Modelo on-device para detección de anomalías
- [ ] Inferencia <100ms
- [ ] Feedback instantáneo al conductor

**Backend:**
- [ ] Training pipeline en BigQuery ML
- [ ] Modelo de predicción de mantenimiento
- [ ] Modelo de predicción de incidentes
- [ ] API para servir predicciones

---

#### Sprint 19-20 (Semanas 37-40): Optimización de Rutas + IA

**Mobile:**
- [ ] Integración Mapbox Directions API (Truck profile)
- [ ] Comparación de rutas (rápida, corta, económica)
- [ ] Recalcular ruta automáticamente por tráfico
- [ ] Navegación turn-by-turn

**Backend:**
- [ ] Algoritmo de optimización de múltiples paradas
- [ ] ML para predecir tiempos de entrega
- [ ] Integración con APIs de tráfico en tiempo real

---

#### Sprint 21-22 (Semanas 41-44): Marketplace de Integraciones

**Backend:**
- [ ] API pública REST + GraphQL
- [ ] Documentación con Swagger/OpenAPI
- [ ] Sistema de API keys
- [ ] Rate limiting
- [ ] Webhooks para eventos

**Web:**
- [ ] Portal de desarrolladores
- [ ] Marketplace de integraciones
- [ ] Conectores pre-built (ERP, TMS, contabilidad)

---

**✅ FIN DE FASE 3 - PLATAFORMA ESCALABLE CON IA**

**Métricas de Éxito Fase 3:**
- 500+ vehículos soportados
- Predicciones ML con >80% precisión
- API pública con 10+ integraciones activas
- Rutas optimizadas ahorran 10-15% combustible

---

### 7.5. Cronograma Visual (Gantt Simplificado)
Mes 1  Mes 2  Mes 3  Mes 4  Mes 5  Mes 6  Mes 7  Mes 8  Mes 9  Mes 10 Mes 11 Mes 12
├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│█████ Fase 1: MVP (12 sem)       │                                                   │
│      ├─ Auth & Setup             │                                                   │
│      ├─ Tracking GPS             │                                                   │
│      └─ Viajes Básicos           │                                                   │
│                                  │████████ Fase 2: Features (16 sem)                │
│                                  ├─ Background tracking                             │
│                                  ├─ Alertas & Geocercas                             │
│                                  ├─ Scoring & Gamificación                          │
│                                  ├─ Reportes                                        │
│                                  └─ Mantenimiento & PESV                            │
│                                                                  │█████ Fase 3: IA  │
│                                                                  ├─ ML on-device    │
│                                                                  ├─ Rutas IA        │
│                                                                  └─ API Marketplace │
└──────────────────────────────────────────────────────────────────────────────────────┘

---

¿Continúo con la **Sección 8: Costos y Escalabilidad** o prefieres que profundice en algo específico de lo que ya vimos? 🚀RetryHcontinua¡Perfecto! Continúo con la Sección 8: Costos y Escalabilidad:

💰 8. COSTOS Y ESCALABILIDAD
8.1. Estructura de Costos Detallada
8.1.1. Costos de Infraestructura (Cloud)
Firebase (Google Cloud Platform)
ServicioPlan GratuitoCosto Estimado por NivelFirebase Authentication50K MAU$0 (dentro del límite para 500 veh)Firestore- Lecturas50K/día$0.06 / 100K lecturas- Escrituras20K/día$0.18 / 100K escrituras- Eliminaciones20K/día$0.02 / 100K eliminaciones- Storage1 GB$0.18 / GB/mesCloud Functions- Invocaciones2M/mes$0.40 / millón- GB-seconds400K/mes$0.0000025 / GB-sec- GHz-seconds200K/mes$0.0000100 / GHz-secCloud Storage5 GB$0.026 / GB/mesFirebase Hosting10 GB/mes$0.15 / GB transferidoCloud Messaging (FCM)Ilimitado$0 (gratis)
Estimaciones por Escala:
┌─────────────────────────────────────────────────────────────────────┐
│ PEQUEÑA FLOTA (10-50 vehículos)                                     │
├─────────────────────────────────────────────────────────────────────┤
│ Firestore:                                                          │
│ - Lecturas: 2M/mes × $0.06/100K = $1.20                           │
│ - Escrituras: 5M/mes × $0.18/100K = $9.00                         │
│ - Storage: 15 GB × $0.18 = $2.70                                   │
│                                                                     │
│ Cloud Functions:                                                    │
│ - Invocaciones: 8M/mes × $0.40/1M = $3.20                         │
│ - Compute: ~$5.00                                                   │
│                                                                     │
│ Cloud Storage (fotos, docs):                                        │
│ - Storage: 50 GB × $0.026 = $1.30                                  │
│ - Transferencia: 20 GB × $0.12 = $2.40                            │
│                                                                     │
│ Firebase Hosting:                                                   │
│ - Transferencia: 30 GB × $0.15 = $4.50                            │
│                                                                     │
│ SUBTOTAL FIREBASE: $29.30/mes                                      │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│ MEDIANA FLOTA (50-200 vehículos)                                    │
├─────────────────────────────────────────────────────────────────────┤
│ Firestore:                                                          │
│ - Lecturas: 15M/mes × $0.06/100K = $9.00                          │
│ - Escrituras: 35M/mes × $0.18/100K = $63.00                       │
│ - Storage: 80 GB × $0.18 = $14.40                                  │
│                                                                     │
│ Cloud Functions:                                                    │
│ - Invocaciones: 50M/mes × $0.40/1M = $20.00                       │
│ - Compute: ~$35.00                                                  │
│                                                                     │
│ Cloud Storage:                                                      │
│ - Storage: 300 GB × $0.026 = $7.80                                 │
│ - Transferencia: 120 GB × $0.12 = $14.40                          │
│                                                                     │
│ Firebase Hosting:                                                   │
│ - Transferencia: 180 GB × $0.15 = $27.00                          │
│                                                                     │
│ SUBTOTAL FIREBASE: $190.60/mes                                     │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│ GRAN FLOTA (200-500 vehículos)                                      │
├─────────────────────────────────────────────────────────────────────┤
│ Firestore:                                                          │
│ - Lecturas: 45M/mes × $0.06/100K = $27.00                         │
│ - Escrituras: 120M/mes × $0.18/100K = $216.00                     │
│ - Storage: 250 GB × $0.18 = $45.00                                 │
│                                                                     │
│ Cloud Functions:                                                    │
│ - Invocaciones: 180M/mes × $0.40/1M = $72.00                      │
│ - Compute: ~$125.00                                                 │
│                                                                     │
│ Cloud Storage:                                                      │
│ - Storage: 1 TB × $0.026 = $26.00                                  │
│ - Transferencia: 400 GB × $0.12 = $48.00                          │
│                                                                     │
│ Firebase Hosting:                                                   │
│ - Transferencia: 500 GB × $0.15 = $75.00                          │
│                                                                     │
│ SUBTOTAL FIREBASE: $634.00/mes                                     │
└─────────────────────────────────────────────────────────────────────┘
Mapbox
ServicioPlan GratuitoCosto por UsoMap Loads50K/mes$0.60 / 1,000 loadsDirections API100K requests$0.60 / 1,000 requestsGeocoding100K requests$0.50 / 1,000 requestsIsochrone API100K requests$0.75 / 1,000 requestsStatic Images50K requests$0.40 / 1,000 requests
Estimaciones por Escala:
Pequeña (10-50 veh):
- Map loads: 80K × $0.60/1K = $48.00
- Directions: 5K × $0.60/1K = $3.00
- Geocoding: 3K × $0.50/1K = $1.50
SUBTOTAL: $52.50/mes

Mediana (50-200 veh):
- Map loads: 450K × $0.60/1K = $270.00
- Directions: 28K × $0.60/1K = $16.80
- Geocoding: 18K × $0.50/1K = $9.00
SUBTOTAL: $295.80/mes

Gran (200-500 veh):
- Map loads: 1.2M × $0.60/1K = $720.00
- Directions: 85K × $0.60/1K = $51.00
- Geocoding: 55K × $0.50/1K = $27.50
SUBTOTAL: $798.50/mes
BigQuery + Looker Studio
ServicioPlan GratuitoCosto por UsoBigQuery Storage10 GB$0.02 / GB/mes (activo), $0.01 / GB/mes (long-term)BigQuery Queries1 TB/mes$5.00 / TB procesadoBigQuery ML10 GB/mes$250 / TB procesadoLooker StudioGratis básico$0 (compartir ilimitado)
Estimaciones:
Pequeña:
- Storage: 50 GB × $0.02 = $1.00
- Queries: 100 GB × $5/1000 = $0.50
SUBTOTAL: $1.50/mes

Mediana:
- Storage: 300 GB × $0.02 = $6.00
- Queries: 800 GB × $5/1000 = $4.00
SUBTOTAL: $10.00/mes

Gran:
- Storage: 1 TB × $0.02 = $20.00
- Queries: 3 TB × $5/1000 = $15.00
- ML: 50 GB × $250/1000 = $12.50
SUBTOTAL: $47.50/mes
Otros Servicios Cloud
ServicioCosto MensualCloudflare CDN (para web assets)$20-50SendGrid (emails transaccionales)$15-30 (hasta 50K emails)Twilio (SMS - opcional)$0.01/SMS (solo si se habilita)OpenWeatherMap API$0-40 (según calls)Sentry (error tracking)$26-80 (según eventos)

8.1.2. Resumen de Costos de Infraestructura
┌─────────────────────────────────────────────────────────────────────┐
│                    PEQUEÑA FLOTA (10-50 vehículos)                  │
├─────────────────────────────────────────────────────────────────────┤
│ Firebase:                 $29.30                                    │
│ Mapbox:                   $52.50                                    │
│ BigQuery + Looker:        $1.50                                     │
│ Otros servicios:          $60.00                                    │
│ ─────────────────────────────────                                  │
│ TOTAL MENSUAL:           $143.30                                    │
│ POR VEHÍCULO:            $2.87 - $14.33 (según 10-50 veh)          │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│                   MEDIANA FLOTA (50-200 vehículos)                  │
├─────────────────────────────────────────────────────────────────────┤
│ Firebase:                $190.60                                    │
│ Mapbox:                  $295.80                                    │
│ BigQuery + Looker:       $10.00                                     │
│ Otros servicios:         $100.00                                    │
│ ─────────────────────────────────────                              │
│ TOTAL MENSUAL:           $596.40                                    │
│ POR VEHÍCULO:            $2.98 - $11.93 (según 50-200 veh)         │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│                    GRAN FLOTA (200-500 vehículos)                   │
├─────────────────────────────────────────────────────────────────────┤
│ Firebase:                $634.00                                    │
│ Mapbox:                  $798.50                                    │
│ BigQuery + Looker:       $47.50                                     │
│ Otros servicios:         $180.00                                    │
│ ─────────────────────────────────────                              │
│ TOTAL MENSUAL:          $1,660.00                                   │
│ POR VEHÍCULO:           $3.32 - $8.30 (según 200-500 veh)          │
└─────────────────────────────────────────────────────────────────────┘
💡 Insight Clave: Los costos por vehículo disminuyen con escala debido a economías de escala y planes de volumen.

8.1.3. Costos de Desarrollo (One-Time + Mantenimiento)
Desarrollo Inicial (MVP - Fase 1):
RolTarifa/mesMesesTotalTech Lead$8,0003$24,000Flutter Dev x2$6,000 × 23$36,000Backend Dev$6,5003$19,500UI/UX Designer$4,000 (50%)3$6,000QA Engineer$4,5001.5$6,750Product Manager$5,000 (50%)3$7,500SUBTOTAL$99,750Overhead (15%)$14,963TOTAL MVP$114,713
Desarrollo Completo (Fases 1-3):
Fase 1 (MVP): $114,713
Fase 2 (Features): $186,500 (4 meses, mismo equipo)
Fase 3 (IA): $139,875 (3 meses, mismo equipo)
───────────────────────────────
TOTAL DESARROLLO: $441,088
Costos de Mantenimiento Anual (Post-Launch):
ConceptoCosto AnualEquipo de desarrollo (2 devs part-time)$72,000DevOps / SRE (part-time)$36,000Support / QA (part-time)$30,000Product Manager (part-time)$30,000Licencias y herramientas$5,000TOTAL ANUAL$173,000
Costo por vehículo (mantenimiento):

100 vehículos: $173,000 / 100 = $1,730/año = $144/mes
500 vehículos: $173,000 / 500 = $346/año = $29/mes


8.1.4. Costos Operativos (Go-to-Market)
Marketing y Ventas:
ConceptoCosto AnualSales team (2 vendedores)$120,000Marketing digital (ads, content)$60,000Demos y eventos$20,000Customer success manager$50,000TOTAL$250,000
Soporte al Cliente:
ConceptoCosto MensualSoporte técnico (2 personas)$8,000Herramientas (Intercom, Zendesk)$500Onboarding y capacitación$2,000TOTAL MENSUAL$10,500TOTAL ANUAL$126,000

8.2. Modelo de Ingresos (Revenue Streams)
8.2.1. Pricing Strategy
Tier 1: BÁSICO (Freemium)

Precio: Gratis
Límite: Hasta 3 vehículos
Features:

Tracking en vivo
Reportes básicos (últimos 7 días)
1 usuario admin
Soporte por email


Objetivo: Adquisición y evangelización (10% de usuarios se quedan aquí)

Tier 2: PROFESIONAL

Precio: $15 USD/vehículo/mes
Mínimo: 5 vehículos
Features:

Todo lo del plan Básico +
Historial completo (90 días)
Alertas avanzadas (geocercas, velocidad)
Reportes exportables (PDF, Excel)
Hasta 5 usuarios admin
Soporte email 24/7


Target: Flotas 5-50 vehículos (60% de clientes)

Tier 3: ENTERPRISE

Precio: $10 USD/vehículo/mes
Mínimo: 50 vehículos
Features:

Todo lo del plan Profesional +
AI predictivo (mantenimiento, comportamiento)
Dashboard Looker Studio personalizado
Integraciones API (ERP, TMS)
Usuarios ilimitados
Soporte dedicado + onboarding
SLA 99.5% uptime


Target: Flotas >50 vehículos (30% de clientes)

Tier 4: ENTERPRISE PLUS

Precio: Custom (cotización)
Features:

Todo lo anterior +
White-label
Despliegue on-premise
Desarrollo custom
Account manager dedicado


Target: Flotas >500 vehículos, multipaís


8.2.2. Proyecciones de Ingresos (5 Años)
Supuestos:

Adquisición mensual: 5 clientes/mes (Año 1), 10/mes (Año 2), 15/mes (Año 3+)
Promedio vehículos por cliente: 25 (Año 1), 30 (Año 2), 35 (Año 3+)
Churn rate: 10% anual
Mix de planes: 60% Professional, 30% Enterprise, 10% Básico/Plus
Precio promedio ponderado: $12 USD/veh/mes

┌─────────────────────────────────────────────────────────────────────┐
│                           AÑO 1                                     │
├─────────────────────────────────────────────────────────────────────┤
│ Clientes adquiridos: 5/mes × 12 = 60 clientes                      │
│ Vehículos promedio: 25                                             │
│ Total vehículos: 60 × 25 = 1,500                                   │
│ Churn: 10% → Vehículos netos: 1,350                                │
│                                                                     │
│ MRR (Monthly Recurring Revenue):                                    │
│   1,350 vehículos × $12/mes = $16,200/mes                          │
│                                                                     │
│ ARR (Annual Recurring Revenue):                                     │
│   $16,200 × 12 = $194,400                                          │
│                                                                     │
│ Revenue adicional (setup fees, custom dev): $30,000                │
│                                                                     │
│ TOTAL REVENUE AÑO 1: $224,400                                      │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│                           AÑO 2                                     │
├─────────────────────────────────────────────────────────────────────┤
│ Clientes nuevos: 10/mes × 12 = 120                                 │
│ Base existente: 54 (60 - 6 churn)                                  │
│ Total clientes: 174                                                │
│ Vehículos promedio: 30                                             │
│ Total vehículos: 174 × 30 = 5,220                                  │
│                                                                     │
│ ARR: 5,220 × $12 × 12 = $751,680                                   │
│ Revenue adicional: $80,000                                         │
│                                                                     │
│ TOTAL REVENUE AÑO 2: $831,680                                      │
│ Crecimiento vs Año 1: +271%                                        │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│                           AÑO 3                                     │
├─────────────────────────────────────────────────────────────────────┤
│ Clientes nuevos: 15/mes × 12 = 180                                 │
│ Base existente: 157 (174 - 17 churn)                               │
│ Total clientes: 337                                                │
│ Vehículos promedio: 35                                             │
│ Total vehículos: 337 × 35 = 11,795                                 │
│                                                                     │
│ ARR: 11,795 × $12 × 12 = $1,698,480                                │
│ Revenue adicional: $200,000                                        │
│                                                                     │
│ TOTAL REVENUE AÑO 3: $1,898,480                                    │
│ Crecimiento vs Año 2: +128%                                        │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│                           AÑO 4                                     │
├─────────────────────────────────────────────────────────────────────┤
│ Clientes nuevos: 15/mes × 12 = 180                                 │
│ Base existente: 303 (337 - 34 churn)                               │
│ Total clientes: 483                                                │
│ Vehículos promedio: 38                                             │
│ Total vehículos: 483 × 38 = 18,354                                 │
│                                                                     │
│ ARR: 18,354 × $12 × 12 = $2,643,000                                │
│ Revenue adicional: $380,000                                        │
│                                                                     │
│ TOTAL REVENUE AÑO 4: $3,023,000                                    │
│ Crecimiento vs Año 3: +59%                                         │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│                           AÑO 5                                     │
├─────────────────────────────────────────────────────────────────────┤
│ Clientes nuevos: 15/mes × 12 = 180                                 │
│ Base existente: 435 (483 - 48 churn)                               │
│ Total clientes: 615                                                │
│ Vehículos promedio: 40                                             │
│ Total vehículos: 615 × 40 = 24,600                                 │
│                                                                     │
│ ARR: 24,600 × $12 × 12 = $3,542,400                                │
│ Revenue adicional: $550,000                                        │
│                                                                     │
│ TOTAL REVENUE AÑO 5: $4,092,400                                    │
│ Crecimiento vs Año 4: +35%                                         │
└─────────────────────────────────────────────────────────────────────┘
Gráfico de Crecimiento:
Revenue
$4.5M │                                              ●
     │                                         ●
$4.0M│                                    ●
     │
$3.5M│                               ●
     │
$3.0M│
     │                          ●
$2.5M│
     │
$2.0M│                     ●
     │
$1.5M│
     │                ●
$1.0M│
     │
$0.5M│           ●
     │      ●
$0   └────┴────┴────┴────┴────┴────
       Año1 Año2 Año3 Año4 Año5

8.3. Análisis de Rentabilidad (P&L)
8.3.1. Profit & Loss Statement - Año 1
┌─────────────────────────────────────────────────────────────────────┐
│                        P&L - AÑO 1                                  │
├─────────────────────────────────────────────────────────────────────┤
│ INGRESOS                                                            │
│   Suscripciones (ARR)             $194,400                          │
│   Setup fees & custom             $30,000                           │
│   ─────────────────────────────────────                            │
│   TOTAL INGRESOS                 $224,400                           │
│                                                                     │
│ COSTOS DIRECTOS (COGS)                                              │
│   Infraestructura cloud           $8,600                            │
│   Mapas (Mapbox)                  $3,800                            │
│   Otros servicios                 $2,400                            │
│   ─────────────────────────────────────                            │
│   TOTAL COGS                     $14,800                            │
│                                                                     │
│ GROSS PROFIT                     $209,600                           │
│ Gross Margin                      93.4%                             │
│                                                                     │
│ GASTOS OPERATIVOS                                                   │
│   Desarrollo y mantenimiento     $173,000                           │
│   Marketing y ventas             $250,000                           │
│   Soporte al cliente             $126,000                           │
│   Administrativo (legal, cont)    $40,000                           │
│   Oficina y equipos               $30,000                           │
│   ─────────────────────────────────────                            │
│   TOTAL OPEX                     $619,000                           │
│                                                                     │
│ EBITDA                          -$409,400                           │
│ EBITDA Margin                    -182.4%                            │
│                                                                     │
│ Depreciación y amortización       $15,000                           │
│                                                                     │
│ NET INCOME (LOSS)               -$424,400                           │
│                                                                     │
│ 💡 Típico para SaaS en Año 1 (fase de inversión)                   │
└─────────────────────────────────────────────────────────────────────┘
8.3.2. P&L Proyectado - Años 2-5
┌─────────────────────────────────────────────────────────────────────┐
│                    PROYECCIÓN P&L - AÑOS 2-5                        │
├──────────┬──────────┬──────────┬──────────┬──────────────────────────┤
│          │  AÑO 2   │  AÑO 3   │  AÑO 4   │  AÑO 5                  │
├──────────┼──────────┼──────────┼──────────┼──────────────────────────┤
│ INGRESOS │          │          │          │                         │
│ ARR      │ $751,680 │$1,698,480│$2,643,000│$3,542,400               │
│ Otros    │  $80,000 │ $200,000 │ $380,000 │ $550,000                │
│ TOTAL    │ $831,680 │$1,898,480│$3,023,000│$4,092,400               │
│          │          │          │          │                         │
│ COGS     │  $35,000 │  $68,000 │  $95,000 │ $125,000                │
│          │          │          │          │                         │
│ GROSS    │ $796,680 │$1,830,480│$2,928,000│$3,967,400               │
│ Margin   │   95.8%  │   96.4%  │   96.9%  │   96.9%                 │
│          │          │          │          │                         │
│ OPEX     │ $750,000 │ $980,000 │$1,250,000│$1,550,000               │
│          │          │          │          │                         │
│ EBITDA   │  $46,680 │ $850,480 │$1,678,000│$2,417,400               │
│ Margin   │    5.6%  │   44.8%  │   55.5%  │   59.1%                 │
│          │          │          │          │                         │
│ NET      │  $25,000 │ $730,000 │$1,470,000│$2,150,000               │
│ INCOME   │          │          │          │                         │
└──────────┴──────────┴──────────┴──────────┴──────────────────────────┘
💡 Key Insights:

Breakeven: Alcanzado en Q3 del Año 2
Profitabilidad: Año 3 en adelante con márgenes >40%
Gross Margin: Excelente (>93%) típico de SaaS
Escalabilidad: OPEX crece más lento que Revenue (economías de escala)


8.4. Unit Economics
8.4.1. CAC (Customer Acquisition Cost)
CAC = (Marketing + Sales Costs) / New Customers Acquired

Año 1:
CAC = $250,000 / 60 = $4,167 por cliente

Año 2:
CAC = $270,000 / 120 = $2,250 por cliente

Año 3+:
CAC = $320,000 / 180 = $1,778 por cliente
CAC Payback Period:
Año 1:
Average Revenue per Customer = $16,200 × 12 / 60 = $3,240/año
CAC Payback = $4,167 / ($3,240/12) = 15.4 meses

Año 3:
Average Revenue per Customer = $6,660/año
CAC Payback = $1,778 / ($6,660/12) = 3.2 meses ✅