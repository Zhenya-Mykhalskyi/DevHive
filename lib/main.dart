import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:dev_hive_test_task/features/post_comments/cubit/post_comments_cubit.dart';
import 'package:dev_hive_test_task/features/user_posts/cubit/user_posts_cubit.dart';
import 'package:dev_hive_test_task/features/user_posts/view/user_post_screen.dart';
import 'package:dev_hive_test_task/repositories/comments/comments_repository.dart';
import 'package:dev_hive_test_task/repositories/posts/posts_repository.dart';
import 'package:dev_hive_test_task/theme/app_theme.dart';

final talker = GetIt.instance;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  talker.registerSingleton<Dio>(Dio());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsCubit>(
          create: (_) => PostsCubit(PostsRepository(dio: talker<Dio>())),
        ),
        BlocProvider<CommentsCubit>(
            create: (_) =>
                CommentsCubit(CommentsRepository(dio: talker<Dio>()))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DevHive',
        theme: AppTheme.darkTheme,
        home: const UserPostsScreen(userId: 1),
      ),
    );
  }
}
