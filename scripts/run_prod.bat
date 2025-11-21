@echo off
REM Run Flutter app in production flavor
echo 🚀 Running SmartFleet in PRODUCTION mode...
flutter run --flavor prod -t lib/main_prod.dart --release %*
