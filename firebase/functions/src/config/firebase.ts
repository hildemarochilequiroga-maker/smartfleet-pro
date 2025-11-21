/**
 * Firebase Admin Initialization
 * This file initializes Firebase Admin SDK for server-side operations
 */

import * as admin from 'firebase-admin';
import * as path from 'path';

let initialized = false;

export function initializeFirebaseAdmin(): admin.app.App {
  if (!initialized) {
    try {
      // Try to initialize with project ID from environment
      const projectId = process.env.GCLOUD_PROJECT || process.env.FIREBASE_PROJECT_ID || 'smartfleet-pro-dev';
      
      // Use service account if available
      const serviceAccountPath = path.join(__dirname, '../../service-account.json');
      
      admin.initializeApp({
        credential: admin.credential.cert(serviceAccountPath),
        projectId: projectId,
      });
      
      // Only use emulator if explicitly set
      if (process.env.FIRESTORE_EMULATOR_HOST) {
        console.log(`Using Firestore Emulator at ${process.env.FIRESTORE_EMULATOR_HOST}`);
      } else {
        console.log(`Using Firebase Production: ${projectId}`);
      }
      
      initialized = true;
      console.log(`Firebase Admin initialized for project: ${projectId}`);
    } catch (error) {
      // If already initialized, just continue
      if ((error as any).code === 'app/duplicate-app') {
        console.log('Firebase Admin already initialized');
        initialized = true;
      } else {
        throw error;
      }
    }
  }
  
  return admin.app();
}

export function getFirestore(): admin.firestore.Firestore {
  if (!initialized) {
    initializeFirebaseAdmin();
  }
  return admin.firestore();
}

export function getAuth(): admin.auth.Auth {
  if (!initialized) {
    initializeFirebaseAdmin();
  }
  return admin.auth();
}

export function getStorage(): admin.storage.Storage {
  if (!initialized) {
    initializeFirebaseAdmin();
  }
  return admin.storage();
}
