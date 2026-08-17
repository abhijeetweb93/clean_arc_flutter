import 'package:clean_arc_flutter/features/signup/domain/entities/signup_entity.dart';

class SignupModel extends SignupEntity {
  SignupModel({
    required super.username,
    required super.email,
    required super.password,
  });

  factory SignupModel.fromEntity(SignupEntity entity) {
    return SignupModel(
      username: entity.username,
      email: entity.email,
      password: entity.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}

class SignupResponseModel extends SignupResponseEntity {
  SignupResponseModel({
    required super.id,
    required super.username,
    required super.email,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      id: json['id']?.toString() ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}