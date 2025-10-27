part of 'get_home_data_cubit.dart';

@immutable
sealed class GetHomeDataState {}

final class GetHomeDataInitial extends GetHomeDataState {}

final class GetHomeDataSuccess extends GetHomeDataState {}

final class GetHomeDataLoading extends GetHomeDataState {}

final class GetHomeDataFailure extends GetHomeDataState {
  final String msg;
  GetHomeDataFailure({required this.msg});
}
