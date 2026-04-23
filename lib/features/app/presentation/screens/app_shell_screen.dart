import 'package:flutter/material.dart';

import '../../../assistant/data/services/assistant_conversation_storage.dart';
import '../../../assistant/domain/services/assistant_service.dart';
import '../../../assistant/presentation/screens/assistant_screen.dart';
import '../../../assistant/presentation/widgets/assistant_bottom_nav.dart';

class AppShellScreen extends StatefulWidget {
  const AppShellScreen({
    super.key,
    required this.assistantService,
    required this.conversationStorage,
  });

  final AssistantService assistantService;
  final AssistantConversationStorage conversationStorage;

  @override
  State<AppShellScreen> createState() => _AppShellScreenState();
}

class _AppShellScreenState extends State<AppShellScreen> {
  int _currentIndex = 1;

  late final List<Widget> _screens = [
    const _PlaceholderTab(
      title: 'Incidentes',
      description: 'Tela sera implementada em breve.',
      icon: Icons.personal_injury_outlined,
    ),
    AssistantScreen(
      assistantService: widget.assistantService,
      conversationStorage: widget.conversationStorage,
    ),
    const _PlaceholderTab(
      title: 'Contatos',
      description: 'Tela sera implementada em breve.',
      icon: Icons.call_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: AssistantBottomNav(
        currentIndex: _currentIndex,
        onSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 42, color: const Color(0xFF2F7A5F)),
                const SizedBox(height: 16),
                Text(title, style: theme.textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
