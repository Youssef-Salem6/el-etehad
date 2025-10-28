import 'package:flutter/material.dart';

class PrayerTimeHeader extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final bool isDark;

  const PrayerTimeHeader({
    super.key,
    required this.fadeAnimation,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: FadeTransition(
          opacity: fadeAnimation,
          child: const Text(
            'مواقيت الصلاة',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:
                  isDark
                      ? [const Color(0xFF271C2E), const Color(0xFF000014)]
                      : [const Color(0xFF0d0316), const Color(0xFF240933)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -50,
                right: -50,
                child: _buildDecorativeCircle(150, 0.05),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: _buildDecorativeCircle(120, 0.08),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeCircle(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(opacity),
      ),
    );
  }
}
