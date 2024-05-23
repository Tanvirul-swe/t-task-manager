import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_task_manager/src/common/widget/primary_buttom.dart';
import 'package:t_task_manager/src/common/widget/primary_text_buttom.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/common_content.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: scaffoldDefaultPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(AppAsset.intro),
              const SizedBox(height: 20),
              Text(
                'T-Task Manager',
                style: GoogleFonts.hindSiliguri(
                  fontSize: 32,
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Plan what you will do to be more organized for today, tomorrow and beyond',
                style: GoogleFonts.hindSiliguri(
                  fontSize: 14,
                  color: AppColors.primaryBlack,
                ),
              ),
              const Spacer(),
              PrimaryButtom(
                title: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, '/SignInPage');
                },
              ),
              const SizedBox(height: 25),
              PrimaryTextButtom(
                title: 'Sign Up',
                textSize: 16,
                onPressed: () {
                  Navigator.pushNamed(context, '/SignUpPage');
                },
              ),
              // PrimaryButtom(
              //   title: 'Sign Up',
              //   onPressed: () {
              //     Navigator.pushNamed(context, '/SignUpPage');
              //   },
              //   backgroundColor: AppColors.primaryWhite,
              //   textColor: AppColors.primaryBlue,
              // ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
