import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color darkBg = Color(0xFF0a0e27);
  static const Color darkBgLight = Color(0xFF1a1f3a);
  static const Color aqua = Color(0xFF00d9ff);
  static const Color neonPurple = Color(0xFFb026ff);
  static const Color glassLight = Color(0xFF1a1f3a);
  static const Color glassLightTransparent = Color(0x661a1f3a);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBg,
    primaryColor: aqua,
    colorScheme: ColorScheme.dark(
      primary: aqua,
      secondary: neonPurple,
      surface: darkBgLight,
      background: darkBg,
      error: Colors.red.shade400,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkBg,
      elevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: aqua),
      titleTextStyle: GoogleFonts.elMessiri(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: aqua,
        letterSpacing: 1,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: aqua,
      foregroundColor: darkBg,
      elevation: 8,
      disabledElevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: aqua,
        backgroundColor: aqua.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: aqua, width: 1.5),
        ),
        elevation: 0,
      ),
    ),
    textTheme: GoogleFonts.elMessiriTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: glassLightTransparent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: aqua),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: aqua.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: aqua, width: 2),
      ),
      hintStyle: GoogleFonts.elMessiri(
        fontSize: 14,
        color: Colors.white38,
      ),
      labelStyle: GoogleFonts.elMessiri(
        fontSize: 14,
        color: aqua,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    dialogBackgroundColor: darkBgLight,
    dialogTheme: DialogTheme(
      backgroundColor: darkBgLight,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titleTextStyle: GoogleFonts.elMessiri(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: aqua,
      ),
      contentTextStyle: GoogleFonts.elMessiri(
        fontSize: 14,
        color: Colors.white70,
      ),
    ),
  );
}
