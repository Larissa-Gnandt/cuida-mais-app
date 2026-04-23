import '../../domain/models/assistant_message.dart';

class AssistantApiMessage {
  const AssistantApiMessage({
    required this.role,
    required this.content,
  });

  final String role;
  final String content;

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }

  factory AssistantApiMessage.fromDomain(AssistantMessage message) {
    return AssistantApiMessage(
      role: message.sender.apiRole,
      content: message.text,
    );
  }
}
