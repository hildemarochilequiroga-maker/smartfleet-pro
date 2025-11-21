/**
 * SmartFleet Pro - Firestore Security Rules Tests
 * 
 * Test suite to validate security rules for multi-tenant access control
 * 
 * Usage:
 *   npm test (from firebase directory)
 * 
 * Requirements:
 *   - @firebase/rules-unit-testing
 *   - mocha
 */

const { 
  initializeTestEnvironment, 
  assertSucceeds, 
  assertFails 
} = require('@firebase/rules-unit-testing');
const { readFileSync } = require('fs');

// Test data constants
const COMPANY_A_ID = 'COMP-2025-001';
const COMPANY_B_ID = 'COMP-2025-002';

const ADMIN_A_UID = 'admin-company-a';
const DRIVER_A_UID = 'driver-company-a';
const ADMIN_B_UID = 'admin-company-b';
const DRIVER_B_UID = 'driver-company-b';
const UNAUTHENTICATED_UID = null;

const VEHICLE_A_ID = 'VEH-2025-001';
const TRIP_A_ID = 'TRIP-20251121-0001';
const USER_A_ID = 'USR-2025-001';

// Test environment
let testEnv;

describe('SmartFleet Pro - Firestore Security Rules', () => {
  
  // ============================================
  // Setup & Teardown
  // ============================================
  
  before(async () => {
    // Initialize test environment
    testEnv = await initializeTestEnvironment({
      projectId: 'smartfleet-rules-test',
      firestore: {
        rules: readFileSync('firestore.rules', 'utf8'),
        host: '127.0.0.1',
        port: 8082
      }
    });
  });

  beforeEach(async () => {
    // Clear Firestore data between tests
    await testEnv.clearFirestore();
  });

  after(async () => {
    // Clean up test environment
    await testEnv.cleanup();
  });

  // ============================================
  // Helper Functions
  // ============================================
  
  function getAuthContext(uid, companyId, role) {
    if (!uid) return testEnv.unauthenticatedContext();
    
    return testEnv.authenticatedContext(uid, {
      company_id: companyId,
      role: role
    });
  }

  function getAdminAContext() {
    return getAuthContext(ADMIN_A_UID, COMPANY_A_ID, 'admin');
  }

  function getDriverAContext() {
    return getAuthContext(DRIVER_A_UID, COMPANY_A_ID, 'driver');
  }

  function getAdminBContext() {
    return getAuthContext(ADMIN_B_UID, COMPANY_B_ID, 'admin');
  }

  function getDriverBContext() {
    return getAuthContext(DRIVER_B_UID, COMPANY_B_ID, 'driver');
  }

  function getUnauthenticatedContext() {
    return testEnv.unauthenticatedContext();
  }

  // ============================================
  // Test Suite: Authentication
  // ============================================
  
  describe('Authentication', () => {
    it('should deny unauthenticated read access to any collection', async () => {
      const unauthed = getUnauthenticatedContext();
      
      await assertFails(unauthed.firestore().collection('companies').doc(COMPANY_A_ID).get());
      await assertFails(unauthed.firestore().collection('users').doc(USER_A_ID).get());
      await assertFails(unauthed.firestore().collection('vehicles').doc(VEHICLE_A_ID).get());
      await assertFails(unauthed.firestore().collection('trips').doc(TRIP_A_ID).get());
    });

    it('should deny unauthenticated write access to any collection', async () => {
      const unauthed = getUnauthenticatedContext();
      
      await assertFails(unauthed.firestore().collection('companies').doc(COMPANY_A_ID).set({name: 'Test'}));
      await assertFails(unauthed.firestore().collection('users').doc(USER_A_ID).set({name: 'Test'}));
    });
  });

  // ============================================
  // Test Suite: Companies Collection
  // ============================================
  
  describe('Companies Collection', () => {
    beforeEach(async () => {
      // Seed company data
      await testEnv.withSecurityRulesDisabled(async (context) => {
        await context.firestore().collection('companies').doc(COMPANY_A_ID).set({
          id: COMPANY_A_ID,
          name: 'Company A',
          rfc: 'COMP-A-RFC',
          is_active: true,
          created_at: new Date(),
          updated_at: new Date()
        });
        
        await context.firestore().collection('companies').doc(COMPANY_B_ID).set({
          id: COMPANY_B_ID,
          name: 'Company B',
          rfc: 'COMP-B-RFC',
          is_active: true,
          created_at: new Date(),
          updated_at: new Date()
        });
      });
    });

    it('should allow users to read their own company', async () => {
      const adminA = getAdminAContext();
      await assertSucceeds(adminA.firestore().collection('companies').doc(COMPANY_A_ID).get());
    });

    it('should deny users from reading other companies', async () => {
      const adminA = getAdminAContext();
      await assertFails(adminA.firestore().collection('companies').doc(COMPANY_B_ID).get());
    });

    it('should allow admins to update their own company', async () => {
      const adminA = getAdminAContext();
      await assertSucceeds(
        adminA.firestore().collection('companies').doc(COMPANY_A_ID).update({
          name: 'Updated Company A',
          updated_at: new Date()
        })
      );
    });

    it('should deny drivers from updating company', async () => {
      const driverA = getDriverAContext();
      await assertFails(
        driverA.firestore().collection('companies').doc(COMPANY_A_ID).update({
          name: 'Hacked'
        })
      );
    });

    it('should deny company creation via Firestore', async () => {
      const adminA = getAdminAContext();
      await assertFails(
        adminA.firestore().collection('companies').doc('COMP-2025-003').set({
          id: 'COMP-2025-003',
          name: 'New Company',
          rfc: 'NEW-RFC',
          is_active: true,
          created_at: new Date(),
          updated_at: new Date()
        })
      );
    });

    it('should deny company deletion', async () => {
      const adminA = getAdminAContext();
      await assertFails(adminA.firestore().collection('companies').doc(COMPANY_A_ID).delete());
    });
  });

  // ============================================
  // Test Suite: Users Collection
  // ============================================
  
  describe('Users Collection', () => {
    beforeEach(async () => {
      // Seed user data
      await testEnv.withSecurityRulesDisabled(async (context) => {
        await context.firestore().collection('users').doc(ADMIN_A_UID).set({
          id: 'USR-2025-001',
          company_id: COMPANY_A_ID,
          email: 'admin@companya.com',
          full_name: 'Admin A',
          role: 'admin',
          is_active: true,
          created_at: new Date(),
          updated_at: new Date()
        });
        
        await context.firestore().collection('users').doc(DRIVER_A_UID).set({
          id: 'USR-2025-002',
          company_id: COMPANY_A_ID,
          email: 'driver@companya.com',
          full_name: 'Driver A',
          role: 'driver',
          is_active: true,
          created_at: new Date(),
          updated_at: new Date()
        });
        
        await context.firestore().collection('users').doc(DRIVER_B_UID).set({
          id: 'USR-2025-003',
          company_id: COMPANY_B_ID,
          email: 'driver@companyb.com',
          full_name: 'Driver B',
          role: 'driver',
          is_active: true,
          created_at: new Date(),
          updated_at: new Date()
        });
      });
    });

    it('should allow users to read their own profile', async () => {
      const driverA = getDriverAContext();
      await assertSucceeds(driverA.firestore().collection('users').doc(DRIVER_A_UID).get());
    });

    it('should allow admins to read users in their company', async () => {
      const adminA = getAdminAContext();
      await assertSucceeds(adminA.firestore().collection('users').doc(DRIVER_A_UID).get());
    });

    it('should deny users from reading other company users', async () => {
      const adminA = getAdminAContext();
      await assertFails(adminA.firestore().collection('users').doc(DRIVER_B_UID).get());
    });

    it('should deny drivers from reading other users in same company', async () => {
      const driverA = getDriverAContext();
      await assertFails(driverA.firestore().collection('users').doc(ADMIN_A_UID).get());
    });

    it('should allow admins to create users in their company', async () => {
      const adminA = getAdminAContext();
      await assertSucceeds(
        adminA.firestore().collection('users').doc('new-driver-uid').set({
          id: 'USR-2025-004',
          company_id: COMPANY_A_ID,
          email: 'newdriver@companya.com',
          full_name: 'New Driver',
          role: 'driver',
          is_active: true,
          created_at: new Date(),
          updated_at: new Date()
        })
      );
    });

    it('should deny admins from creating users in other companies', async () => {
      const adminA = getAdminAContext();
      await assertFails(
        adminA.firestore().collection('users').doc('hacker-uid').set({
          id: 'USR-2025-999',
          company_id: COMPANY_B_ID,
          email: 'hacker@companyb.com',
          full_name: 'Hacker',
          role: 'admin',
          is_active: true,
          created_at: new Date(),
          updated_at: new Date()
        })
      );
    });

    it('should allow users to update their own profile (limited fields)', async () => {
      const driverA = getDriverAContext();
      await assertSucceeds(
        driverA.firestore().collection('users').doc(DRIVER_A_UID).update({
          full_name: 'Updated Name',
          phone: '555-1234',
          updated_at: new Date()
        })
      );
    });

    it('should deny users from changing their role', async () => {
      const driverA = getDriverAContext();
      await assertFails(
        driverA.firestore().collection('users').doc(DRIVER_A_UID).update({
          role: 'admin'
        })
      );
    });

    it('should allow admins to update user profiles in their company', async () => {
      const adminA = getAdminAContext();
      await assertSucceeds(
        adminA.firestore().collection('users').doc(DRIVER_A_UID).update({
          full_name: 'Admin Updated Name',
          role: 'operator',
          updated_at: new Date()
        })
      );
    });
  });

  // ============================================
  // Test Suite: Vehicles Collection
  // ============================================
  
  describe('Vehicles Collection', () => {
    beforeEach(async () => {
      // Seed vehicle data
      await testEnv.withSecurityRulesDisabled(async (context) => {
        await context.firestore().collection('vehicles').doc(VEHICLE_A_ID).set({
          id: VEHICLE_A_ID,
          company_id: COMPANY_A_ID,
          license_plate: 'ABC-123',
          brand: 'Toyota',
          model: 'Hilux',
          year: 2023,
          vehicle_type: 'truck',
          capacity_kg: 1000,
          status: 'in_use',
          assigned_driver_id: DRIVER_A_UID,
          created_at: new Date(),
          updated_at: new Date()
        });
        
        await context.firestore().collection('vehicles').doc('VEH-2025-002').set({
          id: 'VEH-2025-002',
          company_id: COMPANY_B_ID,
          license_plate: 'XYZ-789',
          brand: 'Chevrolet',
          model: 'NPR',
          year: 2022,
          vehicle_type: 'truck',
          capacity_kg: 3000,
          status: 'available',
          created_at: new Date(),
          updated_at: new Date()
        });
      });
    });

    it('should allow drivers to read their assigned vehicle', async () => {
      const driverA = getDriverAContext();
      await assertSucceeds(driverA.firestore().collection('vehicles').doc(VEHICLE_A_ID).get());
    });

    it('should deny drivers from reading unassigned vehicles', async () => {
      const driverB = getDriverBContext();
      await assertFails(driverB.firestore().collection('vehicles').doc(VEHICLE_A_ID).get());
    });

    it('should allow admins to read all company vehicles', async () => {
      const adminA = getAdminAContext();
      await assertSucceeds(adminA.firestore().collection('vehicles').doc(VEHICLE_A_ID).get());
    });

    it('should deny admins from reading other company vehicles', async () => {
      const adminA = getAdminAContext();
      await assertFails(adminA.firestore().collection('vehicles').doc('VEH-2025-002').get());
    });

    it('should allow admins to create vehicles', async () => {
      const adminA = getAdminAContext();
      await assertSucceeds(
        adminA.firestore().collection('vehicles').doc('VEH-2025-003').set({
          id: 'VEH-2025-003',
          company_id: COMPANY_A_ID,
          license_plate: 'NEW-001',
          brand: 'Ford',
          model: 'F-150',
          year: 2024,
          vehicle_type: 'truck',
          capacity_kg: 1500,
          status: 'available',
          created_at: new Date(),
          updated_at: new Date()
        })
      );
    });

    it('should deny drivers from creating vehicles', async () => {
      const driverA = getDriverAContext();
      await assertFails(
        driverA.firestore().collection('vehicles').doc('VEH-HACK').set({
          id: 'VEH-HACK',
          company_id: COMPANY_A_ID,
          license_plate: 'HACK-999',
          brand: 'Hacker',
          model: 'X',
          year: 2024,
          vehicle_type: 'truck',
          status: 'available',
          created_at: new Date(),
          updated_at: new Date()
        })
      );
    });

    it('should allow admins to update vehicles', async () => {
      const adminA = getAdminAContext();
      await assertSucceeds(
        adminA.firestore().collection('vehicles').doc(VEHICLE_A_ID).update({
          status: 'maintenance',
          updated_at: new Date()
        })
      );
    });

    it('should deny drivers from updating vehicles', async () => {
      const driverA = getDriverAContext();
      await assertFails(
        driverA.firestore().collection('vehicles').doc(VEHICLE_A_ID).update({
          status: 'available'
        })
      );
    });
  });

  // ============================================
  // Test Suite: Trips Collection
  // ============================================
  
  describe('Trips Collection', () => {
    beforeEach(async () => {
      // Seed trip data
      await testEnv.withSecurityRulesDisabled(async (context) => {
        await context.firestore().collection('trips').doc(TRIP_A_ID).set({
          id: TRIP_A_ID,
          company_id: COMPANY_A_ID,
          vehicle_id: VEHICLE_A_ID,
          driver_id: DRIVER_A_UID,
          origin: { address: 'Origin A', latitude: 19.4326, longitude: -99.1332 },
          destination: { address: 'Destination A', latitude: 20.6597, longitude: -103.3496 },
          status: 'in_progress',
          scheduled_start: new Date(),
          created_at: new Date(),
          updated_at: new Date()
        });
        
        await context.firestore().collection('trips').doc('TRIP-20251121-0002').set({
          id: 'TRIP-20251121-0002',
          company_id: COMPANY_B_ID,
          vehicle_id: 'VEH-2025-002',
          driver_id: DRIVER_B_UID,
          origin: { address: 'Origin B', latitude: 25.6866, longitude: -100.3161 },
          destination: { address: 'Destination B', latitude: 19.4326, longitude: -99.1332 },
          status: 'scheduled',
          scheduled_start: new Date(),
          created_at: new Date(),
          updated_at: new Date()
        });
      });
    });

    it('should allow drivers to read their assigned trips', async () => {
      const driverA = getDriverAContext();
      await assertSucceeds(driverA.firestore().collection('trips').doc(TRIP_A_ID).get());
    });

    it('should deny drivers from reading other drivers trips', async () => {
      const driverA = getDriverAContext();
      await assertFails(driverA.firestore().collection('trips').doc('TRIP-20251121-0002').get());
    });

    it('should allow admins to read all company trips', async () => {
      const adminA = getAdminAContext();
      await assertSucceeds(adminA.firestore().collection('trips').doc(TRIP_A_ID).get());
    });

    it('should allow admins to create trips', async () => {
      const adminA = getAdminAContext();
      await assertSucceeds(
        adminA.firestore().collection('trips').doc('TRIP-20251121-0003').set({
          id: 'TRIP-20251121-0003',
          company_id: COMPANY_A_ID,
          vehicle_id: VEHICLE_A_ID,
          driver_id: DRIVER_A_UID,
          origin: { address: 'New Origin', latitude: 19.0, longitude: -99.0 },
          destination: { address: 'New Destination', latitude: 20.0, longitude: -100.0 },
          status: 'scheduled',
          scheduled_start: new Date(),
          created_at: new Date(),
          updated_at: new Date()
        })
      );
    });

    it('should deny drivers from creating trips', async () => {
      const driverA = getDriverAContext();
      await assertFails(
        driverA.firestore().collection('trips').doc('TRIP-HACK').set({
          id: 'TRIP-HACK',
          company_id: COMPANY_A_ID,
          vehicle_id: VEHICLE_A_ID,
          driver_id: DRIVER_A_UID,
          status: 'scheduled',
          scheduled_start: new Date(),
          created_at: new Date(),
          updated_at: new Date()
        })
      );
    });

    it('should allow drivers to update their trip status', async () => {
      const driverA = getDriverAContext();
      await assertSucceeds(
        driverA.firestore().collection('trips').doc(TRIP_A_ID).update({
          status: 'completed',
          actual_end: new Date(),
          distance_km: 150,
          updated_at: new Date()
        })
      );
    });

    it('should deny drivers from changing trip assignment', async () => {
      const driverA = getDriverAContext();
      await assertFails(
        driverA.firestore().collection('trips').doc(TRIP_A_ID).update({
          driver_id: 'other-driver',
          vehicle_id: 'other-vehicle'
        })
      );
    });

    it('should deny drivers from changing company_id', async () => {
      const driverA = getDriverAContext();
      await assertFails(
        driverA.firestore().collection('trips').doc(TRIP_A_ID).update({
          company_id: COMPANY_B_ID
        })
      );
    });

    it('should allow admins to update any trip field', async () => {
      const adminA = getAdminAContext();
      await assertSucceeds(
        adminA.firestore().collection('trips').doc(TRIP_A_ID).update({
          driver_id: 'USR-2025-999',
          vehicle_id: 'VEH-2025-999',
          status: 'cancelled',
          updated_at: new Date()
        })
      );
    });
  });

  // ============================================
  // Test Suite: Multi-tenancy Isolation
  // ============================================
  
  describe('Multi-tenancy Isolation', () => {
    it('should prevent cross-company data access for all collections', async () => {
      const adminA = getAdminAContext();
      
      // Seed data from Company B
      await testEnv.withSecurityRulesDisabled(async (context) => {
        await context.firestore().collection('users').doc('user-b').set({
          id: 'USR-B',
          company_id: COMPANY_B_ID,
          email: 'user@companyb.com',
          full_name: 'User B',
          role: 'driver',
          is_active: true,
          created_at: new Date(),
          updated_at: new Date()
        });
        
        await context.firestore().collection('vehicles').doc('vehicle-b').set({
          id: 'VEH-B',
          company_id: COMPANY_B_ID,
          license_plate: 'B-001',
          brand: 'Test',
          model: 'Test',
          year: 2024,
          vehicle_type: 'truck',
          status: 'available',
          created_at: new Date(),
          updated_at: new Date()
        });
        
        await context.firestore().collection('trips').doc('trip-b').set({
          id: 'TRIP-B',
          company_id: COMPANY_B_ID,
          vehicle_id: 'VEH-B',
          driver_id: 'user-b',
          status: 'scheduled',
          scheduled_start: new Date(),
          created_at: new Date(),
          updated_at: new Date()
        });
      });
      
      // Admin A should not access Company B data
      await assertFails(adminA.firestore().collection('users').doc('user-b').get());
      await assertFails(adminA.firestore().collection('vehicles').doc('vehicle-b').get());
      await assertFails(adminA.firestore().collection('trips').doc('trip-b').get());
    });
  });

  // ============================================
  // Test Suite: Route Points Subcollection
  // ============================================
  
  describe('Route Points Subcollection', () => {
    beforeEach(async () => {
      // Seed trip and route points
      await testEnv.withSecurityRulesDisabled(async (context) => {
        await context.firestore().collection('trips').doc(TRIP_A_ID).set({
          id: TRIP_A_ID,
          company_id: COMPANY_A_ID,
          vehicle_id: VEHICLE_A_ID,
          driver_id: DRIVER_A_UID,
          status: 'in_progress',
          scheduled_start: new Date(),
          created_at: new Date(),
          updated_at: new Date()
        });
      });
    });

    it('should allow drivers to add route points to their trips', async () => {
      const driverA = getDriverAContext();
      await assertSucceeds(
        driverA.firestore()
          .collection('trips').doc(TRIP_A_ID)
          .collection('route_points').doc('point-1')
          .set({
            latitude: 19.4326,
            longitude: -99.1332,
            timestamp: new Date(),
            speed_kmh: 60
          })
      );
    });

    it('should deny drivers from adding route points to other trips', async () => {
      const driverB = getDriverBContext();
      
      await assertFails(
        driverB.firestore()
          .collection('trips').doc(TRIP_A_ID)
          .collection('route_points').doc('point-hack')
          .set({
            latitude: 0,
            longitude: 0,
            timestamp: new Date()
          })
      );
    });

    it('should deny updating route points (append-only)', async () => {
      const driverA = getDriverAContext();
      
      // First create a route point
      await testEnv.withSecurityRulesDisabled(async (context) => {
        await context.firestore()
          .collection('trips').doc(TRIP_A_ID)
          .collection('route_points').doc('point-1')
          .set({
            latitude: 19.4326,
            longitude: -99.1332,
            timestamp: new Date()
          });
      });
      
      // Try to update it
      await assertFails(
        driverA.firestore()
          .collection('trips').doc(TRIP_A_ID)
          .collection('route_points').doc('point-1')
          .update({ latitude: 20.0 })
      );
    });

    it('should deny deleting route points', async () => {
      const adminA = getAdminAContext();
      
      // First create a route point
      await testEnv.withSecurityRulesDisabled(async (context) => {
        await context.firestore()
          .collection('trips').doc(TRIP_A_ID)
          .collection('route_points').doc('point-1')
          .set({
            latitude: 19.4326,
            longitude: -99.1332,
            timestamp: new Date()
          });
      });
      
      // Even admins can't delete route points
      await assertFails(
        adminA.firestore()
          .collection('trips').doc(TRIP_A_ID)
          .collection('route_points').doc('point-1')
          .delete()
      );
    });
  });

  // ============================================
  // Test Suite: Counters Collection
  // ============================================
  
  describe('Counters Collection (Internal)', () => {
    it('should deny all access to _counters collection', async () => {
      const adminA = getAdminAContext();
      
      await assertFails(adminA.firestore().collection('_counters').doc('test').get());
      await assertFails(adminA.firestore().collection('_counters').doc('test').set({ count: 1 }));
    });
  });
});

console.log('\n✅ Test suite loaded. Run with: npm test\n');
