# GitHub Actions CI/CD - Configuración de Secrets

Esta guía explica cómo configurar los secrets de GitHub necesarios para que los workflows de CI/CD funcionen correctamente.

## 📋 Índice

1. [Secrets Requeridos](#secrets-requeridos)
2. [Crear Service Accounts en Firebase](#crear-service-accounts-en-firebase)
3. [Configurar Secrets en GitHub](#configurar-secrets-en-github)
4. [Configurar Firebase Tokens](#configurar-firebase-tokens)
5. [Verificar Configuración](#verificar-configuración)
6. [Rotación de Secrets](#rotación-de-secrets)
7. [Troubleshooting](#troubleshooting)

## Secrets Requeridos

### Por Ambiente

Cada ambiente (dev, staging, prod) requiere los siguientes secrets:

| Secret Name | Descripción | Usado en |
|-------------|-------------|----------|
| `FIREBASE_SERVICE_ACCOUNT_DEV` | Service account JSON para desarrollo | deploy-dev.yml |
| `FIREBASE_SERVICE_ACCOUNT_STAGING` | Service account JSON para staging | deploy-staging.yml |
| `FIREBASE_SERVICE_ACCOUNT_PROD` | Service account JSON para producción | deploy-prod.yml |
| `FIREBASE_TOKEN_DEV` | Token de autenticación CLI para dev | deploy-dev.yml |
| `FIREBASE_TOKEN_STAGING` | Token de autenticación CLI para staging | deploy-staging.yml |
| `FIREBASE_TOKEN_PROD` | Token de autenticación CLI para producción | deploy-prod.yml |

### Opcionales (Notificaciones)

| Secret Name | Descripción | Usado en |
|-------------|-------------|----------|
| `SLACK_WEBHOOK` | Webhook URL para notificaciones Slack | Todos los workflows |
| `DISCORD_WEBHOOK` | Webhook URL para notificaciones Discord | Todos los workflows |
| `SNYK_TOKEN` | Token para análisis de seguridad Snyk | deploy-prod.yml |

## Crear Service Accounts en Firebase

### Paso 1: Acceder a Firebase Console

1. Ve a [Firebase Console](https://console.firebase.google.com)
2. Selecciona tu proyecto (ej: `smartfleet-pro-dev`)

### Paso 2: Crear Service Account

1. Ve a **Project Settings** (⚙️ en la esquina superior izquierda)
2. Selecciona la pestaña **Service Accounts**
3. Click en **Generate New Private Key**
4. Se descargará un archivo JSON con las credenciales

**⚠️ IMPORTANTE:**
- Guarda este archivo en un lugar seguro
- NUNCA lo subas a Git
- Cada ambiente debe tener su propio service account

### Paso 3: Repetir para cada ambiente

Repite los pasos anteriores para:
- `smartfleet-pro-dev`
- `smartfleet-pro-staging`
- `smartfleet-pro-prod`

### Paso 4: Permisos del Service Account

Verifica que el service account tenga los siguientes roles:

```
✅ Firebase Admin
✅ Cloud Functions Admin
✅ Firestore Admin
✅ Storage Admin
✅ Hosting Admin
```

Para verificar/modificar permisos:
1. Ve a [Google Cloud Console](https://console.cloud.google.com)
2. IAM & Admin → Service Accounts
3. Encuentra el service account
4. Click en "Edit" y agrega los roles necesarios

## Configurar Secrets en GitHub

### Método 1: Via GitHub Web UI

1. Ve a tu repositorio en GitHub
2. Settings → Secrets and variables → Actions
3. Click en "New repository secret"
4. Agrega cada secret:

#### FIREBASE_SERVICE_ACCOUNT_DEV

```
Name: FIREBASE_SERVICE_ACCOUNT_DEV
Secret: [Pega TODO el contenido del archivo JSON descargado]
```

**Ejemplo del contenido JSON:**
```json
{
  "type": "service_account",
  "project_id": "smartfleet-pro-dev",
  "private_key_id": "abc123...",
  "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-xxxxx@smartfleet-pro-dev.iam.gserviceaccount.com",
  "client_id": "123456789...",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/..."
}
```

Repite para `FIREBASE_SERVICE_ACCOUNT_STAGING` y `FIREBASE_SERVICE_ACCOUNT_PROD`.

### Método 2: Via GitHub CLI

```bash
# Instalar GitHub CLI
# https://cli.github.com/

# Login
gh auth login

# Agregar secrets
gh secret set FIREBASE_SERVICE_ACCOUNT_DEV < smartfleet-pro-dev-service-account.json
gh secret set FIREBASE_SERVICE_ACCOUNT_STAGING < smartfleet-pro-staging-service-account.json
gh secret set FIREBASE_SERVICE_ACCOUNT_PROD < smartfleet-pro-prod-service-account.json
```

## Configurar Firebase Tokens

Los tokens de Firebase CLI permiten ejecutar comandos de deploy sin login interactivo.

### Paso 1: Generar Token

```bash
# Instalar Firebase CLI si no lo tienes
npm install -g firebase-tools

# Login en Firebase
firebase login

# Generar token CI
firebase login:ci
```

Esto te dará un token como:
```
1//abcdefghijklmnopqrstuvwxyz
```

### Paso 2: Agregar Tokens a GitHub

Agrega cada token como secret:

```bash
# Via GitHub CLI
gh secret set FIREBASE_TOKEN_DEV
# Pega el token cuando te lo pida

gh secret set FIREBASE_TOKEN_STAGING
# Pega el token cuando te lo pida

gh secret set FIREBASE_TOKEN_PROD
# Pega el token cuando te lo pida
```

O via Web UI:
1. Settings → Secrets and variables → Actions
2. New repository secret
3. Name: `FIREBASE_TOKEN_DEV`
4. Secret: `1//abcdefghijklmnopqrstuvwxyz`

**⚠️ NOTA:** Aunque los tokens pueden ser los mismos para todos los ambientes, se recomienda tener tokens separados para mejor control de acceso.

## Configurar Environments en GitHub

Para que la aprobación manual funcione en production, necesitas crear environments:

### Paso 1: Crear Environments

1. Ve a tu repositorio en GitHub
2. Settings → Environments
3. Click "New environment"
4. Crea 3 environments:
   - `development`
   - `staging`
   - `production`

### Paso 2: Configurar Protection Rules

#### Production Environment

1. Selecciona el environment `production`
2. Habilita "Required reviewers"
3. Agrega revisores autorizados (admins del proyecto)
4. Opcionalmente: Agrega "Wait timer" (ej: 5 minutos)

**Configuración recomendada para Production:**
```
✅ Required reviewers: 1-2 personas
✅ Wait timer: 5 minutos
✅ Deployment branches: main only
```

#### Staging Environment

1. Selecciona el environment `staging`
2. Habilita "Required reviewers" (opcional)
3. Deployment branches: `staging` only

#### Development Environment

1. Selecciona el environment `development`
2. No requiere aprobación manual
3. Deployment branches: `develop` only

## Verificar Configuración

### Checklist de Secrets

Verifica que todos los secrets estén configurados:

```bash
# Via GitHub CLI
gh secret list

# Deberías ver:
FIREBASE_SERVICE_ACCOUNT_DEV
FIREBASE_SERVICE_ACCOUNT_STAGING
FIREBASE_SERVICE_ACCOUNT_PROD
FIREBASE_TOKEN_DEV
FIREBASE_TOKEN_STAGING
FIREBASE_TOKEN_PROD
```

### Test de Deploy

1. Crea una branch `develop` si no existe:
```bash
git checkout -b develop
git push origin develop
```

2. Haz un pequeño cambio y push:
```bash
echo "# Test" >> README.md
git add .
git commit -m "test: CI/CD setup"
git push origin develop
```

3. Ve a Actions en GitHub y verifica que el workflow se ejecute.

## Rotación de Secrets

**⚠️ IMPORTANTE:** Los service accounts y tokens deben rotarse cada 90 días por seguridad.

### Procedimiento de Rotación

#### Service Accounts

1. Ve a Firebase Console → Project Settings → Service Accounts
2. Click "Generate New Private Key"
3. Descarga el nuevo JSON
4. Actualiza el secret en GitHub:
   ```bash
   gh secret set FIREBASE_SERVICE_ACCOUNT_PROD < new-service-account.json
   ```
5. Opcionalmente: Revoca el service account antiguo después de confirmar que el nuevo funciona

#### Firebase Tokens

1. Genera nuevo token:
   ```bash
   firebase login:ci
   ```
2. Actualiza el secret:
   ```bash
   gh secret set FIREBASE_TOKEN_PROD
   ```
3. Revoca el token antiguo:
   ```bash
   firebase logout --token OLD_TOKEN
   ```

### Calendario de Rotación

Establece recordatorios cada 90 días:

| Fecha de creación | Próxima rotación |
|-------------------|------------------|
| 2025-11-21 | 2026-02-19 |
| 2026-02-19 | 2026-05-20 |
| 2026-05-20 | 2026-08-18 |

## Troubleshooting

### Error: "FIREBASE_SERVICE_ACCOUNT_XXX not found"

**Causa:** Secret no configurado o mal nombrado.

**Solución:**
```bash
# Verificar secrets
gh secret list

# Agregar el secret faltante
gh secret set FIREBASE_SERVICE_ACCOUNT_DEV < service-account.json
```

### Error: "Authentication failed"

**Causa:** Service account sin permisos o expirado.

**Solución:**
1. Ve a Google Cloud Console
2. IAM & Admin → Service Accounts
3. Verifica que el service account tenga roles:
   - Firebase Admin
   - Cloud Functions Admin
4. Regenera el private key si es necesario

### Error: "Token expired"

**Causa:** Firebase token expirado o revocado.

**Solución:**
```bash
# Generar nuevo token
firebase login:ci

# Actualizar secret
gh secret set FIREBASE_TOKEN_PROD
```

### Workflow no se ejecuta

**Causa:** Branch protection o triggers mal configurados.

**Solución:**
1. Verifica que la branch existe (`develop`, `staging`, `main`)
2. Revisa los triggers en el archivo `.yml`:
   ```yaml
   on:
     push:
       branches:
         - develop  # Verifica que coincida con tu branch
   ```
3. Verifica que el archivo esté en `.github/workflows/`

### Deploy falla en producción

**Causa:** Falta aprobación manual o reviewers no configurados.

**Solución:**
1. Settings → Environments → production
2. Configura "Required reviewers"
3. Aprueba el deploy manualmente en la pestaña Actions

## Seguridad: Best Practices

### ✅ DO

- Usar service accounts dedicados por ambiente
- Rotar secrets cada 90 días
- Usar GitHub Environments para control de acceso
- Auditar access logs regularmente
- Usar principle of least privilege
- Documentar todos los secrets y su propósito

### ❌ DON'T

- Compartir service accounts entre ambientes
- Subir secrets a Git (usar .gitignore)
- Usar personal tokens en lugar de service accounts
- Dar acceso de admin a todos los developers
- Ignorar notificaciones de rotación de secrets
- Hardcodear credenciales en código

## Documentación Adicional

- [Firebase Service Accounts](https://firebase.google.com/docs/admin/setup#initialize-sdk)
- [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [GitHub Environments](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)
- [Firebase CLI Reference](https://firebase.google.com/docs/cli)

## Contacto y Soporte

En caso de problemas:
1. Revisa los logs de GitHub Actions
2. Consulta la documentación oficial
3. Contacta al DevOps lead del proyecto

---

**Última actualización:** 2025-11-21  
**Responsable:** DevOps Team  
**Próxima revisión:** 2026-02-19
