import 'package:flutter/material.dart';

class EmergencyAlertCard extends StatelessWidget {
  const EmergencyAlertCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F8),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1DDDA)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 18,
                color: Color(0xFFDF5B3A),
              ),
              SizedBox(width: 6),
              Text(
                'IMPORTANTE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFDF5B3A),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Se a pessoa perder a consciencia, inicie a RCP e chame o socorro medico imediatamente.',
            style: TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xFFC05642),
            ),
          ),
        ],
      ),
    );
  }
}
