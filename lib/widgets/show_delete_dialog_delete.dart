import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showDeleteDialog({
  required BuildContext context,
  required VoidCallback onDelete,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Hapus Resep',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      content: Text(
        'Apakah kamu yakin ingin menghapus resep ini',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Batal',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            onDelete();
          },
          child: Text(
            'Hapus',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.red,
            ),
          ),
        ),
      ],
    ),
  );
}
