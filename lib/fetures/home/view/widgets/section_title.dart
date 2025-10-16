import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool isMore;
  final VoidCallback? onMorePressed;

  const SectionTitle({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.onMorePressed,
    required this.isMore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Visibility(
            visible: isMore,
            child: TextButton(
              onPressed: onMorePressed,
              child: const Text('المزيد'),
            ),
          ),
        ],
      ),
    );
  }
}
