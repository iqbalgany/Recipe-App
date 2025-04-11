import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/recipe_model.dart';

class DetailRecipeScreen extends StatelessWidget {
  final RecipeModel? recipe;
  const DetailRecipeScreen({
    super.key,
    this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                recipe!.image,
                height: 350,
                width: MediaQuery.sizeOf(context).width,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 20,
                top: 45,
                child: CircleAvatar(
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
