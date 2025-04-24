import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/constants/app_routes.dart';
import 'package:recipe_app/controllers/recipe_controller.dart';

void main() {
  Get.put(RecipeController(), permanent: true);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
    );
  }
}
