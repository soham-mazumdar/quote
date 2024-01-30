import 'package:flutter/material.dart';
import 'package:quote/ui/theme/theme.dart';

extension AppSnackbar on BuildContext {
  show(
    String message,
    BuildContext? context,
  ) {
    ScaffoldMessenger.of(context ?? this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 100),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(10)),
            child: Text(message),
          ),
        ),
      );
  }
}
