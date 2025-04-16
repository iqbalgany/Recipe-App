import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/recipe_controller.dart';
import 'package:recipe_app/views/item_form_screen.dart';

import '../models/recipe_model.dart';

class DetailRecipeScreen extends StatelessWidget {
  final RecipeModel? recipe;
  DetailRecipeScreen({
    super.key,
    this.recipe,
  });

  final RecipeController controller = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: 'recipe-image-${recipe!.id}',
                child: Image.network(
                  recipe!.image,
                  height: 350,
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 45, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          controller.setRecipeForEdit(recipe!);
                          Get.to(() => ItemFormScreen());
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Text(
                  recipe!.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  recipe!.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
