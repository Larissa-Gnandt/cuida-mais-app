import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonEmergenciesScreen extends StatelessWidget {
  const CommonEmergenciesScreen({
    super.key,
    required this.onDismiss,
    required this.onChokingTap,
    required this.onBleedingTap,
    required this.onBurnTap,
  });

  final VoidCallback onDismiss;
  final VoidCallback onChokingTap;
  final VoidCallback onBleedingTap;
  final VoidCallback onBurnTap;

  static const _primaryGreen = Color(0xFF2F7A5F);
  static const _deepGreen = Color(0xFF246D49);
  static const _softCanvas = Color(0xFFF4FBF5);
  static const _ink = Color(0xFF21332A);

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
                padding: const EdgeInsets.fromLTRB(18, 34, 18, 24),
                decoration: const BoxDecoration(
                  color: _softCanvas,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverList.list(
                      children: [
                        const _CommonEmergenciesHeader(),
                        const SizedBox(height: 26),
                        _EmergencyGuideTile(
                          icon: Icons.air_outlined,
                          title: 'Engasgo',
                          subtitle: 'Manobra de Heimlich e desobstrução',
                          onTap: onChokingTap,
                        ),
                        const SizedBox(height: 14),
                        _EmergencyGuideTile(
                          icon: Icons.bloodtype_outlined,
                          title: 'Sangramento',
                          subtitle: 'Compressão e controle de hemorragias',
                          onTap: onBleedingTap,
                        ),
                        const SizedBox(height: 14),
                        _EmergencyGuideTile(
                          icon: Icons.local_fire_department_outlined,
                          title: 'Queimadura',
                          subtitle: 'Resfriamento e proteção da pele',
                          onTap: onBurnTap,
                        ),
                        const SizedBox(height: 28),
                        const _ImmediateHelpCard(),
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

class _CommonEmergenciesHeader extends StatelessWidget {
  const _CommonEmergenciesHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.medical_services,
              color: CommonEmergenciesScreen._primaryGreen,
              size: 22,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Emergências comuns',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: CommonEmergenciesScreen._ink,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Guia rápido de primeiros socorros para situações críticas. Mantenha a calma e siga as instruções.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF3D5147),
            fontSize: 12,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _EmergencyGuideTile extends StatelessWidget {
  const _EmergencyGuideTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          height: 72,
          padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE0EAE4)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F0E1D16),
                blurRadius: 14,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              _IconBubble(icon: icon),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: CommonEmergenciesScreen._ink,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF4F6158),
                        fontSize: 10,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF6E7E75),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImmediateHelpCard extends StatelessWidget {
  const _ImmediateHelpCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 164,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
      decoration: BoxDecoration(
        color: CommonEmergenciesScreen._deepGreen,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33246D49),
            blurRadius: 22,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(
            right: -8,
            bottom: -34,
            child: Icon(
              Icons.phone_in_talk_outlined,
              color: Color(0x1AFFFFFF),
              size: 84,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Precisa de ajuda imediata?',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Nossos especialistas estão disponíveis 24/7\npara orientação por voz.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.76),
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: FilledButton.icon(
                  onPressed: () => _callNow(context),
                  icon: const Icon(Icons.phone, size: 16),
                  label: const Text('Chamar Agora'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: CommonEmergenciesScreen._deepGreen,
                    textStyle: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _callNow(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final uri = Uri(scheme: 'tel', path: '192');

    if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return;
    }

    messenger.showSnackBar(
      const SnackBar(
        content: Text('Não foi possível iniciar a chamada.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: Color(0xFFE0E9E4),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: CommonEmergenciesScreen._primaryGreen, size: 25),
    );
  }
}
