import 'package:el_etehad/features/services/view/components/cars_services/model_cars_view.dart';
import 'package:flutter/material.dart';

class CarsModelView extends StatefulWidget {
  final String carBrand;
  final String? brandLogo;

  const CarsModelView({super.key, required this.carBrand, this.brandLogo});

  @override
  State<CarsModelView> createState() => _CarsModelViewState();
}

class _CarsModelViewState extends State<CarsModelView> {
  // Sample data - replace with your API data
  final Map<String, List<Map<String, dynamic>>> carModels = {
    "تويوتا": [
      {"name": "كورولا", "image": "assets/images/toyotaLogo.png"},
      {"name": "كامري", "image": "assets/images/toyotaLogo.png"},
      {"name": "راف فور", "image": "assets/images/toyotaLogo.png"},
      {"name": "هايلاندر", "image": "assets/images/toyotaLogo.png"},
      {"name": "لاند كروزر", "image": "assets/images/toyotaLogo.png"},
      {"name": "يارس", "image": "assets/images/toyotaLogo.png"},
    ],
    "مرسيدس": [
      {"name": "C-Class", "image": "assets/images/c-class.png"},
      {"name": "E-Class", "image": "assets/images/e-class.png"},
      {"name": "S-Class", "image": "assets/images/s-class.png"},
      {"name": "GLE", "image": "assets/images/gle.png"},
      {"name": "GLC", "image": "assets/images/glc.png"},
      {"name": "A-Class", "image": "assets/images/a-class.png"},
    ],
    "فيراري": [
      {"name": "Roma", "image": "assets/images/roma.png"},
      {"name": "Portofino", "image": "assets/images/portofino.png"},
      {"name": "F8 Tributo", "image": "assets/images/f8.png"},
      {"name": "SF90", "image": "assets/images/sf90.png"},
    ],
    "دودج": [
      {"name": "Challenger", "image": "assets/images/challenger.png"},
      {"name": "Charger", "image": "assets/images/charger.png"},
      {"name": "Durango", "image": "assets/images/durango.png"},
      {"name": "Ram", "image": "assets/images/ram.png"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final models = carModels[widget.carBrand] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('موديلات ${widget.carBrand}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Brand Header
          _buildBrandHeader(isDark, theme),

          // Models Grid
          Expanded(
            child:
                models.isEmpty
                    ? _buildEmptyState(theme, isDark)
                    : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.85,
                          ),
                      itemCount: models.length,
                      itemBuilder: (context, index) {
                        return _AnimatedModelCard(
                          model: models[index],
                          carBrand: widget.carBrand,
                          delay: Duration(milliseconds: 100 * index),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandHeader(bool isDark, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7c2a9e), Color(0xFF9b3ec7)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7c2a9e).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          if (widget.brandLogo != null)
            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Image.asset(
                widget.brandLogo!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.directions_car,
                    color: Color(0xFF7c2a9e),
                  );
                },
              ),
            ),
          if (widget.brandLogo != null) const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.carBrand,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'اختر الموديل المناسب لك',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
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
            'لا توجد موديلات متاحة',
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

class _AnimatedModelCard extends StatefulWidget {
  final Map<String, dynamic> model;
  final String carBrand;
  final Duration delay;

  const _AnimatedModelCard({
    required this.model,
    required this.carBrand,
    required this.delay,
  });

  @override
  State<_AnimatedModelCard> createState() => _AnimatedModelCardState();
}

class _AnimatedModelCardState extends State<_AnimatedModelCard>
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

  void _navigateToDetails() {
    // TODO: Navigate to model details page
    print('Navigate to: ${widget.carBrand} - ${widget.model['name']}');

    // Navigate from the models page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ModelCarsView(carBrand: "تويوتا", modelName: "كورولا"),
      ),
    );
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
            onTap: _navigateToDetails,
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
                  // Car Image/Icon Container
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 110,
                    height: 110,
                    padding: const EdgeInsets.all(20),
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
                    child:
                        widget.model['image'] != null
                            ? Image.asset(
                              widget.model['image']!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.directions_car,
                                  size: 50,
                                  color:
                                      _isHovered
                                          ? const Color(0xFF7c2a9e)
                                          : const Color(
                                            0xFF7c2a9e,
                                          ).withOpacity(0.5),
                                );
                              },
                            )
                            : Icon(
                              Icons.directions_car,
                              size: 50,
                              color:
                                  _isHovered
                                      ? const Color(0xFF7c2a9e)
                                      : const Color(
                                        0xFF7c2a9e,
                                      ).withOpacity(0.5),
                            ),
                  ),

                  const SizedBox(height: 16),

                  // Model Name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.model['name'] ?? '',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            isDark
                                ? const Color(0xFFe8e8e8)
                                : const Color(0xFF0d0316),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Arrow Indicator
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
