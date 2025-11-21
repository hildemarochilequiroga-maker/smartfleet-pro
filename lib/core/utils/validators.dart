/// Common validation utilities
class Validators {
  /// Validates email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Ingrese un email válido';
    }

    return null;
  }

  /// Validates password strength
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }

    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }

    if (!value.contains(RegExp('[A-Z]'))) {
      return 'La contraseña debe contener al menos una mayúscula';
    }

    if (!value.contains(RegExp('[0-9]'))) {
      return 'La contraseña debe contener al menos un número';
    }

    return null;
  }

  /// Validates password confirmation
  static String? validatePasswordConfirmation(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirme su contraseña';
    }

    if (value != password) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }

  /// Validates full name
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre completo es requerido';
    }

    if (value.length < 3) {
      return 'El nombre debe tener al menos 3 caracteres';
    }

    if (value.length > 100) {
      return 'El nombre es demasiado largo';
    }

    return null;
  }

  /// Validates phone number
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'El teléfono es requerido';
    }

    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

    if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'[\s-]'), ''))) {
      return 'Ingrese un número de teléfono válido';
    }

    return null;
  }

  /// Validates required field
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName es requerido';
    }
    return null;
  }
}
