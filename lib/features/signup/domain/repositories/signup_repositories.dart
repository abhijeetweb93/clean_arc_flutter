import 'package:clean_arc_flutter/features/signup/domain/entities/signup_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SignupRepositories {
  Future<Either<Exception, SignupResponseEntity>> signup({required SignupEntity signupEntity});
}