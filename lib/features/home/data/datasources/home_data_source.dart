import 'package:clean_arc_flutter/core/network/api_client.dart';
import 'package:clean_arc_flutter/core/network/api_endpoints.dart';
import 'package:clean_arc_flutter/features/home/data/models/notes_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class HomeDataSource {
  Future<Either<Exception,ProductListModel>> loadData();
}


class HomeDataSourceImpl implements HomeDataSource{
  final ApiClient _apiClient;
  HomeDataSourceImpl(this._apiClient);

  @override
  Future<Either<Exception, ProductListModel>> loadData() async{
    try{
      var response= await _apiClient.dio.get(ApiEndpoints.products);
      if (response.statusCode == 200) {
        final List<dynamic> rawList = response.data as List<dynamic>;
        final List<ProductModel> products = rawList
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return Right(ProductListModel(products));
      }else{
        return Left(Exception(response.statusMessage));
      }
    }on DioException catch(ex){
      return Left(Exception(ex.response?.data.toString()));
    } catch(ex){
      return Left(Exception(ex.toString()));
    }

  }

}