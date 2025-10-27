part of 'prayer_time_cubit.dart';

@immutable
sealed class PrayerTimeState {}

final class PrayerTimeInitial extends PrayerTimeState {}

final class PrayerTimeLoading extends PrayerTimeState {}

class PrayerTimeSuccess extends PrayerTimeState {
  final PrayerTimesModel prayerTimesModel;

  PrayerTimeSuccess({required this.prayerTimesModel});
}

final class PrayerTimeFailure extends PrayerTimeState {}
