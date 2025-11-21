# US-001 Implementation Checklist

## ✅ Automated Setup (COMPLETED)

- [x] Created Firebase project directory structure
- [x] Installed Firebase CLI (v14.26.0)
- [x] Created `.firebaserc` with project aliases
- [x] Created `firebase.json` configuration
- [x] Created Firestore security rules (`firestore.rules`)
- [x] Created Firestore indexes file (`firestore.indexes.json`)
- [x] Created Cloud Storage rules (`storage.rules`)
- [x] Created Firebase Hosting placeholder (`public/index.html`)
- [x] Created configuration templates for all environments
- [x] Created `.env.example` template
- [x] Updated `.gitignore` to protect sensitive files
- [x] Created comprehensive Firebase setup documentation
- [x] Created Firebase README with quick commands

---

## 🔧 Manual Setup Required (TO DO)

The following tasks must be completed manually in Firebase Console and Google Cloud Platform.

### Task T1: Create 3 Firebase Projects

- [ ] **Create Development Project**
  - Project ID: `smartfleet-dev`
  - Disable Google Analytics (optional)
  - [Create Project](https://console.firebase.google.com/)

- [ ] **Create Staging Project**
  - Project ID: `smartfleet-staging`
  - Disable Google Analytics (optional)
  - [Create Project](https://console.firebase.google.com/)

- [ ] **Create Production Project**
  - Project ID: `smartfleet-prod`
  - Disable Google Analytics (optional)
  - [Create Project](https://console.firebase.google.com/)

---

### Task T2: Enable Firestore Database

For **EACH** environment (dev, staging, prod):

- [ ] **smartfleet-dev**
  - Navigate to Firestore Database
  - Create database in **production mode**
  - Select region: **us-central1 (Iowa)**
  - [Dev Firestore](https://console.firebase.google.com/project/smartfleet-dev/firestore)

- [ ] **smartfleet-staging**
  - Navigate to Firestore Database
  - Create database in **production mode**
  - Select region: **us-central1 (Iowa)**
  - [Staging Firestore](https://console.firebase.google.com/project/smartfleet-staging/firestore)

- [ ] **smartfleet-prod**
  - Navigate to Firestore Database
  - Create database in **production mode**
  - Select region: **us-central1 (Iowa)**
  - [Prod Firestore](https://console.firebase.google.com/project/smartfleet-prod/firestore)

---

### Task T3: Enable Authentication

For **EACH** environment:

- [ ] **smartfleet-dev**
  - Go to Authentication → Sign-in method
  - Enable **Email/Password**
  - Enable **Google** (enter support email)
  - [Dev Auth](https://console.firebase.google.com/project/smartfleet-dev/authentication)

- [ ] **smartfleet-staging**
  - Go to Authentication → Sign-in method
  - Enable **Email/Password**
  - Enable **Google** (enter support email)
  - [Staging Auth](https://console.firebase.google.com/project/smartfleet-staging/authentication)

- [ ] **smartfleet-prod**
  - Go to Authentication → Sign-in method
  - Enable **Email/Password**
  - Enable **Google** (enter support email)
  - [Prod Auth](https://console.firebase.google.com/project/smartfleet-prod/authentication)

---

### Task T4: Enable Cloud Functions & Upgrade to Blaze Plan

For **EACH** environment:

- [ ] **smartfleet-dev**
  - Go to Build → Functions
  - Upgrade to **Blaze (Pay as you go)** plan
  - Confirm Node.js 20 runtime
  - [Dev Functions](https://console.firebase.google.com/project/smartfleet-dev/functions)

- [ ] **smartfleet-staging**
  - Go to Build → Functions
  - Upgrade to **Blaze (Pay as you go)** plan
  - Confirm Node.js 20 runtime
  - [Staging Functions](https://console.firebase.google.com/project/smartfleet-staging/functions)

- [ ] **smartfleet-prod**
  - Go to Build → Functions
  - Upgrade to **Blaze (Pay as you go)** plan
  - Confirm Node.js 20 runtime
  - [Prod Functions](https://console.firebase.google.com/project/smartfleet-prod/functions)

---

### Task T5: Enable Cloud Storage

For **EACH** environment:

- [ ] **smartfleet-dev**
  - Go to Build → Storage
  - Start in production mode
  - Select region: **us-central1**
  - Verify bucket: `smartfleet-dev.appspot.com`
  - [Dev Storage](https://console.firebase.google.com/project/smartfleet-dev/storage)

- [ ] **smartfleet-staging**
  - Go to Build → Storage
  - Start in production mode
  - Select region: **us-central1**
  - Verify bucket: `smartfleet-staging.appspot.com`
  - [Staging Storage](https://console.firebase.google.com/project/smartfleet-staging/storage)

- [ ] **smartfleet-prod**
  - Go to Build → Storage
  - Start in production mode
  - Select region: **us-central1**
  - Verify bucket: `smartfleet-prod.appspot.com`
  - [Prod Storage](https://console.firebase.google.com/project/smartfleet-prod/storage)

---

### Task T6: Enable Firebase Hosting

For **EACH** environment:

- [ ] **smartfleet-dev**
  - Go to Build → Hosting
  - Complete setup wizard
  - Note URL: `https://smartfleet-dev.web.app`
  - [Dev Hosting](https://console.firebase.google.com/project/smartfleet-dev/hosting)

- [ ] **smartfleet-staging**
  - Go to Build → Hosting
  - Complete setup wizard
  - Note URL: `https://smartfleet-staging.web.app`
  - [Staging Hosting](https://console.firebase.google.com/project/smartfleet-staging/hosting)

- [ ] **smartfleet-prod**
  - Go to Build → Hosting
  - Complete setup wizard
  - Note URL: `https://smartfleet-prod.web.app`
  - [Prod Hosting](https://console.firebase.google.com/project/smartfleet-prod/hosting)

---

### Task T7: Enable Cloud Messaging (FCM)

- [ ] **Verify FCM is enabled** (automatically enabled when project is created)
  - Check in Firebase Console → Build → Messaging
  - No additional setup required at this stage
  - Will configure when setting up Flutter apps (US-005)

---

### Task T8: Configure Billing & Budget Alerts

For **EACH** environment:

- [ ] **smartfleet-dev**
  - Go to Project Settings → Usage and billing
  - Verify Blaze plan is active
  - Go to [Google Cloud Console Billing](https://console.cloud.google.com/billing)
  - Create budget with alerts at: $25, $50, $100
  - Add team email addresses for notifications

- [ ] **smartfleet-staging**
  - Go to Project Settings → Usage and billing
  - Verify Blaze plan is active
  - Create budget with alerts at: $37.50, $75, $150

- [ ] **smartfleet-prod**
  - Go to Project Settings → Usage and billing
  - Verify Blaze plan is active
  - Create budget with alerts at: $50, $100, $200

---

### Task T9: Generate Service Account Keys

For **EACH** environment:

- [ ] **smartfleet-dev**
  - Go to [Google Cloud Console](https://console.cloud.google.com/)
  - Select `smartfleet-dev` project
  - Go to IAM & Admin → Service Accounts
  - Create service account: `smartfleet-dev-ci-cd`
  - Grant role: **Firebase Admin**
  - Create JSON key
  - **Download and store securely** (NOT in Git)
  - Add to GitHub Secrets as `FIREBASE_SERVICE_ACCOUNT_DEV`

- [ ] **smartfleet-staging**
  - Repeat above for `smartfleet-staging`
  - Service account name: `smartfleet-staging-ci-cd`
  - Add to GitHub Secrets as `FIREBASE_SERVICE_ACCOUNT_STAGING`

- [ ] **smartfleet-prod**
  - Repeat above for `smartfleet-prod`
  - Service account name: `smartfleet-prod-ci-cd`
  - Add to GitHub Secrets as `FIREBASE_SERVICE_ACCOUNT_PROD`

---

### Task T10: Download Firebase Configuration Files

For **EACH** environment:

- [ ] **smartfleet-dev - Web**
  - Go to Project Settings → General
  - Under "Your apps", add Web app
  - App nickname: `smartfleet-web-dev`
  - Copy configuration values to `.env` file

- [ ] **smartfleet-dev - Android**
  - Add Android app
  - Package name: `com.smartfleetpro.totaltracking.dev`
  - Download `google-services.json`
  - Place in `android/app/src/dev/`

- [ ] **smartfleet-dev - iOS**
  - Add iOS app
  - Bundle ID: `com.smartfleetpro.totaltracking.dev`
  - Download `GoogleService-Info.plist`
  - Place in `ios/Runner/dev/`

- [ ] **Repeat for staging** (package: `*.staging`, bundle: `*.staging`)

- [ ] **Repeat for production** (package: `*.totaltracking`, bundle: `*.totaltracking`)

---

## 📋 Verification Steps

After completing all manual setup:

- [ ] Run `firebase login` and authenticate
- [ ] Run `firebase projects:list` and verify all 3 projects appear
- [ ] Run `firebase use dev` to select dev project
- [ ] Run `firebase deploy --only firestore:rules --debug` to test deployment
- [ ] Verify deployment succeeds without errors
- [ ] Check Firestore rules in Firebase Console
- [ ] Repeat for staging and production

---

## ✅ Acceptance Criteria Status

Based on US-001 requirements:

- [ ] **AC1:** 3 Firebase projects exist (dev, staging, production) with consistent naming
- [ ] **AC2:** All services enabled: Firestore, Auth, Functions, Storage, Hosting, FCM
- [ ] **AC3:** Configuration files generated and stored securely
- [ ] **AC4:** Billing configured with alerts at $50, $100, $200
- [ ] **AC5:** Documentation created (✅ `docs/firebase-setup.md` exists)

---

## 📝 Notes

- **Security:** All sensitive files are in `.gitignore`
- **Service account keys:** Rotation required every 90 days (next: Feb 21, 2026)
- **Estimated time:** 2-3 hours for manual setup across all environments
- **Support:** Refer to `docs/firebase-setup.md` for detailed instructions

---

## 🎯 Next Steps

After US-001 is complete:

1. **US-002:** Define Firestore collections and schemas
2. **US-003:** Implement comprehensive security rules
3. **US-004:** Setup CI/CD with GitHub Actions
4. **US-005:** Setup Flutter project with flavors

---

**Last Updated:** November 21, 2025  
**Status:** Automated setup complete, manual setup pending  
**Estimated Completion:** 2-3 hours of manual work
