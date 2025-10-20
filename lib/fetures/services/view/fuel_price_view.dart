import 'package:flutter/material.dart';

class FuelPriceView extends StatefulWidget {
  const FuelPriceView({super.key});

  @override
  State<FuelPriceView> createState() => _FuelPriceViewState();
}

class _FuelPriceViewState extends State<FuelPriceView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // بيانات أسعار الوقود
  final List<FuelItem> fuelItems = [
    FuelItem(
      name: 'بنزين 80',
      price: 13.50,
      icon: Icons.local_gas_station,
      color: const Color(0xFF10b981),
      unit: 'جنيه/لتر',
      priceChange: 0.50,
    ),
    FuelItem(
      name: 'بنزين 92',
      price: 15.25,
      icon: Icons.local_gas_station,
      color: const Color(0xFF3b82f6),
      unit: 'جنيه/لتر',
      priceChange: 0.75,
    ),
    FuelItem(
      name: 'بنزين 95',
      price: 17.00,
      icon: Icons.local_gas_station,
      color: const Color(0xFF8b5cf6),
      unit: 'جنيه/لتر',
      priceChange: 1.00,
    ),
    FuelItem(
      name: 'سولار',
      price: 11.50,
      icon: Icons.local_shipping,
      color: const Color(0xFFf59e0b),
      unit: 'جنيه/لتر',
      priceChange: 0.25,
    ),
    FuelItem(
      name: 'غاز طبيعي',
      price: 5.75,
      icon: Icons.propane_tank,
      color: const Color(0xFF06b6d4),
      unit: 'جنيه/متر³',
      priceChange: -0.15,
    ),
    FuelItem(
      name: 'مازوت',
      price: 9.25,
      icon: Icons.water_drop,
      color: const Color(0xFFec4899),
      unit: 'جنيه/لتر',
      priceChange: 0.10,
    ),
  ];

  String lastUpdate = '19 أكتوبر 2025 - 02:30 م';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // إزالة السهم الافتراضي
        title: const Text('أسعار الوقود'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            lastUpdate = 'الآن';
          });
          // إعادة تشغيل الأنيميشن عند التحديث
          _animationController.reset();
          _animationController.forward();
        },
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // عنوان القسم
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'الأسعار الحالية',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),

                // قائمة أسعار الوقود مع animation
                ...fuelItems.asMap().entries.map(
                  (entry) => _buildAnimatedFuelCard(
                    context,
                    entry.value,
                    isDark,
                    entry.key,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedFuelCard(
    BuildContext context,
    FuelItem item,
    bool isDark,
    int index,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: _buildFuelCard(context, item, isDark),
    );
  }

  Widget _buildFuelCard(BuildContext context, FuelItem item, bool isDark) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          _showPriceDetails(context, item);
        },
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // أيقونة نوع الوقود مع animation
              Hero(
                tag: 'fuel_icon_${item.name}',
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.8, end: 1.0),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.elasticOut,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: item.color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(item.icon, color: item.color, size: 32),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),

              // اسم الوقود والوحدة
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.unit,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              // السعر مع animation
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: item.price),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        value.toStringAsFixed(2),
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: item.color,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPriceDetails(BuildContext context, FuelItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // مؤشر السحب
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // محتوى الـ Bottom Sheet مع animation
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Hero(
                              tag: 'fuel_icon_${item.name}',
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: item.color.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  item.icon,
                                  color: item.color,
                                  size: 36,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    item.unit,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          context,
                          'السعر الحالي',
                          '${item.price.toStringAsFixed(2)} جنيه',
                        ),
                        _buildDetailRow(
                          context,
                          'التغيير',
                          '${item.priceChange >= 0 ? '+' : ''}${item.priceChange.toStringAsFixed(2)} جنيه',
                          color:
                              item.priceChange > 0
                                  ? const Color(0xFFef4444)
                                  : const Color(0xFF10b981),
                        ),
                        _buildDetailRow(context, 'آخر تحديث', lastUpdate),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('إغلاق'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// نموذج بيانات الوقود
class FuelItem {
  final String name;
  final double price;
  final IconData icon;
  final Color color;
  final String unit;
  final double priceChange;

  FuelItem({
    required this.name,
    required this.price,
    required this.icon,
    required this.color,
    required this.unit,
    required this.priceChange,
  });
}
