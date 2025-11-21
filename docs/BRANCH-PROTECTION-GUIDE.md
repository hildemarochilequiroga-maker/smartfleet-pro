# Branch Protection Rules - Configuración

Esta guía explica cómo configurar las reglas de protección de branches en GitHub para mantener la calidad del código y prevenir deployments accidentales.

## 📋 Índice

1. [Estrategia de Branches](#estrategia-de-branches)
2. [Configurar Branch Protection](#configurar-branch-protection)
3. [Reglas por Branch](#reglas-por-branch)
4. [Git Flow Workflow](#git-flow-workflow)
5. [Merge Strategies](#merge-strategies)

## Estrategia de Branches

SmartFleet Pro utiliza una estrategia de branching basada en Git Flow:

```
main (production)
  ├── staging
  │    ├── develop
  │    │    ├── feature/US-XXX-descripcion
  │    │    ├── bugfix/issue-123-descripcion
  │    │    └── hotfix/critical-fix
  │    └── release/v1.0.0
  └── hotfix/production-critical-fix
```

### Descripción de Branches

| Branch | Propósito | Deploy a |
|--------|-----------|----------|
| `main` | Producción estable | Firebase Production |
| `staging` | Pre-producción para QA | Firebase Staging |
| `develop` | Desarrollo activo | Firebase Dev |
| `feature/*` | Nuevas funcionalidades | No deploy automático |
| `bugfix/*` | Corrección de bugs | No deploy automático |
| `hotfix/*` | Fixes críticos de producción | Merge directo a main |
| `release/*` | Preparación de releases | No deploy automático |

## Configurar Branch Protection

### Acceso a Settings

1. Ve a tu repositorio en GitHub
2. Settings → Branches
3. Click "Add branch protection rule"

### Reglas por Branch

#### 1. Branch: `main` (Production)

**Patrón:** `main`

**Reglas obligatorias:**

```yaml
✅ Require a pull request before merging
   ✅ Require approvals: 2
   ✅ Dismiss stale pull request approvals when new commits are pushed
   ✅ Require review from Code Owners

✅ Require status checks to pass before merging
   ✅ Require branches to be up to date before merging
   Status checks required:
   - lint
   - test-rules
   - test-functions
   - security-scan
   - build

✅ Require conversation resolution before merging

✅ Require signed commits (opcional pero recomendado)

✅ Require linear history

✅ Include administrators (admins también deben seguir las reglas)

❌ Allow force pushes (NUNCA en main)

❌ Allow deletions (NUNCA en main)
```

**Configuración vía Web UI:**

1. Branch name pattern: `main`
2. Protect matching branches:
   - ✅ Require pull request reviews before merging
     - Required approving reviews: `2`
     - ✅ Dismiss stale pull request approvals
     - ✅ Require review from Code Owners
   - ✅ Require status checks to pass
     - ✅ Require branches to be up to date
     - Search for status checks: `lint`, `test-rules`, `test-functions`, `security-scan`, `build`
   - ✅ Require conversation resolution
   - ✅ Require linear history
   - ✅ Include administrators
3. Click "Create"

#### 2. Branch: `staging` (Staging)

**Patrón:** `staging`

**Reglas obligatorias:**

```yaml
✅ Require a pull request before merging
   ✅ Require approvals: 1
   ✅ Dismiss stale pull request approvals when new commits are pushed

✅ Require status checks to pass before merging
   ✅ Require branches to be up to date before merging
   Status checks required:
   - lint
   - test-rules
   - build

✅ Require conversation resolution before merging

✅ Require linear history

❌ Allow force pushes (NUNCA en staging)

❌ Allow deletions (NUNCA en staging)
```

**Configuración vía Web UI:**

1. Branch name pattern: `staging`
2. Protect matching branches:
   - ✅ Require pull request reviews before merging
     - Required approving reviews: `1`
     - ✅ Dismiss stale pull request approvals
   - ✅ Require status checks to pass
     - ✅ Require branches to be up to date
     - Status checks: `lint`, `test-rules`, `build`
   - ✅ Require conversation resolution
   - ✅ Require linear history
3. Click "Create"

#### 3. Branch: `develop` (Development)

**Patrón:** `develop`

**Reglas obligatorias:**

```yaml
✅ Require a pull request before merging
   ✅ Require approvals: 1

✅ Require status checks to pass before merging
   Status checks required:
   - lint
   - build

❌ Allow force pushes (permitido solo para maintainers)

❌ Allow deletions
```

**Configuración vía Web UI:**

1. Branch name pattern: `develop`
2. Protect matching branches:
   - ✅ Require pull request reviews before merging
     - Required approving reviews: `1`
   - ✅ Require status checks to pass
     - Status checks: `lint`, `build`
3. Click "Create"

#### 4. Branches de Feature/Bugfix

**Patrón:** `feature/*` y `bugfix/*`

No requieren branch protection, pero deben seguir naming conventions:

```bash
feature/US-001-firebase-setup
feature/US-002-firestore-schema
bugfix/fix-authentication-error
bugfix/issue-123-vehicle-assignment
```

## Configurar CODEOWNERS

Crea un archivo `.github/CODEOWNERS` para definir revisores automáticos:

```bash
# CODEOWNERS para SmartFleet Pro

# Default owners para todo el repositorio
* @tu-usuario @tech-lead

# Firebase backend
/firebase/ @backend-team @tech-lead

# Workflows de CI/CD
/.github/workflows/ @devops-team @tech-lead

# Documentación
/docs/ @tech-lead

# Flutter app (cuando se agregue)
# /lib/ @mobile-team @tech-lead

# Security-critical files
/firebase/firestore.rules @backend-team @security-team @tech-lead
```

Para crear el archivo:

```bash
# Crear directorio si no existe
mkdir -p .github

# Crear CODEOWNERS
cat > .github/CODEOWNERS << 'EOF'
# CODEOWNERS para SmartFleet Pro
* @tu-usuario
/firebase/ @tu-usuario
/.github/workflows/ @tu-usuario
/docs/ @tu-usuario
/firebase/firestore.rules @tu-usuario
EOF
```

Reemplaza `@tu-usuario` con los handles de GitHub reales.

## Git Flow Workflow

### Crear Feature Branch

```bash
# Actualizar develop
git checkout develop
git pull origin develop

# Crear feature branch
git checkout -b feature/US-004-cicd-setup

# Trabajar en la feature...
git add .
git commit -m "feat: add GitHub Actions workflows"

# Push feature branch
git push origin feature/US-004-cicd-setup
```

### Crear Pull Request

1. Ve a GitHub → Pull requests → New pull request
2. Base: `develop` ← Compare: `feature/US-004-cicd-setup`
3. Título: `[US-004] Setup CI/CD con GitHub Actions`
4. Descripción:
   ```markdown
   ## Descripción
   Implementa CI/CD con GitHub Actions para deploy automático.
   
   ## Cambios
   - ✅ Workflow deploy-dev.yml
   - ✅ Workflow deploy-staging.yml
   - ✅ Workflow deploy-prod.yml
   - ✅ PR checks workflow
   
   ## Testing
   - [ ] Lint pasa
   - [ ] Build pasa
   - [ ] Tests pasan
   
   ## Relacionado
   Closes #4
   ```
5. Assignees: Tú mismo
6. Reviewers: Code owners automáticos
7. Labels: `enhancement`, `ci-cd`
8. Click "Create pull request"

### Review y Merge

1. Esperar a que los checks pasen (✅ verde)
2. Pedir review a code owners
3. Resolver comentarios
4. Esperar aprobación (✅ Approved)
5. Click "Squash and merge" (recomendado)
6. Confirmar merge
7. Eliminar branch de feature

### Promover a Staging

```bash
# Actualizar develop
git checkout develop
git pull origin develop

# Crear PR de develop → staging
# (Via GitHub UI)
```

1. Base: `staging` ← Compare: `develop`
2. Título: `Release v1.1.0 - Deploy to Staging`
3. Obtener 1 aprobación
4. Merge cuando checks pasen
5. **GitHub Actions deployará automáticamente a staging**

### Promover a Production

```bash
# Actualizar staging
git checkout staging
git pull origin staging

# Crear PR de staging → main
# (Via GitHub UI)
```

1. Base: `main` ← Compare: `staging`
2. Título: `Release v1.1.0 - Production Deploy`
3. Obtener **2 aprobaciones**
4. Todos los checks deben pasar
5. Resolver todas las conversaciones
6. Merge cuando todo esté listo
7. **GitHub Actions deployará a production (con aprobación manual)**

### Hotfix Workflow

Para fixes críticos en producción:

```bash
# Crear hotfix branch desde main
git checkout main
git pull origin main
git checkout -b hotfix/critical-security-fix

# Hacer el fix
git add .
git commit -m "fix: critical security vulnerability"

# Push
git push origin hotfix/critical-security-fix

# Crear PR a main
# (Via GitHub UI)
# Base: main ← Compare: hotfix/critical-security-fix

# Después del merge a main, también merge a develop y staging
git checkout develop
git merge main
git push origin develop
```

## Merge Strategies

### Squash and Merge (Recomendado)

**Cuándo usar:** Feature branches → develop

**Ventajas:**
- Historia limpia y lineal
- Un commit por feature
- Fácil de revert

**Cómo:**
```
Base: develop ← Compare: feature/US-004
Click: "Squash and merge"
Commit message: "feat(ci-cd): setup GitHub Actions workflows (#4)"
```

### Merge Commit

**Cuándo usar:** develop → staging, staging → main

**Ventajas:**
- Preserva historia completa
- Muestra todos los commits individuales

**Cómo:**
```
Base: staging ← Compare: develop
Click: "Create a merge commit"
Commit message: "Merge develop into staging - Release v1.1.0"
```

### Rebase and Merge

**Cuándo usar:** Raramente (solo para mantener historia lineal)

**Ventajas:**
- Historia completamente lineal
- No merge commits

**Desventajas:**
- Puede causar conflictos
- Pierde contexto de branches

## Protección Adicional

### Firmar Commits

Para mayor seguridad, configura GPG signing:

```bash
# Generar GPG key
gpg --full-generate-key

# Listar keys
gpg --list-secret-keys --keyid-format=long

# Configurar Git
git config --global user.signingkey YOUR_KEY_ID
git config --global commit.gpgsign true

# Agregar GPG key a GitHub
gpg --armor --export YOUR_KEY_ID
# Copiar output y pegarlo en GitHub → Settings → SSH and GPG keys
```

### Verificar Commits Firmados

En branch protection, habilita:
```
✅ Require signed commits
```

## Verificación de Configuración

### Checklist

```bash
# Verificar branch protection
# Ve a: Settings → Branches

✅ main tiene 2 required reviewers
✅ main requiere status checks: lint, test-rules, test-functions, security-scan, build
✅ staging tiene 1 required reviewer
✅ staging requiere status checks: lint, test-rules, build
✅ develop tiene 1 required reviewer
✅ develop requiere status checks: lint, build
✅ CODEOWNERS file existe
✅ Force push bloqueado en main y staging
```

### Test de Branch Protection

```bash
# Intentar push directo a main (debe fallar)
git checkout main
echo "test" >> README.md
git add .
git commit -m "test"
git push origin main
# Esperado: Error: protected branch

# Crear feature branch y PR (debe funcionar)
git checkout develop
git checkout -b feature/test-protection
echo "# Test" >> README.md
git add .
git commit -m "test: branch protection"
git push origin feature/test-protection
# Crear PR en GitHub
# Verificar que requiere aprobación
```

## Troubleshooting

### Error: "Required status check is failing"

**Causa:** Algún check de CI/CD falló.

**Solución:**
1. Ve a la pestaña "Checks" del PR
2. Identifica qué check falló
3. Revisa los logs
4. Corrige el problema
5. Push nuevamente

### Error: "Review required"

**Causa:** No tienes las aprobaciones necesarias.

**Solución:**
1. Pide review a code owners
2. Espera aprobación
3. Resuelve comentarios si hay

### Error: "Branch is out of date"

**Causa:** La branch base se actualizó después de crear el PR.

**Solución:**
```bash
git checkout feature/tu-branch
git fetch origin
git rebase origin/develop
git push --force-with-lease origin feature/tu-branch
```

## Best Practices

### ✅ DO

- Crear PRs pequeños y enfocados
- Escribir descripciones claras de PRs
- Linkear issues relacionados
- Resolver conversaciones antes de merge
- Eliminar branches después de merge
- Usar conventional commits
- Mantener develop estable

### ❌ DON'T

- Push directo a main/staging/develop
- Force push a branches protegidas
- Merge PRs con checks fallidos
- Ignorar comentarios de reviewers
- Crear PRs gigantes (>500 líneas)
- Merge trabajo incompleto a develop

## Referencias

- [GitHub Branch Protection](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [CODEOWNERS](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

**Última actualización:** 2025-11-21  
**Responsable:** DevOps Team
