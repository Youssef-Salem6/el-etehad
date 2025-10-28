// currency_converter_widget.dart

import 'package:el_etehad/features/services/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class CurrencyConverterWidget extends StatefulWidget {
  final CurrencyModel model;

  const CurrencyConverterWidget({super.key, required this.model});

  @override
  State<CurrencyConverterWidget> createState() =>
      _CurrencyConverterWidgetState();
}

class _CurrencyConverterWidgetState extends State<CurrencyConverterWidget>
    with TickerProviderStateMixin {
  final TextEditingController _amountController = TextEditingController(
    text: '1',
  );
  String? selectedFromCurrency;
  String? selectedToCurrency;
  double convertedAmount = 0.0;

  late AnimationController _swapController;
  late AnimationController _resultController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _swapController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _resultController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: math.pi).animate(
      CurvedAnimation(parent: _swapController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _resultController, curve: Curves.elasticOut),
    );
  }

  void _convertCurrency() {
    if (selectedFromCurrency == null || selectedToCurrency == null) return;

    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final fromRate = widget.model.rates[selectedFromCurrency!] ?? 1.0;
    final toRate = widget.model.rates[selectedToCurrency!] ?? 1.0;

    setState(() {
      convertedAmount = (amount / fromRate) * toRate;
    });

    _resultController.forward(from: 0);
    HapticFeedback.mediumImpact();
  }

  void _swapCurrencies() {
    setState(() {
      final temp = selectedFromCurrency;
      selectedFromCurrency = selectedToCurrency;
      selectedToCurrency = temp;
    });
    _swapController.forward(from: 0);
    _convertCurrency();
    HapticFeedback.mediumImpact();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _swapController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3b82f6).withOpacity(0.2),
                    const Color(0xFF60a5fa).withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.swap_horiz_rounded,
                color:
                    isDark ? const Color(0xFF60a5fa) : const Color(0xFF3b82f6),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'محول العملات',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Dropdowns and Swap Button Row
        Row(
          children: [
            // From Currency Dropdown
            Expanded(
              child: _buildCompactDropdown(
                value: selectedFromCurrency,
                label: 'من',
                isDark: isDark,
                gradientColors: const [Color(0xFF10b981), Color(0xFF34d399)],
                onChanged: (value) {
                  setState(() => selectedFromCurrency = value);
                  _convertCurrency();
                },
              ),
            ),
            const SizedBox(width: 12),
            // Swap Button
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7c2a9e), Color(0xFF9b3ec7)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7c2a9e).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _swapCurrencies,
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.swap_horiz_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            // To Currency Dropdown
            Expanded(
              child: _buildCompactDropdown(
                value: selectedToCurrency,
                label: 'إلى',
                isDark: isDark,
                gradientColors: const [Color(0xFFef4444), Color(0xFFf87171)],
                onChanged: (value) {
                  setState(() => selectedToCurrency = value);
                  _convertCurrency();
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Amount Input
        _buildAnimatedTextField(
          controller: _amountController,
          label: 'المبلغ',
          icon: Icons.payments_rounded,
          isDark: isDark,
          onChanged: (value) => _convertCurrency(),
        ),

        const SizedBox(height: 32),

        // Result
        if (selectedFromCurrency != null && selectedToCurrency != null)
          ScaleTransition(
            scale: _scaleAnimation,
            child: _buildResultCard(isDark),
          ),
      ],
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isDark,
    required Function(String) onChanged,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors:
                      isDark
                          ? [const Color(0xFF1a1424), const Color(0xFF2a2334)]
                          : [Colors.white, const Color(0xFFF8F9FA)],
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDark
                            ? const Color(0xFF000014).withOpacity(0.3)
                            : Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(
                  color:
                      isDark
                          ? const Color(0xFF271C2E).withOpacity(0.5)
                          : const Color(0xFF0d0316).withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color:
                      isDark
                          ? const Color(0xFFe8e8e8)
                          : const Color(0xFF0d0316),
                ),
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(
                    color:
                        isDark
                            ? const Color(0xFFb8b8b8)
                            : const Color(0xFF0d0316).withOpacity(0.6),
                  ),
                  prefixIcon: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7c2a9e), Color(0xFF9b3ec7)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: Colors.white, size: 20),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                ),
                onChanged: onChanged,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompactDropdown({
    required String? value,
    required String label,
    required bool isDark,
    required List<Color> gradientColors,
    required Function(String?) onChanged,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, animValue, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - animValue)),
          child: Opacity(
            opacity: animValue,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors:
                      isDark
                          ? [const Color(0xFF1a1424), const Color(0xFF2a2334)]
                          : [Colors.white, const Color(0xFFF8F9FA)],
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDark
                            ? const Color(0xFF000014).withOpacity(0.3)
                            : Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(
                  color:
                      isDark
                          ? const Color(0xFF271C2E).withOpacity(0.5)
                          : const Color(0xFF0d0316).withOpacity(0.1),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          isDark
                              ? const Color(0xFFb8b8b8)
                              : const Color(0xFF0d0316).withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    underline: const SizedBox(),
                    dropdownColor:
                        isDark ? const Color(0xFF1a1424) : Colors.white,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          isDark
                              ? const Color(0xFFe8e8e8)
                              : const Color(0xFF0d0316),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color:
                          isDark
                              ? const Color(0xFFb8b8b8)
                              : const Color(0xFF0d0316),
                      size: 20,
                    ),
                    hint: Text(
                      'اختر',
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            isDark
                                ? const Color(0xFF8a8a8a)
                                : const Color(0xFF0d0316).withOpacity(0.5),
                      ),
                    ),
                    items:
                        widget.model.rates.keys.map((currency) {
                          return DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                    onChanged: onChanged,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF7c2a9e),
            const Color(0xFF9b3ec7),
            const Color(0xFFb554e8),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7c2a9e).withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'نتيجة التحويل',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_amountController.text} $selectedFromCurrency',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Icon(
            Icons.arrow_downward_rounded,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  convertedAmount.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7c2a9e),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  selectedToCurrency!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF7c2a9e).withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: Colors.white,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'السعر: 1 $selectedFromCurrency = ${(convertedAmount / (double.tryParse(_amountController.text) ?? 1)).toStringAsFixed(4)} $selectedToCurrency',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
