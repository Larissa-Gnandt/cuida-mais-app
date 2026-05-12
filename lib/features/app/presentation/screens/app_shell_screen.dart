import 'package:flutter/material.dart';

import '../../../assistant/data/services/assistant_conversation_storage.dart';
import '../../../assistant/domain/services/assistant_service.dart';
import '../../../assistant/presentation/screens/assistant_screen.dart';
import '../../../assistant/presentation/widgets/assistant_bottom_nav.dart';
import '../../../contacts/presentation/screens/emergency_contacts_screen.dart';
import '../../../incidents/presentation/screens/bleeding_emergency_screen.dart';
import '../../../incidents/presentation/screens/burn_emergency_screen.dart';
import '../../../incidents/presentation/screens/choking_emergency_screen.dart';
import '../../../incidents/presentation/screens/common_emergencies_screen.dart';
import '../../../incidents/presentation/screens/domestic_emergency_screen.dart';
import '../../../incidents/presentation/screens/first_aid_kit_screen.dart';
import '../../../incidents/presentation/screens/incidents_screen.dart';
import '../../../incidents/presentation/screens/serious_emergency_screen.dart';

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
  bool _showBleedingEmergency = false;
  bool _showBurnEmergency = false;
  bool _showChestPainEmergency = false;
  bool _showStrokeEmergency = false;
  bool _showSeizureEmergency = false;
  bool _showPoisoningEmergency = false;
  bool _showElectricShockEmergency = false;
  bool _showDrowningEmergency = false;

  late final List<Widget> _screens = [
    IncidentsScreen(
      onDailyTipTap: _openFirstAidKit,
      onCommonEmergenciesTap: _openCommonEmergencies,
      onEmergencyContactsTap: _openEmergencyContacts,
      onChokingTap: _openChokingEmergency,
      onBleedingTap: _openBleedingEmergency,
      onBurnTap: _openBurnEmergency,
      onChestPainTap: _openChestPainEmergency,
      onStrokeTap: _openStrokeEmergency,
      onSeizureTap: _openSeizureEmergency,
      onPoisoningTap: _openPoisoningEmergency,
      onElectricShockTap: _openElectricShockEmergency,
      onDrowningTap: _openDrowningEmergency,
    ),
    AssistantScreen(
      assistantService: widget.assistantService,
      conversationStorage: widget.conversationStorage,
    ),
    const EmergencyContactsScreen(),
  ];

  void _openEmergencyContacts() {
    setState(() {
      _currentIndex = 2;
      _showFirstAidKit = false;
      _showCommonEmergencies = false;
      _showChokingEmergency = false;
      _showBleedingEmergency = false;
      _showBurnEmergency = false;
      _showChestPainEmergency = false;
      _showStrokeEmergency = false;
      _showSeizureEmergency = false;
      _showPoisoningEmergency = false;
      _showElectricShockEmergency = false;
      _showDrowningEmergency = false;
    });
  }

  void _closeIncidentCard() {
    setState(() {
      _currentIndex = 0;
      _showFirstAidKit = false;
      _showCommonEmergencies = false;
      _showChokingEmergency = false;
      _showBleedingEmergency = false;
      _showBurnEmergency = false;
      _showChestPainEmergency = false;
      _showStrokeEmergency = false;
      _showSeizureEmergency = false;
      _showPoisoningEmergency = false;
      _showElectricShockEmergency = false;
      _showDrowningEmergency = false;
    });
  }

  void _openFirstAidKit() {
    setState(() {
      _currentIndex = 0;
      _showFirstAidKit = true;
      _showCommonEmergencies = false;
      _showChokingEmergency = false;
      _showBleedingEmergency = false;
      _showBurnEmergency = false;
      _showChestPainEmergency = false;
      _showStrokeEmergency = false;
      _showSeizureEmergency = false;
      _showPoisoningEmergency = false;
      _showElectricShockEmergency = false;
      _showDrowningEmergency = false;
    });
  }

  void _openCommonEmergencies() {
    setState(() {
      _currentIndex = 0;
      _showCommonEmergencies = true;
      _showFirstAidKit = false;
      _showChokingEmergency = false;
      _showBleedingEmergency = false;
      _showBurnEmergency = false;
      _showChestPainEmergency = false;
      _showStrokeEmergency = false;
      _showSeizureEmergency = false;
      _showPoisoningEmergency = false;
      _showElectricShockEmergency = false;
      _showDrowningEmergency = false;
    });
  }

  void _openChokingEmergency() {
    setState(() {
      _currentIndex = 0;
      _showChokingEmergency = true;
      _showCommonEmergencies = false;
      _showFirstAidKit = false;
      _showBleedingEmergency = false;
      _showBurnEmergency = false;
      _showChestPainEmergency = false;
      _showStrokeEmergency = false;
      _showSeizureEmergency = false;
      _showPoisoningEmergency = false;
      _showElectricShockEmergency = false;
      _showDrowningEmergency = false;
    });
  }

  void _openBleedingEmergency() {
    setState(() {
      _currentIndex = 0;
      _showBleedingEmergency = true;
      _showChokingEmergency = false;
      _showCommonEmergencies = false;
      _showFirstAidKit = false;
      _showBurnEmergency = false;
      _showChestPainEmergency = false;
      _showStrokeEmergency = false;
      _showSeizureEmergency = false;
      _showPoisoningEmergency = false;
      _showElectricShockEmergency = false;
      _showDrowningEmergency = false;
    });
  }

  void _openBurnEmergency() {
    setState(() {
      _currentIndex = 0;
      _showBurnEmergency = true;
      _showBleedingEmergency = false;
      _showChokingEmergency = false;
      _showCommonEmergencies = false;
      _showFirstAidKit = false;
      _showChestPainEmergency = false;
      _showStrokeEmergency = false;
      _showSeizureEmergency = false;
      _showPoisoningEmergency = false;
      _showElectricShockEmergency = false;
      _showDrowningEmergency = false;
    });
  }

  void _openChestPainEmergency() {
    setState(() {
      _currentIndex = 0;
      _showChestPainEmergency = true;
      _showStrokeEmergency = false;
      _showSeizureEmergency = false;
      _showBurnEmergency = false;
      _showBleedingEmergency = false;
      _showChokingEmergency = false;
      _showCommonEmergencies = false;
      _showFirstAidKit = false;
      _showPoisoningEmergency = false;
      _showElectricShockEmergency = false;
      _showDrowningEmergency = false;
    });
  }

  void _openStrokeEmergency() {
    setState(() {
      _currentIndex = 0;
      _showStrokeEmergency = true;
      _showChestPainEmergency = false;
      _showSeizureEmergency = false;
      _showBurnEmergency = false;
      _showBleedingEmergency = false;
      _showChokingEmergency = false;
      _showCommonEmergencies = false;
      _showFirstAidKit = false;
      _showPoisoningEmergency = false;
      _showElectricShockEmergency = false;
      _showDrowningEmergency = false;
    });
  }

  void _openSeizureEmergency() {
    setState(() {
      _currentIndex = 0;
      _showSeizureEmergency = true;
      _showChestPainEmergency = false;
      _showStrokeEmergency = false;
      _showBurnEmergency = false;
      _showBleedingEmergency = false;
      _showChokingEmergency = false;
      _showCommonEmergencies = false;
      _showFirstAidKit = false;
      _showPoisoningEmergency = false;
      _showElectricShockEmergency = false;
      _showDrowningEmergency = false;
    });
  }

  void _openPoisoningEmergency() {
    setState(() {
      _currentIndex = 0;
      _showPoisoningEmergency = true;
      _showElectricShockEmergency = false;
      _showDrowningEmergency = false;
      _showSeizureEmergency = false;
      _showStrokeEmergency = false;
      _showChestPainEmergency = false;
      _showBurnEmergency = false;
      _showBleedingEmergency = false;
      _showChokingEmergency = false;
      _showCommonEmergencies = false;
      _showFirstAidKit = false;
    });
  }

  void _openElectricShockEmergency() {
    setState(() {
      _currentIndex = 0;
      _showElectricShockEmergency = true;
      _showPoisoningEmergency = false;
      _showDrowningEmergency = false;
      _showSeizureEmergency = false;
      _showStrokeEmergency = false;
      _showChestPainEmergency = false;
      _showBurnEmergency = false;
      _showBleedingEmergency = false;
      _showChokingEmergency = false;
      _showCommonEmergencies = false;
      _showFirstAidKit = false;
    });
  }

  void _openDrowningEmergency() {
    setState(() {
      _currentIndex = 0;
      _showDrowningEmergency = true;
      _showPoisoningEmergency = false;
      _showElectricShockEmergency = false;
      _showSeizureEmergency = false;
      _showStrokeEmergency = false;
      _showChestPainEmergency = false;
      _showBurnEmergency = false;
      _showBleedingEmergency = false;
      _showChokingEmergency = false;
      _showCommonEmergencies = false;
      _showFirstAidKit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showFirstAidKit
          ? FirstAidKitScreen(onDismiss: _closeIncidentCard)
          : _showDrowningEmergency
          ? DrowningEmergencyScreen(onDismiss: _closeIncidentCard)
          : _showElectricShockEmergency
          ? ElectricShockEmergencyScreen(onDismiss: _closeIncidentCard)
          : _showPoisoningEmergency
          ? PoisoningEmergencyScreen(onDismiss: _closeIncidentCard)
          : _showSeizureEmergency
          ? SeizureEmergencyScreen(onDismiss: _closeIncidentCard)
          : _showStrokeEmergency
          ? StrokeEmergencyScreen(onDismiss: _closeIncidentCard)
          : _showChestPainEmergency
          ? ChestPainEmergencyScreen(onDismiss: _closeIncidentCard)
          : _showBurnEmergency
          ? BurnEmergencyScreen(onDismiss: _closeIncidentCard)
          : _showBleedingEmergency
          ? BleedingEmergencyScreen(onDismiss: _closeIncidentCard)
          : _showChokingEmergency
          ? ChokingEmergencyScreen(onDismiss: _closeIncidentCard)
          : _showCommonEmergencies
          ? CommonEmergenciesScreen(
              onDismiss: _closeIncidentCard,
              onChokingTap: _openChokingEmergency,
              onBleedingTap: _openBleedingEmergency,
              onBurnTap: _openBurnEmergency,
            )
          : IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: AssistantBottomNav(
        currentIndex: _currentIndex,
        onSelected: (index) {
          setState(() {
            _currentIndex = index;
            _showFirstAidKit = false;
            _showCommonEmergencies = false;
            _showChokingEmergency = false;
            _showBleedingEmergency = false;
            _showBurnEmergency = false;
            _showChestPainEmergency = false;
            _showStrokeEmergency = false;
            _showSeizureEmergency = false;
            _showPoisoningEmergency = false;
            _showElectricShockEmergency = false;
            _showDrowningEmergency = false;
          });
        },
      ),
    );
  }
}
