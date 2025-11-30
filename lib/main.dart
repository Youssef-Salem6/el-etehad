import 'package:el_etehad/core/manager/changeThemeCubit/change_theme_cubit.dart';
import 'package:el_etehad/core/themes/appTheme.dart';
import 'package:el_etehad/core/view/nav_view.dart';
import 'package:el_etehad/features/home/manager/homeData/get_home_data_cubit.dart';
import 'package:el_etehad/features/news/manager/cubit/get_news_details_cubit.dart';
import 'package:el_etehad/features/polls/manager/cubit/get_all_polls_cubit.dart';
import 'package:el_etehad/features/search/manager/artical_search/artical_search_cubit.dart';
import 'package:el_etehad/features/services/manager/currentCubit/get_current_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main(List<String> args) async {
  // Ensure Flutter is initialized before using SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangeThemeCubit()),
        BlocProvider(create: (context) => GetCurrentCubit()),
        BlocProvider(create: (context) => GetHomeDataCubit()),
        BlocProvider(create: (context) => GetNewsDetailsCubit()),
        BlocProvider(create: (context) => GetAllPollsCubit()),
        BlocProvider(create: (context) => ArticalSearchCubit()),
      ],
      child: BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
        builder: (context, state) {
          ThemeMode themeMode = ThemeMode.light;

          if (state is ChangeThemeInitial) {
            themeMode = state.themeMode;
          }

          return MaterialApp(
            // Arabic Language & RTL Configuration
            locale: const Locale('ar', 'SA'),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],

            // RTL Direction
            builder:
                (context, child) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: child!,
                ),

            // App Content
            home: const NavView(),
            debugShowCheckedModeBanner: false,

            // Theme Configuration
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}
