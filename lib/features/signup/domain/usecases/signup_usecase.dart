import 'package:clean_arc_flutter/core/use_case/use_case.dart';
import 'package:clean_arc_flutter/features/signup/domain/entities/signup_entity.dart';
import 'package:clean_arc_flutter/features/signup/domain/repositories/signup_repositories.dart';
import 'package:dartz/dartz.dart';

class SignupUseCase implements UseCase<SignupResponseEntity, SignupEntity> {
  final SignupRepositories signupRepositories;
  SignupUseCase(this.signupRepositories);

  @override
  Future<Either<Exception, SignupResponseEntity>> call(SignupEntity params) {
    return signupRepositories.signup(signupEntity: params);
  }
}