import 'dart:convert';

import 'package:clean_arc_flutter/features/home/domain/entities/notes_entity.dart';

class ProductModel extends ProductEntity{
  const ProductModel({required super.id, required super.title, required super.description, required super.image, required super.price, required super.category});
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      category: json['category'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'price': price,
      'category': category
    };
  }
}



class ProductListModel extends ProductListEntity{
  const ProductListModel(super.notesList);

  factory ProductListModel.fromJson(List<dynamic> jsonList) {
    return ProductListModel(jsonList.map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList());
  }
}