class AssistantReply {
  const AssistantReply({
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
}
