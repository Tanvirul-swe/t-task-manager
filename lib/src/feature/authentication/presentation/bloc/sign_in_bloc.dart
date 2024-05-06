import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:t_task_manager/src/common/function/common_method.dart';
import 'package:t_task_manager/src/feature/authentication/repositories/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;
  SignInBloc(this.userRepository) : super(SignInInitial()) {
    on<SignInEvent>((event, emit) {
      // TODO: implement event handler
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
    _passwordStream.sink.add(password);
    return;
  }
}
