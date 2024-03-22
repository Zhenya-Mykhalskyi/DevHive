import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:dev_hive_test_task/features/post_comments/cubit/post_comments_cubit.dart';
import 'package:dev_hive_test_task/features/user_posts/cubit/user_posts_cubit.dart';
import 'package:dev_hive_test_task/features/user_posts/view/user_post_screen.dart';
import 'package:dev_hive_test_task/features/users_list/cubit/user_list_cubit.dart';
import 'package:dev_hive_test_task/repositories/users/users_repository.dart';
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
        BlocProvider<UserPostsCubit>(
          create: (_) => UserPostsCubit(PostsRepository(dio: talker<Dio>())),
        ),
        BlocProvider<PostCommentsCubit>(
            create: (_) =>
                PostCommentsCubit(CommentsRepository(dio: talker<Dio>()))),
        BlocProvider<UserListCubit>(
            create: (_) => UserListCubit(UsersRepository(dio: talker<Dio>()))),
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
