abstract interface class TokenLocalDataSource {
  Future<void> saveToken({
    required String accessToken,
    required String refreshToken,
  });

  Future<void> deleteToken();

  Future<String> getRefreshToken();
  Future<String> getAccessToken();
}
