import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';

class PrimaryTextField extends StatelessWidget {
  final String hintText;
  final String helperText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final String labelText;
  final String ?errorText;
  final String prefixIcon;
  final String suffixIcon;
  final Function()? onTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  const PrimaryTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.readOnly = false,
      this.enabled = true,
      this.labelText = '',
      this.errorText,
      this.prefixIcon = '',
      this.helperText = '',
      this.onTap,
      this.onChanged,
      this.suffixIcon = '',
      this.validator
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      
      decoration: InputDecoration(
        
        // contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        helperText: helperText,
        errorStyle: GoogleFonts.hindSiliguri(
          fontSize: 12,
          color: AppColors.primaryRead,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: GoogleFonts.hindSiliguri(
          fontSize: 16,
         color: AppColors.secondaryGray,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: GoogleFonts.hindSiliguri(
          fontSize: 16,
          color: const Color(0xffA9A9A9),
          fontWeight: FontWeight.w400,
        ),
        helperStyle: GoogleFonts.hindSiliguri(
          fontSize: 16,
          color: const Color(0xffA9A9A9),
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE8E9F3), width: 1.0),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryBlue, width: 1.0),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color:Color(0xFFE8E9F3), width: 1.0),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryRead, width: 1.0),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:Color(0xFFE8E9F3), width: 1.0),
        ),

        
        // border: const UnderlineInputBorder(
        //     borderSide: BorderSide(color: AppColors.primaryBlue)),

        // disabledBorder: const UnderlineInputBorder(
        //     borderSide: BorderSide(color: AppColors.primaryBlue)),
        // enabledBorder: const UnderlineInputBorder(
        //     borderSide: BorderSide(color: AppColors.primaryBlue)),
        // focusedBorder: const UnderlineInputBorder(
        //     borderSide: BorderSide(color: AppColors.primaryBlue)),
        prefixIcon: prefixIcon.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  height: 24,
                  width: 24,
                  prefixIcon,
                  color: AppColors.primaryBlack,
                ),
              )
            : null,
        suffixIcon: suffixIcon.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  height: 24,
                  width: 24,
                  suffixIcon,
                  color: AppColors.primaryBlack,
                ),
              )
            : null,
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final String hintText;
  final String helperText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final String labelText;
  final String errorText;
  final String prefixIcon;
  final String suffixIcon;
  const SearchTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.readOnly = false,
      this.enabled = true,
      this.labelText = '',
      this.errorText = '',
      this.prefixIcon = '',
      this.helperText = '',
      this.suffixIcon = ''});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      decoration: InputDecoration(
        fillColor: const Color(0xFFF6F6F6),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 2),
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        helperText: helperText,
        errorStyle: GoogleFonts.hindSiliguri(
          fontSize: 12,
          color: AppColors.primaryRead,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: GoogleFonts.hindSiliguri(
          fontSize: 16,
          color: const Color(0xffA9A9A9),
          fontWeight: FontWeight.w400,
        ),
        hintStyle: GoogleFonts.hindSiliguri(
          fontSize: 16,
          color: const Color(0xffA9A9A9),
          fontWeight: FontWeight.w400,
        ),
        helperStyle: GoogleFonts.hindSiliguri(
          fontSize: 16,
          color: const Color(0xffA9A9A9),
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
            
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
        prefixIcon: prefixIcon.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  height: 24,
                  width: 24,
                  prefixIcon,
                ),
              )
            : null,
        suffixIcon: suffixIcon.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  height: 24,
                  width: 24,
                  suffixIcon,
                ),
              )
            : null,
      ),
    );
  }
}
