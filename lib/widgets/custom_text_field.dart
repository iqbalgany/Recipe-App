import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final double height;
  final EdgeInsetsGeometry contentPadding;
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.contentPadding,
    required this.controller,
    this.maxLines = 1,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Color(0xff3E5481),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Color(0xffD0DBEA),
            ),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xff9FA5C0),
              ),
              border: InputBorder.none,
              contentPadding: contentPadding,
            ),
          ),
        ),
      ],
    );
  }
}
