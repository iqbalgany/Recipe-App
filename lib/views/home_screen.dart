import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/recipe_controller.dart';
import 'package:recipe_app/views/detail_recipe_screen.dart';
import 'package:recipe_app/views/item_form_screen.dart';
import 'package:recipe_app/widgets/recipe_card.dart';
import 'package:recipe_app/widgets/show_delete_dialog_delete.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final RecipeController controller = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecipeController>(
      initState: (_) {
        controller.fetchRecipes();
        controller.fetchCategories();
      },
      builder: (controller) => Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.only(left: 29),
                child: Text(
                  'Let\'s Cooking',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xff535353),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                child: TextField(
                  controller: controller.titleController,
                  onChanged: controller.onSearchChanged,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search Item',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      gapPadding: 15,
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xff535353),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.clearSelectedCategory(),
                      child: Container(
                        width: 116,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'Clear',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    var category = controller.categories[index];
                    var isSelected =
                        controller.selectedCategoryId.value == category.id;
                    return GestureDetector(
                      onTap: () => controller.onCategorySelected(category.id),
                      child: Container(
                        margin: EdgeInsets.only(
                            right: index == controller.categories.length - 1
                                ? 0
                                : 10),
                        width: 116,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: isSelected ? Colors.black : Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                          color: isSelected ? Colors.black : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            controller.categories[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: isSelected ? Colors.grey : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  controller: controller.scrollController,
                  itemCount: controller.recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = controller.recipes[index];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(24, 5, 24, 5),
                      child: GestureDetector(
                        onLongPress: () {
                          showDeleteDialog(
                              context: context,
                              onDelete: () =>
                                  controller.deleteRecipe(recipe.id));
                        },
                        onTap: () {
                          Get.to(
                            DetailRecipeScreen(recipe: recipe),
                          );
                        },
                        child: RecipeCard(recipe: recipe),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.resetForm();
            Get.to(() => ItemFormScreen());
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
