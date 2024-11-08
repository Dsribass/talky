import 'dart:io';

import 'package:core/src/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

class HttpErrorMapper {
  static GenericNetworkException tryMapDioError(
    DioException error,
    StackTrace stackTrace,
  ) {
    final networkErrorType = getNetworkErrorType(error);

    return GenericNetworkException(
      message: error.message ?? 'Unknown error',
      statusError: networkErrorType,
      originalError: error,
      statusCode: error.response?.statusCode ?? 0,
      originalStackTrace: stackTrace,
    );
  }

  static NetworkStatusError getNetworkErrorType(DioException error) {
    if (error is SocketException) {
      return NetworkStatusError.noConnection;
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return NetworkStatusError.timeout;
    }

    final statusCode = error.response?.statusCode ?? 0;

    if (statusCode == 401) {
      return NetworkStatusError.unauthorized;
    }

    if (statusCode == 403) {
      return NetworkStatusError.forbidden;
    }

    if (statusCode == 404) {
      return NetworkStatusError.notFound;
    }

    if (statusCode >= 400 && statusCode <= 499) {
      return NetworkStatusError.badRequest;
    }

    if (statusCode >= 500 && statusCode <= 599) {
      return NetworkStatusError.internalServerError;
    }

    return NetworkStatusError.unknown;
  }
}
