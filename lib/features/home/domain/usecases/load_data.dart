import 'package:clean_arc_flutter/core/use_case/use_case.dart';
import 'package:clean_arc_flutter/features/home/domain/entities/notes_entity.dart';
import 'package:clean_arc_flutter/features/home/domain/repositories/home_repositories.dart';
import 'package:dartz/dartz.dart';

class LoadData extends UseCase<ProductListEntity,NoParams>{
  final HomeRepositories _homeRepositories;
  LoadData(this._homeRepositories);

  @override
  Future<Either<Exception, ProductListEntity>> call(NoParams params) {
    return _homeRepositories.loadData();
  }

}