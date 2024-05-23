class TFirebaseAuthException implements Exception {
  // The error code associated with the exception.
  final String code;

  // Constructs an instance of [TFirebaseAuthException] with the provided error [code].
  TFirebaseAuthException(this.code);

  // Get the corresponding error message for the error code.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'Email already in use';
      case 'invalid-email':
        return 'Invalid email';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'weak-password':
        return 'Weak password';
      case 'user-disabled':
        return 'User disabled';
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Wrong password';
      case 'account-exists-with-different-credential':
        return 'Account exists with different credential';
      case 'auth-domain-config-required':
        return 'Auth domain configuration required';
      case 'cancelled-popup-request':
        return 'Cancelled popup request';
      case 'popup-blocked':
        return 'Popup blocked';
      case 'popup-closed-by-user':
        return 'Popup closed by user';
      case 'missing-verification-code':
        return 'Missing verification code';
      case 'invalid-verification-code':
        return 'Invalid verification code';
      case 'missing-verification-id':
        return 'Missing verification ID';
      case 'invalid-verification-id':
        return 'Invalid verification ID';
      case 'invalid-credential':
        return 'Invalid credential';
      case 'too-many-requests':
        return 'Too many requests. Please try again later';
      case 'requires-recent-login':
        return 'Requires recent login. Please log in again';
      default:
        return 'An unknown error occurred';
    }
  }
}
