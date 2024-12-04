enum AuthEndpoints {
  signIn('/auth/sign-in'),
  signUp('/auth/sign-up'),
  refreshToken('/auth/refresh-token');

  const AuthEndpoints(this.path);

  final String path;
}
