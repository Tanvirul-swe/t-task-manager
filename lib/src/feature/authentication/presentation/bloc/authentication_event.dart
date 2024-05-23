part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInRequestEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInRequestEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignUpRequestEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignUpRequestEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignOutRequestEvent extends AuthenticationEvent {}

class CheckAuthenticationEvent extends AuthenticationEvent {}


