import 'package:el_etehad/features/services/view/components/cars_services/car_details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ModelCarsView extends StatefulWidget {
  final String? carBrand;
  final String? modelName;

  const ModelCarsView({super.key, this.carBrand, this.modelName});

  @override
  State<ModelCarsView> createState() => _ModelCarsViewState();
}

class _ModelCarsViewState extends State<ModelCarsView> {
  // Sample data - replace with your API data
  List<Map<String, String>> carsDetails = [
    {
      "name": "كورولا 2024 فل أوبشن",
      "price": "450,000 جنيه",
      "horse_power": "170 حصان",
      "year": "2024",
      "image": "assets/images/car1.png",
    },
    {
      "name": "كورولا 2024 ستاندر",
      "price": "380,000 جنيه",
      "horse_power": "140 حصان",
      "year": "2024",
      "image": "assets/images/car2.png",
    },
    {
      "name": "كورولا 2023 فل أوبشن",
      "price": "420,000 جنيه",
      "horse_power": "170 حصان",
      "year": "2023",
      "image": "assets/images/car3.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.modelName ?? 'تفاصيل السيارات'),
        centerTitle: true,
      ),
      body:
          carsDetails.isEmpty
              ? _buildEmptyState(theme, isDark)
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: carsDetails.length,
                itemBuilder: (context, index) {
                  return _AnimatedCarCard(
                    carData: carsDetails[index],
                    delay: Duration(milliseconds: 100 * index),
                  );
                },
              ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_car_outlined,
            size: 80,
            color:
                isDark
                    ? Colors.white.withOpacity(0.3)
                    : Colors.black.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد تفاصيل متاحة',
            style: theme.textTheme.titleLarge?.copyWith(
              color:
                  isDark
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedCarCard extends StatefulWidget {
  final Map<String, String> carData;
  final Duration delay;

  const _AnimatedCarCard({required this.carData, required this.delay});

  @override
  State<_AnimatedCarCard> createState() => _AnimatedCarCardState();
}

class _AnimatedCarCardState extends State<_AnimatedCarCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1a1424) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isDark
                    ? const Color(0xFF271C2E).withOpacity(0.3)
                    : const Color(0xFF271C2E).withOpacity(0.1),
            width: 1,
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
            // Car Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                height: 200,
                color:
                    isDark ? const Color(0xFF2a2334) : const Color(0xFFF5F5F5),
                child:
                    widget.carData['image'] != null
                        ? Image.asset(
                          widget.carData['image']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.directions_car,
                                size: 80,
                                color: const Color(0xFF7c2a9e).withOpacity(0.3),
                              ),
                            );
                          },
                        )
                        : Center(
                          child: Icon(
                            Icons.directions_car,
                            size: 80,
                            color: const Color(0xFF7c2a9e).withOpacity(0.3),
                          ),
                        ),
              ),
            ),

            // Car Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car Name
                  Text(
                    widget.carData['name'] ?? 'غير محدد',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          isDark
                              ? const Color(0xFFe8e8e8)
                              : const Color(0xFF0d0316),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Horse Power
                  _buildDetailItem(
                    icon: Icons.monetization_on,
                    label: 'السعر',
                    value: widget.carData['price'] ?? 'غير محدد',
                    isDark: isDark,
                    theme: theme,
                  ),
                  // Details Row
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      // Price
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.speed,
                          label: 'القوة',
                          value: widget.carData['horse_power'] ?? 'غير محدد',
                          isDark: isDark,
                          theme: theme,
                          fullWidth: true,
                        ),
                      ),
                      Gap(10),
                      // Year
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.calendar_today,
                          label: 'الموديل',
                          value: widget.carData['year'] ?? 'غير محدد',
                          isDark: isDark,
                          theme: theme,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CarDetails()),
                        );
                        print('View details: ${widget.carData['name']}');
                      },
                      icon: const Icon(Icons.info_outline),
                      label: const Text('المزيد من التفاصيل'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7c2a9e),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
    required ThemeData theme,
    bool fullWidth = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2a2334) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF7c2a9e).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF7c2a9e).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF7c2a9e)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color:
                        isDark
                            ? const Color(0xFFb8b8b8)
                            : const Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color:
                        isDark
                            ? const Color(0xFFe8e8e8)
                            : const Color(0xFF0d0316),
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
