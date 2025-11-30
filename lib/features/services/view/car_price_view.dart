import 'package:el_etehad/features/services/view/components/cars_services/brand_models_view.dart';
import 'package:flutter/material.dart';

class CarPriceView extends StatefulWidget {
  const CarPriceView({super.key});

  @override
  State<CarPriceView> createState() => _CarPriceViewState();
}

class _CarPriceViewState extends State<CarPriceView> {
  final List<Map<String, String>> cars = [
    {"type": "مرسيدس", "image": "assets/images/MercedesLogo.png"},
    {"type": "تويوتا", "image": "assets/images/toyotaLogo.png"},
    {"type": "فيراري", "image": "assets/images/ferrariLogo.png"},
    {"type": "دودج", "image": "assets/images/dodge-logo-black-and-white.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('أسعار السيارات'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: cars.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return _AnimatedCarCard(
              carType: cars[index]["type"]!,
              imagePath: cars[index]["image"]!,
              delay: Duration(milliseconds: 100 * index),
            );
          },
        ),
      ),
    );
  }
}

class _AnimatedCarCard extends StatefulWidget {
  final String carType;
  final String imagePath;
  final Duration delay;

  const _AnimatedCarCard({
    required this.carType,
    required this.imagePath,
    required this.delay,
  });

  @override
  State<_AnimatedCarCard> createState() => _AnimatedCarCardState();
}

class _AnimatedCarCardState extends State<_AnimatedCarCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Start animation after delay
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

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: InkWell(
            onTap: () {
              print('Selected: ${widget.carType}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => CarsModelView(
                        carBrand: "تويوتا",
                        brandLogo: "assets/images/toyotaLogo.png",
                      ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform:
                  Matrix4.identity()
                    ..scale(_isHovered ? 1.05 : 1.0)
                    ..translate(0.0, _isHovered ? -5.0 : 0.0),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1a1424) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      _isHovered
                          ? const Color(0xFF7c2a9e)
                          : (isDark
                              ? const Color(0xFF271C2E).withOpacity(0.3)
                              : const Color(0xFF271C2E).withOpacity(0.1)),
                  width: _isHovered ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        _isHovered
                            ? const Color(0xFF7c2a9e).withOpacity(0.3)
                            : (isDark
                                ? const Color(0xFF000014).withOpacity(0.4)
                                : const Color(0xFF000014).withOpacity(0.08)),
                    blurRadius: _isHovered ? 20 : 12,
                    offset: Offset(0, _isHovered ? 8 : 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Container with Glow Effect
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? const Color(0xFF2a2334)
                              : const Color(0xFFF5F5F5),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            _isHovered
                                ? const Color(0xFF7c2a9e)
                                : const Color(0xFF7c2a9e).withOpacity(0.2),
                        width: _isHovered ? 3 : 2,
                      ),
                      boxShadow:
                          _isHovered
                              ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFF7c2a9e,
                                  ).withOpacity(0.4),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ]
                              : null,
                    ),
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.directions_car,
                          size: 50,
                          color:
                              _isHovered
                                  ? const Color(0xFF7c2a9e)
                                  : const Color(0xFF7c2a9e).withOpacity(0.5),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Car Name
                  Text(
                    widget.carType,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          isDark
                              ? const Color(0xFFe8e8e8)
                              : const Color(0xFF0d0316),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // View Details Badge
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
