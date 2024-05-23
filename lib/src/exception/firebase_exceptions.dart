class TFirebaseException implements Exception {
  // The error code associated with the exception.
  final String code;

  // Constructs an instance of [TFirebaseException] with the provided error [code].
  TFirebaseException(this.code);

  // Get the corresponding error message for the error code.
  String get message {
    switch (code) {
      // Firestore exceptions
      case 'cancelled':
        return 'The operation was cancelled';
      case 'unknown':
        return 'An unknown error occurred';
      case 'invalid-argument':
        return 'An invalid argument was provided';
      case 'deadline-exceeded':
        return 'The deadline for the operation was exceeded';
      case 'not-found':
        return 'The requested document was not found';
      case 'already-exists':
        return 'The document already exists';
      case 'permission-denied':
        return 'Permission denied';
      case 'resource-exhausted':
        return 'Resource exhausted';
      case 'failed-precondition':
        return 'Failed precondition';
      case 'aborted':
        return 'The operation was aborted';
      case 'out-of-range':
        return 'Out of range';
      case 'unimplemented':
        return 'Operation not implemented';
      case 'internal':
        return 'Internal error';
      case 'unavailable':
        return 'Service unavailable';
      case 'data-loss':
        return 'Data loss';
      case 'unauthenticated':
        return 'Unauthenticated';

      // Storage exceptions
      case 'object-not-found':
        return 'No object exists at the desired reference';
      case 'bucket-not-found':
        return 'No bucket is configured for Cloud Storage';
      case 'project-not-found':
        return 'No project is configured for Cloud Storage';
      case 'quota-exceeded':
        return 'Quota on your Cloud Storage bucket has been exceeded';
      case 'unauthorized':
        return 'User is not authorized to perform the desired action';
      case 'retry-limit-exceeded':
        return 'The maximum time limit on an operation (upload, download, delete, etc.) has been exceeded';
      case 'invalid-checksum':
        return 'File on the client does not match the checksum of the file received by the server';
      case 'canceled':
        return 'User canceled the operation';
      case 'invalid-event-name':
        return 'Invalid event name provided. Must be one of [running, progress, pause]';
      case 'invalid-url':
        return 'Invalid URL provided to refFromURL()';

      case 'no-default-bucket':
        return 'No default bucket configured in Firebase';
      case 'cannot-slice-blob':
        return 'Cannot slice blob for upload';
      case 'server-file-wrong-size':
        return 'File on the server is of an unexpected size';

      // Realtime Database exceptions
      case 'disconnected':
        return 'The operation had to be aborted due to a network disconnect';
      case 'expired-token':
        return 'The supplied auth token has expired';
      case 'invalid-token':
        return 'The supplied auth token was invalid';
      case 'max-retries':
        return 'The transaction had too many retries';
      case 'network-error':
        return 'The operation could not be performed due to a network error';
      case 'overridden-by-set':
        return 'The transaction was overridden by a subsequent set';

      case 'write-canceled':
        return 'The write was canceled locally';

      default:
        return 'An unknown error occurred';
    }
  }
}
