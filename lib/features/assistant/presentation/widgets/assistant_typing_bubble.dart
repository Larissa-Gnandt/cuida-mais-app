import 'package:flutter/material.dart';

class AssistantTypingBubble extends StatefulWidget {
  const AssistantTypingBubble({super.key});

  @override
  State<AssistantTypingBubble> createState() => _AssistantTypingBubbleState();
}

class _AssistantTypingBubbleState extends State<AssistantTypingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 140),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          3,
          (index) => AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final progress = (_controller.value + (index * 0.18)) % 1;
              final opacity = 0.35 + (0.65 * (1 - (progress - 0.5).abs() * 2));

              return Padding(
                padding: EdgeInsets.only(right: index == 2 ? 0 : 6),
                child: Opacity(
                  opacity: opacity.clamp(0.25, 1),
                  child: child,
                ),
              );
            },
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFF7C8C84),
                shape: BoxShape.circle,
              ),
              child: SizedBox(width: 8, height: 8),
            ),
          ),
        ),
      ),
    );
  }
}
