import 'package:equatable/equatable.dart';

class SignupEntity extends Equatable {
  final String username;
  final String email;
  final String password;

  const SignupEntity({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, password];
}

class SignupResponseEntity extends Equatable {
  final String id;
  final String username;
  final String email;

  const SignupResponseEntity({
    required this.id,
    required this.username,
    required this.email,
  });

  @override
  List<Object?> get props => [id, username, email];
}