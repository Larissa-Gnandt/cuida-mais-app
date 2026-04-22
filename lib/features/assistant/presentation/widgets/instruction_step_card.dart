import 'package:flutter/material.dart';

import '../../domain/models/instruction_step.dart';

class InstructionStepCard extends StatelessWidget {
  const InstructionStepCard({
    super.key,
    required this.step,
  });

  final InstructionStep step;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBF8),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFDCE6E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                step.number,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 26,
                  color: const Color(0xFF2F7A5F),
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                step.icon,
                size: 18,
                color: const Color(0xFF2F7A5F),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            step.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF55675E),
            ),
          ),
        ],
      ),
    );
  }
}
