import 'package:el_etehad/features/services/models/emergency_service.dart';
import 'package:el_etehad/features/services/view/components/animated_numbers_card.dart';
import 'package:flutter/material.dart';


class NumbersGridSection extends StatelessWidget {
  final String title;
  final List<EmergencyNumber> numbers;
  final bool isDark;
  final Function(String) onCopy;
  final Color accentColor;

  const NumbersGridSection({
    super.key,
    required this.title,
    required this.numbers,
    required this.isDark,
    required this.onCopy,
    required this.accentColor,
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

        // Numbers Grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              return AnimatedNumberCard(
                number: numbers[index],
                index: index,
                isDark: isDark,
                onCopy: () => onCopy(numbers[index].number),
              );
            },
          ),
        ),
      ],
    );
  }
}