import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/assistant_message.dart';

class AssistantConversationStorage {
  const AssistantConversationStorage();

  static const _conversationKey = 'assistant_conversation';
  static const _conversationIdKey = 'assistant_conversation_id';

  Future<StoredConversation?> read() async {
    final prefs = await SharedPreferences.getInstance();
    final conversationJson = prefs.getString(_conversationKey);
    final conversationId = prefs.getString(_conversationIdKey);

    if (conversationJson == null || conversationJson.trim().isEmpty) {
      return null;
    }

    final decoded = jsonDecode(conversationJson);
    if (decoded is! List) {
      return null;
    }

    final messages = decoded
        .whereType<Map>()
        .map((item) => item.cast<String, dynamic>())
        .map(StoredAssistantMessage.fromJson)
        .map((stored) => stored.toDomain())
        .toList(growable: false);

    if (messages.isEmpty) {
      return null;
    }

    return StoredConversation(
      messages: messages,
      conversationId: conversationId,
    );
  }

  Future<void> write({
    required List<AssistantMessage> conversation,
    String? conversationId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final payload = conversation
        .map(StoredAssistantMessage.fromDomain)
        .map((stored) => stored.toJson())
        .toList(growable: false);

    await prefs.setString(_conversationKey, jsonEncode(payload));

    if (conversationId == null || conversationId.trim().isEmpty) {
      await prefs.remove(_conversationIdKey);
    } else {
      await prefs.setString(_conversationIdKey, conversationId);
    }
  }
}

class StoredConversation {
  const StoredConversation({
    required this.messages,
    this.conversationId,
  });

  final List<AssistantMessage> messages;
  final String? conversationId;
}

class StoredAssistantMessage {
  const StoredAssistantMessage({
    required this.text,
    required this.sender,
    this.summary,
    this.immediateSteps = const [],
    this.alerts = const [],
    this.followUpQuestion,
  });

  final String text;
  final String sender;
  final String? summary;
  final List<String> immediateSteps;
  final List<String> alerts;
  final String? followUpQuestion;

  factory StoredAssistantMessage.fromDomain(AssistantMessage message) {
    return StoredAssistantMessage(
      text: message.text,
      sender: message.sender.apiRole,
      summary: message.summary,
      immediateSteps: message.immediateSteps,
      alerts: message.alerts,
      followUpQuestion: message.followUpQuestion,
    );
  }

  AssistantMessage toDomain() {
    return AssistantMessage(
      text: text,
      sender: sender == 'assistant'
          ? MessageSender.assistant
          : MessageSender.user,
      summary: summary,
      immediateSteps: immediateSteps,
      alerts: alerts,
      followUpQuestion: followUpQuestion,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'sender': sender,
      'summary': summary,
      'immediateSteps': immediateSteps,
      'alerts': alerts,
      'followUpQuestion': followUpQuestion,
    };
  }

  factory StoredAssistantMessage.fromJson(Map<String, dynamic> json) {
    return StoredAssistantMessage(
      text: json['text'] as String? ?? '',
      sender: json['sender'] as String? ?? 'user',
      summary: json['summary'] as String?,
      immediateSteps: _readStringList(json['immediateSteps']),
      alerts: _readStringList(json['alerts']),
      followUpQuestion: json['followUpQuestion'] as String?,
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
