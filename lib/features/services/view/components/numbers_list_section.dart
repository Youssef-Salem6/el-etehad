import 'package:el_etehad/features/services/models/emergency_service.dart';
import 'package:el_etehad/features/services/view/components/animated_numbers_list_item.dart';
import 'package:flutter/material.dart';


class NumbersListSection extends StatelessWidget {
  final String title;
  final List<EmergencyNumber> numbers;
  final bool isDark;
  final Function(String) onCopy;
  final Color accentColor;
  final int startIndex;

  const NumbersListSection({
    super.key,
    required this.title,
    required this.numbers,
    required this.isDark,
    required this.onCopy,
    required this.accentColor,
    this.startIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Numbers List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return AnimatedNumberListItem(
              number: numbers[index],
              index: startIndex + index,
              isDark: isDark,
              onCopy: () => onCopy(numbers[index].number),
            );
          },
        ),
      ],
    );
  }
}