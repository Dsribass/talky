import 'package:json_annotation/json_annotation.dart';

part 'chat_error_response.g.dart';

@JsonSerializable()
class ChatErrorResponse {
  const ChatErrorResponse({
    required this.message,
    required this.error,
    required this.inputIssues,
  });

  factory ChatErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatErrorResponseToJson(this);

  final String message;
  final String error;
  @JsonKey(defaultValue: {})
  final Map<String, List<String>> inputIssues;
}
