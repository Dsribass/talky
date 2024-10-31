import 'package:core/dependencies.dart';

part 'token_dto.g.dart';

@JsonSerializable()
class TokenRemoteDto {
  TokenRemoteDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenRemoteDto.fromJson(Map<String, dynamic> json) =>
      _$TokenRemoteDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TokenRemoteDtoToJson(this);

  final String accessToken;
  final String refreshToken;

  TokenCacheDto toCache() => TokenCacheDto(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
}

class TokenCacheDto {
  TokenCacheDto({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  TokenRemoteDto toRemote() => TokenRemoteDto(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
}
