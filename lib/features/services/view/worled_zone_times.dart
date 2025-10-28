import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'dart:async';

class WorldZoneTimes extends StatefulWidget {
  const WorldZoneTimes({super.key});

  @override
  State<WorldZoneTimes> createState() => _WorldZoneTimesState();
}

class _WorldZoneTimesState extends State<WorldZoneTimes> {
  Timer? _timer;

  // قائمة المدن الرئيسية مع المناطق الزمنية
  final List<CityTimeZone> _cities = [
    // الدول العربية
    CityTimeZone(
      city: 'مكة المكرمة',
      country: 'السعودية',
      timezone: 'Asia/Riyadh',
      flag: '🇸🇦',
    ),
    CityTimeZone(
      city: 'أبو ظبي',
      country: 'الإمارات',
      timezone: 'Asia/Dubai',
      flag: '🇦🇪',
    ),
    CityTimeZone(
      city: 'القاهرة',
      country: 'مصر',
      timezone: 'Africa/Cairo',
      flag: '🇪🇬',
    ),
    CityTimeZone(
      city: 'الرباط',
      country: 'المغرب',
      timezone: 'Africa/Casablanca',
      flag: '🇲🇦',
    ),
    CityTimeZone(
      city: 'الجزائر',
      country: 'الجزائر',
      timezone: 'Africa/Algiers',
      flag: '🇩🇿',
    ),
    CityTimeZone(
      city: 'تونس',
      country: 'تونس',
      timezone: 'Africa/Tunis',
      flag: '🇹🇳',
    ),
    CityTimeZone(
      city: 'بيروت',
      country: 'لبنان',
      timezone: 'Asia/Beirut',
      flag: '🇱🇧',
    ),
    CityTimeZone(
      city: 'دمشق',
      country: 'سوريا',
      timezone: 'Asia/Damascus',
      flag: '🇸🇾',
    ),
    CityTimeZone(
      city: 'عمّان',
      country: 'الأردن',
      timezone: 'Asia/Amman',
      flag: '🇯🇴',
    ),
    CityTimeZone(
      city: 'بغداد',
      country: 'العراق',
      timezone: 'Asia/Baghdad',
      flag: '🇮🇶',
    ),
    CityTimeZone(
      city: 'الكويت',
      country: 'الكويت',
      timezone: 'Asia/Kuwait',
      flag: '🇰🇼',
    ),
    CityTimeZone(
      city: 'الدوحة',
      country: 'قطر',
      timezone: 'Asia/Qatar',
      flag: '🇶🇦',
    ),
    CityTimeZone(
      city: 'المنامة',
      country: 'البحرين',
      timezone: 'Asia/Bahrain',
      flag: '🇧🇭',
    ),
    CityTimeZone(
      city: 'مسقط',
      country: 'عمان',
      timezone: 'Asia/Muscat',
      flag: '🇴🇲',
    ),
    CityTimeZone(
      city: 'صنعاء',
      country: 'اليمن',
      timezone: 'Asia/Aden',
      flag: '🇾🇪',
    ),
    CityTimeZone(
      city: 'الخرطوم',
      country: 'السودان',
      timezone: 'Africa/Khartoum',
      flag: '🇸🇩',
    ),
    CityTimeZone(
      city: 'طرابلس',
      country: 'ليبيا',
      timezone: 'Africa/Tripoli',
      flag: '🇱🇾',
    ),

    // الدول المهمة حول العالم
    CityTimeZone(
      city: 'لندن',
      country: 'بريطانيا',
      timezone: 'Europe/London',
      flag: '🇬🇧',
    ),
    CityTimeZone(
      city: 'باريس',
      country: 'فرنسا',
      timezone: 'Europe/Paris',
      flag: '🇫🇷',
    ),
    CityTimeZone(
      city: 'برلين',
      country: 'ألمانيا',
      timezone: 'Europe/Berlin',
      flag: '🇩🇪',
    ),
    CityTimeZone(
      city: 'روما',
      country: 'إيطاليا',
      timezone: 'Europe/Rome',
      flag: '🇮🇹',
    ),
    CityTimeZone(
      city: 'مدريد',
      country: 'إسبانيا',
      timezone: 'Europe/Madrid',
      flag: '🇪🇸',
    ),
    CityTimeZone(
      city: 'موسكو',
      country: 'روسيا',
      timezone: 'Europe/Moscow',
      flag: '🇷🇺',
    ),
    CityTimeZone(
      city: 'إسطنبول',
      country: 'تركيا',
      timezone: 'Europe/Istanbul',
      flag: '🇹🇷',
    ),
    CityTimeZone(
      city: 'نيويورك',
      country: 'أمريكا',
      timezone: 'America/New_York',
      flag: '🇺🇸',
    ),
    CityTimeZone(
      city: 'لوس أنجلوس',
      country: 'أمريكا',
      timezone: 'America/Los_Angeles',
      flag: '🇺🇸',
    ),
    CityTimeZone(
      city: 'شيكاغو',
      country: 'أمريكا',
      timezone: 'America/Chicago',
      flag: '🇺🇸',
    ),
    CityTimeZone(
      city: 'واشنطن',
      country: 'أمريكا',
      timezone: 'America/New_York',
      flag: '🇺🇸',
    ),
    CityTimeZone(
      city: 'تورونتو',
      country: 'كندا',
      timezone: 'America/Toronto',
      flag: '🇨🇦',
    ),
    CityTimeZone(
      city: 'طوكيو',
      country: 'اليابان',
      timezone: 'Asia/Tokyo',
      flag: '🇯🇵',
    ),
    CityTimeZone(
      city: 'بكين',
      country: 'الصين',
      timezone: 'Asia/Shanghai',
      flag: '🇨🇳',
    ),
    CityTimeZone(
      city: 'شنغهاي',
      country: 'الصين',
      timezone: 'Asia/Shanghai',
      flag: '🇨🇳',
    ),
    CityTimeZone(
      city: 'هونغ كونغ',
      country: 'الصين',
      timezone: 'Asia/Hong_Kong',
      flag: '🇭🇰',
    ),
    CityTimeZone(
      city: 'سنغافورة',
      country: 'سنغافورة',
      timezone: 'Asia/Singapore',
      flag: '🇸🇬',
    ),
    CityTimeZone(
      city: 'سيول',
      country: 'كوريا الجنوبية',
      timezone: 'Asia/Seoul',
      flag: '🇰🇷',
    ),
    CityTimeZone(
      city: 'نيودلهي',
      country: 'الهند',
      timezone: 'Asia/Kolkata',
      flag: '🇮🇳',
    ),
    CityTimeZone(
      city: 'مومباي',
      country: 'الهند',
      timezone: 'Asia/Kolkata',
      flag: '🇮🇳',
    ),
    CityTimeZone(
      city: 'كراتشي',
      country: 'باكستان',
      timezone: 'Asia/Karachi',
      flag: '🇵🇰',
    ),
    CityTimeZone(
      city: 'طهران',
      country: 'إيران',
      timezone: 'Asia/Tehran',
      flag: '🇮🇷',
    ),
    CityTimeZone(
      city: 'سيدني',
      country: 'أستراليا',
      timezone: 'Australia/Sydney',
      flag: '🇦🇺',
    ),
    CityTimeZone(
      city: 'ملبورن',
      country: 'أستراليا',
      timezone: 'Australia/Melbourne',
      flag: '🇦🇺',
    ),
    CityTimeZone(
      city: 'ساو باولو',
      country: 'البرازيل',
      timezone: 'America/Sao_Paulo',
      flag: '🇧🇷',
    ),
    CityTimeZone(
      city: 'بوينس آيرس',
      country: 'الأرجنتين',
      timezone: 'America/Argentina/Buenos_Aires',
      flag: '🇦🇷',
    ),
    CityTimeZone(
      city: 'مكسيكو سيتي',
      country: 'المكسيك',
      timezone: 'America/Mexico_City',
      flag: '🇲🇽',
    ),
    CityTimeZone(
      city: 'جوهانسبرج',
      country: 'جنوب أفريقيا',
      timezone: 'Africa/Johannesburg',
      flag: '🇿🇦',
    ),
    CityTimeZone(
      city: 'نيروبي',
      country: 'كينيا',
      timezone: 'Africa/Nairobi',
      flag: '🇰🇪',
    ),
    CityTimeZone(
      city: 'لاغوس',
      country: 'نيجيريا',
      timezone: 'Africa/Lagos',
      flag: '🇳🇬',
    ),
  ];

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    // تحديث الوقت كل ثانية
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _getTimeForCity(String timezone) {
    try {
      final location = tz.getLocation(timezone);
      final now = tz.TZDateTime.now(location);

      final hour = now.hour.toString().padLeft(2, '0');
      final minute = now.minute.toString().padLeft(2, '0');
      final second = now.second.toString().padLeft(2, '0');

      return '$hour:$minute:$second';
    } catch (e) {
      return '--:--:--';
    }
  }

  String _getDateForCity(String timezone) {
    try {
      final location = tz.getLocation(timezone);
      final now = tz.TZDateTime.now(location);

      final arabicDays = [
        'الأحد',
        'الاثنين',
        'الثلاثاء',
        'الأربعاء',
        'الخميس',
        'الجمعة',
        'السبت',
      ];

      final arabicMonths = [
        'يناير',
        'فبراير',
        'مارس',
        'أبريل',
        'مايو',
        'يونيو',
        'يوليو',
        'أغسطس',
        'سبتمبر',
        'أكتوبر',
        'نوفمبر',
        'ديسمبر',
      ];

      final dayName = arabicDays[now.weekday % 7];
      final day = now.day;
      final month = arabicMonths[now.month - 1];
      final year = now.year;

      return '$dayName، $day $month $year';
    } catch (e) {
      return '';
    }
  }

  String _getTimeDifference(String timezone) {
    try {
      final location = tz.getLocation(timezone);
      final now = tz.TZDateTime.now(location);
      final offset = now.timeZoneOffset;

      final hours = offset.inHours;
      final minutes = (offset.inMinutes % 60).abs();

      if (hours >= 0) {
        return minutes > 0
            ? '+${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}'
            : '+${hours.toString().padLeft(2, '0')}:00';
      } else {
        return minutes > 0
            ? '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}'
            : '${hours.toString().padLeft(2, '0')}:00';
      }
    } catch (e) {
      return '+00:00';
    }
  }

  bool _isDayTime(String timezone) {
    try {
      final location = tz.getLocation(timezone);
      final now = tz.TZDateTime.now(location);
      final hour = now.hour;
      return hour >= 6 && hour < 18;
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('أوقات المناطق الزمنية'), elevation: 0),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _cities.length,
        itemBuilder: (context, index) {
          final city = _cities[index];
          final time = _getTimeForCity(city.timezone);
          final date = _getDateForCity(city.timezone);
          final timeDiff = _getTimeDifference(city.timezone);
          final isDayTime = _isDayTime(city.timezone);

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors:
                      isDark
                          ? [
                            isDayTime
                                ? const Color(0xFF2a2334).withOpacity(0.8)
                                : const Color(0xFF1a1424).withOpacity(0.8),
                            isDayTime
                                ? const Color(0xFF1a1424).withOpacity(0.8)
                                : const Color(0xFF0d0316).withOpacity(0.8),
                          ]
                          : [
                            isDayTime
                                ? Colors.blue.shade50
                                : Colors.indigo.shade50,
                            isDayTime
                                ? Colors.cyan.shade50
                                : Colors.purple.shade50,
                          ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // العلم
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color:
                                isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              city.flag,
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // معلومات المدينة
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                city.city,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: theme.textTheme.bodySmall?.color,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    city.country,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.textTheme.bodySmall?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // أيقونة النهار/الليل
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                isDayTime
                                    ? Colors.amber.withOpacity(0.2)
                                    : Colors.indigo.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isDayTime ? Icons.wb_sunny : Icons.nightlight_round,
                            color:
                                isDayTime
                                    ? Colors.amber
                                    : Colors.indigo.shade300,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      color: theme.dividerColor.withOpacity(0.3),
                      height: 1,
                    ),
                    const SizedBox(height: 16),
                    // الوقت
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الوقت الحالي',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              time,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'UTC $timeDiff',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // التاريخ
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          date,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CityTimeZone {
  final String city;
  final String country;
  final String timezone;
  final String flag;

  CityTimeZone({
    required this.city,
    required this.country,
    required this.timezone,
    required this.flag,
  });
}
