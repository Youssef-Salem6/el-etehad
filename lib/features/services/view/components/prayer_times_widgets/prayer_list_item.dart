import 'package:flutter/material.dart';

class PrayerListItem extends StatelessWidget {
  final String name;
  final String nameEn;
  final String? time;
  final IconData icon;
  final bool isNext;
  final bool isPassed;

  const PrayerListItem({
    super.key,
    required this.name,
    required this.nameEn,
    required this.time,
    required this.icon,
    required this.isNext,
    required this.isPassed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color:
            isNext
                ? theme.colorScheme.primary.withOpacity(0.15)
                : theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isNext ? theme.colorScheme.primary : theme.dividerColor,
          width: isNext ? 2 : 1,
        ),
        boxShadow:
            isNext
                ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:
                isNext
                    ? theme.colorScheme.primary
                    : isPassed
                    ? theme.colorScheme.surface
                    : theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color:
                isNext || isPassed ? Colors.white : theme.colorScheme.primary,
            size: 24,
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: isNext ? FontWeight.bold : FontWeight.w600,
            color:
                isPassed
                    ? theme.textTheme.bodySmall?.color
                    : theme.textTheme.titleLarge?.color,
          ),
        ),
        subtitle: Text(
          nameEn,
          style: TextStyle(
            fontSize: 12,
            color:
                isPassed
                    ? theme.textTheme.bodySmall?.color
                    : theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time ?? '--:--',
              style: TextStyle(
                fontSize: 20,
                fontWeight: isNext ? FontWeight.bold : FontWeight.w600,
                color:
                    isNext
                        ? theme.colorScheme.primary
                        : isPassed
                        ? theme.textTheme.bodySmall?.color
                        : theme.textTheme.titleLarge?.color,
                letterSpacing: 1,
              ),
            ),
            if (isNext)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'القادمة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
