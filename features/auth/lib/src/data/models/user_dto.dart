import 'package:core/dependencies.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserRemoteDTO {
  UserRemoteDTO({
    required this.email,
    required this.password,
    this.name,
  });

  factory UserRemoteDTO.fromJson(Map<String, dynamic> json) =>
      _$UserRemoteDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserRemoteDTOToJson(this);

  @JsonKey(includeIfNull: false)
  final String? name;
  final String email;
  final String password;
}

class UserCacheDTO {}
