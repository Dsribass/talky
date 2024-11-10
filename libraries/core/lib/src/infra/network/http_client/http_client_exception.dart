import 'package:core/src/exceptions/core_exception.dart';

class HttpClientException extends CoreException {
  HttpClientException({
    required super.message,
    required this.statusError,
    required this.statusCode,
    super.originalError,
    super.originalStackTrace,
  });

  final int statusCode;
  final HttpStatusError statusError;

  String get detailedMessage {
    final message = StringBuffer()
      ..write('NetworkException')
      ..write('[${statusError.name}]')
      ..write(': ')
      ..write(this.message)
      ..write('\n\n')
      ..write('Original error: ')
      ..write(originalError);

    return message.toString();
  }
}

enum HttpStatusError {
  unknown,
  timeout,
  noConnection,
  badRequest,
  internalServerError,
  unauthorized,
  notFound,
  forbidden;
}
