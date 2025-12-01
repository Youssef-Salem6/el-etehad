
import 'package:el_etehad/features/news/manager/toggleLike/toggle_like_cubit.dart';
import 'package:el_etehad/features/comments/view/comments_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomActions extends StatefulWidget {
  final int id;
  final ThemeData theme;
  final bool initialLiked; // Pass the initial like state from the news data
  final int initialLikeCount; // Pass the initial like count

  const BottomActions({
    super.key,
    required this.theme,
    required this.id,
    this.initialLiked = false,
    this.initialLikeCount = 0,
  });

  @override
  State<BottomActions> createState() => _BottomActionsState();
}

class _BottomActionsState extends State<BottomActions> {
  late bool liked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    liked = widget.initialLiked;
    likeCount = widget.initialLikeCount;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToggleLikeCubit(),
      child: BlocListener<ToggleLikeCubit, ToggleLikeState>(
        listener: (context, state) {
          if (state is ToggleLikeSuccess) {
            setState(() {
              // Update like count based on the NEW state from API
              if (state.isLiked) {
                // User liked it
                likeCount++;
              } else {
                // User unliked it
                likeCount--;
              }
              // Update liked state
              liked = state.isLiked;
            });
          } else if (state is ToggleLikeFailure) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('فشل في تحديث الإعجاب'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 70,
          decoration: BoxDecoration(
            color: widget.theme.cardTheme.color,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<ToggleLikeCubit, ToggleLikeState>(
                builder: (context, state) {
                  final isLoading = state is ToggleLikeLoading;

                  return _buildActionButton(
                    icon: liked ? Icons.favorite : Icons.favorite_border,
                    label: likeCount.toString(),
                    onTap:
                        isLoading
                            ? null
                            : () {
                              context.read<ToggleLikeCubit>().toggleLike(
                                id: widget.id,
                              );
                            },
                    theme: widget.theme,
                    isLiked: liked,
                    isLoading: isLoading,
                  );
                },
              ),
              _buildActionButton(
                icon: Icons.comment_outlined,
                label: '89',
                onTap: () {
                  CommentsView.show(context, newsId: widget.id);
                },
                theme: widget.theme,
              ),
              _buildActionButton(
                icon: Icons.share_outlined,
                label: 'مشاركة',
                onTap: () {},
                theme: widget.theme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    required ThemeData theme,
    bool isLiked = false,
    bool isLoading = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isLoading
                ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.primaryColor,
                    ),
                  ),
                )
                : Icon(
                  icon,
                  size: 24,
                  color: isLiked ? Colors.red : theme.primaryColor,
                ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isLiked ? Colors.red : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
