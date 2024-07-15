import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_task_manager/src/feature/authentication/repositories/authentication_repository.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final AuthenticationRepository repo;
  VerificationBloc(this.repo) : super(VerificationInitial()) {
    on<VerificationEvent>((event, emit) async {
      emit(VerificationLoading());
      try {
        if (event is VerifyEmailEvent) {
          await repo.sendEmailVerification();
          emit(VerificationEmailSent());
        }
        else if (event is EmailVerificationSuccessEvent) {
          emit(EmailVerificationSuccess());
        }
      } catch (e) {
        emit(VerificationFailureState(message: e.toString()));
      }
    });
  }

  /// Timer to automaticallly redirect on RootPage
  Future<void> setTimerForAutoRedirect() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      debugPrint("Reloading user for email verification : ${timer.tick}");
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        add(EmailVerificationSuccessEvent());
      }
    });
  }
}
