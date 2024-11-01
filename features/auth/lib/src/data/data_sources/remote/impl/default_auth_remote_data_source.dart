import 'package:auth/src/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:auth/src/data/exceptions.dart';
import 'package:auth/src/data/models/token_dto.dart';
import 'package:auth/src/data/models/user_dto.dart';
import 'package:core/infra.dart';
import 'package:core/utils.dart';

final class DefaultAuthRemoteDataSource implements AuthRemoteDataSource {
  DefaultAuthRemoteDataSource(this._client);

  final HttpClient _client;

  @override
  Future<TokenRemoteDto> signIn(UserRemoteDTO user) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        _AuthEndpoints.signIn.path,
        data: user.toJson(),
      );

      return TokenRemoteDto.fromJson(response.data!);
    } catch (e) {
      if (e is! TKNetworkException) rethrow;

      throw switch (e.type) {
        NetworkErrorType.unauthorized ||
        NetworkErrorType.notFound =>
          TKInvalidCredentialsException(message: e.message),
        _ => e,
      };
    }
  }

  @override
  Future<TokenRemoteDto> signUp(UserRemoteDTO user) async {
    final response = await _client.post<Map<String, dynamic>>(
      _AuthEndpoints.signUp.path,
      data: user.toJson(),
    );

    return TokenRemoteDto.fromJson(response.data!);
  }
}

enum _AuthEndpoints {
  signIn('/auth/sign-in'),
  signUp('/auth/sign-up');
  // refreshToken('/auth/refresh-token');

  const _AuthEndpoints(this.path);

  final String path;
}
