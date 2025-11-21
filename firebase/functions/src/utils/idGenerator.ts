/**
 * SmartFleet Pro - ID Generation Utilities
 * Helper functions to generate consistent, human-readable IDs
 * 
 * Formats:
 * - Companies: COMP-YYYY-XXX (e.g., COMP-2025-001)
 * - Users: USR-YYYY-XXX (e.g., USR-2025-001)
 * - Vehicles: VEH-YYYY-XXX (e.g., VEH-2025-001)
 * - Trips: TRIP-YYYYMMDD-XXXX (e.g., TRIP-20251121-0001)
 */

import * as admin from 'firebase-admin';
import { getFirestore } from '../config/firebase';

const getDb = () => getFirestore();

// ============================================
// Counter Management
// ============================================

/**
 * Get the next counter value for a given type and year
 */
async function getNextCounter(
  type: 'company' | 'user' | 'vehicle' | 'trip',
  year: number,
  date?: Date
): Promise<number> {
  const db = getDb();
  const counterRef = db.collection('_counters').doc(`${type}_${year}`);
  
  try {
    const result = await db.runTransaction(async (transaction) => {
      const doc = await transaction.get(counterRef);
      
      let nextValue = 1;
      
      if (doc.exists) {
        const data = doc.data();
        nextValue = (data?.count || 0) + 1;
      }
      
      transaction.set(counterRef, { 
        count: nextValue,
        updated_at: admin.firestore.FieldValue.serverTimestamp(),
      }, { merge: true });
      
      return nextValue;
    });
    
    return result;
  } catch (error) {
    console.error('Error getting next counter:', error);
    throw new Error('Failed to generate ID');
  }
}

/**
 * Get the next trip counter for a specific date
 */
async function getNextTripCounter(date: Date): Promise<number> {
  const db = getDb();
  const dateStr = formatDateForTripId(date);
  const counterRef = db.collection('_counters').doc(`trip_${dateStr}`);
  
  try {
    const result = await db.runTransaction(async (transaction: FirebaseFirestore.Transaction) => {
      const doc = await transaction.get(counterRef);
      
      let nextValue = 1;
      
      if (doc.exists) {
        const data = doc.data();
        nextValue = (data?.count || 0) + 1;
      }
      
      transaction.set(counterRef, { 
        count: nextValue,
        date: dateStr,
        updated_at: admin.firestore.FieldValue.serverTimestamp(),
      }, { merge: true });
      
      return nextValue;
    });
    
    return result;
  } catch (error) {
    console.error('Error getting next trip counter:', error);
    throw new Error('Failed to generate trip ID');
  }
}

// ============================================
// ID Generation Functions
// ============================================

/**
 * Generate Company ID
 * Format: COMP-YYYY-XXX (e.g., COMP-2025-001)
 */
export async function generateCompanyId(): Promise<string> {
  const year = new Date().getFullYear();
  const counter = await getNextCounter('company', year);
  const paddedCounter = counter.toString().padStart(3, '0');
  
  return `COMP-${year}-${paddedCounter}`;
}

/**
 * Generate User ID
 * Format: USR-YYYY-XXX (e.g., USR-2025-001)
 */
export async function generateUserId(): Promise<string> {
  const year = new Date().getFullYear();
  const counter = await getNextCounter('user', year);
  const paddedCounter = counter.toString().padStart(3, '0');
  
  return `USR-${year}-${paddedCounter}`;
}

/**
 * Generate Vehicle ID
 * Format: VEH-YYYY-XXX (e.g., VEH-2025-001)
 */
export async function generateVehicleId(): Promise<string> {
  const year = new Date().getFullYear();
  const counter = await getNextCounter('vehicle', year);
  const paddedCounter = counter.toString().padStart(3, '0');
  
  return `VEH-${year}-${paddedCounter}`;
}

/**
 * Generate Trip ID
 * Format: TRIP-YYYYMMDD-XXXX (e.g., TRIP-20251121-0001)
 */
export async function generateTripId(date: Date = new Date()): Promise<string> {
  const dateStr = formatDateForTripId(date);
  const counter = await getNextTripCounter(date);
  const paddedCounter = counter.toString().padStart(4, '0');
  
  return `TRIP-${dateStr}-${paddedCounter}`;
}

/**
 * Generate Route Point ID (timestamp-based for ordering)
 * Format: timestamp in milliseconds
 */
export function generateRoutePointId(timestamp?: Date): string {
  const ts = timestamp || new Date();
  return ts.getTime().toString();
}

// ============================================
// Helper Functions
// ============================================

/**
 * Format date for trip ID: YYYYMMDD
 */
function formatDateForTripId(date: Date): string {
  const year = date.getFullYear();
  const month = (date.getMonth() + 1).toString().padStart(2, '0');
  const day = date.getDate().toString().padStart(2, '0');
  
  return `${year}${month}${day}`;
}

/**
 * Parse Company ID to get year and counter
 */
export function parseCompanyId(id: string): { year: number; counter: number } | null {
  const match = id.match(/^COMP-(\d{4})-(\d{3})$/);
  if (!match) return null;
  
  return {
    year: parseInt(match[1], 10),
    counter: parseInt(match[2], 10),
  };
}

/**
 * Parse User ID to get year and counter
 */
export function parseUserId(id: string): { year: number; counter: number } | null {
  const match = id.match(/^USR-(\d{4})-(\d{3})$/);
  if (!match) return null;
  
  return {
    year: parseInt(match[1], 10),
    counter: parseInt(match[2], 10),
  };
}

/**
 * Parse Vehicle ID to get year and counter
 */
export function parseVehicleId(id: string): { year: number; counter: number } | null {
  const match = id.match(/^VEH-(\d{4})-(\d{3})$/);
  if (!match) return null;
  
  return {
    year: parseInt(match[1], 10),
    counter: parseInt(match[2], 10),
  };
}

/**
 * Parse Trip ID to get date and counter
 */
export function parseTripId(id: string): { date: Date; counter: number } | null {
  const match = id.match(/^TRIP-(\d{8})-(\d{4})$/);
  if (!match) return null;
  
  const dateStr = match[1];
  const year = parseInt(dateStr.substring(0, 4), 10);
  const month = parseInt(dateStr.substring(4, 6), 10) - 1; // Month is 0-indexed
  const day = parseInt(dateStr.substring(6, 8), 10);
  
  return {
    date: new Date(year, month, day),
    counter: parseInt(match[2], 10),
  };
}

// ============================================
// Validation Functions
// ============================================

/**
 * Validate Company ID format
 */
export function isValidCompanyId(id: string): boolean {
  return /^COMP-\d{4}-\d{3}$/.test(id);
}

/**
 * Validate User ID format
 */
export function isValidUserId(id: string): boolean {
  return /^USR-\d{4}-\d{3}$/.test(id);
}

/**
 * Validate Vehicle ID format
 */
export function isValidVehicleId(id: string): boolean {
  return /^VEH-\d{4}-\d{3}$/.test(id);
}

/**
 * Validate Trip ID format
 */
export function isValidTripId(id: string): boolean {
  return /^TRIP-\d{8}-\d{4}$/.test(id);
}

// ============================================
// Batch ID Generation (for seed data)
// ============================================

/**
 * Generate multiple IDs at once (useful for seed data)
 * Note: This is less efficient but useful for testing
 */
export async function generateMultipleIds(
  type: 'company' | 'user' | 'vehicle',
  count: number
): Promise<string[]> {
  const ids: string[] = [];
  
  for (let i = 0; i < count; i++) {
    let id: string;
    
    switch (type) {
      case 'company':
        id = await generateCompanyId();
        break;
      case 'user':
        id = await generateUserId();
        break;
      case 'vehicle':
        id = await generateVehicleId();
        break;
      default:
        throw new Error(`Invalid type: ${type}`);
    }
    
    ids.push(id);
  }
  
  return ids;
}

/**
 * Reset counters (DANGER: Only use in development/testing)
 */
export async function resetCounters(): Promise<void> {
  if (process.env.NODE_ENV === 'production') {
    throw new Error('Cannot reset counters in production!');
  }
  
  const db = getDb();
  const countersRef = db.collection('_counters');
  const snapshot = await countersRef.get();
  
  const batch = db.batch();
  snapshot.docs.forEach((doc: FirebaseFirestore.QueryDocumentSnapshot) => {
    batch.delete(doc.ref);
  });
  
  await batch.commit();
  console.log('All counters reset');
}
