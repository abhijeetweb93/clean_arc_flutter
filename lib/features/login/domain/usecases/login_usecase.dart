// import '../repositories/login_repositories.dart';

import 'package:clean_arc_flutter/core/use_case/use_case.dart';
import 'package:clean_arc_flutter/features/login/domain/repositories/login_repositories.dart';
import 'package:dartz/dartz.dart';

import '../entities/login_entity.dart';

class LoginUseCase implements UseCase<UserEntity,(String, String)> {
  final LoginRepositories loginRepositories;
  LoginUseCase(this.loginRepositories);

  @override
  Future<Either<Exception,UserEntity>> call((String, String) params) {
    final (email, password) = params;
    return loginRepositories.login(email: email, password: password);
  }

  // Future<UserEntity?> call({required String email, required String password}) async {
  //    return loginRepositories.login(email: email, password: password);
  // }
}
