import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 290,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                recipe.image,
                fit: BoxFit.cover,
                width: MediaQuery.sizeOf(context).width,
                height: 237,
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                recipe.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xff535353),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                recipe.description,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xff6D6D6D),
                ),
              ),
            ),
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
