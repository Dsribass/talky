import 'package:meta/meta.dart';

@immutable
final class Token {
  const Token({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;
}
