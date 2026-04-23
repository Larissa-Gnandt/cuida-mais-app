import 'package:flutter/material.dart';

class ChatInputCard extends StatelessWidget {
  const ChatInputCard({
    super.key,
    required this.controller,
    required this.onSend,
    this.enabled = true,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5FAF6),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x120E1D16),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.add,
            size: 28,
            color: Color(0xFF2F7A5F),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: 'Escreva sua mensagem...',
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF97A49D),
                    ),
              ),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF42544A),
                  ),
            ),
          ),
          const SizedBox(width: 12),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(26),
              onTap: enabled ? onSend : null,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: enabled
                      ? const Color(0xFF2F7A5F)
                      : const Color(0xFF9DB7AB),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
