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
  var isLoading = true.obs;
  var recipes = <RecipeModel>[].obs;
  var categories = <CategoryModel>[].obs;
  final selectedCategoryId = Rx<int?>(null);
  RxString searchText = ''.obs;
  final ScrollController scrollController = ScrollController();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();

  final Rx<File?> imageFile = Rx<File?>(null);
  Rx<RecipeModel?> selectedRecipe = Rx<RecipeModel?>(null);

  final ImagePicker picker = ImagePicker();
  final RecipeService _recipeService = RecipeService();

  final Debouncer debouncer = Debouncer();

  void fetchRecipes({
    int page = 1,
    String? title,
    int? categoryId,
    bool isLoadMore = false,
  }) async {
    isLoading.value = true;
    try {
      final result = await _recipeService.getAllRecipes(
        page: page,
        title: title ?? searchText.value,
        categoryId: categoryId ?? selectedCategoryId.value,
      );

      if (isLoadMore) {
        recipes.addAll(result);
        page++;
      } else {
        recipes.assignAll(result);
        page = 2;
      }

      update();
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat resep');
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    debouncer.debounce(
        duration: Duration(milliseconds: 500),
        onDebounce: () => fetchRecipes(title: value));
    update();
  }

  void onCategorySelected(int? id) {
    selectedCategoryId.value = id!;
    update();
    fetchRecipes(
      title: searchText.value,
      categoryId: id,
    );
    update();
  }

  void clearSelectedCategory() {
    selectedCategoryId.value = null;
    searchText.value = '';
    titleController.clear();
    fetchRecipes();
    update();
  }

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile.value = File(picked.path);
    }
  }

  Future<void> createRecipe() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final image = imageFile.value;

    if (title.isEmpty || description.isEmpty || image == null) {
      Get.snackbar('Error', 'Semua field harus diisi');
    }
    isLoading.value = true;

    try {
      await _recipeService.createRecipe(
        title: title,
        description: description,
        categoryId: selectedCategoryId.value!,
        imageFile: image!,
      );
      update();

      resetForm();
      fetchRecipes(
        title: searchText.value,
        categoryId: selectedCategoryId.value,
      );
      Get.offAll(() => HomeScreen());
      Get.snackbar('Berhasil', "Resep berhasil ditambahkan");
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void updateRecipe() async {
    final title = titleController.text;
    final description = descriptionController.text;

    if (title.isEmpty || description.isEmpty || selectedRecipe.value == null) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return;
    }

    isLoading.value = true;
    try {
      await _recipeService.updateRecipe(
        id: selectedRecipe.value!.id,
        title: title,
        description: description,
        categoryId: selectedCategoryId.value!,
        image: imageFile.value,
      );
      update();

      resetForm();
      fetchRecipes(
        title: searchText.value,
        categoryId: selectedCategoryId.value,
      );
      Get.offAll(() => HomeScreen());
      Get.snackbar('Success', 'Resep berhasil diupdate');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void setRecipeForEdit(RecipeModel recipe) {
    selectedRecipe.value = recipe;
    titleController.text = recipe.title;
    descriptionController.text = recipe.description;
    selectedCategoryId.value = recipe.categoryId;
    imageFile.value = null;
  }

  void resetForm() {
    titleController.clear();
    descriptionController.clear();

    imageFile.value = null;
    selectedRecipe.value = null;
  }

  Future<void> fetchCategories() async {
    try {
      final result = await _recipeService.getCategories();
      categories.assignAll(result);
      if (result.isNotEmpty) {
        selectedCategoryId.value = null;
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
