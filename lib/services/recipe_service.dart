import 'dart:io';

import 'package:dio/dio.dart';
import 'package:recipe_app/helpers/dio_client.dart';
import 'package:recipe_app/models/category_model.dart';
import 'package:recipe_app/models/recipe_model.dart';

class RecipeService {
  Future<List<RecipeModel>> getAllRecipes({
    int page = 1,
    String? title,
    int? categoryId,
  }) async {
    try {
      final Response response =
          await DioClient.instance.get('/recipes', queryParameters: {
        'page': page,
        'title': title ?? '',
        'category_id': categoryId?.toString() ?? '',
      });

      final List data = response.data['data']['data'];
      return data.map((json) => RecipeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createRecipe({
    required String title,
    required String description,
    required int categoryId,
    required File imageFile,
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        'description': description,
        'category_id': categoryId.toString(),
        'image': await MultipartFile.fromFile(imageFile.path,
            filename: imageFile.path.split('/').last),
      });

      await DioClient.instance.post(
        '/recipes',
        data: formData,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<RecipeModel> updateRecipe({
    required int id,
    required String title,
    required String description,
    required int categoryId,
    File? image,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'title': title,
        'description': description,
        'category_id': categoryId.toString(),
        if (image != null)
          'image': await MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last),
      });

      final Response response = await DioClient.instance.post(
        '/recipes/${id}/update',
        data: formData,
      );
      return RecipeModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      Response response = await DioClient.instance.get('/categories');

      List<CategoryModel> categories = (response.data as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();

      return categories;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteRecipe(int id) async {
    try {
      await DioClient.instance.delete('/recipes/$id');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Gagal menghapus resep');
    }
  }
}
