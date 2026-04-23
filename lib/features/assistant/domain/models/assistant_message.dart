class AssistantMessage {
  const AssistantMessage({
    required this.text,
    required this.sender,
    this.summary,
    this.immediateSteps = const [],
    this.alerts = const [],
    this.followUpQuestion,
  });

  final String text;
  final MessageSender sender;
  final String? summary;
  final List<String> immediateSteps;
  final List<String> alerts;
  final String? followUpQuestion;
}

enum MessageSender {
  assistant,
  user,
}

extension MessageSenderRole on MessageSender {
  String get apiRole {
    switch (this) {
      case MessageSender.assistant:
        return 'assistant';
      case MessageSender.user:
        return 'user';
    }
  }
}
