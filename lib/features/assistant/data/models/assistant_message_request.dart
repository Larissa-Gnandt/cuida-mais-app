import '../../domain/models/assistant_message.dart';
import 'assistant_api_message.dart';

class AssistantMessageRequest {
  const AssistantMessageRequest({
    required this.prompt,
    required this.conversation,
    this.conversationId,
  });

  final String prompt;
  final List<AssistantMessage> conversation;
  final String? conversationId;

  Map<String, dynamic> toJson() {
    return {
      'prompt': prompt,
      'conversationId': conversationId,
      'conversation': conversation
          .map(AssistantApiMessage.fromDomain)
          .map((message) => message.toJson())
          .toList(),
    };
  }
}
