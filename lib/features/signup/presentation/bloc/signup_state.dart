part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();
}

final class SignupInitial extends SignupState {
  @override
  List<Object> get props => [];
}

class SignupLoading extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupSuccess extends SignupState {
  final SignupResponseEntity user;
  const SignupSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class SignupError extends SignupState {
  final String message;
  const SignupError(this.message);

  @override
  List<Object?> get props => [message];
}