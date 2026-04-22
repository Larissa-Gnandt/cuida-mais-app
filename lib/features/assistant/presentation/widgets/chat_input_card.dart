import 'package:flutter/material.dart';

class ChatInputCard extends StatelessWidget {
  const ChatInputCard({super.key});

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
            child: Text(
              'Escreva sua mensagem...',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF97A49D),
                  ),
            ),
          ),
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0xFF2F7A5F),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.send_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
