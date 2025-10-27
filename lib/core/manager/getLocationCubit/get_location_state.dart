part of 'get_location_cubit.dart';

@immutable
sealed class GetLocationState {}

final class GetLocationInitial extends GetLocationState {}

final class GetLocationSuccess extends GetLocationState {
  final double latitude;
  final double longitude;

  GetLocationSuccess({required this.latitude, required this.longitude});
}

final class GetLocationFailure extends GetLocationState {
  final String error;

  GetLocationFailure({required this.error});
}

final class GetLocationLoading extends GetLocationState {}
