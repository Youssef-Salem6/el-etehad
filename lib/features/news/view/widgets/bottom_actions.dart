import 'package:flutter/material.dart';

class BottomActions extends StatelessWidget {
  final ThemeData theme;

  const BottomActions({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 70,
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            icon: Icons.thumb_up_outlined,
            label: '245',
            onTap: () {},
            theme: theme,
          ),
          _buildActionButton(
            icon: Icons.comment_outlined,
            label: '89',
            onTap: () {},
            theme: theme,
          ),
          _buildActionButton(
            icon: Icons.share_outlined,
            label: 'مشاركة',
            onTap: () {},
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: theme.primaryColor),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}