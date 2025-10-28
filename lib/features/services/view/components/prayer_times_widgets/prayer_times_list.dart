import 'package:flutter/material.dart';
import 'package:el_etehad/features/services/models/prayer_times_model.dart';
import 'prayer_list_item.dart';

class PrayerTimesList extends StatelessWidget {
  final PrayerTimesModel model;
  final String nextPrayer;
  final bool Function(String?) isPrayerPassed;
  final AnimationController listAnimationController;

  const PrayerTimesList({
    super.key,
    required this.model,
    required this.nextPrayer,
    required this.isPrayerPassed,
    required this.listAnimationController,
  });

  @override
  Widget build(BuildContext context) {
    final prayers = [
      {
        'name': 'الفجر',
        'nameEn': 'Fajr',
        'time': model.fajr,
        'icon': Icons.brightness_2,
      },
      {
        'name': 'الشروق',
        'nameEn': 'Sunrise',
        'time': model.sunrise,
        'icon': Icons.wb_sunny_outlined,
      },
      {
        'name': 'الظهر',
        'nameEn': 'Dhuhr',
        'time': model.duhr,
        'icon': Icons.wb_sunny,
      },
      {
        'name': 'العصر',
        'nameEn': 'Asr',
        'time': model.asr,
        'icon': Icons.wb_twilight,
      },
      {
        'name': 'المغرب',
        'nameEn': 'Maghrib',
        'time': model.maghreb,
        'icon': Icons.nightlight_round,
      },
      {
        'name': 'العشاء',
        'nameEn': 'Isha',
        'time': model.esha,
        'icon': Icons.nights_stay,
      },
    ];

    return Column(
      children:
          prayers.asMap().entries.map((entry) {
            final index = entry.key;
            final prayer = entry.value;
            final isNext = prayer['name'] == nextPrayer;
            final isPassed = isPrayerPassed(prayer['time'] as String?);

            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 400 + (index * 100)),
              tween: Tween(begin: 0.0, end: 1.0),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 30 * (1 - value)),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: PrayerListItem(
                name: prayer['name'] as String,
                nameEn: prayer['nameEn'] as String,
                time: prayer['time'] as String?,
                icon: prayer['icon'] as IconData,
                isNext: isNext,
                isPassed: isPassed,
              ),
            );
          }).toList(),
    );
  }
}
