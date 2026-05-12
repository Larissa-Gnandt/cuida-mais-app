import 'package:flutter/material.dart';

class IncidentsScreen extends StatefulWidget {
  const IncidentsScreen({
    super.key,
    required this.onDailyTipTap,
    required this.onCommonEmergenciesTap,
    required this.onEmergencyContactsTap,
    required this.onChokingTap,
    required this.onBleedingTap,
    required this.onBurnTap,
    required this.onChestPainTap,
    required this.onStrokeTap,
    required this.onSeizureTap,
    required this.onPoisoningTap,
    required this.onElectricShockTap,
    required this.onDrowningTap,
  });

  final VoidCallback onDailyTipTap;
  final VoidCallback onCommonEmergenciesTap;
  final VoidCallback onEmergencyContactsTap;
  final VoidCallback onChokingTap;
  final VoidCallback onBleedingTap;
  final VoidCallback onBurnTap;
  final VoidCallback onChestPainTap;
  final VoidCallback onStrokeTap;
  final VoidCallback onSeizureTap;
  final VoidCallback onPoisoningTap;
  final VoidCallback onElectricShockTap;
  final VoidCallback onDrowningTap;

  static const _primaryGreen = Color(0xFF2F7A5F);
  static const _deepGreen = Color(0xFF2D8057);
  static const _softCanvas = Color(0xFFF4FBF5);
  static const _mutedTile = Color(0xFFE1E9E5);
  static const _ink = Color(0xFF21332A);

  @override
  State<IncidentsScreen> createState() => _IncidentsScreenState();
}

class _IncidentsScreenState extends State<IncidentsScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  List<_SearchTarget> get _targets => [
    _SearchTarget(
      icon: Icons.air_outlined,
      title: 'Engasgo',
      subtitle: 'Manobra de Heimlich e desobstrucao',
      category: 'Emergencia comum',
      terms: 'engasgo engasgando sufocamento nao respira falta de ar heimlich',
      onTap: widget.onChokingTap,
    ),
    _SearchTarget(
      icon: Icons.bloodtype_outlined,
      title: 'Sangramento',
      subtitle: 'Compressao e controle de hemorragias',
      category: 'Emergencia comum',
      terms: 'sangramento sangue corte ferimento hemorragia machucado',
      onTap: widget.onBleedingTap,
    ),
    _SearchTarget(
      icon: Icons.local_fire_department_outlined,
      title: 'Queimadura',
      subtitle: 'Resfriamento e protecao da pele',
      category: 'Emergencia comum',
      terms: 'queimadura queimou fogo quente pele bolha',
      onTap: widget.onBurnTap,
    ),
    _SearchTarget(
      icon: Icons.monitor_heart_outlined,
      title: 'Dor no peito',
      subtitle: 'Possivel infarto',
      category: 'Situacao grave',
      terms: 'dor peito infarto coracao falta de ar aperto',
      onTap: widget.onChestPainTap,
    ),
    _SearchTarget(
      icon: Icons.psychology_outlined,
      title: 'AVC',
      subtitle: 'Rosto torto, fraqueza ou fala enrolada',
      category: 'Situacao grave',
      terms: 'avc derrame rosto torto fala enrolada fraqueza movimento',
      onTap: widget.onStrokeTap,
    ),
    _SearchTarget(
      icon: Icons.flash_on_outlined,
      title: 'Convulsao',
      subtitle: 'Crise convulsiva ou ataque epileptico',
      category: 'Situacao grave',
      terms: 'convulsao convulsao crise epileptica ataque tremendo desmaio',
      onTap: widget.onSeizureTap,
    ),
    _SearchTarget(
      icon: Icons.coronavirus_outlined,
      title: 'Intoxicacao',
      subtitle: 'Produto quimico, remedio ou veneno',
      category: 'Acidente domestico',
      terms: 'intoxicacao veneno produto quimico remedio ingeriu bebeu',
      onTap: widget.onPoisoningTap,
    ),
    _SearchTarget(
      icon: Icons.bolt_outlined,
      title: 'Choque eletrico',
      subtitle: 'Descarga eletrica e tomada',
      category: 'Acidente domestico',
      terms: 'choque eletrico tomada fio eletricidade descarga',
      onTap: widget.onElectricShockTap,
    ),
    _SearchTarget(
      icon: Icons.waves_outlined,
      title: 'Afogamento',
      subtitle: 'Pessoa aspirou agua ou nao respira',
      category: 'Acidente domestico',
      terms: 'afogamento agua piscina mar rio nao respira aspirou',
      onTap: widget.onDrowningTap,
    ),
    _SearchTarget(
      icon: Icons.medical_services_outlined,
      title: 'Kit de primeiros socorros',
      subtitle: 'Gazes, esparadrapo, soro e itens essenciais',
      category: 'Kit',
      terms:
          'kit primeiros socorros gazes gaze esparadrapo band aid alcool soro agua oxigenada analgesico antitermico antialergico tesoura pinca termometro luvas',
      onTap: widget.onDailyTipTap,
    ),
    _SearchTarget(
      icon: Icons.emergency_outlined,
      title: 'SAMU',
      subtitle: 'Telefone 192',
      category: 'Telefone de emergencia',
      terms: 'samu ambulancia socorro medico telefone 192',
      onTap: widget.onEmergencyContactsTap,
    ),
    _SearchTarget(
      icon: Icons.local_fire_department_outlined,
      title: 'Bombeiros',
      subtitle: 'Telefone 193',
      category: 'Telefone de emergencia',
      terms: 'bombeiros incendio resgate fogo telefone 193',
      onTap: widget.onEmergencyContactsTap,
    ),
    _SearchTarget(
      icon: Icons.security_outlined,
      title: 'Policia Militar',
      subtitle: 'Telefone 190',
      category: 'Telefone de emergencia',
      terms: 'policia militar seguranca telefone 190',
      onTap: widget.onEmergencyContactsTap,
    ),
  ];

  List<_SearchTarget> get _results {
    final normalizedQuery = _normalize(_query);

    if (normalizedQuery.isEmpty) {
      return const [];
    }

    return _targets.where((target) {
      final haystack = _normalize(
        '${target.title} ${target.subtitle} ${target.category} ${target.terms}',
      );
      return normalizedQuery
          .split(RegExp(r'\s+'))
          .where((term) => term.isNotEmpty)
          .every(haystack.contains);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasQuery = _query.trim().isNotEmpty;
    final results = _results;

    return Scaffold(
      backgroundColor: IncidentsScreen._softCanvas,
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
                      color: IncidentsScreen._primaryGreen,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 44),
                  _SearchPill(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value),
                    onClear: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                  ),
                  const SizedBox(height: 34),
                  if (hasQuery) ...[
                    _SearchResultsSection(results: results),
                    const SizedBox(height: 26),
                  ] else ...[
                    _SectionHeader(
                      icon: Icons.medical_services_outlined,
                      title: 'Emergências comuns',
                      action: 'Ver todos',
                      onActionTap: widget.onCommonEmergenciesTap,
                    ),
                    const SizedBox(height: 18),
                    _CommonEmergenciesCarousel(
                      onChokingTap: widget.onChokingTap,
                      onBleedingTap: widget.onBleedingTap,
                      onBurnTap: widget.onBurnTap,
                    ),
                    const SizedBox(height: 40),
                    const _SectionHeader(
                      icon: Icons.warning_amber_rounded,
                      title: 'Situações graves',
                    ),
                    const SizedBox(height: 18),
                    const _ImmediateRiskCard(),
                    const SizedBox(height: 12),
                    _SeriousSituationTile(
                      icon: Icons.monitor_heart_outlined,
                      title: 'Dor no peito',
                      subtitle: 'Possível infarto',
                      onTap: widget.onChestPainTap,
                    ),
                    const SizedBox(height: 14),
                    _SeriousSituationTile(
                      icon: Icons.psychology_outlined,
                      title: 'AVC',
                      subtitle: 'Perda de movimento',
                      onTap: widget.onStrokeTap,
                    ),
                    const SizedBox(height: 14),
                    _SeriousSituationTile(
                      icon: Icons.flash_on_outlined,
                      title: 'Convulsão',
                      subtitle: 'Ataque epiléptico',
                      onTap: widget.onSeizureTap,
                    ),
                    const SizedBox(height: 34),
                    const _SectionHeader(
                      icon: Icons.home_work_outlined,
                      title: 'Acidentes domésticos',
                    ),
                    const SizedBox(height: 18),
                    _DomesticAccidentsCard(
                      onPoisoningTap: widget.onPoisoningTap,
                      onElectricShockTap: widget.onElectricShockTap,
                      onDrowningTap: widget.onDrowningTap,
                    ),
                    const SizedBox(height: 34),
                    _DailyTipCard(onTap: widget.onDailyTipTap),
                    const SizedBox(height: 26),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _normalize(String value) {
  return value
      .toLowerCase()
      .replaceAll(RegExp('[áàâãä]'), 'a')
      .replaceAll(RegExp('[éèêë]'), 'e')
      .replaceAll(RegExp('[íìîï]'), 'i')
      .replaceAll(RegExp('[óòôõö]'), 'o')
      .replaceAll(RegExp('[úùûü]'), 'u')
      .replaceAll('ç', 'c');
}

class _SearchTarget {
  const _SearchTarget({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.terms,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String category;
  final String terms;
  final VoidCallback onTap;
}

class _SearchPill extends StatelessWidget {
  const _SearchPill({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

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
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              cursorColor: IncidentsScreen._primaryGreen,
              decoration: InputDecoration(
                hintText: 'O que está acontecendo?',
                border: InputBorder.none,
                isCollapsed: true,
                hintStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFFADB6B0),
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFFADB6B0),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (controller.text.isNotEmpty) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: onClear,
              icon: const Icon(Icons.close_rounded),
              color: const Color(0xFF9EAAA3),
              iconSize: 20,
              tooltip: 'Limpar busca',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 32, height: 32),
            ),
          ],
        ],
      ),
    );
  }
}

class _SearchResultsSection extends StatelessWidget {
  const _SearchResultsSection({required this.results});

  final List<_SearchTarget> results;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (results.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE0EAE4)),
        ),
        child: Text(
          'Nenhum resultado encontrado.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF5D6D65),
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          icon: Icons.manage_search_outlined,
          title: results.length == 1
              ? '1 resultado'
              : '${results.length} resultados',
        ),
        const SizedBox(height: 16),
        for (var index = 0; index < results.length; index++) ...[
          _SearchResultTile(result: results[index]),
          if (index != results.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  const _SearchResultTile({required this.result});

  final _SearchTarget result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: result.onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 74),
          child: Ink(
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
                _IconBubble(icon: result.icon),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        result.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: IncidentsScreen._primaryGreen,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        result.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: IncidentsScreen._ink,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        result.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF5D6D65),
                          fontSize: 11,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF93A199),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
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
  const _CommonEmergenciesCarousel({
    required this.onChokingTap,
    required this.onBleedingTap,
    required this.onBurnTap,
  });

  final VoidCallback onChokingTap;
  final VoidCallback onBleedingTap;
  final VoidCallback onBurnTap;

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
            onTap: switch (index) {
              0 => onChokingTap,
              1 => onBleedingTap,
              2 => onBurnTap,
              _ => null,
            },
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
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
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
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF93A199),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DomesticAccidentsCard extends StatelessWidget {
  const _DomesticAccidentsCard({
    required this.onPoisoningTap,
    required this.onElectricShockTap,
    required this.onDrowningTap,
  });

  final VoidCallback onPoisoningTap;
  final VoidCallback onElectricShockTap;
  final VoidCallback onDrowningTap;

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
            _DomesticAccidentTile(
              accident: accidents[i],
              onTap: switch (i) {
                0 => onPoisoningTap,
                1 => onElectricShockTap,
                2 => onDrowningTap,
                _ => null,
              },
            ),
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
  const _DomesticAccidentTile({required this.accident, required this.onTap});

  final _DomesticAccidentData accident;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Ink(
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
              const Icon(
                Icons.chevron_right,
                color: Color(0xFFA9B6AE),
                size: 21,
              ),
            ],
          ),
        ),
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
