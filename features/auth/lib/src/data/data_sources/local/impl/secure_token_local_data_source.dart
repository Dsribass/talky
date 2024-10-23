import 'package:auth/src/data/data_sources/local/token_local_data_source.dart';
import 'package:core/dependencies.dart';
import 'package:core/utils.dart';

class SecureTokenLocalDataSource implements TokenLocalDataSource {
  SecureTokenLocalDataSource(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  final _accessTokenKey = 'auth_access_token';
  final _refreshTokenKey = 'auth_refresh_token';

  @override
  Future<void> saveToken({
    required String accessToken,
    required String refreshToken,
  }) =>
      Future.wait([
        _secureStorage.write(key: _accessTokenKey, value: accessToken),
        _secureStorage.write(key: _refreshTokenKey, value: refreshToken),
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
      throw TKItemNotFoundException(message: 'Access token not found');
    }

    return accessToken;
  }

  @override
  Future<String> getRefreshToken() async {
    final refreshToken = await _secureStorage.read(key: _refreshTokenKey);

    if (refreshToken == null) {
      throw TKItemNotFoundException(message: 'Refresh token not found');
    }

    return refreshToken;
  }
}
