import 'package:flutter/material.dart';

/// Complete Category Slider Component with color-coded categories
class HorizontalCategorySlider extends StatefulWidget {
  final List<String> categories;
  final String? selectedCategory;
  final Function(String)? onCategorySelected;
  final bool showInContainer;
  final bool isDark;

  const HorizontalCategorySlider({
    super.key,
    required this.categories,
    this.selectedCategory,
    this.onCategorySelected,
    this.showInContainer = true,
    required this.isDark,
  });

  @override
  State<HorizontalCategorySlider> createState() =>
      _HorizontalCategorySliderState();
}

class _HorizontalCategorySliderState extends State<HorizontalCategorySlider> {
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory ?? widget.categories.first;
  }

  @override
  void didUpdateWidget(HorizontalCategorySlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCategory != null &&
        widget.selectedCategory != _selectedCategory) {
      _selectedCategory = widget.selectedCategory!;
    }
  }

  /// Get color for each category
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'الكل':
      case 'الرئيسية':
        return const Color(0xFF9b3ec7); // Purple
      case 'سياسة':
        return const Color(0xFF3b82f6); // Blue
      case 'رياضة':
        return const Color(0xFF10b981); // Green
      case 'عالمي':
        return const Color(0xFF06b6d4); // Cyan
      case 'فن':
        return const Color(0xFFec4899); // Pink
      case 'اقتصاد':
        return const Color(0xFFf59e0b); // Amber
      case 'تكنولوجيا':
        return const Color(0xFF8b5cf6); // Violet
      case 'صحة':
        return const Color(0xFFef4444); // Red
      case 'ثقافة':
        return const Color(0xFF14b8a6); // Teal
      default:
        return const Color(0xFF6b7280); // Gray
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          final isSelected = category == _selectedCategory;
          final categoryColor = _getCategoryColor(category);

          return Padding(
            padding: const EdgeInsets.only(left: 12),
            child: _CategoryChip(
              label: category,
              isSelected: isSelected,
              isDark: widget.isDark,
              categoryColor: categoryColor,
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
                widget.onCategorySelected?.call(category);
              },
            ),
          );
        },
      ),
    );

    if (!widget.showInContainer) {
      return content;
    }

    // Return with container wrapper
    return Container(
      decoration: BoxDecoration(
        color:
            widget.isDark ? const Color(0xFF000014) : const Color(0xFFFAFAFA),
        boxShadow: [
          BoxShadow(
            color:
                widget.isDark
                    ? Colors.black.withOpacity(0.2)
                    : Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          content,
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// Category Chip Widget
class _CategoryChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final bool isDark;
  final Color categoryColor;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.isDark,
    required this.categoryColor,
    required this.onTap,
  });

  @override
  State<_CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<_CategoryChip> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color:
                widget.isSelected
                    ? widget.categoryColor
                    : (widget.isDark ? const Color(0xFF1a1424) : Colors.white),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: widget.categoryColor.withOpacity(
                widget.isSelected ? 1.0 : 0.6,
              ),
              width: 2,
            ),
            boxShadow:
                widget.isSelected
                    ? [
                      BoxShadow(
                        color: widget.categoryColor.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ]
                    : [
                      BoxShadow(
                        color:
                            widget.isDark
                                ? const Color(0xFF000014).withOpacity(0.3)
                                : const Color(0xFF000014).withOpacity(0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color:
                  widget.isSelected
                      ? Colors.white
                      : (widget.isDark
                          ? const Color(0xFFe8e8e8)
                          : const Color(0xFF0d0316)),
            ),
          ),
        ),
      ),
    );
  }
}
