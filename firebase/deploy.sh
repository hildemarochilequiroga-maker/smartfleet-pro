#!/usr/bin/env bash

# SmartFleet Pro - Firebase Deployment Script
# Usage: ./deploy.sh [environment] [service]
# Example: ./deploy.sh dev firestore
# Example: ./deploy.sh staging all

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check arguments
if [ $# -lt 1 ]; then
    print_error "Missing environment argument"
    echo "Usage: ./deploy.sh [environment] [service]"
    echo "Environments: dev, staging, prod"
    echo "Services: firestore, functions, hosting, storage, all"
    exit 1
fi

ENVIRONMENT=$1
SERVICE=${2:-all}

# Validate environment
if [[ ! "$ENVIRONMENT" =~ ^(dev|staging|prod)$ ]]; then
    print_error "Invalid environment: $ENVIRONMENT"
    echo "Valid environments: dev, staging, prod"
    exit 1
fi

# Validate service
if [[ ! "$SERVICE" =~ ^(firestore|functions|hosting|storage|all)$ ]]; then
    print_error "Invalid service: $SERVICE"
    echo "Valid services: firestore, functions, hosting, storage, all"
    exit 1
fi

print_info "🚀 Starting deployment to $ENVIRONMENT environment"

# Change to firebase directory
cd "$(dirname "$0")"

# Select Firebase project
print_info "Selecting Firebase project: smartfleet-$ENVIRONMENT"
firebase use $ENVIRONMENT

# Deploy based on service
case $SERVICE in
    firestore)
        print_info "Deploying Firestore rules and indexes..."
        firebase deploy --only firestore:rules,firestore:indexes
        ;;
    functions)
        print_info "Deploying Cloud Functions..."
        firebase deploy --only functions
        ;;
    hosting)
        print_info "Deploying Firebase Hosting..."
        firebase deploy --only hosting
        ;;
    storage)
        print_info "Deploying Storage rules..."
        firebase deploy --only storage
        ;;
    all)
        print_warning "Deploying ALL services..."
        read -p "Are you sure? (yes/no): " confirm
        if [ "$confirm" != "yes" ]; then
            print_error "Deployment cancelled"
            exit 0
        fi
        firebase deploy
        ;;
esac

print_info "✅ Deployment completed successfully!"

# Show URLs
echo ""
print_info "Environment URLs:"
echo "  Console: https://console.firebase.google.com/project/smartfleet-$ENVIRONMENT"
echo "  Hosting: https://smartfleet-$ENVIRONMENT.web.app"
echo "  Firestore: https://console.firebase.google.com/project/smartfleet-$ENVIRONMENT/firestore"
