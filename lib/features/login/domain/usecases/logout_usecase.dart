
import 'package:clean_arc_flutter/core/use_case/use_case.dart';
import 'package:clean_arc_flutter/features/login/domain/repositories/login_repositories.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase implements UseCase<void,NoParams>{
  final LoginRepositories loginRepositories;
  LogoutUseCase(this.loginRepositories);

  @override
  Future<Either<Exception,void>> call(NoParams params) {
    return loginRepositories.logout();
  }
}