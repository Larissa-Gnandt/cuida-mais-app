import 'package:flutter/material.dart';

class ChestPainEmergencyScreen extends StatelessWidget {
  const ChestPainEmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SeriousEmergencyScreen(
      icon: Icons.monitor_heart_outlined,
      title: 'Como agir em caso de\ndor no peito?',
      steps: [
        _EmergencyStep(
          number: '01',
          icon: Icons.call_outlined,
          instruction:
              'Chame o socorro médico imediatamente se a dor for súbita, forte ou durar alguns minutos.',
        ),
        _EmergencyStep(
          number: '02',
          icon: Icons.airline_seat_recline_normal_outlined,
          instruction:
              'Mantenha a pessoa em repouso, sentada ou semi-sentada, e evite esforço físico.',
        ),
        _EmergencyStep(
          number: '03',
          icon: Icons.favorite_border_rounded,
          instruction:
              'Observe a respiração. Se a pessoa desmaiar e não respirar, inicie a RCP.',
        ),
      ],
      alert:
          'Dor no peito pode ser sinal de infarto. Não espere melhorar para buscar ajuda.',
    );
  }
}

class StrokeEmergencyScreen extends StatelessWidget {
  const StrokeEmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SeriousEmergencyScreen(
      icon: Icons.psychology_outlined,
      title: 'Como agir em caso de\nAVC?',
      steps: [
        _EmergencyStep(
          number: '01',
          icon: Icons.record_voice_over_outlined,
          instruction:
              'Verifique sinais: rosto torto, fraqueza em um braço ou fala enrolada.',
        ),
        _EmergencyStep(
          number: '02',
          icon: Icons.call_outlined,
          instruction:
              'Chame o socorro médico imediatamente e anote o horário em que os sintomas começaram.',
        ),
        _EmergencyStep(
          number: '03',
          icon: Icons.no_food_outlined,
          instruction:
              'Não ofereça comida, bebida ou remédios. Mantenha a pessoa em local seguro.',
        ),
      ],
      alert:
          'AVC é emergência. Cada minuto conta para reduzir o risco de sequelas.',
    );
  }
}

class SeizureEmergencyScreen extends StatelessWidget {
  const SeizureEmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SeriousEmergencyScreen(
      icon: Icons.flash_on_outlined,
      title: 'Como agir em caso de\nconvulsão?',
      steps: [
        _EmergencyStep(
          number: '01',
          icon: Icons.shield_outlined,
          instruction:
              'Afaste objetos perigosos e proteja a cabeça da pessoa durante a crise.',
        ),
        _EmergencyStep(
          number: '02',
          icon: Icons.pan_tool_alt_outlined,
          instruction:
              'Não segure a pessoa e não coloque nada em sua boca durante a convulsão.',
        ),
        _EmergencyStep(
          number: '03',
          icon: Icons.timer_outlined,
          instruction:
              'Marque o tempo da crise e vire a pessoa de lado quando os movimentos pararem.',
        ),
      ],
      alert:
          'Chame socorro se durar mais de 5 minutos, repetir, houver ferimento ou dificuldade para respirar.',
    );
  }
}

class _SeriousEmergencyScreen extends StatelessWidget {
  const _SeriousEmergencyScreen({
    required this.icon,
    required this.title,
    required this.steps,
    required this.alert,
  });

  static const _primaryGreen = Color(0xFF2F7A5F);
  static const _softCanvas = Color(0xFFF4FBF5);
  static const _ink = Color(0xFF17261F);
  static const _dangerRed = Color(0xFFB42318);

  final IconData icon;
  final String title;
  final List<_EmergencyStep> steps;
  final String alert;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFDCE6DF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
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
                      children: [
                        _EmergencyHeader(icon: icon, title: title),
                        const SizedBox(height: 28),
                        for (var index = 0; index < steps.length; index++) ...[
                          _InstructionStepCard(step: steps[index]),
                          if (index != steps.length - 1)
                            const SizedBox(height: 14),
                        ],
                        const SizedBox(height: 26),
                        _ImportantAlertCard(alert: alert),
                        const SizedBox(height: 20),
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

class _EmergencyStep {
  const _EmergencyStep({
    required this.number,
    required this.icon,
    required this.instruction,
  });

  final String number;
  final IconData icon;
  final String instruction;
}

class _EmergencyHeader extends StatelessWidget {
  const _EmergencyHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: _SeriousEmergencyScreen._primaryGreen, size: 24),
        const SizedBox(width: 18),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: _SeriousEmergencyScreen._ink,
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
  const _InstructionStepCard({required this.step});

  final _EmergencyStep step;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 104),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFCFB),
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
                color: _SeriousEmergencyScreen._primaryGreen,
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
                            step.number,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: _SeriousEmergencyScreen._primaryGreen,
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            step.instruction,
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
                    _StepIconBubble(icon: step.icon),
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
  const _ImportantAlertCard({required this.alert});

  final String alert;

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
                color: _SeriousEmergencyScreen._dangerRed,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'IMPORTANTE',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: _SeriousEmergencyScreen._dangerRed,
                  fontSize: 10,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            alert,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: _SeriousEmergencyScreen._dangerRed,
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
      child: Icon(icon, color: _SeriousEmergencyScreen._primaryGreen, size: 24),
    );
  }
}
