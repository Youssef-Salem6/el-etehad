import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  static const String _themeKey = 'theme_mode';
  
  ChangeThemeCubit() : super(ChangeThemeInitial(ThemeMode.light)) {
    _loadThemeFromPrefs();
  }

  // Load theme from SharedPreferences
  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false; // Default to false (light mode)
    emit(ChangeThemeInitial(isDark ? ThemeMode.dark : ThemeMode.light));
  }

  // Save theme to SharedPreferences
  Future<void> _saveThemeToPrefs(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }

  // Toggle between light and dark mode
  void toggleTheme() {
    if (state is ChangeThemeInitial) {
      final currentMode = (state as ChangeThemeInitial).themeMode;
      if (currentMode == ThemeMode.light) {
        emit(ChangeThemeInitial(ThemeMode.dark));
        _saveThemeToPrefs(true);
      } else {
        emit(ChangeThemeInitial(ThemeMode.light));
        _saveThemeToPrefs(false);
      }
    }
  }

  // Set specific theme mode
  void setThemeMode(ThemeMode mode) {
    emit(ChangeThemeInitial(mode));
    _saveThemeToPrefs(mode == ThemeMode.dark);
  }

  // Check if current theme is dark
  bool get isDarkMode {
    if (state is ChangeThemeInitial) {
      return (state as ChangeThemeInitial).themeMode == ThemeMode.dark;
    }
    return false; // Default to false
  }
}