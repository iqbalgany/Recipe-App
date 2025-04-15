import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/recipe_controller.dart';
import 'package:recipe_app/widgets/custom_text_field.dart';

class ItemFormScreen extends StatelessWidget {
  ItemFormScreen({super.key});

  final RecipeController controller = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: 90),
                    GestureDetector(
                        onTap: controller.pickImage,
                        child: Obx(
                          () {
                            final image = controller.imageFile.value;
                            return Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Color(0xffD0DBEA),
                                ),
                                image: image != null
                                    ? DecorationImage(
                                        image: FileImage(image),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: image == null
                                  ? Column(
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
                                    )
                                  : null,
                            );
                          },
                        )),
                    SizedBox(height: 24),
                    CustomTextField(
                        label: 'Food Name',
                        hint: 'Enter food name',
                        controller: controller.titleController),
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
                            child: DropdownButton(
                              isExpanded: true,
                              items: controller.categories.map(
                                (category) {
                                  return DropdownMenuItem<int>(
                                    value: category.id,
                                    child: Text(category.name),
                                  );
                                },
                              ).toList(),
                              value: controller.selectedCategoryId.value,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectedCategoryId.value = value;
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
                      height: 80,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: controller.createRecipe,
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
              );
      }),
    );
  }
}
