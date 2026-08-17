import 'package:clean_arc_flutter/features/home/data/datasources/home_data_source.dart';
import 'package:clean_arc_flutter/features/home/domain/entities/notes_entity.dart';
import 'package:clean_arc_flutter/features/home/domain/repositories/home_repositories.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoriesImpl extends HomeRepositories{
  final HomeDataSource _homeDataSource;
  HomeRepositoriesImpl(this._homeDataSource);
  @override
  Future<Either<Exception, ProductListEntity>> loadData() {
    return _homeDataSource.loadData();
  }

}