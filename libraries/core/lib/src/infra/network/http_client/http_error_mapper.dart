import 'dart:io';

import 'package:core/src/utils/exceptions.dart';
import 'package:dio/dio.dart';

class HttpErrorMapper {
  static TKNetworkException tryMapDioError(
    DioException error,
    StackTrace stackTrace,
  ) {
    final networkErrorType = getNetworkErrorType(error);

    return TKNetworkException(
      message: error.message ?? 'Unknown error',
      type: networkErrorType,
      originalError: error,
      originalStackTrace: stackTrace,
    );
  }

  static NetworkErrorType getNetworkErrorType(DioException error) {
    if (error is SocketException) {
      return NetworkErrorType.noConnection;
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return NetworkErrorType.timeout;
    }

    final statusCode = error.response?.statusCode ?? 0;

    if (statusCode == 401) {
      return NetworkErrorType.unauthorized;
    }

    if (statusCode == 403) {
      return NetworkErrorType.forbidden;
    }

    if (statusCode == 404) {
      return NetworkErrorType.notFound;
    }

    if (statusCode >= 400 && statusCode <= 499) {
      return NetworkErrorType.badRequest;
    }

    if (statusCode >= 500 && statusCode <= 599) {
      return NetworkErrorType.internalServerError;
    }

    return NetworkErrorType.unknown;
  }
}
