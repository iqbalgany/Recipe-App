import 'package:get/get.dart';
import 'package:recipe_app/views/detail_recipe_screen.dart';
import 'package:recipe_app/views/home_screen.dart';
import 'package:recipe_app/views/item_form_screen.dart';

class AppRoutes {
  static const String home = "/home";
  static const String detailRecipe = "/detail-recipe";
  static const String itemForm = "/item-form";

  static final routes = [
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: detailRecipe, page: () => DetailRecipeScreen()),
    GetPage(name: itemForm, page: () => ItemFormScreen()),
  ];
}
