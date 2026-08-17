part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
}

// Initial State
final class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

// Loading State
class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

// Success State
class LoginSuccess extends LoginState {
  final UserEntity user;
  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

// Error State
class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);

  @override
  List<Object?> get props => [message];
}

class LogoutSuccess extends LoginState {
  const LogoutSuccess();

  @override
  List<Object?> get props => [];
}