import 'package:flutter/material.dart';

class AppTheme {
  // ═══════════════════════════════════════════════════════════════
  // NEW COLORS TO INTEGRATE
  // ═══════════════════════════════════════════════════════════════
  static const Color newDarkBlue = Color(0xFF000014); // Very dark blue
  static const Color newDarkPurple = Color(0xFF271C2E); // Dark purple

  // ═══════════════════════════════════════════════════════════════
  // الألوان الأساسية (Primary Brand Colors) - UPDATED
  // ═══════════════════════════════════════════════════════════════
  static const Color brandPrimaryDark = Color(0xFF0d0316); // اللون الرئيسي
  static const Color brandSecondaryDark = Color(0xFF0f0319); // اللون الثانوي

  // ═══════════════════════════════════════════════════════════════
  // تدرجات منطقية ومتناسقة من الألوان الأساسية - UPDATED
  // (Shades - من الأغمق للأفتح)
  // ═══════════════════════════════════════════════════════════════
  static const Color shade950 = Color(0xFF000014); // الأغمق (New dark blue)
  static const Color shade925 = Color(
    0xFF271C2E,
  ); // غامق جداً (New dark purple)
  static const Color shade900 = Color(0xFF0d0316); // الأغمق (Primary)
  static const Color shade800 = Color(0xFF0f0319); // غامق جداً (Secondary)
  static const Color shade700 = Color(0xFF15041f); // غامق
  static const Color shade600 = Color(0xFF1c0629); // غامق متوسط
  static const Color shade500 = Color(0xFF240933); // متوسط
  static const Color shade400 = Color(0xFF2f0d40); // فاتح متوسط
  static const Color shade300 = Color(0xFF3d124f); // فاتح
  static const Color shade200 = Color(0xFF4d1861); // فاتح جداً
  static const Color shade100 = Color(0xFF5f1f75); // الأفتح

  // ═══════════════════════════════════════════════════════════════
  // ألوان مميزة للتفاعل (Accent Colors)
  // ═══════════════════════════════════════════════════════════════
  static const Color accentPrimary = Color(0xFF7c2a9e); // للأزرار الرئيسية
  static const Color accentSecondary = Color(0xFF9b3ec7); // للعناصر المختارة
  static const Color accentLight = Color(0xFFb554e8); // للتأكيدات الخفيفة
  static const Color accentGlow = Color(0xFFd084ff); // للإضاءة والتأثيرات

  // ═══════════════════════════════════════════════════════════════
  // ألوان الحالات (Status Colors)
  // ═══════════════════════════════════════════════════════════════
  static const Color statusSuccess = Color(0xFF10b981);
  static const Color statusWarning = Color(0xFFf59e0b);
  static const Color statusError = Color(0xFFef4444);
  static const Color statusInfo = Color(0xFF3b82f6);

  // ═══════════════════════════════════════════════════════════════
  // ألوان الخلفيات (Background Colors) - UPDATED
  // ═══════════════════════════════════════════════════════════════
  static const Color bgLight = Color(0xFFFAFAFA);
  static const Color bgLightSecondary = Color(0xFFF5F5F5);

  // ألوان الوضع المظلم المحسّنة - UPDATED with new colors
  static const Color bgDark = Color(
    0xFF000014,
  ); // استخدام اللون الأزرق الداكن الجديد
  static const Color bgDarkSecondary = Color(
    0xFF271C2E,
  ); // استخدام اللون البنفسجي الداكن الجديد
  static const Color bgDarkCard = Color(
    0xFF1a1424,
  ); // لون وسيط بين اللونين الجديدين
  static const Color bgDarkElevated = Color(0xFF2a2334); // أفتح قليلاً

  // ألوان النصوص المحسّنة للوضع المظلم
  static const Color textDarkPrimary = Color(0xFFe8e8e8); // نص رئيسي
  static const Color textDarkSecondary = Color(0xFFb8b8b8); // نص ثانوي
  static const Color textDarkTertiary = Color(0xFF8a8a8a); // نص ثالثي

  // ألوان Accent محسّنة للوضع المظلم (أغمق قليلاً)
  static const Color accentDarkPrimary = Color(
    0xFF8b3db3,
  ); // أغمق من accentSecondary
  static const Color accentDarkSecondary = Color(0xFF9b4dc2); // متوسط
  static const Color accentDarkLight = Color(
    0xFFa560d0,
  ); // أغمق من accentLight الأصلي

  // ═══════════════════════════════════════════════════════════════
  // Light Theme - UPDATED with subtle uses of new colors
  // ═══════════════════════════════════════════════════════════════
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Almarai',
    useMaterial3: true,
    brightness: Brightness.light,

    primaryColor: brandPrimaryDark,
    scaffoldBackgroundColor: bgLight,

    // AppBar - يمكن استخدام اللون الجديد كخلفية بديلة
    appBarTheme: const AppBarTheme(
      backgroundColor: brandPrimaryDark, // أو newDarkPurple للتنويع
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Almarai',
      ),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: brandPrimaryDark,
      selectedItemColor: accentGlow,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),

    // Navigation Bar
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: brandPrimaryDark,
      indicatorColor: accentLight.withOpacity(0.2),
      iconTheme: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const IconThemeData(color: accentGlow);
        }
        return const IconThemeData(color: Colors.white54);
      }),
      labelTextStyle: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const TextStyle(
            color: accentGlow,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          );
        }
        return const TextStyle(color: Colors.white54, fontSize: 12);
      }),
    ),

    // Card - استخدام تدرجات من الألوان الجديدة
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shadowColor: newDarkBlue.withOpacity(0.1), // استخدام اللون الجديد
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: newDarkPurple.withOpacity(0.05),
          width: 1,
        ), // استخدام اللون الجديد
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: newDarkPurple.withOpacity(0.05), // استخدام اللون الجديد
      selectedColor: accentPrimary.withOpacity(0.15),
      labelStyle: const TextStyle(color: shade900),
      secondaryLabelStyle: const TextStyle(color: accentPrimary),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(
        color: newDarkBlue.withOpacity(0.1),
        width: 1,
      ), // استخدام اللون الجديد
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: newDarkBlue.withOpacity(0.15), // استخدام اللون الجديد
      thickness: 1,
      space: 1,
    ),

    // Dialog
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: newDarkPurple.withOpacity(0.08),
          width: 1,
        ), // استخدام اللون الجديد
      ),
      titleTextStyle: const TextStyle(
        color: shade900,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: 'Almarai',
      ),
      contentTextStyle: TextStyle(
        color: shade900.withOpacity(0.8),
        fontSize: 16,
        fontFamily: 'Almarai',
      ),
    ),

    // Bottom Sheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        side: BorderSide(
          color: newDarkBlue.withOpacity(0.08),
          width: 1,
        ), // استخدام اللون الجديد
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        color: shade900,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: const TextStyle(
        color: shade900,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: const TextStyle(
        color: shade900,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: const TextStyle(
        color: shade900,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: const TextStyle(
        color: shade900,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: const TextStyle(
        color: shade900,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: shade900.withOpacity(0.9),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: shade900.withOpacity(0.9),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: shade900.withOpacity(0.85),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(color: shade900.withOpacity(0.8), fontSize: 16),
      bodyMedium: TextStyle(color: shade900.withOpacity(0.8), fontSize: 14),
      bodySmall: TextStyle(color: shade900.withOpacity(0.6), fontSize: 12),
      labelLarge: TextStyle(
        color: shade900.withOpacity(0.9),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(color: shade900.withOpacity(0.8), fontSize: 12),
      labelSmall: TextStyle(color: shade900.withOpacity(0.6), fontSize: 11),
    ),

    iconTheme: IconThemeData(color: shade900.withOpacity(0.8), size: 24),

    // Color Scheme - UPDATED with new colors
    colorScheme: ColorScheme.light(
      primary: brandPrimaryDark,
      onPrimary: Colors.white,
      primaryContainer: newDarkPurple.withOpacity(0.1), // استخدام اللون الجديد
      onPrimaryContainer: shade900,
      secondary: accentPrimary,
      onSecondary: Colors.white,
      secondaryContainer: accentPrimary.withOpacity(0.15),
      onSecondaryContainer: shade900,
      tertiary: accentSecondary,
      onTertiary: Colors.white,
      error: statusError,
      onError: Colors.white,
      errorContainer: statusError.withOpacity(0.15),
      onErrorContainer: const Color(0xFF7f1d1d),
      background: bgLight,
      onBackground: shade900,
      surface: Colors.white,
      onSurface: shade900,
      surfaceVariant: newDarkBlue.withOpacity(0.03), // استخدام اللون الجديد
      onSurfaceVariant: shade900.withOpacity(0.7),
      outline: newDarkPurple.withOpacity(0.2), // استخدام اللون الجديد
      outlineVariant: newDarkBlue.withOpacity(0.1), // استخدام اللون الجديد
      shadow: newDarkBlue.withOpacity(0.15), // استخدام اللون الجديد
      scrim: newDarkBlue.withOpacity(0.4), // استخدام اللون الجديد
      inverseSurface: shade900,
      onInverseSurface: Colors.white,
      inversePrimary: accentLight,
    ),

    // Input Decoration - UPDATED with new colors
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: newDarkBlue.withOpacity(0.03), // استخدام اللون الجديد
      hoverColor: newDarkPurple.withOpacity(0.05), // استخدام اللون الجديد
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: newDarkPurple.withOpacity(0.15),
          width: 1,
        ), // استخدام اللون الجديد
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: newDarkPurple.withOpacity(0.15),
          width: 1,
        ), // استخدام اللون الجديد
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: statusError, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: statusError, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: TextStyle(color: shade900.withOpacity(0.4)),
      labelStyle: TextStyle(color: shade900.withOpacity(0.7)),
      errorStyle: const TextStyle(color: statusError),
    ),

    // بقية الـ Light theme يبقى كما هو...
    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: brandPrimaryDark,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: brandPrimaryDark.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(88, 50),
      ),
    ),

    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    // Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: brandPrimaryDark,
        side: const BorderSide(color: brandPrimaryDark, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(88, 50),
      ),
    ),

    // Floating Action Button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentPrimary,
      foregroundColor: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return accentPrimary;
        }
        return shade900.withOpacity(0.3);
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return accentPrimary.withOpacity(0.5);
        }
        return shade900.withOpacity(0.15);
      }),
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return accentPrimary;
        }
        return Colors.transparent;
      }),
      checkColor: MaterialStateProperty.all(Colors.white),
      side: BorderSide(color: shade900.withOpacity(0.5), width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // Radio
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return accentPrimary;
        }
        return shade900.withOpacity(0.5);
      }),
    ),

    // Slider
    sliderTheme: SliderThemeData(
      activeTrackColor: accentPrimary,
      inactiveTrackColor: accentPrimary.withOpacity(0.3),
      thumbColor: accentPrimary,
      overlayColor: accentPrimary.withOpacity(0.2),
      valueIndicatorColor: accentPrimary,
      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
    ),

    // Progress Indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: accentPrimary,
      linearTrackColor: newDarkPurple.withOpacity(0.15), // استخدام اللون الجديد
      circularTrackColor: newDarkPurple.withOpacity(
        0.15,
      ), // استخدام اللون الجديد
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: newDarkBlue, // استخدام اللون الجديد مباشرة
      contentTextStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
      actionTextColor: accentGlow,
    ),

    // List Tile
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      iconColor: shade900.withOpacity(0.8),
      textColor: shade900.withOpacity(0.9),
    ),

    // Tab Bar
    tabBarTheme: TabBarTheme(
      labelColor: accentPrimary,
      unselectedLabelColor: shade900.withOpacity(0.5),
      indicatorColor: accentPrimary,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 14),
    ),
  );

  // ═══════════════════════════════════════════════════════════════
  // Dark Theme - UPDATED with new colors as primary backgrounds
  // ═══════════════════════════════════════════════════════════════
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Almarai',
    useMaterial3: true,
    brightness: Brightness.dark,

    primaryColor: accentDarkPrimary,
    scaffoldBackgroundColor: bgDark, // استخدام اللون الأزرق الداكن الجديد
    // AppBar - استخدام اللون البنفسجي الداكن الجديد
    appBarTheme: const AppBarTheme(
      backgroundColor: newDarkPurple, // استخدام اللون الجديد مباشرة
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Almarai',
      ),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: bgDarkSecondary, // استخدام اللون البنفسجي الداكن الجديد
      selectedItemColor: accentDarkLight,
      unselectedItemColor: textDarkTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),

    // Navigation Bar
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: bgDarkSecondary, // استخدام اللون البنفسجي الداكن الجديد
      indicatorColor: accentDarkPrimary.withOpacity(0.25),
      iconTheme: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const IconThemeData(color: accentDarkLight);
        }
        return const IconThemeData(color: textDarkTertiary);
      }),
      labelTextStyle: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const TextStyle(
            color: accentDarkLight,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          );
        }
        return const TextStyle(color: textDarkTertiary, fontSize: 12);
      }),
    ),

    // Card
    cardTheme: CardTheme(
      color: bgDarkCard,
      elevation: 4,
      shadowColor: newDarkBlue.withOpacity(0.4), // استخدام اللون الجديد
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: newDarkPurple.withOpacity(0.3),
          width: 1,
        ), // استخدام اللون الجديد
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: bgDarkElevated,
      selectedColor: accentDarkPrimary.withOpacity(0.3),
      labelStyle: const TextStyle(color: textDarkSecondary),
      secondaryLabelStyle: const TextStyle(color: accentDarkLight),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(
        color: newDarkPurple.withOpacity(0.4),
        width: 1,
      ), // استخدام اللون الجديد
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: newDarkPurple.withOpacity(0.4), // استخدام اللون الجديد
      thickness: 1,
      space: 1,
    ),

    // Dialog
    dialogTheme: DialogTheme(
      backgroundColor: bgDarkCard,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: newDarkPurple.withOpacity(0.3),
          width: 1,
        ), // استخدام اللون الجديد
      ),
      titleTextStyle: const TextStyle(
        color: textDarkPrimary,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: 'Almarai',
      ),
      contentTextStyle: const TextStyle(
        color: textDarkSecondary,
        fontSize: 16,
        fontFamily: 'Almarai',
      ),
    ),

    // Bottom Sheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: bgDarkCard,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        side: BorderSide(
          color: newDarkPurple.withOpacity(0.3),
          width: 1,
        ), // استخدام اللون الجديد
      ),
    ),

    // Text Theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: textDarkPrimary,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: textDarkPrimary,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: textDarkPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        color: textDarkPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: textDarkPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: textDarkPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: textDarkPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: textDarkPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: textDarkSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(color: textDarkSecondary, fontSize: 16),
      bodyMedium: TextStyle(color: textDarkSecondary, fontSize: 14),
      bodySmall: TextStyle(color: textDarkTertiary, fontSize: 12),
      labelLarge: TextStyle(
        color: textDarkPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(color: textDarkSecondary, fontSize: 12),
      labelSmall: TextStyle(color: textDarkTertiary, fontSize: 11),
    ),

    iconTheme: const IconThemeData(color: textDarkSecondary, size: 24),

    // Color Scheme - UPDATED with new colors
    colorScheme: const ColorScheme.dark(
      primary: accentDarkPrimary,
      onPrimary: Colors.white,
      primaryContainer: accentDarkSecondary,
      onPrimaryContainer: Colors.white,
      secondary: accentDarkLight,
      onSecondary: newDarkBlue, // استخدام اللون الجديد
      secondaryContainer: bgDarkElevated,
      onSecondaryContainer: accentDarkLight,
      tertiary: accentDarkLight,
      onTertiary: newDarkBlue, // استخدام اللون الجديد
      error: statusError,
      onError: Colors.white,
      errorContainer: Color(0xFF5c1a1a),
      onErrorContainer: Color(0xFFf5a3a3),
      background: newDarkBlue, // استخدام اللون الجديد مباشرة
      onBackground: textDarkPrimary,
      surface: bgDarkCard,
      onSurface: textDarkPrimary,
      surfaceVariant: bgDarkElevated,
      onSurfaceVariant: textDarkSecondary,
      outline: newDarkPurple, // استخدام اللون الجديد
      outlineVariant: Color(0xFF2a2a2a),
      shadow: newDarkBlue, // استخدام اللون الجديد
      scrim: newDarkBlue, // استخدام اللون الجديد
      inverseSurface: textDarkPrimary,
      onInverseSurface: newDarkBlue, // استخدام اللون الجديد
      inversePrimary: brandPrimaryDark,
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: bgDarkElevated,
      hoverColor: newDarkPurple.withOpacity(0.2), // استخدام اللون الجديد
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: newDarkPurple.withOpacity(0.4),
          width: 1,
        ), // استخدام اللون الجديد
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: newDarkPurple.withOpacity(0.4),
          width: 1,
        ), // استخدام اللون الجديد
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentDarkPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: statusError, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: statusError, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: const TextStyle(color: Color(0xFF6a6a6a)),
      labelStyle: const TextStyle(color: textDarkTertiary),
      errorStyle: const TextStyle(color: statusError),
    ),

    // بقية الـ Dark theme يبقى كما هو...
    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentDarkPrimary,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: accentDarkPrimary.withOpacity(0.4),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(88, 50),
      ),
    ),

    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentDarkLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    // Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentDarkLight,
        side: const BorderSide(color: accentDarkSecondary, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(88, 50),
      ),
    ),

    // Floating Action Button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentDarkPrimary,
      foregroundColor: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return accentDarkLight;
        }
        return const Color(0xFF6a6a6a);
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return accentDarkPrimary.withOpacity(0.5);
        }
        return const Color(0xFF3a3a3a);
      }),
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return accentDarkPrimary;
        }
        return Colors.transparent;
      }),
      checkColor: MaterialStateProperty.all(Colors.white),
      side: const BorderSide(color: textDarkTertiary, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // Radio
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return accentDarkPrimary;
        }
        return textDarkTertiary;
      }),
    ),

    // Slider
    sliderTheme: SliderThemeData(
      activeTrackColor: accentDarkPrimary,
      inactiveTrackColor: accentDarkPrimary.withOpacity(0.3),
      thumbColor: accentDarkLight,
      overlayColor: accentDarkPrimary.withOpacity(0.2),
      valueIndicatorColor: accentDarkPrimary,
      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
    ),

    // Progress Indicator
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: accentDarkPrimary,
      linearTrackColor: Color(0xFF2a2a2a),
      circularTrackColor: Color(0xFF2a2a2a),
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: newDarkPurple, // استخدام اللون الجديد مباشرة
      contentTextStyle: const TextStyle(color: textDarkPrimary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
      actionTextColor: accentDarkLight,
    ),

    // List Tile
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      iconColor: textDarkSecondary,
      textColor: textDarkPrimary,
    ),

    // Tab Bar
    tabBarTheme: const TabBarTheme(
      labelColor: accentDarkLight,
      unselectedLabelColor: textDarkTertiary,
      indicatorColor: accentDarkLight,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      unselectedLabelStyle: TextStyle(fontSize: 14),
    ),
  );
}
