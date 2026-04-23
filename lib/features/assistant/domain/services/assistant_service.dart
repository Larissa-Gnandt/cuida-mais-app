import '../models/assistant_message.dart';
import '../models/assistant_reply.dart';

abstract class AssistantService {
  Future<AssistantReply> sendMessage({
    required String prompt,
    required List<AssistantMessage> conversation,
    String? conversationId,
  });
}
