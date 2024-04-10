import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';

class PrimaryButtom extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnable;
  final double borderRadius;
  final double height;
  final Color backgroundColor;
  final Color textColor;

  const PrimaryButtom(
      {super.key,
      required this.title,
      required this.onPressed,
      this.isLoading = false,
      this.isEnable = true,
      this.borderRadius = 14,
      this.backgroundColor = AppColors.primaryBlue,
      this.textColor = AppColors.primaryWhite,
      this.height = 52});

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          isEnable ? backgroundColor : AppColors.primaryBlue.withOpacity(0.5),
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: isEnable ? onPressed : null,
        child: Container(
          height: height,
          alignment: Alignment.center,
          child: isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  title,
                  style: GoogleFonts.hindSiliguri(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
