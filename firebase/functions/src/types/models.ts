/**
 * SmartFleet Pro - Data Models
 * TypeScript interfaces for Firestore collections
 * 
 * Multi-tenancy: All documents include company_id for data isolation
 * Timestamps: All documents include created_at and updated_at
 * IDs: Custom format for easy debugging (COMP-YYYY-XXX, USR-YYYY-XXX, etc.)
 */

// ============================================
// Base Types & Enums
// ============================================

export type Timestamp = FirebaseFirestore.Timestamp;

export enum UserRole {
  ADMIN = 'admin',
  SUPERVISOR = 'supervisor',
  DRIVER = 'driver',
}

export enum VehicleStatus {
  ACTIVE = 'active',
  INACTIVE = 'inactive',
  MAINTENANCE = 'maintenance',
  OUT_OF_SERVICE = 'out_of_service',
}

export enum TripStatus {
  SCHEDULED = 'scheduled',
  IN_PROGRESS = 'in_progress',
  COMPLETED = 'completed',
  CANCELLED = 'cancelled',
}

export enum VehicleType {
  SEDAN = 'sedan',
  SUV = 'suv',
  VAN = 'van',
  TRUCK = 'truck',
  BUS = 'bus',
  MOTORCYCLE = 'motorcycle',
}

// ============================================
// Base Document Interface
// ============================================

export interface BaseDocument {
  created_at: Timestamp;
  updated_at: Timestamp;
  company_id: string;
}

// ============================================
// Company Collection
// ============================================

export interface Company {
  id: string; // Format: COMP-YYYY-XXX (e.g., COMP-2025-001)
  name: string;
  email: string;
  phone: string;
  address: {
    street: string;
    city: string;
    state: string;
    country: string;
    postal_code: string;
  };
  tax_id?: string; // RUT, RFC, NIT, etc.
  logo_url?: string;
  
  // Subscription info (for future billing)
  plan: 'free' | 'basic' | 'premium' | 'enterprise';
  max_users: number;
  max_vehicles: number;
  
  // Settings
  settings: {
    timezone: string; // e.g., 'America/Bogota'
    currency: string; // e.g., 'COP', 'USD'
    language: string; // e.g., 'es', 'en'
  };
  
  // Status
  is_active: boolean;
  
  // Timestamps
  created_at: Timestamp;
  updated_at: Timestamp;
}

// ============================================
// User Collection
// ============================================

export interface User extends BaseDocument {
  id: string; // Format: USR-YYYY-XXX (e.g., USR-2025-001)
  
  // Auth info
  firebase_uid: string; // Firebase Auth UID
  email: string;
  
  // Personal info
  first_name: string;
  last_name: string;
  full_name: string; // Computed: first_name + last_name
  phone?: string;
  photo_url?: string;
  
  // Role & permissions
  role: UserRole;
  
  // Driver-specific fields (only if role === 'driver')
  driver_info?: {
    license_number: string;
    license_expiry: Timestamp;
    license_type: string; // A, B, C, etc.
    assigned_vehicle_id?: string; // Reference to vehicles/{id}
  };
  
  // Status
  is_active: boolean;
  last_login_at?: Timestamp;
}

// ============================================
// Vehicle Collection
// ============================================

export interface Vehicle extends BaseDocument {
  id: string; // Format: VEH-YYYY-XXX (e.g., VEH-2025-001)
  
  // Basic info
  plate: string; // License plate
  brand: string; // e.g., 'Toyota', 'Ford'
  model: string; // e.g., 'Corolla', 'F-150'
  year: number;
  color: string;
  vehicle_type: VehicleType;
  
  // Technical info
  vin?: string; // Vehicle Identification Number
  engine_number?: string;
  
  // Current assignment
  assigned_driver_id?: string; // Reference to users/{id}
  
  // Tracking
  current_location?: {
    latitude: number;
    longitude: number;
    timestamp: Timestamp;
  };
  
  // Odometer
  odometer_km: number;
  last_odometer_update: Timestamp;
  
  // Maintenance
  last_maintenance_date?: Timestamp;
  next_maintenance_km?: number;
  
  // Status
  status: VehicleStatus;
  
  // Insurance (optional)
  insurance?: {
    provider: string;
    policy_number: string;
    expiry_date: Timestamp;
  };
  
  // GPS Device info (for future integration)
  gps_device_id?: string;
  gps_device_imei?: string;
}

// ============================================
// Trip Collection
// ============================================

export interface Trip extends BaseDocument {
  id: string; // Format: TRIP-YYYYMMDD-XXXX (e.g., TRIP-20251121-0001)
  
  // References
  vehicle_id: string; // Reference to vehicles/{id}
  driver_id: string; // Reference to users/{id}
  
  // Route info
  origin: {
    address: string;
    latitude: number;
    longitude: number;
  };
  destination: {
    address: string;
    latitude: number;
    longitude: number;
  };
  
  // Timing
  scheduled_start: Timestamp;
  actual_start?: Timestamp;
  scheduled_end?: Timestamp;
  actual_end?: Timestamp;
  
  // Distance
  planned_distance_km?: number;
  actual_distance_km?: number;
  
  // Status
  status: TripStatus;
  
  // Stats (computed from route_points subcollection)
  stats?: {
    max_speed_kmh: number;
    avg_speed_kmh: number;
    total_stops: number;
    total_idle_time_minutes: number;
  };
  
  // Notes
  notes?: string;
  
  // Cancellation (if status === 'cancelled')
  cancellation_reason?: string;
  cancelled_at?: Timestamp;
  cancelled_by?: string; // User ID who cancelled
}

// ============================================
// Trip Route Points (Subcollection)
// ============================================
// Collection path: trips/{tripId}/route_points/{pointId}

export interface RoutePoint {
  id: string; // Auto-generated or timestamp-based
  
  // Location
  latitude: number;
  longitude: number;
  accuracy: number; // GPS accuracy in meters
  
  // Telemetry
  speed_kmh: number;
  heading: number; // Degrees (0-360)
  altitude?: number; // Meters above sea level
  
  // Status
  is_moving: boolean;
  is_idle: boolean;
  
  // Timestamp
  timestamp: Timestamp;
  
  // Optional: Battery, signal strength, etc. (for future)
  device_info?: {
    battery_level?: number;
    signal_strength?: number;
  };
}

// ============================================
// Firestore Collection Names (Constants)
// ============================================

export const COLLECTIONS = {
  COMPANIES: 'companies',
  USERS: 'users',
  VEHICLES: 'vehicles',
  TRIPS: 'trips',
  ROUTE_POINTS: 'route_points', // Subcollection of trips
} as const;

// ============================================
// Type Guards
// ============================================

export function isDriver(user: User): boolean {
  return user.role === UserRole.DRIVER;
}

export function isAdmin(user: User): boolean {
  return user.role === UserRole.ADMIN;
}

export function isSupervisor(user: User): boolean {
  return user.role === UserRole.SUPERVISOR;
}

export function isActiveVehicle(vehicle: Vehicle): boolean {
  return vehicle.status === VehicleStatus.ACTIVE;
}

export function isActiveTripStatus(status: TripStatus): boolean {
  return status === TripStatus.IN_PROGRESS || status === TripStatus.SCHEDULED;
}

// ============================================
// Validation Types (for runtime validation)
// ============================================

export interface CreateCompanyInput {
  name: string;
  email: string;
  phone: string;
  address: Company['address'];
  tax_id?: string;
  timezone?: string;
  currency?: string;
  language?: string;
}

export interface CreateUserInput {
  firebase_uid: string;
  email: string;
  first_name: string;
  last_name: string;
  phone?: string;
  role: UserRole;
  company_id: string;
  driver_info?: User['driver_info'];
}

export interface CreateVehicleInput {
  plate: string;
  brand: string;
  model: string;
  year: number;
  color: string;
  vehicle_type: VehicleType;
  company_id: string;
  vin?: string;
  assigned_driver_id?: string;
  odometer_km?: number;
}

export interface CreateTripInput {
  vehicle_id: string;
  driver_id: string;
  company_id: string;
  origin: Trip['origin'];
  destination: Trip['destination'];
  scheduled_start: Date | Timestamp;
  scheduled_end?: Date | Timestamp;
  notes?: string;
}
