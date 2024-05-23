
class TPlatformException implements Exception {
  // The error code associated with the exception.
  final String code;

  // The error message associated with the exception.
  final String message;

  // Constructs an instance of [TPlatformException] with the provided error [code] and [message].
  TPlatformException(this.code, this.message);

  // Get the corresponding error message for the error code.
  String get errorMessage {
    switch (code) {
      // Add more platform-specific error codes if needed
      case 'camera_permission_denied':
        return 'Camera permission denied';
      case 'camera_permission_restricted':
        return 'Camera permission restricted';
      default:
        if (message.contains('Invalid number')) {
          return 'Please enter a valid number.';
        } else if (message.contains('Invalid date')) {
          return 'Please enter a valid date in the format YYYY-MM-DD.';
        } else if (message.contains('Invalid JSON')) {
          return 'Please provide valid JSON data.';
        } else if (message.contains('Invalid URI')) {
          return 'Please provide a valid URI.';
        } else {
          return 'An unknown platform error occurred';
        }
    }
  }

  @override
  String toString() => 'TPlatformException: $message (code: $code)';
}
