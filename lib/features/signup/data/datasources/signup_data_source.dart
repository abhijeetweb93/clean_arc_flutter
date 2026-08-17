import 'package:clean_arc_flutter/core/network/api_client.dart';
import 'package:clean_arc_flutter/core/network/api_endpoints.dart';
import 'package:clean_arc_flutter/features/signup/data/models/signup_model.dart';
import 'package:clean_arc_flutter/features/signup/domain/entities/signup_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class SignupDataSource {
  Future<Either<Exception, SignupResponseEntity>> signup({required SignupEntity signupEntity});
}

class SignupDataSourceImpl implements SignupDataSource {
  final ApiClient apiClient;
  SignupDataSourceImpl({required this.apiClient});

  @override
  Future<Either<Exception, SignupResponseEntity>> signup({required SignupEntity signupEntity}) async {
    try {
      final model = SignupModel.fromEntity(signupEntity);
      final response = await apiClient.dio.post(ApiEndpoints.register, data: model.toJson(),);
      final result = SignupResponseModel.fromJson(response.data);
      return Right(result);
    } on DioException catch (exception) {
      return Left(Exception(exception.response?.data.toString() ?? exception.message));
    } catch (exception) {
      return Left(Exception(exception.toString()));
    }
  }
}