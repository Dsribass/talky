import 'package:core/dependencies.dart';
import 'package:core/infra.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DefaultTokenManager implements TokenManager {
  DefaultTokenManager(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  final _accessTokenKey = 'auth_access_token';
  final _refreshTokenKey = 'auth_refresh_token';

  Map<String, dynamic> decodeToken(String token) => JwtDecoder.decode(token);

  @override
  bool hasTokenExpired(String token) => JwtDecoder.isExpired(token);

  @override
  Future<void> deleteToken() => Future.wait([
        _secureStorage.delete(key: _accessTokenKey),
        _secureStorage.delete(key: _refreshTokenKey),
      ]);

  @override
  Future<void> upsertToken(Token token) => Future.wait([
        _secureStorage.write(key: _accessTokenKey, value: token.accessToken),
        _secureStorage.write(key: _refreshTokenKey, value: token.refreshToken),
      ]);

  @override
  Future<String?> getAccessToken() => _secureStorage.read(key: _accessTokenKey);

  @override
  Future<String?> getRefreshToken() =>
      _secureStorage.read(key: _refreshTokenKey);
}
