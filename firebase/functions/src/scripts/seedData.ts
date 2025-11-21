/**
 * SmartFleet Pro - Seed Data Script
 * Populates Firestore with initial test data
 * 
 * Usage:
 *   npm run seed (from functions directory)
 * 
 * Creates:
 * - 1 company
 * - 3 users (1 admin, 2 drivers)
 * - 2 vehicles
 * - 5 trips (various statuses)
 */

import * as admin from 'firebase-admin';
import { initializeFirebaseAdmin, getFirestore } from '../config/firebase';
import {
  Company,
  User,
  Vehicle,
  Trip,
  UserRole,
  VehicleStatus,
  VehicleType,
  TripStatus,
  COLLECTIONS,
} from '../types/models';
import {
  generateCompanyId,
  generateUserId,
  generateVehicleId,
  generateTripId,
  resetCounters,
} from '../utils/idGenerator';

// Initialize Firebase Admin
initializeFirebaseAdmin();

const db = getFirestore();
const Timestamp = admin.firestore.Timestamp;

// ============================================
// Seed Data Configuration
// ============================================

const SEED_CONFIG = {
  clearExisting: true, // Set to false to keep existing data
  companyName: 'Demo Transport Company',
  adminEmail: 'admin@demo-transport.com',
  driverEmails: ['driver1@demo-transport.com', 'driver2@demo-transport.com'],
};

// ============================================
// Helper Functions
// ============================================

/**
 * Clear existing data from collections
 */
async function clearCollections(): Promise<void> {
  console.log('🗑️  Clearing existing data...');
  
  const collections = [
    COLLECTIONS.COMPANIES,
    COLLECTIONS.USERS,
    COLLECTIONS.VEHICLES,
    COLLECTIONS.TRIPS,
  ];
  
  for (const collectionName of collections) {
    const snapshot = await db.collection(collectionName).get();
    
    if (!snapshot.empty) {
      const batch = db.batch();
      snapshot.docs.forEach((doc) => {
        batch.delete(doc.ref);
      });
      await batch.commit();
      console.log(`   ✓ Cleared ${snapshot.size} documents from ${collectionName}`);
    }
  }
  
  // Reset ID counters
  await resetCounters();
  console.log('   ✓ Reset ID counters');
}

/**
 * Create a timestamp from days offset
 */
function daysFromNow(days: number): admin.firestore.Timestamp {
  const date = new Date();
  date.setDate(date.getDate() + days);
  return Timestamp.fromDate(date);
}

/**
 * Create a timestamp from hours offset
 */
function hoursFromNow(hours: number): admin.firestore.Timestamp {
  const date = new Date();
  date.setHours(date.getHours() + hours);
  return Timestamp.fromDate(date);
}

// ============================================
// Seed Data Functions
// ============================================

/**
 * Create seed company
 */
async function createCompany(): Promise<Company> {
  console.log('\n🏢 Creating company...');
  
  const companyId = await generateCompanyId();
  const now = Timestamp.now();
  
  const company: Company = {
    id: companyId,
    name: SEED_CONFIG.companyName,
    email: 'contact@demo-transport.com',
    phone: '+57 300 123 4567',
    address: {
      street: 'Calle 123 #45-67',
      city: 'Bogotá',
      state: 'Cundinamarca',
      country: 'Colombia',
      postal_code: '110111',
    },
    tax_id: '900123456-7',
    plan: 'premium',
    max_users: 50,
    max_vehicles: 20,
    settings: {
      timezone: 'America/Bogota',
      currency: 'COP',
      language: 'es',
    },
    is_active: true,
    created_at: now,
    updated_at: now,
  };
  
  await db.collection(COLLECTIONS.COMPANIES).doc(companyId).set(company);
  console.log(`   ✓ Created company: ${companyId} - ${company.name}`);
  
  return company;
}

/**
 * Create seed users
 */
async function createUsers(companyId: string): Promise<User[]> {
  console.log('\n👥 Creating users...');
  
  const users: User[] = [];
  const now = Timestamp.now();
  
  // Admin user
  const adminId = await generateUserId();
  const admin: User = {
    id: adminId,
    firebase_uid: `firebase_${adminId}`, // Mock UID for seed data
    email: SEED_CONFIG.adminEmail,
    first_name: 'Carlos',
    last_name: 'Administrador',
    full_name: 'Carlos Administrador',
    phone: '+57 300 111 1111',
    role: UserRole.ADMIN,
    company_id: companyId,
    is_active: true,
    created_at: now,
    updated_at: now,
  };
  
  await db.collection(COLLECTIONS.USERS).doc(adminId).set(admin);
  users.push(admin);
  console.log(`   ✓ Created admin: ${adminId} - ${admin.full_name}`);
  
  // Driver 1
  const driver1Id = await generateUserId();
  const driver1: User = {
    id: driver1Id,
    firebase_uid: `firebase_${driver1Id}`,
    email: SEED_CONFIG.driverEmails[0],
    first_name: 'Juan',
    last_name: 'Conductor',
    full_name: 'Juan Conductor',
    phone: '+57 300 222 2222',
    role: UserRole.DRIVER,
    company_id: companyId,
    driver_info: {
      license_number: 'COL-12345678',
      license_expiry: daysFromNow(365),
      license_type: 'C2',
    },
    is_active: true,
    created_at: now,
    updated_at: now,
  };
  
  await db.collection(COLLECTIONS.USERS).doc(driver1Id).set(driver1);
  users.push(driver1);
  console.log(`   ✓ Created driver: ${driver1Id} - ${driver1.full_name}`);
  
  // Driver 2
  const driver2Id = await generateUserId();
  const driver2: User = {
    id: driver2Id,
    firebase_uid: `firebase_${driver2Id}`,
    email: SEED_CONFIG.driverEmails[1],
    first_name: 'María',
    last_name: 'Transportista',
    full_name: 'María Transportista',
    phone: '+57 300 333 3333',
    role: UserRole.DRIVER,
    company_id: companyId,
    driver_info: {
      license_number: 'COL-87654321',
      license_expiry: daysFromNow(730),
      license_type: 'C2',
    },
    is_active: true,
    created_at: now,
    updated_at: now,
  };
  
  await db.collection(COLLECTIONS.USERS).doc(driver2Id).set(driver2);
  users.push(driver2);
  console.log(`   ✓ Created driver: ${driver2Id} - ${driver2.full_name}`);
  
  return users;
}

/**
 * Create seed vehicles
 */
async function createVehicles(companyId: string, driverIds: string[]): Promise<Vehicle[]> {
  console.log('\n🚗 Creating vehicles...');
  
  const vehicles: Vehicle[] = [];
  const now = Timestamp.now();
  
  // Vehicle 1 - Toyota Hilux (assigned to driver 1)
  const vehicle1Id = await generateVehicleId();
  const vehicle1: Vehicle = {
    id: vehicle1Id,
    plate: 'ABC-123',
    brand: 'Toyota',
    model: 'Hilux',
    year: 2022,
    color: 'Blanco',
    vehicle_type: VehicleType.TRUCK,
    vin: '1HGBH41JXMN109186',
    assigned_driver_id: driverIds[0],
    current_location: {
      latitude: 4.6097,
      longitude: -74.0817,
      timestamp: now,
    },
    odometer_km: 45000,
    last_odometer_update: now,
    last_maintenance_date: daysFromNow(-30),
    next_maintenance_km: 50000,
    status: VehicleStatus.ACTIVE,
    insurance: {
      provider: 'Seguros Bolívar',
      policy_number: 'POL-2025-001',
      expiry_date: daysFromNow(180),
    },
    company_id: companyId,
    created_at: now,
    updated_at: now,
  };
  
  await db.collection(COLLECTIONS.VEHICLES).doc(vehicle1Id).set(vehicle1);
  vehicles.push(vehicle1);
  console.log(`   ✓ Created vehicle: ${vehicle1Id} - ${vehicle1.brand} ${vehicle1.model} (${vehicle1.plate})`);
  
  // Vehicle 2 - Chevrolet NPR (assigned to driver 2)
  const vehicle2Id = await generateVehicleId();
  const vehicle2: Vehicle = {
    id: vehicle2Id,
    plate: 'XYZ-789',
    brand: 'Chevrolet',
    model: 'NPR',
    year: 2021,
    color: 'Azul',
    vehicle_type: VehicleType.TRUCK,
    vin: '2HGBH41JXMN109187',
    assigned_driver_id: driverIds[1],
    current_location: {
      latitude: 4.6517,
      longitude: -74.0574,
      timestamp: now,
    },
    odometer_km: 62000,
    last_odometer_update: now,
    last_maintenance_date: daysFromNow(-15),
    next_maintenance_km: 65000,
    status: VehicleStatus.ACTIVE,
    insurance: {
      provider: 'Seguros del Estado',
      policy_number: 'POL-2025-002',
      expiry_date: daysFromNow(270),
    },
    company_id: companyId,
    created_at: now,
    updated_at: now,
  };
  
  await db.collection(COLLECTIONS.VEHICLES).doc(vehicle2Id).set(vehicle2);
  vehicles.push(vehicle2);
  console.log(`   ✓ Created vehicle: ${vehicle2Id} - ${vehicle2.brand} ${vehicle2.model} (${vehicle2.plate})`);
  
  return vehicles;
}

/**
 * Create seed trips
 */
async function createTrips(
  companyId: string,
  vehicleIds: string[],
  driverIds: string[]
): Promise<Trip[]> {
  console.log('\n🗺️  Creating trips...');
  
  const trips: Trip[] = [];
  const now = Timestamp.now();
  
  // Trip 1 - Scheduled (future)
  const trip1Id = await generateTripId();
  const trip1: Trip = {
    id: trip1Id,
    vehicle_id: vehicleIds[0],
    driver_id: driverIds[0],
    company_id: companyId,
    origin: {
      address: 'Calle 26 #68-91, Bogotá',
      latitude: 4.6280,
      longitude: -74.1202,
    },
    destination: {
      address: 'Carrera 7 #32-16, Bogotá',
      latitude: 4.6200,
      longitude: -74.0656,
    },
    scheduled_start: hoursFromNow(2),
    scheduled_end: hoursFromNow(4),
    planned_distance_km: 12.5,
    status: TripStatus.SCHEDULED,
    notes: 'Entrega de mercancía en el centro',
    created_at: now,
    updated_at: now,
  };
  
  await db.collection(COLLECTIONS.TRIPS).doc(trip1Id).set(trip1);
  trips.push(trip1);
  console.log(`   ✓ Created trip: ${trip1Id} - ${trip1.status}`);
  
  // Trip 2 - In Progress
  const trip2Id = await generateTripId();
  const trip2: Trip = {
    id: trip2Id,
    vehicle_id: vehicleIds[1],
    driver_id: driverIds[1],
    company_id: companyId,
    origin: {
      address: 'Autopista Norte #123-45, Bogotá',
      latitude: 4.7110,
      longitude: -74.0721,
    },
    destination: {
      address: 'Calle 170 #54-32, Bogotá',
      latitude: 4.7539,
      longitude: -74.0460,
    },
    scheduled_start: hoursFromNow(-1),
    actual_start: hoursFromNow(-1),
    scheduled_end: hoursFromNow(2),
    planned_distance_km: 8.3,
    status: TripStatus.IN_PROGRESS,
    notes: 'Recogida de paquetes',
    created_at: daysFromNow(-1),
    updated_at: now,
  };
  
  await db.collection(COLLECTIONS.TRIPS).doc(trip2Id).set(trip2);
  trips.push(trip2);
  console.log(`   ✓ Created trip: ${trip2Id} - ${trip2.status}`);
  
  // Trip 3 - Completed
  const trip3Id = await generateTripId();
  const trip3: Trip = {
    id: trip3Id,
    vehicle_id: vehicleIds[0],
    driver_id: driverIds[0],
    company_id: companyId,
    origin: {
      address: 'Carrera 15 #100-30, Bogotá',
      latitude: 4.6881,
      longitude: -74.0583,
    },
    destination: {
      address: 'Avenida Boyacá #80-10, Bogotá',
      latitude: 4.6937,
      longitude: -74.0989,
    },
    scheduled_start: daysFromNow(-2),
    actual_start: daysFromNow(-2),
    scheduled_end: daysFromNow(-2),
    actual_end: daysFromNow(-2),
    planned_distance_km: 6.8,
    actual_distance_km: 7.2,
    status: TripStatus.COMPLETED,
    stats: {
      max_speed_kmh: 65,
      avg_speed_kmh: 35,
      total_stops: 3,
      total_idle_time_minutes: 15,
    },
    notes: 'Viaje completado sin incidentes',
    created_at: daysFromNow(-3),
    updated_at: daysFromNow(-2),
  };
  
  await db.collection(COLLECTIONS.TRIPS).doc(trip3Id).set(trip3);
  trips.push(trip3);
  console.log(`   ✓ Created trip: ${trip3Id} - ${trip3.status}`);
  
  // Trip 4 - Completed (yesterday)
  const trip4Id = await generateTripId();
  const trip4: Trip = {
    id: trip4Id,
    vehicle_id: vehicleIds[1],
    driver_id: driverIds[1],
    company_id: companyId,
    origin: {
      address: 'Calle 72 #10-34, Bogotá',
      latitude: 4.6533,
      longitude: -74.0602,
    },
    destination: {
      address: 'Carrera 30 #45-03, Bogotá',
      latitude: 4.6351,
      longitude: -74.0815,
    },
    scheduled_start: daysFromNow(-1),
    actual_start: daysFromNow(-1),
    scheduled_end: daysFromNow(-1),
    actual_end: daysFromNow(-1),
    planned_distance_km: 5.2,
    actual_distance_km: 5.5,
    status: TripStatus.COMPLETED,
    stats: {
      max_speed_kmh: 55,
      avg_speed_kmh: 28,
      total_stops: 2,
      total_idle_time_minutes: 8,
    },
    created_at: daysFromNow(-2),
    updated_at: daysFromNow(-1),
  };
  
  await db.collection(COLLECTIONS.TRIPS).doc(trip4Id).set(trip4);
  trips.push(trip4);
  console.log(`   ✓ Created trip: ${trip4Id} - ${trip4.status}`);
  
  // Trip 5 - Cancelled
  const trip5Id = await generateTripId();
  const trip5: Trip = {
    id: trip5Id,
    vehicle_id: vehicleIds[0],
    driver_id: driverIds[0],
    company_id: companyId,
    origin: {
      address: 'Calle 127 #15-50, Bogotá',
      latitude: 4.7067,
      longitude: -74.0320,
    },
    destination: {
      address: 'Carrera 50 #26-20, Bogotá',
      latitude: 4.6417,
      longitude: -74.1026,
    },
    scheduled_start: daysFromNow(-3),
    planned_distance_km: 15.0,
    status: TripStatus.CANCELLED,
    cancellation_reason: 'Cliente canceló la solicitud',
    cancelled_at: daysFromNow(-3),
    cancelled_by: driverIds[0],
    notes: 'Cancelado por solicitud del cliente',
    created_at: daysFromNow(-4),
    updated_at: daysFromNow(-3),
  };
  
  await db.collection(COLLECTIONS.TRIPS).doc(trip5Id).set(trip5);
  trips.push(trip5);
  console.log(`   ✓ Created trip: ${trip5Id} - ${trip5.status}`);
  
  return trips;
}

// ============================================
// Main Seed Function
// ============================================

async function seedDatabase(): Promise<void> {
  console.log('\n🌱 Starting seed process...\n');
  console.log('='.repeat(50));
  
  try {
    // Clear existing data if configured
    if (SEED_CONFIG.clearExisting) {
      await clearCollections();
    }
    
    // Create company
    const company = await createCompany();
    
    // Create users
    const users = await createUsers(company.id);
    const driverIds = users.filter(u => u.role === UserRole.DRIVER).map(u => u.id);
    
    // Create vehicles
    const vehicles = await createVehicles(company.id, driverIds);
    const vehicleIds = vehicles.map(v => v.id);
    
    // Create trips
    const trips = await createTrips(company.id, vehicleIds, driverIds);
    
    // Summary
    console.log('\n' + '='.repeat(50));
    console.log('\n✅ Seed completed successfully!\n');
    console.log('📊 Summary:');
    console.log(`   • Company: ${company.id} - ${company.name}`);
    console.log(`   • Users: ${users.length} (${users.filter(u => u.role === UserRole.ADMIN).length} admin, ${driverIds.length} drivers)`);
    console.log(`   • Vehicles: ${vehicles.length}`);
    console.log(`   • Trips: ${trips.length}`);
    console.log('');
    console.log('🔗 View in Firebase Console:');
    console.log('   https://console.firebase.google.com/project/smartfleet-pro-dev/firestore');
    console.log('');
    
    // Update vehicles with assigned driver names for easy reference
    await updateVehicleAssignments(vehicles, users);
    
  } catch (error) {
    console.error('\n❌ Seed failed:', error);
    throw error;
  }
}

/**
 * Helper: Update vehicle documents to denormalize driver info (optional optimization)
 */
async function updateVehicleAssignments(vehicles: Vehicle[], users: User[]): Promise<void> {
  // This is optional - adds denormalized data for easier queries
  // In production, you might use Cloud Functions triggers instead
  console.log('\n📝 Updating vehicle assignments...');
  
  for (const vehicle of vehicles) {
    if (vehicle.assigned_driver_id) {
      const driver = users.find(u => u.id === vehicle.assigned_driver_id);
      if (driver) {
        console.log(`   ✓ ${vehicle.plate} assigned to ${driver.full_name}`);
      }
    }
  }
}

// ============================================
// Execute Seed
// ============================================

// Run if called directly
if (require.main === module) {
  seedDatabase()
    .then(() => {
      console.log('✅ Done!');
      process.exit(0);
    })
    .catch((error) => {
      console.error('❌ Error:', error);
      process.exit(1);
    });
}

export { seedDatabase };
