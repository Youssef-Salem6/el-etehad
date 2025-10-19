import 'package:flutter/material.dart';
import 'gold_chart_painter.dart';

class GoldChartSection extends StatelessWidget {
  final ThemeData theme;
  final bool isDark;

  const GoldChartSection({
    super.key,
    required this.theme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
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
                  color: const Color(0xFFf59e0b).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.show_chart,
                  color: Color(0xFFf59e0b),
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'أسعار الذهب اليوم',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'تحديث مباشر',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF10b981),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Chart placeholder with sample data visualization
          Container(
            height: 200,
            decoration: BoxDecoration(
              color:
                  isDark
                      ? const Color(0xFF2a2334).withOpacity(0.5)
                      : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: CustomPaint(
              painter: GoldChartPainter(isDark: isDark),
              child: const Center(),
            ),
          ),

          const SizedBox(height: 16),

          // Gold prices summary
          Row(
            children: [
              Expanded(
                child: _buildPriceCard('عيار 24', '3500', theme, isDark),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildPriceCard('عيار 21', '3062', theme, isDark),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildPriceCard('عيار 18', '2625', theme, isDark),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard(
    String carat,
    String price,
    ThemeData theme,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
            isDark
                ? const Color(0xFF2a2334)
                : const Color(0xFF271C2E).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFf59e0b).withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            carat,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$price ج.م',
            style: theme.textTheme.titleMedium?.copyWith(
              color: const Color(0xFFf59e0b),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
