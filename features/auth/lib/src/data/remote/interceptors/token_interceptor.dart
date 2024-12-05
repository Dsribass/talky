import 'dart:async';
import 'dart:collection';

import 'package:auth/src/data/models/token_dto.dart';
import 'package:auth/src/data/remote/infra/endpoints.dart';
import 'package:auth/src/data/remote/infra/token_manager.dart';
import 'package:core/dependencies.dart';
import 'package:core/infra.dart';

typedef RetryRequest = ({
  RequestOptions options,
  void Function(Response<dynamic>) resolve,
  void Function(DioException) reject,
});

@internal
class TokenInterceptor extends Interceptor {
  TokenInterceptor({
    required HttpOptions httpOptions,
    required TokenManager tokenManager,
  })  : _tokenManager = tokenManager,
        _httpClient = BaseApiHttpClient(options: httpOptions);

  final HttpClient _httpClient;
  final TokenManager _tokenManager;
  final Queue<RetryRequest> _queuedRequests = Queue();

  Completer<String>? _refreshTokenTask;

  final _authorizationHeader = 'Authorization';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _tokenManager.getAccessToken();

    if (_tokenManager.hasTokenExpired(accessToken)) {
      return _handleInvalidToken(
        (
          options: options,
          resolve: handler.resolve,
          reject: handler.reject,
        ),
      );
    }

    options.headers[_authorizationHeader] = 'Bearer $accessToken';
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async =>
      err.response?.statusCode == 401
          ? _handleInvalidToken(
              (
                options: err.requestOptions,
                resolve: handler.resolve,
                reject: handler.reject,
              ),
            )
          : super.onError(err, handler);

  Future<void> _handleInvalidToken(RetryRequest request) async {
    _queuedRequests.add(request);

    if (_isFetchingRefreshToken) return;

    try {
      _refreshTokenTask = Completer<String>();
      await _renewAccessToken(request.options)
          .then(_refreshTokenTask!.complete)
          .catchError(_refreshTokenTask!.completeError);

      final updatedAccessToken = await _refreshTokenTask!.future;

      return await _retryQueuedRequests(updatedAccessToken);
    } catch (error) {
      return request.reject(
        error is DioException
            ? error
            : DioException(
                requestOptions: request.options,
                error: error,
              ),
      );
    }
  }

  bool get _isFetchingRefreshToken =>
      _refreshTokenTask != null && !_refreshTokenTask!.isCompleted;

  Future<String> _renewAccessToken(RequestOptions options) async {
    try {
      final refreshToken = await _tokenManager.getRefreshToken();

      final response = await _httpClient.post<Map<String, dynamic>>(
        AuthEndpoints.refreshToken.path,
        data: {'refreshToken': refreshToken},
      );

      final token = TokenRemoteDto.fromJson(response.data!);
      await _tokenManager.upsertToken(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      );

      return token.accessToken;
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 401) {
        throw InvalidTokenException.fromDioException(error);
      }

      rethrow;
    }
  }

  Future<void> _retryQueuedRequests(String accessToken) async {
    for (final queuedRequest in _queuedRequests) {
      try {
        queuedRequest.resolve(
          await _retryRequest(
            queuedRequest.options,
            accessToken,
          ),
        );
      } catch (error) {
        queuedRequest.reject(
          error is DioException
              ? error.response?.statusCode == 401
                  ? InvalidTokenException.fromDioException(error)
                  : error
              : DioException(
                  requestOptions: queuedRequest.options,
                  error: error,
                ),
        );
      }
    }

    _queuedRequests.clear();
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions requestOptions,
    String accessToken,
  ) async {
    requestOptions.headers = {
      ...requestOptions.headers..remove(_authorizationHeader),
      _authorizationHeader: 'Bearer $accessToken',
    };

    return _httpClient.fetch(requestOptions);
  }
}
