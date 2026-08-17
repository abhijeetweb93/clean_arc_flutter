// lib/features/home/model/home_item_model.dart
class HomeItemModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final double rating;
  final DateTime createdAt;

  HomeItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.createdAt,
  });

  factory HomeItemModel.fromJson(Map<String, dynamic> json) {
    return HomeItemModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? json['imageUrl'] ?? '',
      category: json['category'] ?? 'General',
      rating: (json['rating'] ?? 0).toDouble(),
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'category': category,
      'rating': rating,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

// Response Model for JSON structure
class HomeResponseModel {
  final String status;
  final String message;
  final List<HomeItemModel> data;
  final int totalCount;
  final int page;
  final int perPage;

  HomeResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalCount,
    required this.page,
    required this.perPage,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>? ?? [];

    return HomeResponseModel(
      status: json['status'] ?? 'error',
      message: json['message'] ?? '',
      data: dataList.map((item) => HomeItemModel.fromJson(item)).toList(),
      totalCount: json['total_count'] ?? 0,
      page: json['page'] ?? 1,
      perPage: json['per_page'] ?? 10,
    );
  }
}