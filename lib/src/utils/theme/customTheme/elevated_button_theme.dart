import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._(); // To avoid creating instances

  /// Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primaryBlue.withOpacity(0.5),
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,

      side: const BorderSide(color: Colors.blue),
      textStyle: GoogleFonts.hindSiliguri(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      // padding: const EdgeInsets.symmetric(vertical: 18),
      minimumSize: const Size(double.infinity, 52), //////// HERE

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  /// Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
