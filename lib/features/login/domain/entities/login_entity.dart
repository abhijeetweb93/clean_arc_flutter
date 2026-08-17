// lib/features/login/models/login_entity.dart
import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable{
  final String email;
  final String password;

  LoginEntity({
    required this.email,
    required this.password,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) {
    return LoginEntity(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [email,password];
}

// User Model for response
class UserEntity extends Equatable{
  final String id;
  final String name;
  final String email;

  UserEntity({required this.id, required this.name, required this.email});



  @override
  List<Object?> get props => [id,name,email];
}