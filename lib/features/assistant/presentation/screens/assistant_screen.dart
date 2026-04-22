import 'package:flutter/material.dart';

import '../../domain/models/assistant_message.dart';
import '../../domain/models/instruction_step.dart';
import '../widgets/assistant_bottom_nav.dart';
import '../widgets/assistant_header_card.dart';
import '../widgets/chat_input_card.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/emergency_alert_card.dart';
import '../widgets/instruction_step_card.dart';

class AssistantScreen extends StatelessWidget {
  const AssistantScreen({super.key});

  static const _messages = [
    AssistantMessage(
      text: 'Ola! Sou seu assistente CUIDA+. Como posso auxiliar sua saude hoje?',
      sender: MessageSender.assistant,
    ),
    AssistantMessage(
      text: 'Pode me orientar sobre como agir em caso de engasgo?',
      sender: MessageSender.user,
    ),
    AssistantMessage(
      text: 'Com certeza. Para desobstruir as vias aereas (Manobra de Heimlich), siga estes passos:',
      sender: MessageSender.assistant,
    ),
  ];

  static const _steps = [
    InstructionStep(
      number: '01',
      description:
          'Posicione-se por tras da pessoa e envolva os bracos em volta da cintura dela.',
      icon: Icons.back_hand_outlined,
    ),
    InstructionStep(
      number: '02',
      description:
          'Feche uma das maos e coloque o lado do polegar logo acima do umbigo.',
      icon: Icons.pan_tool_outlined,
    ),
    InstructionStep(
      number: '03',
      description:
          'Pressione o abdomen com movimentos rapidos para dentro e para cima.',
      icon: Icons.front_hand_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'CUIDA+',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 30,
                        color: const Color(0xFF2F7A5F),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x110E1D16),
                            blurRadius: 18,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(14, 16, 14, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const AssistantHeaderCard(),
                          const SizedBox(height: 18),
                          for (final message in _messages) ...[
                            ChatMessageBubble(message: message),
                            const SizedBox(height: 12),
                          ],
                          for (final step in _steps) ...[
                            InstructionStepCard(step: step),
                            const SizedBox(height: 12),
                          ],
                          const EmergencyAlertCard(),
                          const SizedBox(height: 18),
                          const ChatInputCard(),
                          const SizedBox(height: 18),
                          Text(
                            '...',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: const Color(0xFFB4BBB7),
                              letterSpacing: 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const AssistantBottomNav(),
          ],
        ),
      ),
    );
  }
}
