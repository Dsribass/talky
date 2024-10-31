import 'package:auth/src/data/models/token_dto.dart';

abstract interface class TokenLocalDataSource {
  Future<void> saveToken({
    required TokenCacheDto token,
  });

  Future<void> deleteToken();

  Future<String> getRefreshToken();
  Future<String> getAccessToken();
}
