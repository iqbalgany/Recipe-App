import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/recipe_controller.dart';
import 'package:recipe_app/views/detail_recipe_screen.dart';
import 'package:recipe_app/views/item_form_screen.dart';
import 'package:recipe_app/widgets/recipe_card.dart';
import 'package:recipe_app/widgets/show_delete_dialog_delete.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final RecipeController controller = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Let\'s Cooking',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xff535353),
          ),
        ),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.recipes.isEmpty) {
            return Center(child: Text('Tidak ada resep.'));
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),
            itemCount: controller.recipes.length,
            itemBuilder: (context, index) {
              final recipe = controller.recipes[index];
              return GestureDetector(
                onLongPress: () {
                  showDeleteDialog(
                      context: context,
                      onDelete: () => controller.deleteRecipe(recipe.id));
                },
                onTap: () {
                  Get.to(
                    DetailRecipeScreen(
                      recipe: recipe,
                    ),
                  );
                },
                child: RecipeCard(recipe: recipe),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.resetForm();
          Get.to(() => ItemFormScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
