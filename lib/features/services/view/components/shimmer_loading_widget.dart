// shimmer_loading_widget.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header shimmer
          Row(
            children: [
              _buildShimmerBox(40, 40, isDark, isCircle: false),
              const SizedBox(width: 12),
              _buildShimmerBox(200, 24, isDark, isCircle: false),
            ],
          ),
          const SizedBox(height: 16),
          _buildShimmerBox(150, 20, isDark, isCircle: false),
          const SizedBox(height: 24),

          // Shimmer Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.6,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: isDark ? const Color(0xFF271C2E) : Colors.grey[300]!,
                highlightColor:
                    isDark ? const Color(0xFF2a2334) : Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          isDark
                              ? const Color(0xFF271C2E).withOpacity(0.5)
                              : Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 40),

          // Divider shimmer
          Row(
            children: [
              Expanded(
                child: _buildShimmerBox(
                  double.infinity,
                  1,
                  isDark,
                  isCircle: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildShimmerBox(100, 30, isDark, isCircle: false),
              ),
              Expanded(
                child: _buildShimmerBox(
                  double.infinity,
                  1,
                  isDark,
                  isCircle: false,
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Converter shimmer
          Row(
            children: [
              _buildShimmerBox(40, 40, isDark, isCircle: false),
              const SizedBox(width: 12),
              _buildShimmerBox(200, 24, isDark, isCircle: false),
            ],
          ),
          const SizedBox(height: 24),

          Shimmer.fromColors(
            baseColor: isDark ? const Color(0xFF271C2E) : Colors.grey[300]!,
            highlightColor:
                isDark ? const Color(0xFF2a2334) : Colors.grey[100]!,
            child: Column(
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBox(
    double width,
    double height,
    bool isDark, {
    bool isCircle = false,
  }) {
    return Shimmer.fromColors(
      baseColor: isDark ? const Color(0xFF271C2E) : Colors.grey[300]!,
      highlightColor: isDark ? const Color(0xFF2a2334) : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isCircle ? null : BorderRadius.circular(12),
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}
