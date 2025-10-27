import 'package:el_etehad/core/manager/getLocationCubit/get_location_cubit.dart';
import 'package:el_etehad/features/services/manager/prayer_time/prayer_time_cubit.dart';
import 'package:el_etehad/features/services/models/prayer_times_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class PrayerTimePage extends StatefulWidget {
  const PrayerTimePage({super.key});

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage>
    with TickerProviderStateMixin {
  late AnimationController _headerAnimationController;
  late AnimationController _listAnimationController;
  late Animation<double> _fadeAnimation;
  // ignore: unused_field
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  String currentTime = '';
  String timeUntilNextPrayer = '';
  Timer? _timer;
  PrayerTimesModel? _cachedPrayerModel;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());

    // Get location and fetch prayer times
    _fetchPrayerTimes();
  }

  void _fetchPrayerTimes() {
    // First get location
    context.read<GetLocationCubit>().getLocation();
  }

  void _setupAnimations() {
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _listAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _headerAnimationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _headerAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _listAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _headerAnimationController.forward();
  }

  void _updateTime() {
    setState(() {
      final now = DateTime.now();
      currentTime = DateFormat('hh:mm:ss a').format(now);

      // Calculate time until next prayer
      if (_cachedPrayerModel != null) {
        timeUntilNextPrayer = _calculateTimeUntilNextPrayer(
          _cachedPrayerModel!,
        );
      }
    });
  }

  String _calculateTimeUntilNextPrayer(PrayerTimesModel model) {
    final now = DateTime.now();
    final prayers = [
      model.fajr,
      model.sunrise,
      model.duhr,
      model.asr,
      model.maghreb,
      model.esha,
    ];

    DateTime? nextPrayerTime;

    for (var prayerTimeStr in prayers) {
      if (prayerTimeStr == null) continue;

      final parts = prayerTimeStr.split(':');
      final prayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      if (prayerTime.isAfter(now)) {
        nextPrayerTime = prayerTime;
        break;
      }
    }

    // If no prayer time today, next is Fajr tomorrow
    if (nextPrayerTime == null && model.fajr != null) {
      final parts = model.fajr!.split(':');
      nextPrayerTime = DateTime(
        now.year,
        now.month,
        now.day + 1,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
    }

    if (nextPrayerTime == null) return '--:--:--';

    final difference = nextPrayerTime.difference(now);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String _getNextPrayer(PrayerTimesModel model) {
    final now = TimeOfDay.now();
    final prayers = [
      {'name': 'الفجر', 'time': model.fajr},
      {'name': 'الشروق', 'time': model.sunrise},
      {'name': 'الظهر', 'time': model.duhr},
      {'name': 'العصر', 'time': model.asr},
      {'name': 'المغرب', 'time': model.maghreb},
      {'name': 'العشاء', 'time': model.esha},
    ];

    for (var prayer in prayers) {
      final time = _parseTime(prayer['time'] as String);
      if (time.hour > now.hour ||
          (time.hour == now.hour && time.minute > now.minute)) {
        return prayer['name'] as String;
      }
    }
    return 'الفجر'; // Next day Fajr
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  bool _isPrayerPassed(String? prayerTime) {
    if (prayerTime == null) return false;
    final now = TimeOfDay.now();
    final prayer = _parseTime(prayerTime);
    return prayer.hour < now.hour ||
        (prayer.hour == now.hour && prayer.minute < now.minute);
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _listAnimationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocListener<GetLocationCubit, GetLocationState>(
        listener: (context, locationState) {
          if (locationState is GetLocationSuccess) {
            // Fetch prayer times with location
            context.read<PrayerTimeCubit>().getTimes(
              latitude: locationState.latitude.toString(),
              longtude: locationState.longitude.toString(),
            );
          } else if (locationState is GetLocationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(locationState.error),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Animated Header
            SliverAppBar(
              expandedHeight: 100,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'مواقيت الصلاة',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors:
                          isDark
                              ? [
                                const Color(0xFF271C2E),
                                const Color(0xFF000014),
                              ]
                              : [
                                const Color(0xFF0d0316),
                                const Color(0xFF240933),
                              ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Decorative circles
                      Positioned(
                        top: -50,
                        right: -50,
                        child: _buildDecorativeCircle(150, 0.05),
                      ),
                      Positioned(
                        bottom: -30,
                        left: -30,
                        child: _buildDecorativeCircle(120, 0.08),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Prayer Times List
            BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
              builder: (context, state) {
                if (state is PrayerTimeLoading) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'جاري تحميل مواقيت الصلاة...',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is PrayerTimeFailure) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: theme.colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'حدث خطأ في تحميل المواقيت',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: _fetchPrayerTimes,
                            icon: const Icon(Icons.refresh),
                            label: const Text('إعادة المحاولة'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is PrayerTimeSuccess) {
                  _listAnimationController.forward();
                  final model = state.prayerTimesModel;
                  _cachedPrayerModel =
                      model; // Cache the model for timer calculation
                  final nextPrayer = _getNextPrayer(model);

                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Countdown Timer Card
                          _buildCountdownCard(nextPrayer, theme),
                          const SizedBox(height: 20),

                          // Hijri Date Card
                          _buildHijriDateCard(model, theme),
                          const SizedBox(height: 20),

                          // Prayer Times List
                          _buildPrayerTimesList(model, nextPrayer, theme),
                        ],
                      ),
                    ),
                  );
                }

                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mosque,
                          size: 64,
                          color: theme.colorScheme.primary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'اضغط لتحميل مواقيت الصلاة',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _fetchPrayerTimes,
                          icon: const Icon(Icons.refresh),
                          label: const Text('تحميل المواقيت'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecorativeCircle(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(opacity),
      ),
    );
  }

  Widget _buildCountdownCard(String nextPrayer, ThemeData theme) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.secondary.withOpacity(0.8),
              theme.colorScheme.tertiary.withOpacity(0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.secondary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.timer, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text(
                  'الوقت المتبقي لصلاة $nextPrayer',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              timeUntilNextPrayer,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHijriDateCard(PrayerTimesModel model, ThemeData theme) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.8),
              theme.colorScheme.secondary.withOpacity(0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.calendar_today,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'التاريخ الهجري',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${model.weekDay} ${model.day} ${model.month} ${model.year} هـ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTimesList(
    PrayerTimesModel model,
    String nextPrayer,
    ThemeData theme,
  ) {
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
            final isPassed = _isPrayerPassed(prayer['time'] as String?);

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
              child: _buildPrayerCard(
                name: prayer['name'] as String,
                nameEn: prayer['nameEn'] as String,
                time: prayer['time'] as String?,
                icon: prayer['icon'] as IconData,
                isNext: isNext,
                isPassed: isPassed,
                theme: theme,
              ),
            );
          }).toList(),
    );
  }

  Widget _buildPrayerCard({
    required String name,
    required String nameEn,
    required String? time,
    required IconData icon,
    required bool isNext,
    required bool isPassed,
    required ThemeData theme,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color:
            isNext
                ? theme.colorScheme.primary.withOpacity(0.15)
                : theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isNext ? theme.colorScheme.primary : theme.dividerColor,
          width: isNext ? 2 : 1,
        ),
        boxShadow:
            isNext
                ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:
                isNext
                    ? theme.colorScheme.primary
                    : isPassed
                    ? theme.colorScheme.surface
                    : theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color:
                isNext || isPassed ? Colors.white : theme.colorScheme.primary,
            size: 24,
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: isNext ? FontWeight.bold : FontWeight.w600,
            color:
                isPassed
                    ? theme.textTheme.bodySmall?.color
                    : theme.textTheme.titleLarge?.color,
          ),
        ),
        subtitle: Text(
          nameEn,
          style: TextStyle(
            fontSize: 12,
            color:
                isPassed
                    ? theme.textTheme.bodySmall?.color
                    : theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time ?? '--:--',
              style: TextStyle(
                fontSize: 20,
                fontWeight: isNext ? FontWeight.bold : FontWeight.w600,
                color:
                    isNext
                        ? theme.colorScheme.primary
                        : isPassed
                        ? theme.textTheme.bodySmall?.color
                        : theme.textTheme.titleLarge?.color,
                letterSpacing: 1,
              ),
            ),
            if (isNext)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'القادمة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
