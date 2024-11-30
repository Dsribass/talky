import 'package:dio/dio.dart';

class InvalidTokenException extends DioException {
  InvalidTokenException({
    required super.requestOptions,
    super.error,
    super.message,
    super.response,
    super.stackTrace,
    super.type = DioExceptionType.badResponse,
  });

  InvalidTokenException.fromDioException(DioException dioException)
      : this(
          requestOptions: dioException.requestOptions,
          error: dioException.error,
          message: dioException.message,
          response: dioException.response,
          stackTrace: dioException.stackTrace,
        );
}
