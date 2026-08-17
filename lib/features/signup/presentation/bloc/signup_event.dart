part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();
}

class DoSignupEvent extends SignupEvent {
  final String username;
  final String email;
  final String password;

  const DoSignupEvent({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, password];
}