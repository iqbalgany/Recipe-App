import 'package:get/get.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/services/recipe_service.dart';

class RecipeController extends GetxController {
  var isLoading = true.obs;
  var recipes = <RecipeModel>[].obs;

  final RecipeService _recipeService = RecipeService();

  @override
  void onInit() {
    fetchRecipes();
    super.onInit();
  }

  void fetchRecipes({
    int page = 1,
    String? title,
    int? categoryId,
  }) async {
    try {
      isLoading.value = true;
      final result = await _recipeService.getAllRecipes(
          page: page, title: title, categoryId: categoryId);
      recipes.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat resep');
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> createRecipe({
  //   required String title,
  //   required String description,
  //   required int categoryId,
  //   required File imageFile,
  // }) async {
  //   try {
  //     isLoading.value = true;
  //     await _recipeService.createRecipe(
  //       title: title,
  //       description: description,
  //       categoryId: categoryId,
  //       imageFile: imageFile,
  //     );
  //     Get.snackbar('Berhasil', "Resep berhasil ditambahkan");
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
