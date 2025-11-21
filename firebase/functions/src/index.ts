import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Initialize Firebase Admin SDK
admin.initializeApp();

// Example HTTP function
export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", { structuredData: true });
  response.send("Hello from SmartFleet Pro!");
});

// Example callable function
export const getServerTime = functions.https.onCall(async (data, context) => {
  // Check authentication
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  return {
    serverTime: new Date().toISOString(),
    userId: context.auth.uid,
  };
});

// Example Firestore trigger
// Uncomment when Firestore collections are created (US-002)
/*
export const onUserCreated = functions.firestore
  .document("users/{userId}")
  .onCreate(async (snap, context) => {
    const userData = snap.data();
    
    functions.logger.info("New user created", {
      userId: context.params.userId,
      email: userData.email,
    });
    
    // Add custom logic here
    // e.g., send welcome email, create default settings, etc.
    
    return null;
  });
*/
