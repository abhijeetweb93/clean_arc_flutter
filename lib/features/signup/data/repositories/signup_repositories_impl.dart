import 'package:clean_arc_flutter/features/signup/data/datasources/signup_data_source.dart';
import 'package:clean_arc_flutter/features/signup/domain/entities/signup_entity.dart';
import 'package:clean_arc_flutter/features/signup/domain/repositories/signup_repositories.dart';
import 'package:dartz/dartz.dart';

class SignupRepositoriesImpl implements SignupRepositories {
  final SignupDataSource signupDataSource;
  SignupRepositoriesImpl(this.signupDataSource);

  @override
  Future<Either<Exception, SignupResponseEntity>> signup({required SignupEntity signupEntity}) {
    return signupDataSource.signup(signupEntity: signupEntity);
  }
}