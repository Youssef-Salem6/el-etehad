part of 'change_theme_cubit.dart';

@immutable
sealed class ChangeThemeState {}

final class ChangeThemeInitial extends ChangeThemeState {
  final ThemeMode themeMode;

  ChangeThemeInitial(this.themeMode);
}
