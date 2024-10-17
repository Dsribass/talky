import 'package:auth/src/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:auth/src/data/models/token_dto.dart';
import 'package:auth/src/data/models/user_dto.dart';
import 'package:core/infra.dart';

final class DefaultAuthRemoteDataSource implements AuthRemoteDataSource {
  DefaultAuthRemoteDataSource(this._client);

  final HttpClient _client;

  @override
  Future<TokenRemoteDto> signIn(UserRemoteDTO user) async {
    final response = await _client.post<Map<String, dynamic>>(
      _AuthEndpoints.signIn.path,
      data: user.toJson(),
    );

    return TokenRemoteDto.fromJson(response.data!);
  }
}

enum _AuthEndpoints {
  signIn('/auth/sign-in');
  // signUp('/auth/sign-up'),
  // refreshToken('/auth/refresh-token');

  const _AuthEndpoints(this.path);

  final String path;
}
