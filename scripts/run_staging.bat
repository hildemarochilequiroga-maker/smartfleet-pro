@echo off
REM Run Flutter app in staging flavor
echo 🚀 Running SmartFleet in STAGING mode...
flutter run --flavor staging -t lib/main_staging.dart %*
