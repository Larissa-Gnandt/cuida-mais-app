import 'package:flutter/material.dart';

import 'features/assistant/presentation/screens/assistant_screen.dart';

class CuidaMaisApp extends StatelessWidget {
  const CuidaMaisApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF2F7A5F);
    const softGreen = Color(0xFFEAF3EE);
    const canvas = Color(0xFFF4F7F2);

    return MaterialApp(
      title: 'Cuida+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
          primary: primaryGreen,
          secondary: softGreen,
          surface: Colors.white,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1B4332),
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF25352D),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            height: 1.45,
            color: Color(0xFF42544A),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 1.45,
            color: Color(0xFF5F6F67),
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8D9992),
          ),
        ),
      ),
      home: const AssistantScreen(),
    );
  }
}
