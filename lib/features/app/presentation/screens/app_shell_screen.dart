import 'package:flutter/material.dart';

import '../../../assistant/data/services/assistant_conversation_storage.dart';
import '../../../assistant/domain/services/assistant_service.dart';
import '../../../assistant/presentation/screens/assistant_screen.dart';
import '../../../assistant/presentation/widgets/assistant_bottom_nav.dart';
import '../../../contacts/presentation/screens/emergency_contacts_screen.dart';
import '../../../incidents/presentation/screens/choking_emergency_screen.dart';
import '../../../incidents/presentation/screens/common_emergencies_screen.dart';
import '../../../incidents/presentation/screens/first_aid_kit_screen.dart';
import '../../../incidents/presentation/screens/incidents_screen.dart';

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
  int _currentIndex = 0;
  bool _showFirstAidKit = false;
  bool _showCommonEmergencies = false;
  bool _showChokingEmergency = false;

  late final List<Widget> _screens = [
    IncidentsScreen(
      onDailyTipTap: _openFirstAidKit,
      onCommonEmergenciesTap: _openCommonEmergencies,
      onChokingTap: _openChokingEmergency,
    ),
    AssistantScreen(
      assistantService: widget.assistantService,
      conversationStorage: widget.conversationStorage,
    ),
    const EmergencyContactsScreen(),
  ];

  void _openFirstAidKit() {
    setState(() {
      _currentIndex = 1;
      _showFirstAidKit = true;
      _showCommonEmergencies = false;
      _showChokingEmergency = false;
    });
  }

  void _openCommonEmergencies() {
    setState(() {
      _currentIndex = 0;
      _showCommonEmergencies = true;
      _showFirstAidKit = false;
      _showChokingEmergency = false;
    });
  }

  void _openChokingEmergency() {
    setState(() {
      _currentIndex = 0;
      _showChokingEmergency = true;
      _showCommonEmergencies = false;
      _showFirstAidKit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showFirstAidKit
          ? const FirstAidKitScreen()
          : _showChokingEmergency
          ? const ChokingEmergencyScreen()
          : _showCommonEmergencies
          ? CommonEmergenciesScreen(onChokingTap: _openChokingEmergency)
          : IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: AssistantBottomNav(
        currentIndex: _currentIndex,
        onSelected: (index) {
          setState(() {
            _currentIndex = index;
            _showFirstAidKit = false;
            _showCommonEmergencies = false;
            _showChokingEmergency = false;
          });
        },
      ),
    );
  }
}
