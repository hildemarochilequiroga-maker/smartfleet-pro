/// Application-wide constants
class AppConstants {
  // API & Network
  static const int apiTimeoutSeconds = 30;
  static const int maxRetryAttempts = 3;

  // GPS Tracking
  static const int gpsUpdateIntervalSeconds = 15;
  static const double gpsAccuracyThresholdMeters = 10;
  static const double movementSpeedThresholdKmh = 5;

  // Cache & Storage
  static const int cacheExpirationDays = 7;
  static const String localStorageKey = 'smartfleet_storage';

  // UI
  static const double defaultPadding = 16;
  static const double defaultBorderRadius = 8;
  static const double defaultElevation = 2;

  // Animation
  static const int defaultAnimationDurationMs = 300;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Validation
  static const int minPasswordLength = 8;
  static const int maxFullNameLength = 100;

  // Battery
  static const int lowBatteryThreshold = 15;

  // Offline
  static const int offlineDataRetentionDays = 30;
}
