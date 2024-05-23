import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_task_manager/src/common/widget/primary_buttom.dart';
import 'package:t_task_manager/src/common/widget/primary_text_buttom.dart';
import 'package:t_task_manager/src/common/widget/primary_textfield.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/feature/authentication/presentation/bloc/authentication_bloc.dart';

import '../../../../constant/app_colors.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(scaffoldDefaultPadding),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: GoogleFonts.hindSiliguri(
                    fontSize: 36,
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                StreamBuilder<String>(
                    stream: context.read<AuthenticationBloc>().emailStream,
                    builder: (context, snapshot) {
                      return PrimaryTextField(
                        prefixIcon: AppAsset.email,
                        errorText: snapshot.error as String?,
                        controller: emailController,
                        hintText: 'Please enter your email',
                        labelText: "Email",
                        keyboardType: TextInputType.text,
                        onChanged: (p0) {
                          context.read<AuthenticationBloc>().updateEmail(p0);
                        },
                      );
                    }),
                StreamBuilder<String>(
                    stream: context.read<AuthenticationBloc>().passwordStream,
                    builder: (context, snapshot) {
                      return PrimaryTextField(
                        prefixIcon: AppAsset.lock,
                        errorText: snapshot.error as String?,
                        controller: passwordController,
                        hintText: 'Please enter your password',
                        labelText: "Password",
                        onChanged: (p0) {
                          context.read<AuthenticationBloc>().updatePassword(p0);
                        },
                      );
                    }),
                Align(
                    alignment: Alignment.centerRight,
                    child: PrimaryTextButtom(
                        title: "Forgot Password?", onPressed: () {})),
                const SizedBox(height: 30),
                StreamBuilder<bool>(
                    stream: context.read<AuthenticationBloc>().isValidSignInBtn,
                    builder: (context, snapshot) {
                      return PrimaryButtom(
                          isEnable: snapshot.data ?? false,
                          isLoading: state is AuthenticationLoading,
                          title: "Login",
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/RootScreen',
                            );
                          });
                    }),
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
                  title: 'Don\'t have an account?',
                  content: 'Sign Up',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/SignUpPage', (route) => false);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
