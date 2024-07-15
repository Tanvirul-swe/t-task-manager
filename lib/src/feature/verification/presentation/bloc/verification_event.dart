part of 'verification_bloc.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class VerifyEmailEvent extends VerificationEvent {

}

class EmailVerificationSuccessEvent extends VerificationEvent {}
