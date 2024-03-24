import 'package:flutter/material.dart';

import 'package:dev_hive_test_task/features/user_posts/view/user_posts_screen.dart';
import 'package:dev_hive_test_task/theme/app_theme.dart';

class DevHiveApp extends StatefulWidget {
  const DevHiveApp({super.key});

  @override
  State<DevHiveApp> createState() => _CryptoCurrenciesListAppState();
}

class _CryptoCurrenciesListAppState extends State<DevHiveApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DevHive',
      theme: AppTheme.darkTheme,
      home: const UserPostsScreen(),
    );
  }
}
