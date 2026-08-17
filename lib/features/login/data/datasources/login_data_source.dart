
import 'package:clean_arc_flutter/features/login/data/models/login_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';

abstract class LoginDataSource {
  Future<Either<Exception,UserModel>> login({required String email, required String password});
  Future<Either<Exception,void>> logout();
}

class LoginDataSourceImpl implements LoginDataSource{
  final ApiClient apiClient;
  LoginDataSourceImpl({required this.apiClient});

  @override
  Future<Either<Exception,UserModel>> login({required String email, required String password}) async{
    try{
      final response = await apiClient.dio.post(ApiEndpoints.login, data: {"username": email, "password": password},);
      // final result = SignupResponseModel.fromJson(response.data);
      return Right(UserModel(id: "1", name: "name", email: email));
    }
    on DioException catch(exception){
      return Left(Exception(exception.response?.data.toString()));
    }
    catch(exception){
      return Left(Exception(exception.toString()));
    }

  }

  @override
  Future<Either<Exception,void>> logout() async {
     return const Right(());
  }

}