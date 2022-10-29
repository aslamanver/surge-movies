class APIException implements Exception {
  final int statusCode;
  final String body;

  APIException(
    this.statusCode,
    this.body,
  );
}

class NetworkException implements Exception {
  final Exception exception;
  NetworkException(this.exception);
}
