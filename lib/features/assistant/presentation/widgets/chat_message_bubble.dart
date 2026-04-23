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
          child: isUser
              ? Text(
                  message.text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                )
              : _AssistantMessageContent(message: message),
        ),
      ],
    );
  }
}

class _AssistantMessageContent extends StatelessWidget {
  const _AssistantMessageContent({
    required this.message,
  });

  final AssistantMessage message;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF586960),
        );
    final titleStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: const Color(0xFF2F7A5F),
          fontWeight: FontWeight.w700,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(message.summary ?? message.text, style: textStyle),
        if (message.immediateSteps.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text('Passos imediatos', style: titleStyle),
          const SizedBox(height: 6),
          for (final step in message.immediateSteps) ...[
            _BulletLine(text: step, style: textStyle),
            const SizedBox(height: 4),
          ],
        ],
        if (message.alerts.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Sinais de alerta', style: titleStyle?.copyWith(color: const Color(0xFFC05642))),
          const SizedBox(height: 6),
          for (final alert in message.alerts) ...[
            _BulletLine(text: alert, style: textStyle),
            const SizedBox(height: 4),
          ],
        ],
        if (message.followUpQuestion != null &&
            message.followUpQuestion!.trim().isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(message.followUpQuestion!, style: textStyle),
        ],
      ],
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6, right: 8),
          child: Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: Color(0xFF6B7D74),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: style,
          ),
        ),
      ],
    );
  }
}
