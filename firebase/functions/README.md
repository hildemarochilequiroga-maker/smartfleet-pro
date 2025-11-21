# SmartFleet Pro - Cloud Functions

## Overview

This directory contains Firebase Cloud Functions for SmartFleet Pro backend logic.

**Status:** ⚠️ Template created, dependencies not installed yet  
**Runtime:** Node.js 20  
**Language:** TypeScript

---

## Setup Instructions

### Install Dependencies

```powershell
# Navigate to functions directory
cd firebase/functions

# Install npm packages
npm install
```

This will install:
- `firebase-admin` - Firebase Admin SDK
- `firebase-functions` - Cloud Functions SDK
- TypeScript and ESLint development tools

---

## Development

### Build Functions

```bash
# Build TypeScript to JavaScript
npm run build

# Build and watch for changes
npm run build:watch
```

### Test Locally

```bash
# Start Firebase Emulators
npm run serve

# Or from firebase directory
cd ..
firebase emulators:start
```

### Run Linter

```bash
npm run lint
```

---

## Deployment

### Deploy All Functions

```bash
# From functions directory
npm run deploy

# Or from firebase directory
cd ..
firebase deploy --only functions
```

### Deploy Specific Function

```bash
firebase deploy --only functions:helloWorld
```

---

## Project Structure

```
functions/
├── package.json           # Dependencies and scripts
├── tsconfig.json          # TypeScript configuration
├── .eslintrc.js          # ESLint rules
├── src/
│   ├── index.ts          # Main entry point (example functions)
│   ├── types/            # TypeScript type definitions (to be created)
│   ├── utils/            # Utility functions (to be created)
│   └── triggers/         # Firestore triggers (to be created)
└── lib/                  # Compiled JavaScript (generated)
```

---

## Example Functions

### HTTP Function

```typescript
export const helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello from SmartFleet Pro!");
});
```

**URL:** `https://us-central1-smartfleet-dev.cloudfunctions.net/helloWorld`

### Callable Function (with Auth)

```typescript
export const getServerTime = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }
  
  return { serverTime: new Date().toISOString() };
});
```

**Call from Flutter:**
```dart
final callable = FirebaseFunctions.instance.httpsCallable('getServerTime');
final result = await callable();
print(result.data['serverTime']);
```

---

## Firestore Triggers

Example trigger (to be implemented in US-002):

```typescript
export const onUserCreated = functions.firestore
  .document("users/{userId}")
  .onCreate(async (snap, context) => {
    const userData = snap.data();
    // Add logic here (send email, create defaults, etc.)
    return null;
  });
```

---

## Environment Variables

### Set Config Variables

```bash
firebase functions:config:set someservice.key="THE API KEY"
```

### Access in Code

```typescript
const apiKey = functions.config().someservice.key;
```

---

## Testing

### Unit Tests (Jest)

```bash
npm test
```

### Integration Tests

Use Firebase Emulator Suite for testing:

```bash
firebase emulators:start --import=./test-data --export-on-exit
```

---

## Best Practices

### Performance
- Use async/await for Firestore operations
- Avoid nested queries (use composite indexes)
- Set timeouts for long-running functions

### Security
- Always validate input data
- Check authentication (`context.auth`)
- Use security rules as first line of defense

### Logging
```typescript
functions.logger.info("Info message", { userId: "123" });
functions.logger.error("Error message", { error: error.message });
```

### Error Handling
```typescript
try {
  // Your code
} catch (error) {
  functions.logger.error("Error occurred", { error });
  throw new functions.https.HttpsError("internal", "Operation failed");
}
```

---

## Monitoring

### View Logs

```bash
# Real-time logs
firebase functions:log

# Logs for specific function
firebase functions:log --only helloWorld
```

### Firebase Console

- **Logs:** https://console.firebase.google.com/project/smartfleet-dev/functions/logs
- **Usage:** https://console.firebase.google.com/project/smartfleet-dev/functions/usage

---

## Troubleshooting

### Build Errors

```bash
# Clean build
rm -rf lib/
npm run build
```

### Deployment Errors

```bash
# Deploy with debug
firebase deploy --only functions --debug
```

### Module Not Found

```bash
# Reinstall dependencies
rm -rf node_modules package-lock.json
npm install
```

---

## Next Steps (US-002)

When implementing Firestore collections:

1. Create type definitions in `src/types/models.ts`
2. Implement Firestore triggers
3. Add data validation functions
4. Create helper functions for ID generation
5. Set up seed data scripts

---

## Resources

- [Firebase Functions Docs](https://firebase.google.com/docs/functions)
- [TypeScript Guide](https://firebase.google.com/docs/functions/typescript)
- [Callable Functions](https://firebase.google.com/docs/functions/callable)
- [Firestore Triggers](https://firebase.google.com/docs/functions/firestore-events)

---

**Last Updated:** November 21, 2025  
**Status:** Template ready, awaiting npm install
