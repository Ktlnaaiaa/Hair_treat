import 'package:flutter/material.dart';

class HairTreatBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HairTreatBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
      child: SafeArea(
        top: false,
        child: Container(
          height: 74,
          decoration: BoxDecoration(
            color: const Color(0xFF171726).withValues(alpha: 0.78),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _item(Icons.home_rounded, 'Home', 0),
              _item(Icons.spa_outlined, 'Services', 1),
              _item(Icons.calendar_month_outlined, 'Booking', 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.92)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected
                  ? const Color(0xFF7A5C45)
                  : Colors.white.withValues(alpha: 0.82),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF7A5C45)
                    : Colors.white.withValues(alpha: 0.82),
              ),
            ),
          ],
        ),
      ),
    );
  }
}