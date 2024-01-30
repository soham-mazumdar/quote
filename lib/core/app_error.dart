// ignore_for_file: public_member_api_docs

abstract class AppException implements Exception {
  AppException({
    this.code = '',
    this.message = '',
  });

  final String code;
  final String message;

  @override
  String toString() => message;
}

/// {@template http_request_failure}
/// Thrown if an `http` request returns a non-200 status code.
/// {@endtemplate}
class ServerException extends AppException {
  ServerException({
    super.code,
    super.message = 'Server exception',
  });
}

/// Thrown when an error occurs while deserializing the response body.
class DataParsingException extends AppException {
  DataParsingException({
    super.code,
    super.message = 'An error occurred when parsing data',
  });
}

/// Thrown if there is no internet connection
class NoConnectionException extends AppException {
  NoConnectionException({
    super.code,
    super.message = 'No internet connection',
  });
}

/// Thrown when timeout is reached
class TimeOutException extends AppException {
  TimeOutException({
    super.code,
    super.message = 'Time out',
  });
}

/// Thrown if an exception occurs while making an `http` request.
class HttpException extends AppException {
  HttpException({
    super.code,
    super.message = 'An error occurred while making the request',
  });
}

/// Thrown when an error occurs while decoding the response body.
class ErrorResponseException extends AppException {
  ErrorResponseException({
    super.code,
    super.message = 'Unexpected response data from server',
  });
}

/// Thrown when an error occurs while decoding the response body.
class UnexpectedException extends AppException {
  UnexpectedException({
    super.code,
    super.message = 'Unexpected error has occurred',
  });
}

extension AppErrorExtension on Object {
  AppException toAppException() {
    if (this is AppException) {
      return this as AppException;
    }

    return UnexpectedException(message: toString());
  }
}
