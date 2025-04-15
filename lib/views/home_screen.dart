import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/recipe_controller.dart';
import 'package:recipe_app/views/detail_recipe_screen.dart';
import 'package:recipe_app/views/item_form_screen.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

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
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Hapus Resep',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      content: Text(
                        'Apakah kamu yakin ingin menghapus resep ini',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            'Batal',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                            controller.deleteRecipe(recipe.id);
                          },
                          child: Text(
                            'Hapus',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
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
          Get.to(() => ItemFormScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
