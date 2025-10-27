import 'package:el_etehad/features/polls/model/polls_model.dart';
import 'package:el_etehad/features/polls/model/polls_option_model.dart';
import 'package:flutter/material.dart';

// Poll Model
class PollOption {
  final String text;
  int votes;
  final Color color;

  PollOption({required this.text, required this.votes, required this.color});
}

class Poll {
  final String question;
  final List<PollOption> options;
  int totalVotes;

  Poll({
    required this.question,
    required this.options,
    required this.totalVotes,
  });

  double getPercentage(int votes) {
    if (totalVotes == 0) return 0;
    return (votes / totalVotes) * 100;
  }
}

// Color Generator Utility
class PollColorGenerator {
  static final List<Color> _colorPalette = [
    const Color(0xFF4CAF50), // Green
    const Color(0xFF2196F3), // Blue
    const Color(0xFFFF9800), // Orange
    const Color(0xFFF44336), // Red
    const Color(0xFF9C27B0), // Purple
    const Color(0xFF009688), // Teal
    const Color(0xFFE91E63), // Pink
    const Color(0xFFFFEB3B), // Amber
    const Color(0xFF3F51B5), // Indigo
    const Color(0xFF00BCD4), // Cyan
    const Color(0xFF8BC34A), // Light Green
    const Color(0xFFFF5722), // Deep Orange
  ];

  static Color getColorForIndex(int index) {
    return _colorPalette[index % _colorPalette.length];
  }

  static List<Color> getColorsForCount(int count) {
    return List.generate(count, (index) => getColorForIndex(index));
  }
}

// Animated Poll Widget Component with Internal Vote Handling
class AnimatedPollWidget extends StatefulWidget {
  final Poll poll;
  final Function(int)? onVoteSubmitted;
  final PollsModel pollsModel;

  const AnimatedPollWidget({
    super.key,
    required this.poll,
    this.onVoteSubmitted,
    required this.pollsModel,
  });

  @override
  State<AnimatedPollWidget> createState() => _AnimatedPollWidgetState();
}

class _AnimatedPollWidgetState extends State<AnimatedPollWidget>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  int? _hoveredOption;
  int? _selectedOption;
  bool _showResults = false;
  bool _hasVoted = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeOut));

    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  Future<void> _handleVote() async {
    if (_selectedOption != null && !_hasVoted && !_isSubmitting) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        // Get the option model to access the ID

        // Call the API through the callback
        if (widget.onVoteSubmitted != null) {
          await widget.onVoteSubmitted!(_selectedOption!);
        }

        // Update local state after successful API call
        setState(() {
          widget.poll.options[_selectedOption!].votes++;
          widget.poll.totalVotes++;
          _hasVoted = true;
          _showResults = true;
          _isSubmitting = false;
        });

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('تم تسجيل تصويتك بنجاح'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isSubmitting = false;
        });

        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('فشل في إرسال التصويت. حاول مرة أخرى.'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              action: SnackBarAction(
                label: 'إعادة المحاولة',
                textColor: Colors.white,
                onPressed: () => _handleVote(),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1a1424) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color:
                    isDark
                        ? const Color(0xFF271C2E).withOpacity(0.3)
                        : const Color(0xFF271C2E).withOpacity(0.1),
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
                // Poll Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7c2a9e).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.poll,
                        color: Color(0xFF7c2a9e),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'استطلاع رأي',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF7c2a9e),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.pollsModel.title ?? '',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Poll Options
                ...List.generate(widget.pollsModel.options?.length ?? 0, (
                  index,
                ) {
                  final optionModel = PollsOptionModel.fromJson(
                    json: widget.pollsModel.options![index],
                  );
                  return _buildPollOption(
                    index,
                    widget.poll.options[index],
                    isDark,
                    theme,
                    optionModel,
                  );
                }),

                const SizedBox(height: 16),

                // Vote Button (only show if not voted yet and option selected)
                if (!_hasVoted && _selectedOption != null)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _handleVote,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7c2a9e),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        disabledBackgroundColor: const Color(
                          0xFF7c2a9e,
                        ).withOpacity(0.5),
                      ),
                      child:
                          _isSubmitting
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : const Text(
                                'تصويت',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ),

                if (!_hasVoted && _selectedOption != null)
                  const SizedBox(height: 16),

                // Total Votes
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? const Color(0xFF2a2334)
                            : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.how_to_vote,
                        size: 18,
                        color: Color(0xFF7c2a9e),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'إجمالي الأصوات: ${widget.pollsModel.totaVotes ?? 0}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF7c2a9e),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPollOption(
    int index,
    PollOption option,
    bool isDark,
    ThemeData theme,
    PollsOptionModel pollsOptionModel,
  ) {
    final percentage = widget.poll.getPercentage(option.votes);
    final isSelected = _selectedOption == index;
    final isHovered = _hoveredOption == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _PollOptionItem(
        option: option,
        percentage: percentage,
        isSelected: isSelected,
        isHovered: isHovered,
        showResults: _showResults,
        isDark: isDark,
        theme: theme,
        disabled: _isSubmitting,
        onTap: () {
          if (!_hasVoted && !_isSubmitting) {
            setState(() {
              _selectedOption = index;
            });
          }
        },
        onHover: (hovering) {
          if (!_hasVoted && !_isSubmitting) {
            setState(() {
              _hoveredOption = hovering ? index : null;
            });
          }
        },
      ),
    );
  }
}

// Poll Option Item Widget
class _PollOptionItem extends StatefulWidget {
  final PollOption option;
  final double percentage;
  final bool isSelected;
  final bool isHovered;
  final bool showResults;
  final bool isDark;
  final ThemeData theme;
  final bool disabled;
  final VoidCallback onTap;
  final Function(bool) onHover;

  const _PollOptionItem({
    required this.option,
    required this.percentage,
    required this.isSelected,
    required this.isHovered,
    required this.showResults,
    required this.isDark,
    required this.theme,
    required this.onTap,
    required this.onHover,
    this.disabled = false,
  });

  @override
  State<_PollOptionItem> createState() => _PollOptionItemState();
}

class _PollOptionItemState extends State<_PollOptionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.percentage / 100,
    ).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOutCubic),
    );

    if (widget.showResults) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _progressController.forward();
        }
      });
    }
  }

  @override
  void didUpdateWidget(_PollOptionItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showResults && !oldWidget.showResults) {
      _progressAnimation = Tween<double>(
        begin: 0.0,
        end: widget.percentage / 100,
      ).animate(
        CurvedAnimation(
          parent: _progressController,
          curve: Curves.easeOutCubic,
        ),
      );
      _progressController.forward();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => widget.onHover(true),
      onExit: (_) => widget.onHover(false),
      child: GestureDetector(
        onTap: widget.disabled ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                widget.isSelected
                    ? widget.option.color.withOpacity(0.15)
                    : (widget.isDark
                        ? const Color(0xFF2a2334)
                        : const Color(0xFFF5F5F5)),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  widget.isSelected
                      ? widget.option.color
                      : (widget.isHovered
                          ? widget.option.color.withOpacity(0.5)
                          : Colors.transparent),
              width: 2,
            ),
            boxShadow:
                widget.isHovered || widget.isSelected
                    ? [
                      BoxShadow(
                        color: widget.option.color.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
          child: Stack(
            children: [
              // Progress Bar Background (only show in results)
              if (widget.showResults)
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return Positioned.fill(
                      child: FractionallySizedBox(
                        alignment: Alignment.centerRight,
                        widthFactor: _progressAnimation.value,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.option.color.withOpacity(0.3),
                                widget.option.color.withOpacity(0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    );
                  },
                ),

              // Content
              Row(
                children: [
                  // Radio/Check Icon
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            widget.isSelected
                                ? widget.option.color
                                : (widget.isDark
                                    ? Colors.white54
                                    : Colors.black45),
                        width: 2,
                      ),
                      color:
                          widget.isSelected
                              ? widget.option.color
                              : Colors.transparent,
                    ),
                    child:
                        widget.isSelected
                            ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                            : null,
                  ),

                  const SizedBox(width: 12),

                  // Option Text
                  Expanded(
                    child: Text(
                      widget.option.text,
                      style: widget.theme.textTheme.titleSmall?.copyWith(
                        fontWeight:
                            widget.isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                      ),
                    ),
                  ),

                  // Percentage (only show in results)
                  if (widget.showResults) ...[
                    const SizedBox(width: 8),
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: widget.option.color,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${(_progressAnimation.value * 100).toStringAsFixed(1)}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
