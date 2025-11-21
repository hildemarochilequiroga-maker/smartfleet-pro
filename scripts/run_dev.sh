#!/bin/bash

# Run Flutter app in development flavor
echo "🚀 Running SmartFleet in DEVELOPMENT mode..."
flutter run --flavor dev -t lib/main_dev.dart "$@"
