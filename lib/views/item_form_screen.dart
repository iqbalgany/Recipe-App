import 'package:flutter/material.dart';

class ItemFormScreen extends StatelessWidget {
  const ItemFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 115),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 161,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Color(0xffD0DBEA),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 22.33),
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
                ),
              ),
            ),
            SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Food Name',
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
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter food name',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff9FA5C0),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 24),
                    ),
                  ),
                ),
              ],
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
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Choose the category',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff9FA5C0),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 24),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color(0xff3E5481),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xffD0DBEA),
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Tell a little about your food',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff9FA5C0),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 24)),
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
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
            SizedBox(height: 37),
          ],
        ),
      ),
    );
  }
}
