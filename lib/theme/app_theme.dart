import 'package:flutter/material.dart';

class AppColors {
  static const Color backgraundColor = Color(0xFF1B1B1B);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color errorColor = Colors.red;
  static const Color cardColor = Color.fromARGB(119, 45, 45, 45);
}

class AppTheme {
  static final darkTheme = ThemeData(
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.dark(),
    canvasColor: AppColors.backgraundColor,
    scaffoldBackgroundColor: AppColors.backgraundColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: AppColors.blackColor,
    ),
    dividerColor: AppColors.blackColor,
  );
}
