import 'package:auth/src/data/data_sources/local/token_local_data_source.dart';
import 'package:auth/src/data/models/token_dto.dart';
import 'package:core/dependencies.dart';
import 'package:core/exceptions.dart';

class SecureTokenLocalDataSource implements TokenLocalDataSource {
  SecureTokenLocalDataSource(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  final _accessTokenKey = 'auth_access_token';
  final _refreshTokenKey = 'auth_refresh_token';

  @override
  Future<void> saveToken({
    required TokenCacheDto token,
  }) =>
      Future.wait([
        _secureStorage.write(key: _accessTokenKey, value: token.accessToken),
        _secureStorage.write(key: _refreshTokenKey, value: token.refreshToken),
      ]);

  @override
  Future<void> deleteToken() => Future.wait([
        _secureStorage.delete(key: _accessTokenKey),
        _secureStorage.delete(key: _refreshTokenKey),
      ]);

  @override
  Future<String> getAccessToken() async {
    final accessToken = await _secureStorage.read(key: _accessTokenKey);

    if (accessToken == null) {
      throw ItemNotFoundException(message: 'Access token not found');
    }

    return accessToken;
  }

  @override
  Future<String> getRefreshToken() async {
    final refreshToken = await _secureStorage.read(key: _refreshTokenKey);

    if (refreshToken == null) {
      throw ItemNotFoundException(message: 'Refresh token not found');
    }

    return refreshToken;
  }
}
