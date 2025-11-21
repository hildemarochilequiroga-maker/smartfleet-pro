# Firebase Setup Documentation

## Overview

This document provides comprehensive instructions for setting up and managing Firebase projects for SmartFleet Pro across three environments: **Development**, **Staging**, and **Production**.

**Last Updated:** November 21, 2025  
**Document Version:** 1.0  
**Author:** SmartFleet Pro Team

---

## Table of Contents

1. [Firebase Projects Overview](#firebase-projects-overview)
2. [Prerequisites](#prerequisites)
3. [Step-by-Step Setup Guide](#step-by-step-setup-guide)
4. [Service Configuration](#service-configuration)
5. [Security & Access Management](#security--access-management)
6. [Billing Configuration](#billing-configuration)
7. [CI/CD Integration](#cicd-integration)
8. [Service Account Management](#service-account-management)
9. [Environment-Specific URLs](#environment-specific-urls)
10. [Troubleshooting](#troubleshooting)
11. [Maintenance & Best Practices](#maintenance--best-practices)

---

## Firebase Projects Overview

### Project Naming Convention

We use a consistent naming pattern across all Firebase projects:

| Environment | Project ID | Firebase Console URL |
|-------------|------------|---------------------|
| **Development** | `smartfleet-dev` | https://console.firebase.google.com/project/smartfleet-dev |
| **Staging** | `smartfleet-staging` | https://console.firebase.google.com/project/smartfleet-staging |
| **Production** | `smartfleet-prod` | https://console.firebase.google.com/project/smartfleet-prod |

### Services Enabled

Each environment has the following Firebase services enabled:

✅ **Firestore Database** (Native mode, `us-central1`)  
✅ **Authentication** (Email/Password, Google Sign-In)  
✅ **Cloud Functions** (Node.js 20 runtime)  
✅ **Cloud Storage** (with environment-specific buckets)  
✅ **Firebase Hosting** (for web admin dashboard)  
✅ **Cloud Messaging (FCM)** (for push notifications)

---

## Prerequisites

Before setting up Firebase projects, ensure you have:

- [ ] Google Cloud Platform (GCP) account with billing enabled
- [ ] Firebase CLI installed (`npm install -g firebase-tools`)
- [ ] Node.js 20+ installed
- [ ] Project Owner or Editor role in GCP
- [ ] Credit card for billing setup (Blaze plan required for Cloud Functions)

### Verify Firebase CLI Installation

```bash
firebase --version
# Should output: 14.26.0 or higher
```

### Login to Firebase CLI

```bash
firebase login
```

---

## Step-by-Step Setup Guide

### Task T1: Create Firebase Projects

#### 1.1 Create Development Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"**
3. Enter project name: **`smartfleet-dev`**
4. **Disable** Google Analytics (can be enabled later if needed)
5. Click **"Create project"**
6. Wait for project creation to complete

#### 1.2 Create Staging Project

Repeat the above steps with project name: **`smartfleet-staging`**

#### 1.3 Create Production Project

Repeat the above steps with project name: **`smartfleet-prod`**

---

### Task T2: Enable Firestore Database

For **each environment** (dev, staging, prod):

1. Navigate to **Firestore Database** in Firebase Console
2. Click **"Create database"**
3. Select **"Start in production mode"** (we'll configure rules manually)
4. Choose location: **`us-central1 (Iowa)`**
   - **Rationale:** Closest to Latin America (Colombia, Perú, Chile) with good latency
5. Click **"Enable"**

**⚠️ Important:** Once selected, the Firestore location **cannot be changed**.

---

### Task T3: Enable Authentication

For **each environment**:

1. Go to **Authentication** → **Sign-in method**
2. Enable **Email/Password**:
   - Click on **Email/Password** → Toggle **Enable** → Save
3. Enable **Google** (for admin web):
   - Click on **Google** → Toggle **Enable**
   - Enter support email
   - Save

**Additional Providers (Future):**
- Phone authentication (optional for Fase 2)
- Apple Sign-In (for iOS, optional)

---

### Task T4: Enable Cloud Functions

For **each environment**:

1. Go to **Build** → **Functions**
2. Click **"Get started"**
3. Click **"Upgrade project"** to **Blaze (Pay as you go)** plan
   - **Required for Cloud Functions**
   - Configure billing in next step
4. Default runtime: **Node.js 20**
5. Default region: **us-central1**

**Note:** Functions won't be deployed until you run `firebase deploy --only functions`

---

### Task T5: Enable Cloud Storage

For **each environment**:

1. Go to **Build** → **Storage**
2. Click **"Get started"**
3. Select **"Start in production mode"** (rules configured separately)
4. Choose location: **`us-central1`** (same as Firestore)
5. Click **"Done"**

**Default Bucket Names:**
- Dev: `smartfleet-dev.appspot.com`
- Staging: `smartfleet-staging.appspot.com`
- Prod: `smartfleet-prod.appspot.com`

---

### Task T6: Enable Firebase Hosting

For **each environment**:

1. Go to **Build** → **Hosting**
2. Click **"Get started"**
3. Follow the wizard (skip deployment for now)

**Hosting URLs:**
- Dev: `https://smartfleet-dev.web.app`
- Staging: `https://smartfleet-staging.web.app`
- Prod: `https://smartfleet-prod.web.app`

---

### Task T7: Enable Cloud Messaging (FCM)

For **each environment**:

1. Go to **Build** → **Messaging**
2. Cloud Messaging is **automatically enabled** when you create an app
3. We'll configure Android/iOS apps when setting up Flutter (US-005)

---

## Service Configuration

### Firestore Security Rules

Security rules are located in `/firebase/firestore.rules`. Deploy with:

```bash
cd firebase
firebase use dev  # or staging, prod
firebase deploy --only firestore:rules
```

**Initial Rules (Temporary):**
```javascript
// Allow all authenticated users (will be restricted in US-003)
match /{document=**} {
  allow read, write: if request.auth != null;
}
```

### Firestore Indexes

Composite indexes are defined in `/firebase/firestore.indexes.json`. Deploy with:

```bash
firebase deploy --only firestore:indexes
```

**Note:** Indexes can take several minutes to build. Check status in Firebase Console.

---

## Security & Access Management

### IAM Roles

Recommended roles for team members:

| Role | Permissions | Use Case |
|------|-------------|----------|
| **Owner** | Full access | Project lead only |
| **Editor** | Read/Write access | Developers |
| **Viewer** | Read-only access | Stakeholders, QA |
| **Firebase Admin** | Firebase-specific admin | DevOps team |

### Add Team Members

1. Go to **Project Settings** → **Users and permissions**
2. Click **"Add member"**
3. Enter email address
4. Select role
5. Click **"Add"**

---

## Billing Configuration

### Task T8: Configure Billing & Alerts

For **each environment**:

#### 8.1 Link Billing Account

1. Go to **Project Settings** (gear icon) → **Usage and billing**
2. Click **"Modify plan"**
3. Select **"Blaze (Pay as you go)"**
4. Link your billing account
5. Confirm upgrade

#### 8.2 Set Budget Alerts

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Navigate to **Billing** → **Budgets & alerts**
3. Click **"Create budget"**
4. Configure alerts:

   - **Alert 1:** $50 (50% of $100 monthly budget)
   - **Alert 2:** $100 (100% of budget)
   - **Alert 3:** $200 (200% - critical overage)

5. Add email recipients for alerts
6. Save

**Recommended Monthly Budgets:**
- **Dev:** $50/month
- **Staging:** $75/month
- **Production:** $200/month (adjust based on usage)

---

## CI/CD Integration

### Task T9: Generate Service Account Keys

⚠️ **CRITICAL SECURITY:** Service account keys provide full access to Firebase projects. Handle with extreme care.

#### 9.1 Create Service Account (per environment)

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your project (e.g., `smartfleet-dev`)
3. Go to **IAM & Admin** → **Service Accounts**
4. Click **"Create Service Account"**
5. Enter details:
   - **Name:** `smartfleet-dev-ci-cd`
   - **Description:** "Service account for CI/CD deployments"
6. Click **"Create and continue"**
7. Grant roles:
   - **Firebase Admin** (for full Firebase access)
   - **Cloud Functions Admin** (if separate granular control needed)
8. Click **"Done"**

#### 9.2 Generate Key

1. Find the service account in the list
2. Click **Actions** (three dots) → **Manage keys**
3. Click **"Add key"** → **"Create new key"**
4. Select **JSON** format
5. Click **"Create"** → Key file downloads automatically
6. **IMMEDIATELY** move this file to a secure location
7. **NEVER** commit to Git

#### 9.3 Store in GitHub Secrets

1. Go to your GitHub repository → **Settings** → **Secrets and variables** → **Actions**
2. Click **"New repository secret"**
3. Add the following secrets:

   | Secret Name | Value |
   |-------------|-------|
   | `FIREBASE_SERVICE_ACCOUNT_DEV` | Contents of `smartfleet-dev-xxxx.json` |
   | `FIREBASE_SERVICE_ACCOUNT_STAGING` | Contents of `smartfleet-staging-xxxx.json` |
   | `FIREBASE_SERVICE_ACCOUNT_PROD` | Contents of `smartfleet-prod-xxxx.json` |

4. Click **"Add secret"**

**Alternative (Base64 encoding):**

```bash
# Encode service account key to base64
cat smartfleet-dev-xxxx.json | base64 > key.base64.txt
# Copy contents of key.base64.txt to GitHub Secret
```

---

## Service Account Management

### Principle of Least Privilege

Each service account should have **minimum necessary permissions**:

- **CI/CD accounts:** Only deployment permissions
- **Application accounts:** Only read/write to Firestore/Storage
- **Admin accounts:** Full access (use sparingly)

### Rotation Schedule

🔒 **Security Best Practice:** Rotate service account keys every **90 days**.

#### Rotation Procedure

1. Create new service account key (follow steps in 9.2)
2. Update GitHub Secrets with new key
3. Verify CI/CD pipeline works with new key
4. Delete old key from GCP Console
5. Document rotation in team log

**Next Rotation Date:** February 21, 2026 (90 days from setup)

---

## Environment-Specific URLs

### Firebase Console

- **Dev:** https://console.firebase.google.com/project/smartfleet-dev
- **Staging:** https://console.firebase.google.com/project/smartfleet-staging
- **Production:** https://console.firebase.google.com/project/smartfleet-prod

### Firestore Console

- **Dev:** https://console.firebase.google.com/project/smartfleet-dev/firestore
- **Staging:** https://console.firebase.google.com/project/smartfleet-staging/firestore
- **Production:** https://console.firebase.google.com/project/smartfleet-prod/firestore

### Cloud Functions URLs

- **Dev:** `https://us-central1-smartfleet-dev.cloudfunctions.net/<function_name>`
- **Staging:** `https://us-central1-smartfleet-staging.cloudfunctions.net/<function_name>`
- **Production:** `https://us-central1-smartfleet-prod.cloudfunctions.net/<function_name>`

### Firebase Hosting

- **Dev:** https://smartfleet-dev.web.app
- **Staging:** https://smartfleet-staging.web.app
- **Production:** https://smartfleet-prod.web.app

### Cloud Storage Buckets

- **Dev:** `gs://smartfleet-dev.appspot.com`
- **Staging:** `gs://smartfleet-staging.appspot.com`
- **Production:** `gs://smartfleet-prod.appspot.com`

---

## Troubleshooting

### Common Issues

#### Issue: "Billing account required"
**Solution:** Upgrade to Blaze plan (see Task T8)

#### Issue: "Permission denied" when deploying
**Solution:** Ensure you're logged in with correct account: `firebase login`

#### Issue: Firestore indexes taking too long
**Solution:** Indexes can take 10-15 minutes to build. Check status in Firebase Console.

#### Issue: "Firebase project not found"
**Solution:** Run `firebase use <project_id>` to select correct project

### Verify Setup

Run these commands to verify setup:

```bash
# Check current project
firebase use

# List all projects
firebase projects:list

# Test deployment (dry run)
firebase deploy --only firestore:rules --debug
```

---

## Maintenance & Best Practices

### Daily Checks
- [ ] Monitor billing dashboard for unexpected charges
- [ ] Check error logs in Cloud Functions

### Weekly Checks
- [ ] Review Firestore usage metrics
- [ ] Check authentication logs for suspicious activity

### Monthly Checks
- [ ] Review billing and adjust budgets if needed
- [ ] Update dependencies in Cloud Functions
- [ ] Audit IAM permissions

### Quarterly Checks
- [ ] **Rotate service account keys** (every 90 days)
- [ ] Review security rules for improvements
- [ ] Archive old data from Firestore (if applicable)

### Security Checklist

- [ ] Service account keys stored only in GitHub Secrets (not in code)
- [ ] `.env` file added to `.gitignore`
- [ ] Firestore security rules deployed and tested
- [ ] Budget alerts configured
- [ ] Team members have appropriate IAM roles
- [ ] Two-factor authentication enabled for all team members

---

## Next Steps

After completing this setup:

1. ✅ **US-001 Complete:** Firebase projects configured
2. ➡️ **US-002:** Define Firestore collections and schemas
3. ➡️ **US-003:** Implement comprehensive security rules
4. ➡️ **US-004:** Setup CI/CD with GitHub Actions

---

## Support & Resources

- **Firebase Documentation:** https://firebase.google.com/docs
- **Firebase CLI Reference:** https://firebase.google.com/docs/cli
- **Firestore Best Practices:** https://firebase.google.com/docs/firestore/best-practices
- **Firebase Support:** https://firebase.google.com/support

---

## Changelog

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| 2025-11-21 | 1.0 | Initial documentation | SmartFleet Team |

---

**Document Status:** ✅ Complete  
**Review Date:** February 21, 2026  
**Confidential:** Internal use only - Do not share publicly
