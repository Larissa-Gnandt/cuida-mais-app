import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({super.key});

  static const _primaryGreen = Color(0xFF2F7A5F);
  static const _softCanvas = Color(0xFFF4FBF5);
  static const _ink = Color(0xFF21332A);

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
              padding: const EdgeInsets.only(top: 20, bottom: 14),
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
                padding: const EdgeInsets.fromLTRB(18, 34, 18, 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.medical_services_outlined,
                          color: _primaryGreen,
                          size: 18,
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            'Contatos de emergência',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const _EmergencyContactTile(
                      icon: Icons.emergency_outlined,
                      title: 'SAMU',
                      phone: '192',
                    ),
                    const SizedBox(height: 26),
                    const _EmergencyContactTile(
                      icon: Icons.local_fire_department_outlined,
                      title: 'Bombeiros',
                      phone: '193',
                    ),
                    const SizedBox(height: 26),
                    const _EmergencyContactTile(
                      icon: Icons.security_outlined,
                      title: 'Polícia Militar',
                      phone: '190',
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

class _EmergencyContactTile extends StatelessWidget {
  const _EmergencyContactTile({
    required this.icon,
    required this.title,
    required this.phone,
  });

  final IconData icon;
  final String title;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 64,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9EFEA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D0E1D16),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          _ContactIconBubble(icon: icon),
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
                    color: EmergencyContactsScreen._ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phone,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF5D6D65),
                    fontSize: 12,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: const Color(0xFFEAF3EE),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => _callEmergencyNumber(context),
              child: const SizedBox(
                width: 36,
                height: 36,
                child: Icon(
                  Icons.phone_outlined,
                  color: EmergencyContactsScreen._primaryGreen,
                  size: 19,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _callEmergencyNumber(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final uri = Uri(scheme: 'tel', path: phone);

    if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return;
    }

    messenger.showSnackBar(
      SnackBar(
        content: Text('Não foi possível iniciar a chamada para $phone.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _ContactIconBubble extends StatelessWidget {
  const _ContactIconBubble({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: const BoxDecoration(
        color: Color(0xFFEAF3EE),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: EmergencyContactsScreen._primaryGreen, size: 22),
    );
  }
}
