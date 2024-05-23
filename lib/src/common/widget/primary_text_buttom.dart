import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';

class PrimaryTextButtom extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color textColor;
  final double textSize;
  const PrimaryTextButtom(
      {super.key,
      required this.title,
      required this.onPressed,
      this.textSize = 12,
      this.textColor = AppColors.primaryBlue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        title,
        style: GoogleFonts.hindSiliguri(
          fontSize: textSize,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
