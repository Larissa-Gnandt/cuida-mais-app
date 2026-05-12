import 'package:flutter/material.dart';

class ChokingEmergencyScreen extends StatelessWidget {
  const ChokingEmergencyScreen({super.key, required this.onDismiss});

  final VoidCallback onDismiss;

  static const _primaryGreen = Color(0xFF2F7A5F);
  static const _softCanvas = Color(0xFFF4FBF5);
  static const _ink = Color(0xFF17261F);
  static const _dangerRed = Color(0xFFB42318);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFDCE6DF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onDismiss,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 14),
                  child: Text(
                    'CUIDA+',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 20,
                      color: const Color(0xFF1F6A4C),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 34, 24, 20),
                decoration: const BoxDecoration(
                  color: _softCanvas,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverList.list(
                      children: const [
                        _ChokingHeader(),
                        SizedBox(height: 28),
                        _InstructionStepCard(
                          number: '01',
                          icon: Icons.accessibility_new,
                          instruction:
                              'Posicione-se por trás da pessoa e envolva os braços em volta da cintura dela.',
                        ),
                        SizedBox(height: 14),
                        _InstructionStepCard(
                          number: '02',
                          icon: Icons.back_hand_outlined,
                          instruction:
                              'Feche uma das mãos e coloque o lado do polegar logo acima do umbigo.',
                        ),
                        SizedBox(height: 14),
                        _InstructionStepCard(
                          number: '03',
                          icon: Icons.swap_horiz_rounded,
                          instruction:
                              'Pressione o abdômen com movimentos rápidos para dentro e para cima.',
                        ),
                        SizedBox(height: 26),
                        _ImportantAlertCard(),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChokingHeader extends StatelessWidget {
  const _ChokingHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.air_outlined,
          color: ChokingEmergencyScreen._primaryGreen,
          size: 24,
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Text(
            'Como agir em caso de\nengasgo?',
            style: theme.textTheme.titleLarge?.copyWith(
              color: ChokingEmergencyScreen._ink,
              fontSize: 18,
              height: 1.18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _InstructionStepCard extends StatelessWidget {
  const _InstructionStepCard({
    required this.number,
    required this.icon,
    required this.instruction,
  });

  final String number;
  final IconData icon;
  final String instruction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 104),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0EAE4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D0E1D16),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 5,
              decoration: const BoxDecoration(
                color: ChokingEmergencyScreen._primaryGreen,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(18),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 18, 12, 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            number,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: ChokingEmergencyScreen._primaryGreen,
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            instruction,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF4A5B52),
                              fontSize: 12,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _StepIconBubble(icon: icon),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImportantAlertCard extends StatelessWidget {
  const _ImportantAlertCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFD4CF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.warning_rounded,
                color: ChokingEmergencyScreen._dangerRed,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'IMPORTANTE',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: ChokingEmergencyScreen._dangerRed,
                  fontSize: 10,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Se a pessoa perder a consciência, inicie a RCP e chame o socorro médico imediatamente.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: ChokingEmergencyScreen._dangerRed,
              fontSize: 12,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepIconBubble extends StatelessWidget {
  const _StepIconBubble({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        color: Color(0xFFEAF3EE),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: ChokingEmergencyScreen._primaryGreen, size: 24),
    );
  }
}
