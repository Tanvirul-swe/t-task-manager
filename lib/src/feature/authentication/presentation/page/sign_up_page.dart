import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_task_manager/src/common/widget/primary_buttom.dart';
import 'package:t_task_manager/src/common/widget/primary_textfield.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/common_content.dart';

import '../../../../constant/app_colors.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(scaffoldDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign Up',
              style: GoogleFonts.hindSiliguri(
                fontSize: 36,
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            PrimaryTextField(
              prefixIcon: AppAsset.email,
              controller: TextEditingController(),
              hintText: 'Please enter your email',
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
            ),
            PrimaryTextField(
              prefixIcon: AppAsset.lock,
              controller: TextEditingController(),
              hintText: 'Please enter your password',
              labelText: "Password",
              keyboardType: TextInputType.emailAddress,
            ),
          
            const SizedBox(height: 30),
            PrimaryButtom(title: "Create", onPressed: () {}),
            const SizedBox(height: 50),
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: AppColors.secondaryGray,
                    thickness: 1,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Or',
                  style: GoogleFonts.hindSiliguri(
                    fontSize: 12,
                    color: AppColors.primaryBlack,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Divider(
                    color: AppColors.secondaryGray,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.secondaryGray,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(AppAsset.google),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 42,
                    width: 42,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryWhite,
                      border: Border.all(
                        color: AppColors.secondaryGray,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(AppAsset.facebook),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            dontHaveAccout(
              title: 'Have an account?',
              content: 'Sign in',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/SignInPage', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
