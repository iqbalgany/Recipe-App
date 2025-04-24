import 'package:recipe_app/models/category_model.dart';

class RecipeModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final int categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CategoryModel category;

  RecipeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        categoryId: json["category_id"] is String
            ? int.parse(json["category_id"])
            : json["category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: CategoryModel.fromJson(json["category"]),
      );
}
