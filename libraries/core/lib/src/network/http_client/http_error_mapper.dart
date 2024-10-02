import 'dart:io';

import 'package:core/src/utils/exceptions.dart';
import 'package:dio/dio.dart';

class HttpErrorMapper {
  static TKException mapError(Object error, StackTrace stackTrace) {
    if (error is DioException) {
      final networkErrorType = _networkErrorType(error);

      return TKNetworkException(
        message: error.message ?? 'Unknown error',
        type: networkErrorType,
        originalError: error,
        originalStackTrace: stackTrace,
      );
    } else {
      final exception = error is Exception ? error : null;
      return TKException(
        message: exception?.toString() ?? 'Network unknown error',
        originalError: error,
        originalStackTrace: stackTrace,
      );
    }
  }

  static NetworkErrorType _networkErrorType(DioException error) {
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
