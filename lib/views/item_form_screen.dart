import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/recipe_controller.dart';
import 'package:recipe_app/widgets/custom_text_field.dart';

class ItemFormScreen extends StatelessWidget {
  ItemFormScreen({super.key});

  final RecipeController controller = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RecipeController>(
        builder: (controller) => controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SafeArea(
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        GestureDetector(
                          onTap: controller.pickImage,
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Color(0xffD0DBEA),
                              ),
                              image: controller.imageFile != null
                                  ? DecorationImage(
                                      image: FileImage(controller.imageFile!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: controller.imageFile == null
                                ? (controller.selectedRecipe?.image != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          controller.selectedRecipe!.image,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_rounded,
                                            size: 53,
                                            color: Color(0xff9FA5C0),
                                          ),
                                          SizedBox(height: 21.33),
                                          Text(
                                            'Add Cover Photo',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Color(0xff3E5481),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            '(up to 12 Mb)',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Color(0xff9FA5C0),
                                            ),
                                          ),
                                        ],
                                      ))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.file(
                                      controller.imageFile!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 24),
                        CustomTextField(
                          label: 'Food Name',
                          hint: 'Enter food name',
                          controller: controller.titleController,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                        ),
                        SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color(0xff3E5481),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: Color(0xffD0DBEA),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  isExpanded: true,
                                  items: controller.categories.map(
                                    (category) {
                                      return DropdownMenuItem<int>(
                                        value: category.id,
                                        child: Text(category.name),
                                      );
                                    },
                                  ).toList(),
                                  value: controller.selectedCategoryId,
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.selectedCategoryId = value;
                                      controller.update();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        CustomTextField(
                          label: "Desctription",
                          hint: 'Tell a litte about your food',
                          controller: controller.descriptionController,
                          maxLines: 3,
                          height: 120,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            if (controller.selectedRecipe == null) {
                              controller.createRecipe();
                            } else {
                              controller.updateRecipe();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 19),
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              color: Color(0xff1FCC79),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 37),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
