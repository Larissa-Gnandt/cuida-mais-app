import 'package:flutter/material.dart';

import '../../domain/models/assistant_message.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
  });

  final AssistantMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;
    final alignment =
        isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 250),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isUser ? const Color(0xFF2F7A5F) : const Color(0xFFF0F4F1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message.text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isUser ? Colors.white : const Color(0xFF586960),
                ),
          ),
        ),
      ],
    );
  }
}
