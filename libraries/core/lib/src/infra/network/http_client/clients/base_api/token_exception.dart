import 'package:dio/dio.dart';

class TokenException extends DioException {
  TokenException({
    required super.requestOptions,
    super.error,
    super.message,
    super.response,
    super.stackTrace,
    super.type = DioExceptionType.badResponse,
  });

  TokenException.fromDioException(DioException dioException)
      : this(
          requestOptions: dioException.requestOptions,
          error: dioException.error,
          message: dioException.message,
          response: dioException.response,
          stackTrace: dioException.stackTrace,
        );
}
