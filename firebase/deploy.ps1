# SmartFleet Pro - Firebase Deployment Script (PowerShell)
# Usage: .\deploy.ps1 [environment] [service]
# Example: .\deploy.ps1 dev firestore
# Example: .\deploy.ps1 staging all

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('dev', 'staging', 'prod')]
    [string]$Environment,
    
    [Parameter(Mandatory=$false)]
    [ValidateSet('firestore', 'functions', 'hosting', 'storage', 'all')]
    [string]$Service = 'all'
)

# Colors for output
function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

Write-Info "🚀 Starting deployment to $Environment environment"

# Change to firebase directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

# Select Firebase project
Write-Info "Selecting Firebase project: smartfleet-$Environment"
firebase use $Environment

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to select Firebase project"
    exit 1
}

# Deploy based on service
switch ($Service) {
    'firestore' {
        Write-Info "Deploying Firestore rules and indexes..."
        firebase deploy --only firestore:rules,firestore:indexes
    }
    'functions' {
        Write-Info "Deploying Cloud Functions..."
        firebase deploy --only functions
    }
    'hosting' {
        Write-Info "Deploying Firebase Hosting..."
        firebase deploy --only hosting
    }
    'storage' {
        Write-Info "Deploying Storage rules..."
        firebase deploy --only storage
    }
    'all' {
        Write-Warning "Deploying ALL services..."
        $confirm = Read-Host "Are you sure? (yes/no)"
        if ($confirm -ne 'yes') {
            Write-Error "Deployment cancelled"
            exit 0
        }
        firebase deploy
    }
}

if ($LASTEXITCODE -eq 0) {
    Write-Info "✅ Deployment completed successfully!"
    
    # Show URLs
    Write-Host ""
    Write-Info "Environment URLs:"
    Write-Host "  Console:   https://console.firebase.google.com/project/smartfleet-$Environment"
    Write-Host "  Hosting:   https://smartfleet-$Environment.web.app"
    Write-Host "  Firestore: https://console.firebase.google.com/project/smartfleet-$Environment/firestore"
} else {
    Write-Error "Deployment failed!"
    exit 1
}
