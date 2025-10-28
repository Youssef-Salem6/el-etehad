import 'package:el_etehad/core/manager/getLocationCubit/get_location_cubit.dart';
import 'package:el_etehad/core/themes/appTheme.dart';
import 'package:el_etehad/features/services/manager/weather_cubit/weather_cubit.dart';
import 'package:el_etehad/features/services/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    // Auto-fetch location and weather when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchLocationAndWeather();
      _animationController.forward();
    });
  }

  void _fetchLocationAndWeather() {
    final locationCubit = context.read<GetLocationCubit>();
    // final weatherCubit = context.read<WeatherCubit>();

    locationCubit.getLocation().then((_) {
      // Weather will be fetched automatically via the listener
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.bgDark : AppTheme.bgLight,
      body: BlocListener<GetLocationCubit, GetLocationState>(
        listener: (context, locationState) {
          if (locationState is GetLocationSuccess) {
            // Auto-fetch weather when location is obtained
            context.read<WeatherCubit>().getWeather(
              lat: locationState.latitude,
              long: locationState.longitude,
            );
          }
        },
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state is WeatherSuccess) {
              // Refresh animations when new data arrives
              _animationController.forward(from: 0.0);
            }
          },
          builder: (context, state) {
            return _buildBody(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WeatherState state) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Show loading state when initially fetching
    if (state is WeatherInitial || state is WeatherLoading) {
      return _buildShimmerLoadingState(isDark);
    }

    if (state is WeatherFailure) {
      return _buildErrorState(isDark);
    }

    if (state is WeatherSuccess) {
      final weatherModel = WeatherModel.fromJson(state.data);
      return _buildWeatherContent(weatherModel, isDark);
    }

    return _buildShimmerLoadingState(isDark);
  }

  Widget _buildShimmerLoadingState(bool isDark) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 160,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:
                      isDark
                          ? [AppTheme.newDarkPurple, AppTheme.accentDarkPrimary]
                          : [AppTheme.brandPrimaryDark, AppTheme.accentPrimary],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -50,
                    top: -50,
                    child: Icon(
                      Icons.cloud,
                      size: 200,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.white.withOpacity(0.3),
                          highlightColor: Colors.white.withOpacity(0.6),
                          child: Container(
                            width: 120,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Shimmer.fromColors(
                          baseColor: Colors.white.withOpacity(0.3),
                          highlightColor: Colors.white.withOpacity(0.6),
                          child: Container(
                            width: 150,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Shimmer.fromColors(
                          baseColor: Colors.white.withOpacity(0.3),
                          highlightColor: Colors.white.withOpacity(0.6),
                          child: Container(
                            width: 100,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            // Weather Details Shimmer
            _buildShimmerCard(isDark),

            // Forecast Section Shimmer
            _buildShimmerCard(isDark),

            // Sunrise & Sunset Shimmer
            _buildShimmerCard(isDark),

            const SizedBox(height: 20),
          ]),
        ),
      ],
    );
  }

  Widget _buildShimmerCard(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
        highlightColor: isDark ? Colors.grey.shade600 : Colors.grey.shade100,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: isDark ? AppTheme.bgDarkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildShimmerDetailItem(),
                  _buildShimmerDetailItem(),
                  _buildShimmerDetailItem(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerDetailItem() {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 50,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _slideAnimation.value),
                child: Opacity(opacity: _fadeAnimation.value, child: child),
              );
            },
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: isDark ? AppTheme.statusError : Colors.red.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  'فشل في تحميل بيانات الطقس',
                  style: TextStyle(
                    fontSize: 18,
                    color: isDark ? AppTheme.statusError : Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<GetLocationCubit, GetLocationState>(
                  builder: (context, locationState) {
                    String errorMessage =
                        'يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.';

                    if (locationState is GetLocationFailure) {
                      errorMessage = locationState.error;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              isDark
                                  ? AppTheme.textDarkTertiary
                                  : Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (_fadeAnimation.value * 0.1),
                      child: child,
                    );
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      _fetchLocationAndWeather();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDark
                              ? AppTheme.accentDarkPrimary
                              : AppTheme.accentPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: const Text('حاول مرة أخرى'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherContent(WeatherModel weather, bool isDark) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 160,
          flexibleSpace: FlexibleSpaceBar(
            background: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(opacity: _fadeAnimation.value, child: child);
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors:
                        isDark
                            ? [
                              AppTheme.newDarkPurple,
                              AppTheme.accentDarkPrimary,
                            ]
                            : [
                              AppTheme.brandPrimaryDark,
                              AppTheme.accentPrimary,
                            ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      top: -50,
                      child: Icon(
                        _getWeatherIcon(weather.current.condition.text),
                        size: 200,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, _slideAnimation.value),
                                child: child,
                              );
                            },
                            child: Text(
                              '${weather.current.tempC.round()}°',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return FadeTransition(
                                opacity: _fadeAnimation,
                                child: child,
                              );
                            },
                            child: Text(
                              weather.location.name,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return FadeTransition(
                                opacity: _fadeAnimation,
                                child: child,
                              );
                            },
                            child: Text(
                              weather.current.condition.text,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            // Current Weather Details
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: FadeTransition(opacity: _fadeAnimation, child: child),
                );
              },
              child: _buildWeatherDetails(weather, isDark),
            ),

            // Forecast Section
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: FadeTransition(opacity: _fadeAnimation, child: child),
                );
              },
              child: _buildForecastSection(weather, isDark),
            ),

            // Sunrise & Sunset
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: FadeTransition(opacity: _fadeAnimation, child: child),
                );
              },
              child: _buildSunriseSunset(weather, isDark),
            ),

            const SizedBox(height: 20),
          ]),
        ),
      ],
    );
  }

  Widget _buildWeatherDetails(WeatherModel weather, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: isDark ? AppTheme.bgDarkCard : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'الطقس الحالي',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppTheme.textDarkPrimary : AppTheme.shade900,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildWeatherDetailItem(
                    Icons.air,
                    'الرياح',
                    '${weather.current.windKph} كم/ساعة',
                    isDark,
                  ),
                  _buildWeatherDetailItem(
                    Icons.water_drop,
                    'الرطوبة',
                    '${weather.current.humidity}%',
                    isDark,
                  ),
                  _buildWeatherDetailItem(
                    Icons.thermostat,
                    'الشعور',
                    '${weather.current.feelslikeC.round()}°',
                    isDark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherDetailItem(
    IconData icon,
    String title,
    String value,
    bool isDark,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: isDark ? AppTheme.accentDarkLight : AppTheme.accentPrimary,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color:
                isDark
                    ? AppTheme.textDarkTertiary
                    : AppTheme.shade900.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? AppTheme.textDarkPrimary : AppTheme.shade900,
          ),
        ),
      ],
    );
  }

  Widget _buildForecastSection(WeatherModel weather, bool isDark) {
    if (weather.forecast.forecastday.isEmpty) return const SizedBox();

    final forecast = weather.forecast.forecastday.first;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: isDark ? AppTheme.bgDarkCard : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "توقعات اليوم",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppTheme.textDarkPrimary : AppTheme.shade900,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildForecastItem(
                    'العظمى',
                    '${forecast.day.maxtempC.round()}°',
                    isDark,
                  ),
                  _buildForecastItem(
                    'الصغرى',
                    '${forecast.day.mintempC.round()}°',
                    isDark,
                  ),
                  _buildForecastItem(
                    'المتوسط',
                    '${forecast.day.avgtempC.round()}°',
                    isDark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForecastItem(String title, String value, bool isDark) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color:
                isDark
                    ? AppTheme.textDarkTertiary
                    : AppTheme.shade900.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? AppTheme.textDarkPrimary : AppTheme.shade900,
          ),
        ),
      ],
    );
  }

  Widget _buildSunriseSunset(WeatherModel weather, bool isDark) {
    if (weather.forecast.forecastday.isEmpty) return const SizedBox();

    final astro = weather.forecast.forecastday.first.astro;
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: isDark ? AppTheme.bgDarkCard : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'الشروق والغروب',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppTheme.textDarkPrimary : AppTheme.shade900,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSunItem(
                    Icons.wb_sunny,
                    'الشروق',
                    astro.sunrise,
                    isDark,
                  ),
                  _buildSunItem(
                    Icons.nightlight,
                    'الغروب',
                    astro.sunset,
                    isDark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSunItem(IconData icon, String title, String time, bool isDark) {
    return Column(
      children: [
        Icon(
          icon,
          color: isDark ? AppTheme.accentDarkLight : Colors.orange,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color:
                isDark
                    ? AppTheme.textDarkTertiary
                    : AppTheme.shade900.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? AppTheme.textDarkPrimary : AppTheme.shade900,
          ),
        ),
      ],
    );
  }

  IconData _getWeatherIcon(String condition) {
    final conditionLower = condition.toLowerCase();

    if (conditionLower.contains('sunny') || conditionLower.contains('clear')) {
      return Icons.wb_sunny;
    } else if (conditionLower.contains('cloud')) {
      return Icons.cloud;
    } else if (conditionLower.contains('rain')) {
      return Icons.beach_access;
    } else if (conditionLower.contains('snow')) {
      return Icons.ac_unit;
    } else if (conditionLower.contains('storm')) {
      return Icons.flash_on;
    } else if (conditionLower.contains('fog') ||
        conditionLower.contains('mist')) {
      return Icons.blur_on;
    } else {
      return Icons.wb_sunny;
    }
  }
}
