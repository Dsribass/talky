import 'package:json_annotation/json_annotation.dart';

part 'api_error_response.g.dart';

@JsonSerializable()
class ApiErrorResponse {
  const ApiErrorResponse({
    required this.message,
    required this.error,
    required this.inputIssues,
    required this.type,
  });

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorResponseToJson(this);

  final String message;
  final String error;
  final ResponseErrorType type;
  @JsonKey(defaultValue: {})
  final Map<String, List<String>> inputIssues;
}

@JsonEnum()
enum ResponseErrorType {
  @JsonValue('unknown')
  unknown,
  @JsonValue('invalid_token')
  invalidToken,
  @JsonValue('item_not_found')
  itemNotFound,
  @JsonValue('item_already_exists')
  itemAlreadyExists,
  @JsonValue('input_invalid')
  inputInvalid,
  @JsonValue('channel_name_required')
  channelNameRequired,
  @JsonValue('channel_min_members')
  channelMinMembers,
}
