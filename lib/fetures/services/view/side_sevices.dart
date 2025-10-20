import 'package:flutter/material.dart';
import 'components/gold_chart_section.dart';
import 'components/gold_calculator_section.dart';
import 'components/services_grid_section.dart';

class SideServices extends StatefulWidget {
  const SideServices({super.key});

  @override
  State<SideServices> createState() => _SideServicesState();
}

class _SideServicesState extends State<SideServices> {
  // Gold calculator state
  double goldWeight = 0;
  String selectedCarat = '24';
  double pricePerGram = 3500; // سعر افتراضي

  void updateGoldWeight(double weight) {
    setState(() {
      goldWeight = weight;
    });
  }

  void updateSelectedCarat(String carat) {
    setState(() {
      selectedCarat = carat;
      // Update price per gram based on carat
      if (carat == '24') pricePerGram = 3500;
      if (carat == '21') pricePerGram = 3062;
      if (carat == '18') pricePerGram = 2625;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('الخدمات'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gold Price Chart Section
            GoldChartSection(theme: theme, isDark: isDark),
            const SizedBox(height: 24),
            // Gold Calculator Section
            GoldCalculatorSection(
              theme: theme,
              isDark: isDark,
              goldWeight: goldWeight,
              selectedCarat: selectedCarat,
              pricePerGram: pricePerGram,
              onWeightChanged: updateGoldWeight,
              onCaratChanged: updateSelectedCarat,
            ),
            const SizedBox(height: 32),
            // Services Grid Section
            ServicesGridSection(theme: theme, isDark: isDark),
          ],
        ),
      ),
    );
  }
}
