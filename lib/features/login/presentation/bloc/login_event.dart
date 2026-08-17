part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class DoLoginEvent extends LoginEvent {
  final String email;
  final String password;

  const DoLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class DoLogOutEvent extends LoginEvent {
  const DoLogOutEvent();
  @override
  List<Object?> get props => [];
}