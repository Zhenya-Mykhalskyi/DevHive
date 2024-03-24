import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:dev_hive_test_task/features/post_comments/cubit/post_comments_cubit.dart';
import 'package:dev_hive_test_task/features/user_posts/cubit/user_posts_cubit.dart';
import 'package:dev_hive_test_task/features/user_posts/view/user_posts_screen.dart';
import 'package:dev_hive_test_task/features/users_list/cubit/user_list_cubit.dart';
import 'package:dev_hive_test_task/repositories/users/users_repository.dart';
import 'package:dev_hive_test_task/repositories/comments/comments_repository.dart';
import 'package:dev_hive_test_task/repositories/posts/posts_repository.dart';
import 'package:dev_hive_test_task/repositories/posts/models/post_model.dart';
import 'package:dev_hive_test_task/theme/app_theme.dart';

final talker = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  talker.registerSingleton<Dio>(Dio());

  await Hive.initFlutter();
  Hive.registerAdapter(PostModelAdapter());

  final userPostsBox = await Hive.openBox<PostModel>('user_posts_box');
  final userNameBox = await Hive.openBox<String>('user_name_box');

  talker.registerSingleton<Box<PostModel>>(userPostsBox);
  talker.registerSingleton<Box<String>>(userNameBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserPostsCubit>(
          create: (_) => UserPostsCubit(
            PostsRepository(
              dio: talker<Dio>(),
              userPostsBox: talker<Box<PostModel>>(),
              userNameBox: talker<Box<String>>(),
            ),
          ),
        ),
        BlocProvider<PostCommentsCubit>(
          create: (_) => PostCommentsCubit(
            CommentsRepository(
              dio: talker<Dio>(),
            ),
          ),
        ),
        BlocProvider<UsersCubit>(
          create: (_) => UsersCubit(
            UsersRepository(
              dio: talker<Dio>(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DevHive',
        theme: AppTheme.darkTheme,
        home: const UserPostsScreen(),
      ),
    );
  }
}
