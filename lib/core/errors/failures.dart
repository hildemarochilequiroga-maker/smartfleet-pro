/// Base failure class for error handling
abstract class Failure {

  const Failure({required this.message, this.code});
  final String message;
  final String? code;

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

/// Network/Connectivity failures
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

/// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});
}

/// Permission failures (GPS, Camera, etc.)
class PermissionFailure extends Failure {
  const PermissionFailure({required super.message, super.code});
}

/// Cache failures
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

/// GPS/Location failures
class LocationFailure extends Failure {
  const LocationFailure({required super.message, super.code});
}
