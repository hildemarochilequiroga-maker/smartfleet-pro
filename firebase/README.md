# SmartFleet Pro - Firebase Project Structure

## Directory Structure

```
firebase/
├── .firebaserc                 # Firebase project aliases (dev, staging, prod)
├── firebase.json               # Firebase configuration
├── firestore.rules            # Firestore security rules
├── firestore.indexes.json     # Firestore composite indexes
├── storage.rules              # Cloud Storage security rules
├── config/                     # Configuration files (gitignored)
│   ├── firebase-config-dev.json.template
│   ├── firebase-config-staging.json.template
│   └── firebase-config-prod.json.template
├── functions/                  # Cloud Functions (to be set up in US-002)
│   ├── package.json
│   ├── tsconfig.json
│   └── src/
└── public/                     # Hosting files
    └── index.html
```

## Quick Commands

### Switch between environments

```bash
# Use development environment
firebase use dev

# Use staging environment
firebase use staging

# Use production environment
firebase use prod
```

### Deploy specific services

```bash
# Deploy Firestore rules only
firebase deploy --only firestore:rules

# Deploy Firestore indexes only
firebase deploy --only firestore:indexes

# Deploy Storage rules only
firebase deploy --only storage

# Deploy Cloud Functions only
firebase deploy --only functions

# Deploy Hosting only
firebase deploy --only hosting

# Deploy everything
firebase deploy
```

### Testing locally

```bash
# Serve hosting locally
firebase serve --only hosting

# Emulate Firestore and Functions locally
firebase emulators:start
```

## Configuration Notes

- **All sensitive configuration files are in `.gitignore`**
- **Templates are provided in `config/` directory**
- **Real configuration files should be created from templates**
- **Never commit actual Firebase credentials to version control**

## Next Steps

1. Create actual Firebase projects in Firebase Console (see `docs/firebase-setup.md`)
2. Download configuration files and place in `config/` directory
3. Set up Cloud Functions (US-002)
4. Configure Firestore collections and indexes (US-002)
5. Implement security rules (US-003)

## Documentation

See `docs/firebase-setup.md` for complete setup instructions.
