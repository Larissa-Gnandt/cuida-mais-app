import 'package:flutter/material.dart';

class AssistantBottomNav extends StatelessWidget {
  const AssistantBottomNav({
    super.key,
    required this.currentIndex,
    required this.onSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE8ECE8)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            icon: Icons.personal_injury_outlined,
            label: 'INCIDENTES',
            selected: currentIndex == 0,
            onTap: () => onSelected(0),
          ),
          _BottomNavItem(
            icon: Icons.support_agent,
            label: 'ASSISTENTE',
            selected: currentIndex == 1,
            onTap: () => onSelected(1),
          ),
          _BottomNavItem(
            icon: Icons.call_outlined,
            label: 'CONTATOS',
            selected: currentIndex == 2,
            onTap: () => onSelected(2),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEAF3EE) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: selected
                  ? const Color(0xFF2F7A5F)
                  : const Color(0xFFA1AAA5),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: selected
                    ? const Color(0xFF2F7A5F)
                    : const Color(0xFFA1AAA5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
