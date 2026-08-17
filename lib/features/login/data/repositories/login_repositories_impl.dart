import 'package:clean_arc_flutter/features/login/data/datasources/login_data_source.dart';
import 'package:clean_arc_flutter/features/login/domain/entities/login_entity.dart';
import 'package:clean_arc_flutter/features/login/domain/repositories/login_repositories.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoriesImpl implements LoginRepositories{
  final LoginDataSource loginDataSource;
  LoginRepositoriesImpl(this.loginDataSource);
  @override
  Future<Either<Exception,UserEntity>> login({required String email, required String password}) {
    return loginDataSource.login(email: email, password: password);
  }

  @override
  Future<Either<Exception,void>> logout() {
    return loginDataSource.logout();
  }

}