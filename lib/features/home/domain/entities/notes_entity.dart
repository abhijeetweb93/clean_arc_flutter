import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable{
  final int id;
  final String title;
  final String description;
  final String image;
  final double price;
  final String category;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.category
  });

  @override
  List<Object?> get props => [id,title,description,image,price,category];
}


class ProductListEntity extends Equatable{
  final List<ProductEntity> notesList;
  const ProductListEntity(this.notesList);
  @override
  List<Object?> get props => [notesList];
}