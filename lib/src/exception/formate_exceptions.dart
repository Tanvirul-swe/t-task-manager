class TFormatException implements Exception {
  // The error message associated with the exception.
  final String message;

  // Constructs an instance of [TFormatException] with the provided error [message].
  TFormatException(this.message);

  @override
  String toString() => 'TFormatException: $message';
}
