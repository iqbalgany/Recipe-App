import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/models/category_model.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/services/recipe_service.dart';
import 'package:recipe_app/views/home_screen.dart';

class RecipeController extends GetxController {
  bool isLoading = false;
  bool isEndOfList = false;
  List<RecipeModel> recipes = [];
  List<CategoryModel> categories = [];
  int? selectedCategoryId;
  String searchText = '';
  final ScrollController scrollController = ScrollController();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();

  File? imageFile;
  RecipeModel? selectedRecipe;

  final ImagePicker picker = ImagePicker();
  final RecipeService _recipeService = RecipeService();

  final Debouncer debouncer = Debouncer();
  var currentPage = 1;
  var lastPage = 1;

  void fetchRecipes({
    String? title,
    int? categoryId,
    bool isLoadMore = false,
  }) async {
    try {
      isLoading = true;

      if (isLoadMore) {
        if (currentPage < lastPage) {
          currentPage++;
        }
      } else {
        currentPage = 1;
        recipes.clear();
      }

      final result = await _recipeService.getAllRecipes(
        page: currentPage,
        title: searchText.isEmpty ? null : searchText,
        categoryId: selectedCategoryId,
      );

      final List<RecipeModel> fetchedRecipes = result['recipes'];
      lastPage = result['last_page'];

      if (fetchedRecipes.isEmpty && !isLoadMore) {
        recipes.clear();
      } else {
        recipes.addAll(fetchedRecipes);
      }

      isEndOfList = currentPage >= lastPage;
      update();
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat resep');
    } finally {
      isLoading = false;
    }
  }

  void onSearchChanged(String value) {
    searchText = value;
    debouncer.debounce(
        duration: Duration(milliseconds: 500),
        onDebounce: () => fetchRecipes(title: value));
    update();
  }

  void onCategorySelected(int? id) {
    selectedCategoryId = id!;
    update();
    fetchRecipes(
      title: searchText,
      categoryId: id,
    );
    update();
  }

  void clearSelectedCategory() {
    selectedCategoryId = null;
    searchText = '';
    titleController.clear();
    fetchRecipes();
    update();
  }

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile = File(picked.path);
      update();
    }
  }

  Future<void> createRecipe() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final image = imageFile;

    if (title.isEmpty || description.isEmpty || image == null) {
      Get.snackbar('Error', 'Semua field harus diisi');
    }
    isLoading = true;

    try {
      await _recipeService.createRecipe(
        title: title,
        description: description,
        categoryId: selectedCategoryId!,
        imageFile: image!,
      );
      update();

      fetchRecipes(
        title: searchText,
        categoryId: selectedCategoryId,
      );
      Get.offAll(() => HomeScreen());
      resetForm();
      Get.snackbar('Berhasil', "Resep berhasil ditambahkan");
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading = false;
    }
  }

  void updateRecipe() async {
    final title = titleController.text;
    final description = descriptionController.text;

    if (title.isEmpty || description.isEmpty || selectedRecipe == null) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return;
    }

    isLoading = true;
    try {
      await _recipeService.updateRecipe(
        id: selectedRecipe!.id,
        title: title,
        description: description,
        categoryId: selectedCategoryId!,
        image: imageFile,
      );
      update();

      resetForm();
      fetchRecipes(
        title: searchText,
        categoryId: selectedCategoryId,
      );
      Get.offAll(() => HomeScreen());
      Get.snackbar('Success', 'Resep berhasil diupdate');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading = false;
    }
  }

  void setRecipeForEdit(RecipeModel recipe) {
    selectedRecipe = recipe;
    titleController.text = recipe.title;
    descriptionController.text = recipe.description;
    selectedCategoryId = recipe.categoryId;
    if (recipe.image.startsWith('http') || recipe.image.startsWith('https')) {
      imageFile = null;
    } else {
      imageFile = File(recipe.image);
    }
    update();
  }

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    selectedCategoryId = null;
    imageFile = null;
    selectedRecipe = null;
    update();
  }

  Future<void> fetchCategories() async {
    try {
      final result = await _recipeService.getCategories();
      categories.assignAll(result);
      if (result.isNotEmpty) {
        selectedCategoryId = null;
        update();
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat kategori');
    }
  }

  Future<void> deleteRecipe(int id) async {
    try {
      await _recipeService.deleteRecipe(id);
      Get.snackbar('Sukses', 'Resep berhasil dihapus');

      fetchRecipes();
    } catch (e) {
      Get.snackbar('Gagal', 'Gagal menghapus resep');
    }
  }
}
