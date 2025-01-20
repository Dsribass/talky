import 'dart:collection';

import 'package:core/dependencies.dart';
import 'package:core/infra.dart';

final class RetryRequestListQueue implements RetryRequestQueue {
  RetryRequestListQueue({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  final HttpClient _httpClient;
  final _queue = Queue<RetryRequest>();

  @override
  void add(RetryRequest request) => _queue.add(request);

  @override
  Future<void> rejectQueue(DioException error) async {
    for (final request in _queue) {
      request.reject(error);
    }
    _queue.clear();
  }

  @override
  Future<void> resolveQueue(String accessToken) async {
    for (final request in _queue) {
      try {
        request.resolve(
          await _retryRequest(
            request.options,
            accessToken,
          ),
        );
      } catch (error) {
        request.reject(
          error is DioException
              ? error.response?.statusCode == 401
                  ? TokenException.fromDioException(error)
                  : error
              : DioException(
                  requestOptions: request.options,
                  error: error,
                ),
        );
      }
    }

    _queue.clear();
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions options,
    String accessToken,
  ) async {
    options.headers['Authorization'] = 'Bearer $accessToken';
    return _httpClient.fetch(options);
  }
}
