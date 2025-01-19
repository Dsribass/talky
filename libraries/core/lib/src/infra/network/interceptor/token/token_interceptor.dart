import 'dart:async';
import 'dart:collection';

import 'package:core/src/infra/network/interceptor/token/token.dart';
import 'package:core/src/infra/network/interceptor/token/token_exception.dart';
import 'package:core/src/infra/network/interceptor/token/token_manager.dart';
import 'package:dio/dio.dart';

abstract interface class RefreshToken {
  Future<Token> call(String token);
}

typedef RetryRequest = ({
  RequestOptions options,
  void Function(Response<dynamic>) resolve,
  void Function(DioException) reject,
});

abstract interface class QueueRetryRequest implements Queue<RetryRequest> {
  Future<void> resolveQueue(String accessToken);
  Future<void> rejectQueue(DioException error);
}

class TokenInterceptor extends Interceptor {
  TokenInterceptor({
    required RefreshToken refreshToken,
    required TokenManager tokenManager,
    required QueueRetryRequest queuedRequests,
  })  : _tokenManager = tokenManager,
        _refreshToken = refreshToken,
        _queuedRequests = queuedRequests;

  final RefreshToken _refreshToken;
  final TokenManager _tokenManager;
  final QueueRetryRequest _queuedRequests;

  Completer<String>? _refreshTokenTask;

  bool get _isFetchingRefreshToken =>
      _refreshTokenTask != null && !_refreshTokenTask!.isCompleted;

  final _authorizationHeader = 'Authorization';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _tokenManager.getAccessToken();

    if (accessToken == null) {
      return handler.reject(
        TokenException(
          message: 'Access token not found',
          requestOptions: options,
        ),
      );
    }

    if (_tokenManager.hasTokenExpired(accessToken)) {
      return handleInvalidToken(
        (
          options: options,
          resolve: handler.resolve,
          reject: handler.reject,
        ),
      );
    }

    options.headers[_authorizationHeader] = 'Bearer $accessToken';

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async =>
      err.response?.statusCode == 401
          ? handleInvalidToken(
              (
                options: err.requestOptions,
                resolve: handler.resolve,
                reject: handler.reject,
              ),
            )
          : super.onError(err, handler);

  Future<void> handleInvalidToken(RetryRequest request) async {
    _queuedRequests.add(request);

    if (_isFetchingRefreshToken) return;

    try {
      _refreshTokenTask = Completer<String>();
      await _renewAccessToken(request.options)
          .then(_refreshTokenTask!.complete)
          .catchError(_refreshTokenTask!.completeError);

      final updatedAccessToken = await _refreshTokenTask!.future;

      return await _queuedRequests.resolveQueue(updatedAccessToken);
    } catch (error) {
      return _queuedRequests.rejectQueue(
        error is DioException
            ? error
            : DioException(
                requestOptions: request.options,
                error: error,
              ),
      );
    }
  }

  Future<String> _renewAccessToken(RequestOptions options) async {
    final refreshToken = await _tokenManager.getRefreshToken();

    if (refreshToken == null) {
      throw TokenException(
        message: 'Refresh token not found',
        requestOptions: options,
      );
    }

    if (_tokenManager.hasTokenExpired(refreshToken)) {
      throw TokenException(
        message: 'Refresh token has expired',
        requestOptions: options,
      );
    }

    final token = await _refreshToken(refreshToken);
    await _tokenManager.upsertToken(token);

    return token.accessToken;
  }
}
