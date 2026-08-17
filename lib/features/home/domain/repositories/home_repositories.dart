import 'package:clean_arc_flutter/features/home/domain/entities/notes_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepositories {
  Future<Either<Exception,ProductListEntity>> loadData();
}