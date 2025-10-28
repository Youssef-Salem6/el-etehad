part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final Map data;
  WeatherSuccess({required this.data});
}

final class WeatherFailure extends WeatherState {}

final class WeatherLoading extends WeatherState {}
