import '../../domain/models/assistant_reply.dart';

class AssistantMessageResponse {
  const AssistantMessageResponse({
    required this.message,
    this.conversationId,
    this.summary,
    this.immediateSteps = const [],
    this.alerts = const [],
    this.followUpQuestion,
  });

  final String message;
  final String? conversationId;
  final String? summary;
  final List<String> immediateSteps;
  final List<String> alerts;
  final String? followUpQuestion;

  factory AssistantMessageResponse.fromJson(Map<String, dynamic> json) {
    return AssistantMessageResponse(
      message: json['message'] as String? ?? '',
      conversationId: json['conversationId'] as String?,
      summary: json['summary'] as String?,
      immediateSteps: _readStringList(json['immediateSteps']),
      alerts: _readStringList(json['alerts']),
      followUpQuestion: json['followUpQuestion'] as String?,
    );
  }

  AssistantReply toDomain() {
    return AssistantReply(
      message: message,
      conversationId: conversationId,
      summary: summary,
      immediateSteps: immediateSteps,
      alerts: alerts,
      followUpQuestion: followUpQuestion,
    );
  }

  static List<String> _readStringList(Object? value) {
    if (value is! List) {
      return const [];
    }

    return value
        .whereType<String>()
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }
}
