import 'package:flutter/material.dart';

class AnimatedVideoCard extends StatefulWidget {
  final int index;
  final String title;
  final String views;
  final String likes;
  final String duration;
  final VoidCallback? onTap;

  const AnimatedVideoCard({
    super.key,
    required this.index,
    required this.title,
    required this.views,
    required this.likes,
    this.duration = '5:43',
    this.onTap,
  });

  @override
  State<AnimatedVideoCard> createState() => _AnimatedVideoCardState();
}

class _AnimatedVideoCardState extends State<AnimatedVideoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400 + (widget.index * 80)),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.2, 0),
          end: Offset.zero,
        ).animate(_animation),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isHovered = true),
          onTapUp: (_) {
            setState(() => _isHovered = false);
            widget.onTap?.call();
          },
          onTapCancel: () => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform:
                Matrix4.identity()
                  ..scale(_isHovered ? 0.96 : 1.0)
                  ..rotateZ(_isHovered ? -0.01 : 0.0),
            child: Container(
              width: 180,
              margin: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? Colors.black : Colors.grey.shade400)
                        .withOpacity(_isHovered ? 0.4 : 0.2),
                    blurRadius: _isHovered ? 20 : 12,
                    offset: Offset(0, _isHovered ? 8 : 4),
                    spreadRadius: _isHovered ? 2 : 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  color: colorScheme.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Enhanced Thumbnail
                      Stack(
                        children: [
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              // gradient: LinearGradient(
                              //   begin: Alignment.topLeft,
                              //   end: Alignment.bottomRight,
                              //   colors: [
                              //     colorScheme.primary,
                              //     colorScheme.primary.withOpacity(0.8),
                              //     colorScheme.secondary,
                              //   ],
                              // ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.unsplash.com/photo-1530497610245-94d3c16cda28?w=400&q=80",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Overlay gradient for better contrast
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.3),
                                ],
                              ),
                            ),
                          ),
                          // Play button with animation
                          Positioned.fill(
                            child: AnimatedOpacity(
                              opacity: _isHovered ? 1.0 : 0.9,
                              duration: const Duration(milliseconds: 200),
                              child: Center(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: EdgeInsets.all(_isHovered ? 16 : 14),
                                  decoration: BoxDecoration(
                                    color: colorScheme.surface.withOpacity(
                                      0.95,
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: colorScheme.primary,
                                    size: _isHovered ? 36 : 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Duration badge
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                widget.duration,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Enhanced Content Section
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                                letterSpacing: -0.2,
                                color: colorScheme.onSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            // Stats with improved design
                            Row(
                              children: [
                                _buildStatChip(
                                  context,
                                  Icons.visibility_rounded,
                                  widget.views,
                                  isDark,
                                ),
                                const SizedBox(width: 8),
                                _buildStatChip(
                                  context,
                                  Icons.favorite_rounded,
                                  widget.likes,
                                  isDark,
                                  isLike: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(
    BuildContext context,
    IconData icon,
    String value,
    bool isDark, {
    bool isLike = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            isDark
                ? colorScheme.surface.withOpacity(0.5)
                : colorScheme.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color:
                isLike
                    ? (isDark ? Colors.pink.shade300 : Colors.pink.shade400)
                    : colorScheme.primary,
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }
}
