import 'package:clean_arc_flutter/features/login/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepositories {
  Future<Either<Exception,UserEntity>> login({required String email,required String password});
  Future<Either<Exception,void>> logout();
}