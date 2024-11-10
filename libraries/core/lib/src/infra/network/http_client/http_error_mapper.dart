import 'dart:io';

import 'package:core/src/infra/network/http_client/http_client_exception.dart';
import 'package:dio/dio.dart';

class HttpErrorMapper {
  static HttpClientException tryMapDioError(
    DioException error,
    StackTrace stackTrace,
  ) {
    final networkErrorType = getNetworkErrorType(error);

    return HttpClientException(
      message: error.message ?? 'Unknown error',
      statusError: networkErrorType,
      originalError: error,
      statusCode: error.response?.statusCode ?? 0,
      originalStackTrace: stackTrace,
    );
  }

  static HttpStatusError getNetworkErrorType(DioException error) {
    if (error is SocketException) {
      return HttpStatusError.noConnection;
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return HttpStatusError.timeout;
    }

    final statusCode = error.response?.statusCode ?? 0;

    if (statusCode == 401) {
      return HttpStatusError.unauthorized;
    }

    if (statusCode == 403) {
      return HttpStatusError.forbidden;
    }

    if (statusCode == 404) {
      return HttpStatusError.notFound;
    }

    if (statusCode >= 400 && statusCode <= 499) {
      return HttpStatusError.badRequest;
    }

    if (statusCode >= 500 && statusCode <= 599) {
      return HttpStatusError.internalServerError;
    }

    return HttpStatusError.unknown;
  }
}
