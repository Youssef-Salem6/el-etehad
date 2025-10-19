import 'package:flutter/material.dart';

class HorizontalCategorySlider extends StatefulWidget {
  final List<String> categories;
  final String? selectedCategory;
  final Function(String)? onCategorySelected;

  const HorizontalCategorySlider({
    super.key,
    required this.categories,
    this.selectedCategory,
    this.onCategorySelected,
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          final isSelected = category == _selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(left: 12),
            child: AnimatedCategoryChip(
              label: category,
              isSelected: isSelected,
              isDark: isDark,
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
  }
}

class AnimatedCategoryChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const AnimatedCategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<AnimatedCategoryChip> createState() => _AnimatedCategoryChipState();
}

class _AnimatedCategoryChipState extends State<AnimatedCategoryChip> {
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
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? const Color(0xFFef4444) // Red color for selected
                : (widget.isDark
                    ? const Color(0xFF1a1424)
                    : Colors.white),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: widget.isSelected
                  ? const Color(0xFFef4444)
                  : (widget.isDark
                      ? const Color(0xFF271C2E).withOpacity(0.5)
                      : const Color(0xFF271C2E).withOpacity(0.2)),
              width: 2,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFFef4444).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: widget.isDark
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
              color: widget.isSelected
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

// Example usage in your services screen:
class CategoryExample extends StatefulWidget {
  const CategoryExample({super.key});

  @override
  State<CategoryExample> createState() => _CategoryExampleState();
}

class _CategoryExampleState extends State<CategoryExample> {
  String selectedCategory = 'الكل';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مثال على الفئات')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          HorizontalCategorySlider(
            categories: const [
              'الكل',
              'سياسة',
              'رياضة',
              'اقتصاد',
              'تكنولوجيا',
              'ثقافة',
              'صحة',
            ],
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
              // Handle category change
              print('Selected: $category');
            },
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Center(
              child: Text(
                'الفئة المختارة: $selectedCategory',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}