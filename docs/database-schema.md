# Database Schema Documentation

**Project:** SmartFleet Pro  
**Version:** 1.0  
**Last Updated:** November 21, 2025  
**Database:** Cloud Firestore (Firebase)

---

## Overview

SmartFleet Pro utiliza Cloud Firestore como base de datos NoSQL para almacenar todos los datos de la aplicación. El diseño sigue principios de **multi-tenancy** donde cada empresa (company) tiene datos aislados mediante el campo `company_id`.

### Principios de Diseño

1. **Multi-tenancy:** Todos los documentos incluyen `company_id` para aislamiento
2. **IDs Legibles:** Formato personalizado para debugging (COMP-2025-001, USR-2025-001, etc.)
3. **Timestamps:** Todos los documentos incluyen `created_at` y `updated_at`
4. **Denormalización Selectiva:** Se duplican algunos datos para optimizar queries
5. **Subcollections:** Para datos jerárquicos (route_points dentro de trips)

---

## Collections

### 1. Companies (companies)

**Purpose:** Representa empresas/organizaciones que usan la plataforma

**Document Path:** `companies/{companyId}`

**ID Format:** `COMP-YYYY-XXX` (e.g., `COMP-2025-001`)

#### Schema

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | ✅ | Company ID (COMP-YYYY-XXX) |
| `name` | string | ✅ | Nombre de la empresa |
| `email` | string | ✅ | Email de contacto |
| `phone` | string | ✅ | Teléfono de contacto |
| `address` | object | ✅ | Dirección completa |
| `address.street` | string | ✅ | Calle y número |
| `address.city` | string | ✅ | Ciudad |
| `address.state` | string | ✅ | Estado/Departamento |
| `address.country` | string | ✅ | País |
| `address.postal_code` | string | ✅ | Código postal |
| `tax_id` | string | ❌ | NIT, RUT, RFC (identificación fiscal) |
| `logo_url` | string | ❌ | URL del logo (Cloud Storage) |
| `plan` | enum | ✅ | Plan de suscripción: `free`, `basic`, `premium`, `enterprise` |
| `max_users` | number | ✅ | Límite de usuarios |
| `max_vehicles` | number | ✅ | Límite de vehículos |
| `settings` | object | ✅ | Configuración de la empresa |
| `settings.timezone` | string | ✅ | Zona horaria (e.g., `America/Bogota`) |
| `settings.currency` | string | ✅ | Moneda (e.g., `COP`, `USD`) |
| `settings.language` | string | ✅ | Idioma (e.g., `es`, `en`) |
| `is_active` | boolean | ✅ | Estado activo/inactivo |
| `created_at` | timestamp | ✅ | Fecha de creación (serverTimestamp) |
| `updated_at` | timestamp | ✅ | Fecha de última actualización |

#### Example Document

```json
{
  "id": "COMP-2025-001",
  "name": "Demo Transport Company",
  "email": "contact@demo-transport.com",
  "phone": "+57 300 123 4567",
  "address": {
    "street": "Calle 123 #45-67",
    "city": "Bogotá",
    "state": "Cundinamarca",
    "country": "Colombia",
    "postal_code": "110111"
  },
  "tax_id": "900123456-7",
  "plan": "premium",
  "max_users": 50,
  "max_vehicles": 20,
  "settings": {
    "timezone": "America/Bogota",
    "currency": "COP",
    "language": "es"
  },
  "is_active": true,
  "created_at": "2025-11-21T10:00:00Z",
  "updated_at": "2025-11-21T10:00:00Z"
}
```

---

### 2. Users (users)

**Purpose:** Usuarios de la plataforma (admins, supervisores, conductores)

**Document Path:** `users/{userId}`

**ID Format:** `USR-YYYY-XXX` (e.g., `USR-2025-001`)

#### Schema

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | ✅ | User ID (USR-YYYY-XXX) |
| `company_id` | string | ✅ | Reference a companies/{id} |
| `firebase_uid` | string | ✅ | UID de Firebase Authentication |
| `email` | string | ✅ | Email del usuario |
| `first_name` | string | ✅ | Nombre |
| `last_name` | string | ✅ | Apellido |
| `full_name` | string | ✅ | Nombre completo (computed) |
| `phone` | string | ❌ | Teléfono |
| `photo_url` | string | ❌ | URL de foto de perfil |
| `role` | enum | ✅ | Rol: `admin`, `supervisor`, `driver` |
| `driver_info` | object | ❌ | Info adicional (solo si role=driver) |
| `driver_info.license_number` | string | ✅* | Número de licencia |
| `driver_info.license_expiry` | timestamp | ✅* | Fecha de vencimiento |
| `driver_info.license_type` | string | ✅* | Tipo de licencia (A, B, C) |
| `driver_info.assigned_vehicle_id` | string | ❌ | ID del vehículo asignado |
| `is_active` | boolean | ✅ | Estado activo/inactivo |
| `last_login_at` | timestamp | ❌ | Última vez que inició sesión |
| `created_at` | timestamp | ✅ | Fecha de creación |
| `updated_at` | timestamp | ✅ | Fecha de actualización |

**\* Required solo si `role === 'driver'`**

#### Example Document (Driver)

```json
{
  "id": "USR-2025-002",
  "company_id": "COMP-2025-001",
  "firebase_uid": "xYz123AbC456",
  "email": "driver1@demo-transport.com",
  "first_name": "Juan",
  "last_name": "Conductor",
  "full_name": "Juan Conductor",
  "phone": "+57 300 222 2222",
  "role": "driver",
  "driver_info": {
    "license_number": "COL-12345678",
    "license_expiry": "2026-11-21T00:00:00Z",
    "license_type": "C2",
    "assigned_vehicle_id": "VEH-2025-001"
  },
  "is_active": true,
  "last_login_at": "2025-11-21T09:30:00Z",
  "created_at": "2025-11-21T08:00:00Z",
  "updated_at": "2025-11-21T09:30:00Z"
}
```

---

### 3. Vehicles (vehicles)

**Purpose:** Vehículos de la flota

**Document Path:** `vehicles/{vehicleId}`

**ID Format:** `VEH-YYYY-XXX` (e.g., `VEH-2025-001`)

#### Schema

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | ✅ | Vehicle ID (VEH-YYYY-XXX) |
| `company_id` | string | ✅ | Reference a companies/{id} |
| `plate` | string | ✅ | Placa del vehículo |
| `brand` | string | ✅ | Marca (Toyota, Ford, etc.) |
| `model` | string | ✅ | Modelo (Hilux, F-150, etc.) |
| `year` | number | ✅ | Año del vehículo |
| `color` | string | ✅ | Color |
| `vehicle_type` | enum | ✅ | Tipo: `sedan`, `suv`, `van`, `truck`, `bus`, `motorcycle` |
| `vin` | string | ❌ | VIN (Vehicle Identification Number) |
| `engine_number` | string | ❌ | Número de motor |
| `assigned_driver_id` | string | ❌ | Reference a users/{id} |
| `current_location` | object | ❌ | Última ubicación conocida |
| `current_location.latitude` | number | ✅* | Latitud |
| `current_location.longitude` | number | ✅* | Longitud |
| `current_location.timestamp` | timestamp | ✅* | Timestamp de la ubicación |
| `odometer_km` | number | ✅ | Odómetro actual (km) |
| `last_odometer_update` | timestamp | ✅ | Última actualización del odómetro |
| `last_maintenance_date` | timestamp | ❌ | Fecha del último mantenimiento |
| `next_maintenance_km` | number | ❌ | Kilómetros para próximo mantenimiento |
| `status` | enum | ✅ | Estado: `active`, `inactive`, `maintenance`, `out_of_service` |
| `insurance` | object | ❌ | Información del seguro |
| `insurance.provider` | string | ✅* | Aseguradora |
| `insurance.policy_number` | string | ✅* | Número de póliza |
| `insurance.expiry_date` | timestamp | ✅* | Fecha de vencimiento |
| `gps_device_id` | string | ❌ | ID del dispositivo GPS |
| `gps_device_imei` | string | ❌ | IMEI del dispositivo GPS |
| `created_at` | timestamp | ✅ | Fecha de creación |
| `updated_at` | timestamp | ✅ | Fecha de actualización |

#### Example Document

```json
{
  "id": "VEH-2025-001",
  "company_id": "COMP-2025-001",
  "plate": "ABC-123",
  "brand": "Toyota",
  "model": "Hilux",
  "year": 2022,
  "color": "Blanco",
  "vehicle_type": "truck",
  "vin": "1HGBH41JXMN109186",
  "assigned_driver_id": "USR-2025-002",
  "current_location": {
    "latitude": 4.6097,
    "longitude": -74.0817,
    "timestamp": "2025-11-21T10:00:00Z"
  },
  "odometer_km": 45000,
  "last_odometer_update": "2025-11-21T10:00:00Z",
  "last_maintenance_date": "2025-10-21T00:00:00Z",
  "next_maintenance_km": 50000,
  "status": "active",
  "insurance": {
    "provider": "Seguros Bolívar",
    "policy_number": "POL-2025-001",
    "expiry_date": "2026-05-21T00:00:00Z"
  },
  "created_at": "2025-11-21T08:00:00Z",
  "updated_at": "2025-11-21T10:00:00Z"
}
```

---

### 4. Trips (trips)

**Purpose:** Viajes/rutas realizadas por vehículos

**Document Path:** `trips/{tripId}`

**ID Format:** `TRIP-YYYYMMDD-XXXX` (e.g., `TRIP-20251121-0001`)

#### Schema

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | ✅ | Trip ID (TRIP-YYYYMMDD-XXXX) |
| `company_id` | string | ✅ | Reference a companies/{id} |
| `vehicle_id` | string | ✅ | Reference a vehicles/{id} |
| `driver_id` | string | ✅ | Reference a users/{id} |
| `origin` | object | ✅ | Origen del viaje |
| `origin.address` | string | ✅ | Dirección textual |
| `origin.latitude` | number | ✅ | Latitud |
| `origin.longitude` | number | ✅ | Longitud |
| `destination` | object | ✅ | Destino del viaje |
| `destination.address` | string | ✅ | Dirección textual |
| `destination.latitude` | number | ✅ | Latitud |
| `destination.longitude` | number | ✅ | Longitud |
| `scheduled_start` | timestamp | ✅ | Hora programada de inicio |
| `actual_start` | timestamp | ❌ | Hora real de inicio |
| `scheduled_end` | timestamp | ❌ | Hora programada de fin |
| `actual_end` | timestamp | ❌ | Hora real de fin |
| `planned_distance_km` | number | ❌ | Distancia planificada (km) |
| `actual_distance_km` | number | ❌ | Distancia real (km) |
| `status` | enum | ✅ | Estado: `scheduled`, `in_progress`, `completed`, `cancelled` |
| `stats` | object | ❌ | Estadísticas del viaje |
| `stats.max_speed_kmh` | number | ✅* | Velocidad máxima |
| `stats.avg_speed_kmh` | number | ✅* | Velocidad promedio |
| `stats.total_stops` | number | ✅* | Total de paradas |
| `stats.total_idle_time_minutes` | number | ✅* | Tiempo en ralentí (minutos) |
| `notes` | string | ❌ | Notas adicionales |
| `cancellation_reason` | string | ❌ | Razón de cancelación |
| `cancelled_at` | timestamp | ❌ | Fecha de cancelación |
| `cancelled_by` | string | ❌ | User ID quien canceló |
| `created_at` | timestamp | ✅ | Fecha de creación |
| `updated_at` | timestamp | ✅ | Fecha de actualización |

#### Example Document

```json
{
  "id": "TRIP-20251121-0001",
  "company_id": "COMP-2025-001",
  "vehicle_id": "VEH-2025-001",
  "driver_id": "USR-2025-002",
  "origin": {
    "address": "Calle 26 #68-91, Bogotá",
    "latitude": 4.6280,
    "longitude": -74.1202
  },
  "destination": {
    "address": "Carrera 7 #32-16, Bogotá",
    "latitude": 4.6200,
    "longitude": -74.0656
  },
  "scheduled_start": "2025-11-21T14:00:00Z",
  "actual_start": "2025-11-21T14:05:00Z",
  "scheduled_end": "2025-11-21T15:30:00Z",
  "actual_end": "2025-11-21T15:25:00Z",
  "planned_distance_km": 12.5,
  "actual_distance_km": 13.2,
  "status": "completed",
  "stats": {
    "max_speed_kmh": 65,
    "avg_speed_kmh": 35,
    "total_stops": 3,
    "total_idle_time_minutes": 15
  },
  "notes": "Entrega completada sin incidentes",
  "created_at": "2025-11-21T12:00:00Z",
  "updated_at": "2025-11-21T15:25:00Z"
}
```

---

### 5. Route Points (trips/{tripId}/route_points)

**Purpose:** Puntos GPS del recorrido de un viaje (subcollection)

**Document Path:** `trips/{tripId}/route_points/{pointId}`

**ID Format:** Timestamp en milisegundos (para ordenamiento natural)

#### Schema

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | ✅ | Timestamp ID (milliseconds) |
| `latitude` | number | ✅ | Latitud |
| `longitude` | number | ✅ | Longitud |
| `accuracy` | number | ✅ | Precisión GPS (metros) |
| `speed_kmh` | number | ✅ | Velocidad (km/h) |
| `heading` | number | ✅ | Dirección (0-360 grados) |
| `altitude` | number | ❌ | Altitud (metros sobre el nivel del mar) |
| `is_moving` | boolean | ✅ | Si el vehículo está en movimiento |
| `is_idle` | boolean | ✅ | Si el vehículo está en ralentí |
| `timestamp` | timestamp | ✅ | Timestamp del punto |
| `device_info` | object | ❌ | Info del dispositivo (opcional) |
| `device_info.battery_level` | number | ❌ | Nivel de batería (0-100) |
| `device_info.signal_strength` | number | ❌ | Fuerza de señal |

#### Example Document

```json
{
  "id": "1700568000123",
  "latitude": 4.6280,
  "longitude": -74.1202,
  "accuracy": 5.2,
  "speed_kmh": 45,
  "heading": 180,
  "altitude": 2640,
  "is_moving": true,
  "is_idle": false,
  "timestamp": "2025-11-21T14:05:30Z",
  "device_info": {
    "battery_level": 85,
    "signal_strength": 4
  }
}
```

---

## Composite Indexes

Los siguientes índices compuestos están definidos en `firestore.indexes.json`:

### Users Collection

1. **Query by company, role, and active status:**
   - `company_id` (ASC) + `role` (ASC) + `is_active` (ASC)
   - Use case: Listar conductores activos de una empresa

2. **Query active users by creation date:**
   - `company_id` (ASC) + `is_active` (ASC) + `created_at` (DESC)
   - Use case: Usuarios más recientes

### Vehicles Collection

3. **Query by company, status, and date:**
   - `company_id` (ASC) + `status` (ASC) + `created_at` (DESC)
   - Use case: Vehículos activos ordenados por fecha

4. **Query by company, driver, and status:**
   - `company_id` (ASC) + `assigned_driver_id` (ASC) + `status` (ASC)
   - Use case: Vehículos asignados a un conductor específico

### Trips Collection

5. **Query by company, status, and scheduled start:**
   - `company_id` (ASC) + `status` (ASC) + `scheduled_start` (DESC)
   - Use case: Viajes en progreso más recientes

6. **Query by company, driver, and status:**
   - `company_id` (ASC) + `driver_id` (ASC) + `status` (ASC)
   - Use case: Viajes de un conductor específico

7. **Query by company, vehicle, and date:**
   - `company_id` (ASC) + `vehicle_id` (ASC) + `scheduled_start` (DESC)
   - Use case: Historial de viajes de un vehículo

8. **Query by company and creation date:**
   - `company_id` (ASC) + `created_at` (DESC)
   - Use case: Todos los viajes ordenados por fecha

### Route Points Collection

9. **Query by timestamp:**
   - `timestamp` (ASC)
   - Use case: Obtener puntos GPS en orden cronológico

---

## Example Queries

### TypeScript Examples

```typescript
import * as admin from 'firebase-admin';
const db = admin.firestore();

// Get all active drivers for a company
const driversQuery = await db.collection('users')
  .where('company_id', '==', 'COMP-2025-001')
  .where('role', '==', 'driver')
  .where('is_active', '==', true)
  .get();

// Get in-progress trips for a company
const tripsQuery = await db.collection('trips')
  .where('company_id', '==', 'COMP-2025-001')
  .where('status', '==', 'in_progress')
  .orderBy('scheduled_start', 'desc')
  .get();

// Get route points for a trip
const routePoints = await db.collection('trips')
  .doc('TRIP-20251121-0001')
  .collection('route_points')
  .orderBy('timestamp', 'asc')
  .get();

// Get vehicles assigned to a driver
const vehiclesQuery = await db.collection('vehicles')
  .where('company_id', '==', 'COMP-2025-001')
  .where('assigned_driver_id', '==', 'USR-2025-002')
  .where('status', '==', 'active')
  .get();
```

---

## Data Validation Rules

### Companies
- `name`: Required, min 2 chars, max 100 chars
- `email`: Valid email format
- `phone`: Valid phone format
- `plan`: One of: `free`, `basic`, `premium`, `enterprise`

### Users
- `email`: Valid email format, unique per company
- `role`: One of: `admin`, `supervisor`, `driver`
- `driver_info`: Required if role === 'driver'

### Vehicles
- `plate`: Required, unique per company
- `year`: Between 1900 and current year + 1
- `status`: One of: `active`, `inactive`, `maintenance`, `out_of_service`
- `odometer_km`: Non-negative number

### Trips
- `status`: One of: `scheduled`, `in_progress`, `completed`, `cancelled`
- `actual_start`: Must be >= scheduled_start
- `actual_end`: Must be >= actual_start

---

## Security Considerations

1. **Multi-tenancy:** All queries MUST include `company_id` filter
2. **Role-based access:** Firestore rules enforce role-based permissions
3. **Data isolation:** Companies cannot access each other's data
4. **Audit trail:** `created_at` and `updated_at` track all changes
5. **Soft deletes:** Consider using `is_deleted` flag instead of actual deletes

---

## Migration Strategy

### Adding New Fields
- Use optional fields to maintain backward compatibility
- Update TypeScript interfaces
- Deploy Cloud Functions that backfill data if needed

### Changing Field Types
1. Add new field with new type
2. Create migration function to copy data
3. Update code to use new field
4. Deprecate old field (document in comments)
5. Remove old field after grace period

---

## Performance Optimization

1. **Denormalization:** Consider duplicating frequently accessed data
2. **Batch Operations:** Use batched writes for multiple updates
3. **Pagination:** Use `limit()` and `startAfter()` for large datasets
4. **Caching:** Cache frequently accessed, rarely changing data
5. **Subcollections:** Use for large nested datasets (route_points)

---

## Backup & Recovery

- **Firestore Automatic Backups:** Enabled at project level
- **Export Schedule:** Weekly exports to Cloud Storage
- **Point-in-time Recovery:** Available for 7 days
- **Disaster Recovery Plan:** Documented in ops manual

---

## Related Documentation

- [Firestore Best Practices](https://firebase.google.com/docs/firestore/best-practices)
- [Security Rules Guide](../firebase/firestore.rules)
- [TypeScript Models](../firebase/functions/src/types/models.ts)
- [Seed Data Script](../firebase/functions/src/scripts/seedData.ts)

---

**Last Updated:** November 21, 2025  
**Maintained by:** SmartFleet Pro Development Team  
**Review Schedule:** Monthly
