part of 'verification_bloc.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationEmailSent extends VerificationState {}

class EmailVerificationSuccess extends VerificationState {}

class VerificationFailureState extends VerificationState {
  final String message;

  const VerificationFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
