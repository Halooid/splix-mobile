import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryColor = Color(0xFF006A71);
  static const Color secondaryColor = Color(0xFF48A6A7);
  static const Color accentColor = Color(0xFF9ACBD0);
  static const Color backgroundColor = Color(0xFFF2EFE7);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: backgroundColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        displayMedium: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        displaySmall: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        headlineLarge: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        headlineMedium: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        headlineSmall: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        titleLarge: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        titleMedium: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        titleSmall: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        bodyLarge: GoogleFonts.lato(
          color: Colors.black87,
        ),
        bodyMedium: GoogleFonts.lato(
          color: Colors.black87,
        ),
        bodySmall: GoogleFonts.lato(
          color: Colors.black54,
        ),
        labelLarge: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
        ),
        labelMedium: GoogleFonts.lato(
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.lato(
          fontWeight: FontWeight.w500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 2),
          textStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
