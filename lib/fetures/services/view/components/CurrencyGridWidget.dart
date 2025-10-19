// currency_grid_widget.dart

import 'package:el_etehad/fetures/services/models/currency_model.dart';
import 'package:flutter/material.dart';

class CurrencyGridWidget extends StatefulWidget {
  final CurrencyModel model;
  final Function(String) onCurrencyTap;
  final List<Map<String, String>> topCurrencies = const [
    {'code': 'USD', 'name': 'دولار أمريكي'},
    {'code': 'EUR', 'name': 'يورو'},
    {'code': 'GBP', 'name': 'جنيه إسترليني'},
    {'code': 'SAR', 'name': 'ريال سعودي'},
    {'code': 'AED', 'name': 'درهم إماراتي'},
    {'code': 'KWD', 'name': 'دينار كويتي'},
  ];

  const CurrencyGridWidget({
    super.key,
    required this.model,
    required this.onCurrencyTap,
  });

  @override
  State<CurrencyGridWidget> createState() => _CurrencyGridWidgetState();
}

class _CurrencyGridWidgetState extends State<CurrencyGridWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _glowController;
  String? _pressedCurrency;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(isDark),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1, // Increased to make cards shorter
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: widget.topCurrencies.length,
          itemBuilder: (context, index) {
            final currencyData = widget.topCurrencies[index];
            final currency = currencyData['code']!;
            final rate = widget.model.rates[currency] ?? 0.0;
            final egpValue = rate > 0 ? (1 / rate) : 0.0;
            final isPressed = _pressedCurrency == currency;

            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 400 + (index * 100)),
              tween: Tween(begin: 0.0, end: 1.0),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(
                    opacity: value,
                    child: _buildCurrencyCard(
                      context,
                      currencyData,
                      rate,
                      egpValue,
                      isDark,
                      isPressed,
                      index,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              isDark
                  ? [
                    const Color(0xFF271C2E).withOpacity(0.6),
                    const Color(0xFF1a1424).withOpacity(0.6),
                  ]
                  : [
                    const Color(0xFF7c2a9e).withOpacity(0.1),
                    const Color(0xFF9b3ec7).withOpacity(0.05),
                  ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              isDark
                  ? const Color(0xFF7c2a9e).withOpacity(0.3)
                  : const Color(0xFF7c2a9e).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7c2a9e), Color(0xFF9b3ec7)],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7c2a9e).withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.trending_up_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'العملات الشائعة',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_forward_rounded),
            color:
                isDark
                    ? const Color(0xFFb8b8b8)
                    : const Color(0xFF0d0316).withOpacity(0.6),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyCard(
    BuildContext context,
    Map<String, String> currencyData,
    double rate,
    double egpValue,
    bool isDark,
    bool isPressed,
    int index,
  ) {
    final gradientColors = _getGradientColors(index);

    return AnimatedBuilder(
      animation: Listenable.merge([_pulseController, _glowController]),
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            widget.onCurrencyTap(currencyData['code']!);
          },
          onLongPressStart: (_) {
            setState(() {
              _pressedCurrency = currencyData['code']!;
            });
          },
          onLongPressEnd: (_) {
            setState(() {
              _pressedCurrency = null;
            });
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:
                      isPressed
                          ? [
                            gradientColors[0],
                            gradientColors[1],
                            gradientColors[0].withOpacity(0.8),
                          ]
                          : isDark
                          ? [const Color(0xFF1a1424), const Color(0xFF2a2334)]
                          : [Colors.white, const Color(0xFFF8F9FA)],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color:
                      isPressed
                          ? Colors.white.withOpacity(0.3)
                          : isDark
                          ? const Color(0xFF271C2E).withOpacity(0.5)
                          : const Color(0xFF0d0316).withOpacity(0.1),
                  width: isPressed ? 2 : 1,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isPressed
                              ? Colors.white.withOpacity(0.2)
                              : gradientColors[0].withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            isPressed
                                ? Colors.white.withOpacity(0.4)
                                : gradientColors[0].withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      currencyData['name']!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color:
                            isPressed
                                ? Colors.white
                                : isDark
                                ? const Color(0xFFe8e8e8)
                                : const Color(0xFF0d0316),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          isPressed
                              ? Colors.white.withOpacity(0.15)
                              : isDark
                              ? const Color(0xFF000014).withOpacity(0.3)
                              : Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            isPressed
                                ? Colors.white.withOpacity(0.3)
                                : isDark
                                ? const Color(0xFF271C2E).withOpacity(0.3)
                                : const Color(0xFF0d0316).withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '1 ${currencyData['code']}',
                              style: TextStyle(
                                fontSize: 11,
                                color:
                                    isPressed
                                        ? Colors.white.withOpacity(0.8)
                                        : isDark
                                        ? const Color(0xFF8a8a8a)
                                        : const Color(
                                          0xFF0d0316,
                                        ).withOpacity(0.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 11,
                              color:
                                  isPressed
                                      ? Colors.white.withOpacity(0.6)
                                      : isDark
                                      ? const Color(0xFF8a8a8a)
                                      : const Color(
                                        0xFF0d0316,
                                      ).withOpacity(0.4),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              egpValue.toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:
                                    isPressed
                                        ? Colors.white
                                        : isDark
                                        ? const Color(0xFFe8e8e8)
                                        : const Color(0xFF0d0316),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                'جنيه',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      isPressed
                                          ? Colors.white.withOpacity(0.8)
                                          : isDark
                                          ? const Color(0xFFb8b8b8)
                                          : const Color(
                                            0xFF0d0316,
                                          ).withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Color> _getGradientColors(int index) {
    final colors = [
      [const Color(0xFF7c2a9e), const Color(0xFF9b3ec7)],
      [const Color(0xFF3b82f6), const Color(0xFF60a5fa)],
      [const Color(0xFF10b981), const Color(0xFF34d399)],
      [const Color(0xFFf59e0b), const Color(0xFFfbbf24)],
      [const Color(0xFFef4444), const Color(0xFFf87171)],
      [const Color(0xFF8b5cf6), const Color(0xFFa78bfa)],
    ];
    return colors[index % colors.length];
  }
}
