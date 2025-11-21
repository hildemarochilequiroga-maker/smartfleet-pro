/// App configuration for different environments (dev, staging, prod)
class AppConfig {

  const AppConfig({
    required this.appName,
    required this.environment,
    required this.apiUrl,
    required this.firebaseProjectId,
    required this.enableLogging,
    required this.enableAnalytics,
    required this.mapboxAccessToken,
  });
  final String appName;
  final String environment;
  final String apiUrl;
  final String firebaseProjectId;
  final bool enableLogging;
  final bool enableAnalytics;
  final String mapboxAccessToken;

  /// Development environment configuration
  static const AppConfig dev = AppConfig(
    appName: 'SmartFleet DEV',
    environment: 'development',
    apiUrl: 'https://smartfleet-pro-dev.web.app',
    firebaseProjectId: 'smartfleet-pro-dev',
    enableLogging: true,
    enableAnalytics: false,
    mapboxAccessToken:
        'YOUR_MAPBOX_TOKEN_DEV', // TODO: Replace with actual token
  );

  /// Staging environment configuration
  static const AppConfig staging = AppConfig(
    appName: 'SmartFleet STAGING',
    environment: 'staging',
    apiUrl: 'https://smartfleet-pro-staging.web.app',
    firebaseProjectId: 'smartfleet-pro-staging',
    enableLogging: true,
    enableAnalytics: true,
    mapboxAccessToken:
        'YOUR_MAPBOX_TOKEN_STAGING', // TODO: Replace with actual token
  );

  /// Production environment configuration
  static const AppConfig prod = AppConfig(
    appName: 'SmartFleet',
    environment: 'production',
    apiUrl: 'https://smartfleet-pro.web.app',
    firebaseProjectId: 'smartfleet-pro-prod',
    enableLogging: false,
    enableAnalytics: true,
    mapboxAccessToken:
        'YOUR_MAPBOX_TOKEN_PROD', // TODO: Replace with actual token
  );

  bool get isDevelopment => environment == 'development';
  bool get isStaging => environment == 'staging';
  bool get isProduction => environment == 'production';
}
