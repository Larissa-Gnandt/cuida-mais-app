import 'package:flutter/material.dart';

class PoisoningEmergencyScreen extends StatelessWidget {
  const PoisoningEmergencyScreen({super.key, required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return _DomesticEmergencyScreen(
      onDismiss: onDismiss,
      icon: Icons.coronavirus_outlined,
      title: 'Como agir em caso de\nintoxicação?',
      steps: const [
        _EmergencyStep(
          number: '01',
          icon: Icons.call_outlined,
          instruction:
              'Chame o centro de intoxicação ou o socorro médico e informe o produto envolvido.',
        ),
        _EmergencyStep(
          number: '02',
          icon: Icons.inventory_2_outlined,
          instruction:
              'Guarde a embalagem, rótulo ou frasco para orientar a equipe de atendimento.',
        ),
        _EmergencyStep(
          number: '03',
          icon: Icons.no_drinks_outlined,
          instruction:
              'Não provoque vômito e não ofereça comida, bebida ou remédios sem orientação.',
        ),
      ],
      alert:
          'Se houver sonolência, convulsão, confusão ou dificuldade para respirar, chame socorro imediatamente.',
    );
  }
}

class ElectricShockEmergencyScreen extends StatelessWidget {
  const ElectricShockEmergencyScreen({super.key, required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return _DomesticEmergencyScreen(
      onDismiss: onDismiss,
      icon: Icons.bolt_outlined,
      title: 'Como agir em caso de\nchoque elétrico?',
      steps: const [
        _EmergencyStep(
          number: '01',
          icon: Icons.power_settings_new_outlined,
          instruction:
              'Desligue a fonte de energia, se for seguro. Não toque na pessoa enquanto houver corrente.',
        ),
        _EmergencyStep(
          number: '02',
          icon: Icons.pan_tool_alt_outlined,
          instruction:
              'Afaste o fio com objeto seco de madeira, plástico ou papelão, mantendo distância segura.',
        ),
        _EmergencyStep(
          number: '03',
          icon: Icons.favorite_border_rounded,
          instruction:
              'Verifique respiração e movimento. Se não respirar, chame socorro e inicie RCP.',
        ),
      ],
      alert:
          'Choque elétrico pode causar lesões internas. Procure atendimento mesmo sem marcas visíveis.',
    );
  }
}

class DrowningEmergencyScreen extends StatelessWidget {
  const DrowningEmergencyScreen({super.key, required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return _DomesticEmergencyScreen(
      onDismiss: onDismiss,
      icon: Icons.waves_outlined,
      title: 'Como agir em caso de\nafogamento?',
      steps: const [
        _EmergencyStep(
          number: '01',
          icon: Icons.support_outlined,
          instruction:
              'Retire a pessoa da água apenas se for seguro. Peça ajuda e chame o socorro médico.',
        ),
        _EmergencyStep(
          number: '02',
          icon: Icons.air_outlined,
          instruction:
              'Verifique se responde e respira. Abra as vias aéreas e observe o movimento do peito.',
        ),
        _EmergencyStep(
          number: '03',
          icon: Icons.favorite_border_rounded,
          instruction:
              'Se não respirar normalmente, inicie RCP e continue até a chegada do socorro.',
        ),
      ],
      alert:
          'Mesmo após melhora, a pessoa deve ser avaliada se tossir muito, tiver falta de ar ou sonolência.',
    );
  }
}

class _DomesticEmergencyScreen extends StatelessWidget {
  const _DomesticEmergencyScreen({
    required this.onDismiss,
    required this.icon,
    required this.title,
    required this.steps,
    required this.alert,
  });

  static const _primaryGreen = Color(0xFF2F7A5F);
  static const _softCanvas = Color(0xFFF4FBF5);
  static const _ink = Color(0xFF17261F);
  static const _dangerRed = Color(0xFFB42318);

  final VoidCallback onDismiss;
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
        Icon(icon, color: _DomesticEmergencyScreen._primaryGreen, size: 24),
        const SizedBox(width: 18),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: _DomesticEmergencyScreen._ink,
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
                color: _DomesticEmergencyScreen._primaryGreen,
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
                              color: _DomesticEmergencyScreen._primaryGreen,
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
                color: _DomesticEmergencyScreen._dangerRed,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'IMPORTANTE',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: _DomesticEmergencyScreen._dangerRed,
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
              color: _DomesticEmergencyScreen._dangerRed,
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
      child: Icon(
        icon,
        color: _DomesticEmergencyScreen._primaryGreen,
        size: 24,
      ),
    );
  }
}
