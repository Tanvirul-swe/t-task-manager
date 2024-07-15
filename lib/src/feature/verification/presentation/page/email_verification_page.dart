import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_task_manager/src/common/widget/common_widget.dart';
import 'package:t_task_manager/src/common/widget/primary_buttom.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';
import 'package:t_task_manager/src/feature/verification/presentation/bloc/verification_bloc.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Email Verification",
            style: appBarTextStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(scaffoldDefaultPadding),
          child: BlocConsumer<VerificationBloc, VerificationState>(
            listener: (context, state) {
              if (state is VerificationEmailSent) {
                context.read<VerificationBloc>().setTimerForAutoRedirect();
              } else if (state is VerificationFailureState) {
                showCustomSnackBar(context, state.message, isError: true);
              } else if (state is EmailVerificationSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/RootScreen', (route) => false);
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please check your email to verify your account',
                    style: largeHeadingTextStyle,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'We have sent a verification link to your email address. Please click on the link to verify your account.',
                    style: mediumHeadingTextStyle,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'If you have not received the email, please check your spam folder or click on the button below to resend the email.',
                    style: mediumHeadingTextStyle,
                  ),
                  const SizedBox(height: 20),
                  PrimaryButtom(
                    title: "Continue",
                    onPressed: () {},
                  )
                ],
              );
            },
          ),
        ));
  }
}
