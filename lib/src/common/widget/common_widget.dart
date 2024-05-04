import 'package:flutter/material.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';

void showCustomSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.horizontal,
        // margin: const EdgeInsets.all(8),
        duration: const Duration(seconds: 2),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.fixed,

        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          message,
          style: const TextStyle(fontSize: 15, color: AppColors.primaryWhite),
        ),
      ),
    );
  }
}
