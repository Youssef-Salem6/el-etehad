import 'package:el_etehad/features/services/models/emergency_service.dart';
import 'package:flutter/material.dart';


class AnimatedNumberListItem extends StatefulWidget {
  final EmergencyNumber number;
  final int index;
  final bool isDark;
  final VoidCallback onCopy;

  const AnimatedNumberListItem({
    super.key,
    required this.number,
    required this.index,
    required this.isDark,
    required this.onCopy,
  });

  @override
  State<AnimatedNumberListItem> createState() => _AnimatedNumberListItemState();
}

class _AnimatedNumberListItemState extends State<AnimatedNumberListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400 + (widget.index * 50)),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFF1a1424) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.number.color.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: widget.onCopy,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: widget.number.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.number.icon,
                        color: widget.number.color,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Number Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.number.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.number.number,
                            style: TextStyle(
                              color: widget.number.color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Copy Button
                    IconButton(
                      onPressed: widget.onCopy,
                      icon: const Icon(Icons.copy, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: widget.number.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}