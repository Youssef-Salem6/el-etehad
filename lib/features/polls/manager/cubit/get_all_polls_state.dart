part of 'get_all_polls_cubit.dart';

@immutable
sealed class GetAllPollsState {}

final class GetAllPollsInitial extends GetAllPollsState {}

final class GetAllPollsLoading extends GetAllPollsState {}

final class GetAllPollsSuccess extends GetAllPollsState {}

final class GetAllPollsFailure extends GetAllPollsState {}
