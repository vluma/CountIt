import 'package:flutter/material.dart';

class AppTheme {
  // 主色调：现代蓝色系 - 更柔和的蓝色，符合现代审美
  static const Color primaryColor = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryContainer = Color(0xFFDBEAFE);
  
  // 次要色调：绿色 - 更清新的绿色
  static const Color secondaryColor = Color(0xFF059669);
  static const Color secondaryLight = Color(0xFF10B981);
  static const Color secondaryDark = Color(0xFF047857);
  static const Color secondaryContainer = Color(0xFFD1FAE5);
  
  // 强调色：橙色 - 更温暖的橙色
  static const Color accentColor = Color(0xFFD97706);
  static const Color accentLight = Color(0xFFF59E0B);
  static const Color accentDark = Color(0xFFB45309);
  static const Color accentContainer = Color(0xFFFFF3C4);
  
  // 错误色 - 更鲜明的红色
  static const Color errorColor = Color(0xFFDC2626);
  static const Color errorContainer = Color(0xFFFEE2E2);
  
  // 中性色（浅色主题）
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF9FAFB);
  static const Color lightOnBackground = Color(0xFF111827);
  static const Color lightOnSurface = Color(0xFF111827);
  static const Color lightOnSurfaceVariant = Color(0xFF4B5563);
  static const Color lightOutline = Color(0xFFE5E7EB);
  static const Color lightShadow = Color(0x1A000000);
  
  // 中性色（深色主题）
  static const Color darkBackground = Color(0xFF030712);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkSurfaceVariant = Color(0xFF1F2937);
  static const Color darkOnBackground = Color(0xFFF9FAFB);
  static const Color darkOnSurface = Color(0xFFF3F4F6);
  static const Color darkOnSurfaceVariant = Color(0xE5D1D5DB);
  static const Color darkOutline = Color(0xFF4B5563);
  static const Color darkShadow = Color(0x40000000);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: primaryColor,
      primaryContainer: primaryContainer,
      secondary: secondaryColor,
      secondaryContainer: secondaryContainer,
      error: errorColor,
      errorContainer: errorContainer,
      background: lightBackground,
      surface: lightSurface,
      surfaceVariant: lightSurfaceVariant,
      onPrimary: lightOnBackground,
      onPrimaryContainer: lightOnBackground,
      onSecondary: lightOnBackground,
      onSecondaryContainer: lightOnBackground,
      onError: lightOnBackground,
      onErrorContainer: lightOnBackground,
      onBackground: lightOnBackground,
      onSurface: lightOnSurface,
      onSurfaceVariant: lightOnSurfaceVariant,
      outline: lightOutline,
    ),
    useMaterial3: true,
    fontFamily: 'SF Pro Display',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -0.5, height: 1.2),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0, height: 1.3),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0, height: 1.4),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0, height: 1.4),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0, height: 1.4),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0, height: 1.4),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.5, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, letterSpacing: 0.25, height: 1.5),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.4, height: 1.5),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.4),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.4),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.4),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      color: lightSurfaceVariant,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        elevation: 0,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: lightOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: lightOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: errorColor, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: errorColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: const TextStyle(color: lightOnSurfaceVariant, fontSize: 14),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    dividerTheme: const DividerThemeData(
      color: lightOutline,
      thickness: 1,
      space: 0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: primaryColor,
      primaryContainer: primaryDark,
      secondary: secondaryColor,
      secondaryContainer: secondaryDark,
      error: errorColor,
      errorContainer: Color(0xFF7F1D1D),
      background: darkBackground,
      surface: darkSurface,
      surfaceVariant: darkSurfaceVariant,
      onPrimary: darkOnBackground,
      onPrimaryContainer: darkOnBackground,
      onSecondary: darkOnBackground,
      onSecondaryContainer: darkOnBackground,
      onError: darkOnBackground,
      onErrorContainer: darkOnBackground,
      onBackground: darkOnBackground,
      onSurface: darkOnSurface,
      onSurfaceVariant: darkOnSurfaceVariant,
      outline: darkOutline,
    ),
    useMaterial3: true,
    fontFamily: 'SF Pro Display',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -0.5, height: 1.2),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0, height: 1.3),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0, height: 1.4),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0, height: 1.4),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0, height: 1.4),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0, height: 1.4),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.5, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, letterSpacing: 0.25, height: 1.5),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.4, height: 1.5),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.4),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.4),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.4),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      color: darkSurface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        elevation: 0,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      backgroundColor: primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: darkOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: darkOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: errorColor, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: errorColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      fillColor: darkSurfaceVariant,
      filled: true,
      hintStyle: const TextStyle(color: darkOnSurfaceVariant, fontSize: 14),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: darkBackground,
    ),
    dividerTheme: const DividerThemeData(
      color: darkOutline,
      thickness: 1,
      space: 0,
    ),
  );
}
