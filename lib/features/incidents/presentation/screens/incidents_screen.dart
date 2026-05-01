import 'package:flutter/material.dart';

class IncidentsScreen extends StatelessWidget {
  const IncidentsScreen({
    super.key,
    required this.onDailyTipTap,
    required this.onCommonEmergenciesTap,
    required this.onChokingTap,
  });

  final VoidCallback onDailyTipTap;
  final VoidCallback onCommonEmergenciesTap;
  final VoidCallback onChokingTap;

  static const _primaryGreen = Color(0xFF2F7A5F);
  static const _deepGreen = Color(0xFF2D8057);
  static const _softCanvas = Color(0xFFF4FBF5);
  static const _mutedTile = Color(0xFFE1E9E5);
  static const _ink = Color(0xFF21332A);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _softCanvas,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 22),
              sliver: SliverList.list(
                children: [
                  Text(
                    'CUIDA+',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 20,
                      color: _primaryGreen,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 44),
                  const _SearchPill(),
                  const SizedBox(height: 34),
                  _SectionHeader(
                    icon: Icons.medical_services_outlined,
                    title: 'Emergências comuns',
                    action: 'Ver todos',
                    onActionTap: onCommonEmergenciesTap,
                  ),
                  const SizedBox(height: 18),
                  _CommonEmergenciesCarousel(onChokingTap: onChokingTap),
                  const SizedBox(height: 40),
                  const _SectionHeader(
                    icon: Icons.warning_amber_rounded,
                    title: 'Situações graves',
                  ),
                  const SizedBox(height: 18),
                  const _ImmediateRiskCard(),
                  const SizedBox(height: 12),
                  const _SeriousSituationTile(
                    icon: Icons.monitor_heart_outlined,
                    title: 'Dor no peito',
                    subtitle: 'Possível infarto',
                  ),
                  const SizedBox(height: 14),
                  const _SeriousSituationTile(
                    icon: Icons.psychology_outlined,
                    title: 'AVC',
                    subtitle: 'Perda de movimento',
                  ),
                  const SizedBox(height: 14),
                  const _SeriousSituationTile(
                    icon: Icons.flash_on_outlined,
                    title: 'Convulsão',
                    subtitle: 'Ataque epiléptico',
                  ),
                  const SizedBox(height: 34),
                  const _SectionHeader(
                    icon: Icons.home_work_outlined,
                    title: 'Acidentes domésticos',
                  ),
                  const SizedBox(height: 18),
                  const _DomesticAccidentsCard(),
                  const SizedBox(height: 34),
                  _DailyTipCard(onTap: onDailyTipTap),
                  const SizedBox(height: 26),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchPill extends StatelessWidget {
  const _SearchPill();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D0E1D16),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF9EAAA3), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'O que está acontecendo?',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFFADB6B0),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    this.action,
    this.onActionTap,
  });

  final IconData icon;
  final String title;
  final String? action;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, color: IncidentsScreen._primaryGreen, size: 18),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 18,
              color: IncidentsScreen._ink,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onActionTap,
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              action!,
              style: theme.textTheme.labelMedium?.copyWith(
                color: IncidentsScreen._primaryGreen,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
      ],
    );
  }
}

class _CommonEmergenciesCarousel extends StatelessWidget {
  const _CommonEmergenciesCarousel({required this.onChokingTap});

  final VoidCallback onChokingTap;

  @override
  Widget build(BuildContext context) {
    const emergencies = [
      _CommonEmergencyData(Icons.air_outlined, 'Engasgando'),
      _CommonEmergencyData(Icons.bloodtype_outlined, 'Sangramento'),
      _CommonEmergencyData(Icons.local_fire_department_outlined, 'Queimadura'),
    ];

    return SizedBox(
      height: 128,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          final emergency = emergencies[index];
          return _CommonEmergencyCard(
            emergency: emergency,
            onTap: index == 0 ? onChokingTap : null,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemCount: emergencies.length,
      ),
    );
  }
}

class _CommonEmergencyData {
  const _CommonEmergencyData(this.icon, this.label);

  final IconData icon;
  final String label;
}

class _CommonEmergencyCard extends StatelessWidget {
  const _CommonEmergencyCard({required this.emergency, this.onTap});

  final _CommonEmergencyData emergency;
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
          width: 102,
          padding: const EdgeInsets.fromLTRB(12, 18, 12, 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F0E1D16),
                blurRadius: 18,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _IconBubble(
                icon: emergency.icon,
                backgroundColor: const Color(0xFFF0F5F3),
              ),
              Text(
                emergency.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: IncidentsScreen._ink,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImmediateRiskCard extends StatelessWidget {
  const _ImmediateRiskCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 90,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: IncidentsScreen._deepGreen,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'RISCO IMEDIATO',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: 10,
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'NÃO RESPIRA',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          _IconBubble(
            icon: Icons.air_outlined,
            iconColor: Colors.white,
            backgroundColor: Colors.white.withValues(alpha: 0.16),
            size: 56,
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}

class _SeriousSituationTile extends StatelessWidget {
  const _SeriousSituationTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: IncidentsScreen._mutedTile,
        borderRadius: BorderRadius.circular(18),
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
                    color: IncidentsScreen._ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF4E5F56),
                    fontSize: 10,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DomesticAccidentsCard extends StatelessWidget {
  const _DomesticAccidentsCard();

  @override
  Widget build(BuildContext context) {
    const accidents = [
      _DomesticAccidentData(Icons.coronavirus_outlined, 'Intoxicação'),
      _DomesticAccidentData(Icons.bolt_outlined, 'Choque elétrico'),
      _DomesticAccidentData(Icons.waves_outlined, 'Afogamento'),
    ];

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          for (var i = 0; i < accidents.length; i++) ...[
            _DomesticAccidentTile(accident: accidents[i]),
            if (i != accidents.length - 1) const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}

class _DomesticAccidentData {
  const _DomesticAccidentData(this.icon, this.title);

  final IconData icon;
  final String title;
}

class _DomesticAccidentTile extends StatelessWidget {
  const _DomesticAccidentTile({required this.accident});

  final _DomesticAccidentData accident;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _IconBubble(icon: accident.icon, size: 36, iconSize: 19),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              accident.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                color: IncidentsScreen._ink,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFFA9B6AE), size: 21),
        ],
      ),
    );
  }
}

class _DailyTipCard extends StatelessWidget {
  const _DailyTipCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          height: 118,
          padding: const EdgeInsets.fromLTRB(38, 20, 20, 20),
          decoration: BoxDecoration(
            color: const Color(0xFF4EAF80),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A2F7A5F),
                blurRadius: 22,
                offset: Offset(0, 14),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'DICA DO DIA',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.78),
                        fontSize: 9,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'Monte seu kit de\nprimeiros socorros',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.medical_services,
                  color: Color(0xFFC8F1DC),
                  size: 34,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({
    required this.icon,
    this.backgroundColor = const Color(0xFFF2F7F5),
    this.iconColor = IncidentsScreen._primaryGreen,
    this.size = 42,
    this.iconSize = 22,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: iconSize),
    );
  }
}
