part of 'toggle_like_cubit.dart';

@immutable
sealed class ToggleLikeState {}

final class ToggleLikeInitial extends ToggleLikeState {}

final class ToggleLikeLoading extends ToggleLikeState {}

final class ToggleLikeFailure extends ToggleLikeState {}

final class ToggleLikeSuccess extends ToggleLikeState {
  final bool isLiked;
  ToggleLikeSuccess({required this.isLiked});
}
