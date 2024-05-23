part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class SignInSuccess extends AuthenticationState {}

class SignUpSuccess extends AuthenticationState {}

class AuthenticationFailureState extends AuthenticationState {
  final String message;

  const AuthenticationFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
