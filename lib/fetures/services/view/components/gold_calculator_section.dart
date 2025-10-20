import 'package:flutter/material.dart';

class GoldCalculatorSection extends StatelessWidget {
  final ThemeData theme;
  final bool isDark;
  final double goldWeight;
  final String selectedCarat;
  final double pricePerGram;
  final Function(double) onWeightChanged;
  final Function(String) onCaratChanged;

  const GoldCalculatorSection({
    super.key,
    required this.theme,
    required this.isDark,
    required this.goldWeight,
    required this.selectedCarat,
    required this.pricePerGram,
    required this.onWeightChanged,
    required this.onCaratChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1a1424) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              isDark
                  ? const Color(0xFF271C2E).withOpacity(0.3)
                  : const Color(0xFF271C2E).withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color:
                isDark
                    ? const Color(0xFF000014).withOpacity(0.4)
                    : const Color(0xFF000014).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF7c2a9e).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calculate,
                  color: Color(0xFF7c2a9e),
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'حاسبة الذهب',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Carat selector
          Text('اختر العيار', style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildCaratChip('24', theme, isDark),
              const SizedBox(width: 8),
              _buildCaratChip('21', theme, isDark),
              const SizedBox(width: 8),
              _buildCaratChip('18', theme, isDark),
              const SizedBox(width: 8),
              _buildCaratChip('14', theme, isDark),
            ],
          ),

          const SizedBox(height: 20),

          // Weight input
          Text('الوزن بالجرام', style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'أدخل الوزن',
              prefixIcon: const Icon(Icons.balance),
              suffixText: 'جرام',
            ),
            onChanged: (value) {
              onWeightChanged(double.tryParse(value) ?? 0);
            },
          ),

          const SizedBox(height: 20),

          // Result
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF7c2a9e).withOpacity(0.2),
                  const Color(0xFF9b3ec7).withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF7c2a9e).withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Text('السعر الإجمالي', style: theme.textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text(
                  '${_calculateGoldPrice().toStringAsFixed(2)} ج.م',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: const Color(0xFF9b3ec7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaratChip(String carat, ThemeData theme, bool isDark) {
    final isSelected = selectedCarat == carat;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onCaratChanged(carat);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? const Color(0xFF7c2a9e)
                    : (isDark
                        ? const Color(0xFF2a2334)
                        : const Color(0xFF271C2E).withOpacity(0.05)),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isSelected
                      ? const Color(0xFF7c2a9e)
                      : const Color(0xFF271C2E).withOpacity(0.2),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              'عيار $carat',
              style: theme.textTheme.titleSmall?.copyWith(
                color:
                    isSelected
                        ? Colors.white
                        : (isDark
                            ? const Color(0xFFe8e8e8)
                            : const Color(0xFF0d0316)),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _calculateGoldPrice() {
    return goldWeight * pricePerGram;
  }
}
