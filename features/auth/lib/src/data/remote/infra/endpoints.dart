enum AuthEndpoints {
  signIn('/auth/sign-in'),
  signUp('/auth/sign-up'),
  refreshToken('/auth/refresh-token'),
  checkEmailAvailability('/auth/check-email-availability');

  const AuthEndpoints(this.path);

  final String path;
}
