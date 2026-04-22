import 'package:flutter/material.dart';

class InstructionStep {
  const InstructionStep({
    required this.number,
    required this.description,
    required this.icon,
  });

  final String number;
  final String description;
  final IconData icon;
}
