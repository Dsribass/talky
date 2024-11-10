import 'package:json_annotation/json_annotation.dart';

part 'chat_error_response.g.dart';

@JsonSerializable()
class ChatErrorResponse {
  const ChatErrorResponse({
    required this.message,
    required this.error,
    required this.inputIssues,
    required this.type,
  });

  factory ChatErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatErrorResponseToJson(this);

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
