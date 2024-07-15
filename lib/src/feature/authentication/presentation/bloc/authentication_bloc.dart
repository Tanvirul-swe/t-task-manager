import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:t_task_manager/src/common/function/common_method.dart';
import 'package:t_task_manager/src/feature/authentication/repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository userRepository;
  AuthenticationBloc(this.userRepository) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      emit(AuthenticationLoading());
      // Sign Up with Email and Password
      try {
        if (event is SignUpRequestEvent) {
          final user = await userRepository.createUserWithEmailAndPassword(
              event.email, event.password);
          if (user != null) {
            if (user.user?.emailVerified ?? false) {
              emit(SignUpSuccess());

              return;
            }
            emit(SignUpSuccessEmailNotVerified());

            return;
          }
          emit(const AuthenticationFailureState(message: "Sign Up Failed"));
        }
      } catch (e) {
        debugPrint("AuthenticationFailur: ${e.toString()}");
        emit(AuthenticationFailureState(message: e.toString()));
      }
    });
  }

// Email Validation Stream
  final _emailStream = BehaviorSubject<String>();
  Stream<String> get emailStream => _emailStream.stream;

  void updateEmail(
    String email,
  ) {
    if (email.isEmpty) {
      _emailStream.sink.addError("Email should not be empty");
      return;
    } else if (!CommonMethod.isValidateEmail(email)) {
      _emailStream.sink.addError("Email is not valid");
      return;
    }

    _emailStream.sink.add(email);
    return;
  }

  // Password Validation Stream
  final _passwordStream = BehaviorSubject<String>();
  Stream<String> get passwordStream => _passwordStream.stream;

  void updatePassword(String password) {
    if (password.isEmpty) {
      _passwordStream.sink.addError("Password should not be empty");
      return;
    }
    // Password should be at least 6 characters
    else if (password.length < 6) {
      _passwordStream.sink.addError("Password should be at least 6 characters");
      return;
    }
    _passwordStream.sink.add(password);
    return;
  }

  // Sign In Button validation
  Stream<bool> get isValidSignInBtn =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);
}
