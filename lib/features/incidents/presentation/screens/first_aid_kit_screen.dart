import 'package:flutter/material.dart';

class FirstAidKitScreen extends StatelessWidget {
  const FirstAidKitScreen({super.key});

  static const _primaryGreen = Color(0xFF2F7A5F);
  static const _softCanvas = Color(0xFFF4FBF5);
  static const _panel = Color(0xFFFFFFFF);
  static const _card = Color(0xFFEFF6F1);
  static const _ink = Color(0xFF1F2D26);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _softCanvas,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 18),
              child: Text(
                'CUIDA+',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 20,
                  color: _primaryGreen,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _panel,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(30, 44, 30, 28),
                      sliver: SliverList.list(
                        children: [
                          Text(
                            'Seu Kit Essencial',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: const Color(0xFF151C18),
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Itens indispensáveis para ter em casa e em\nviagens.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: const Color(0xFF4D5B54),
                              fontSize: 16,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Center(child: _FirstAidKitIllustration()),
                          const SizedBox(height: 34),
                          const _KitCategoryCard(
                            icon: Icons.medical_services_outlined,
                            title: 'Materiais de Curativo',
                            items: [
                              'Gazes estéreis',
                              'Esparadrapo',
                              'Band-aids de vários tamanhos',
                            ],
                          ),
                          const SizedBox(height: 18),
                          const _KitCategoryCard(
                            icon: Icons.clean_hands_outlined,
                            title: 'Antissépticos',
                            items: [
                              'Álcool 70%',
                              'Água oxigenada',
                              'Soro fisiológico',
                            ],
                          ),
                          const SizedBox(height: 18),
                          const _KitCategoryCard(
                            icon: Icons.medication_outlined,
                            title: 'Medicamentos Básicos',
                            items: [
                              'Analgésicos, antitérmicos e antialérgicos',
                            ],
                            note: 'CONFORME ORIENTAÇÃO MÉDICA',
                          ),
                          const SizedBox(height: 18),
                          const _KitCategoryCard(
                            icon: Icons.business_center_outlined,
                            title: 'Instrumentos',
                            items: [
                              'Tesoura sem ponta e pinça',
                              'Termômetro digital',
                              'Luvas descartáveis',
                            ],
                          ),
                          const SizedBox(height: 38),
                          const _KitAdviceCard(),
                        ],
                      ),
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

class _FirstAidKitIllustration extends StatelessWidget {
  const _FirstAidKitIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 190,
      child: CustomPaint(painter: _FirstAidKitPainter()),
    );
  }
}

class _FirstAidKitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final glowRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.58),
      width: size.width * 0.92,
      height: size.height * 0.48,
    );
    canvas.drawOval(
      glowRect,
      Paint()
        ..shader = const RadialGradient(
          colors: [Color(0x262F7A5F), Color(0x003E8A64)],
        ).createShader(glowRect),
    );

    _drawAccentCircle(canvas, size, Offset(0.18, 0.3), 0.07);
    _drawAccentCircle(canvas, size, Offset(0.82, 0.74), 0.055);
    _drawMedicalSpark(
      canvas,
      size,
      Offset(size.width * 0.74, size.height * 0.24),
    );

    canvas.save();
    canvas.translate(size.width * 0.5, size.height * 0.54);
    canvas.rotate(-0.22);

    final shadowRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(0, size.height * 0.04),
        width: size.width * 0.78,
        height: size.height * 0.3,
      ),
      const Radius.circular(32),
    );
    canvas.drawRRect(
      shadowRect,
      Paint()
        ..color = const Color(0x260E1D16)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18),
    );

    final bandageRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset.zero,
        width: size.width * 0.8,
        height: size.height * 0.3,
      ),
      const Radius.circular(32),
    );
    canvas.drawRRect(
      bandageRect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEFF6F1), Color(0xFFD6E9DF)],
        ).createShader(bandageRect.outerRect),
    );

    canvas.drawRRect(
      bandageRect,
      Paint()
        ..color = const Color(0xFFD5E6DD)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset.zero,
          width: size.width * 0.22,
          height: size.height * 0.24,
        ),
        const Radius.circular(18),
      ),
      Paint()..color = const Color(0xFFE8EFEA),
    );

    _drawPerforations(canvas, size, -size.width * 0.27);
    _drawPerforations(canvas, size, size.width * 0.27);
    _drawCenterPad(canvas, size);
    canvas.restore();
  }

  void _drawCenterPad(Canvas canvas, Size size) {
    final padRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset.zero,
        width: size.width * 0.24,
        height: size.height * 0.25,
      ),
      const Radius.circular(18),
    );
    canvas.drawRRect(
      padRect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFC7E0D0), Color(0xFFAED0BC)],
        ).createShader(padRect.outerRect),
    );
    final plus = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: size.width * 0.04,
            height: size.height * 0.12,
          ),
          const Radius.circular(2),
        ),
      )
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: size.width * 0.13,
            height: size.height * 0.04,
          ),
          const Radius.circular(2),
        ),
      );
    canvas.drawPath(plus, Paint()..color = const Color(0xFF2F7A5F));
  }

  void _drawPerforations(Canvas canvas, Size size, double x) {
    final paint = Paint()..color = const Color(0xFF91BFA5);
    for (final y in [-0.08, 0.0, 0.08]) {
      canvas.drawCircle(Offset(x, size.height * y), 2.7, paint);
      canvas.drawCircle(
        Offset(x + size.width * 0.07, size.height * y),
        2.7,
        paint,
      );
    }
  }

  void _drawAccentCircle(
    Canvas canvas,
    Size size,
    Offset factor,
    double radius,
  ) {
    final center = Offset(size.width * factor.dx, size.height * factor.dy);
    final circleRadius = size.width * radius;
    canvas.drawCircle(
      center.translate(0, 3),
      circleRadius,
      Paint()
        ..color = const Color(0x120E1D16)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );
    canvas.drawCircle(
      center,
      circleRadius,
      Paint()..color = const Color(0xFFEAF3EE),
    );
    canvas.drawCircle(
      center,
      circleRadius * 0.48,
      Paint()..color = const Color(0xFFD5E8DE),
    );
  }

  void _drawMedicalSpark(Canvas canvas, Size size, Offset center) {
    final paint = Paint()
      ..color = const Color(0xFF2F7A5F)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center.translate(-size.width * 0.035, 0),
      center.translate(size.width * 0.035, 0),
      paint,
    );
    canvas.drawLine(
      center.translate(0, -size.width * 0.035),
      center.translate(0, size.width * 0.035),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _KitCategoryCard extends StatelessWidget {
  const _KitCategoryCard({
    required this.icon,
    required this.title,
    required this.items,
    this.note,
  });

  final IconData icon;
  final String title;
  final List<String> items;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
      decoration: BoxDecoration(
        color: FirstAidKitScreen._card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFDDE9E2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFE8EEF9),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: FirstAidKitScreen._primaryGreen, size: 22),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: FirstAidKitScreen._ink,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 22),
                for (final item in items) ...[
                  _BulletText(text: item),
                  if (item != items.last) const SizedBox(height: 10),
                ],
                if (note != null) ...[
                  const SizedBox(height: 14),
                  Text(
                    note!,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: FirstAidKitScreen._primaryGreen,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  const _BulletText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 8),
          decoration: const BoxDecoration(
            color: FirstAidKitScreen._primaryGreen,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF4D5B54),
              fontSize: 16,
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }
}

class _KitAdviceCard extends StatelessWidget {
  const _KitAdviceCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF4FBF8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCDE2D8)),
      ),
      child: Text(
        'Mantenha seu kit em local seco e fora do alcance de\ncrianças.',
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: FirstAidKitScreen._primaryGreen,
          fontSize: 13,
          height: 1.45,
        ),
      ),
    );
  }
}
