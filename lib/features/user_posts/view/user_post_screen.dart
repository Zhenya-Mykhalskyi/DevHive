import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dev_hive_test_task/features/user_posts/cubit/user_posts_cubit.dart';
import 'package:dev_hive_test_task/features/user_posts/widgets/post_item.dart';

class UserPostsScreen extends StatefulWidget {
  final int userId;

  const UserPostsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  late final UserPostsCubit _postCubit;

  @override
  void initState() {
    super.initState();
    _postCubit = context.read<UserPostsCubit>();
    _postCubit.getPostsAndNameByUserId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<UserPostsCubit, PostsState>(
          builder: (context, state) {
            if (state is PostsLoaded && state.posts.isNotEmpty) {
              return Text(_postCubit.userName);
            } else {
              return const Text('User Posts');
            }
          },
        ),
      ),
      body: BlocBuilder<UserPostsCubit, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PostsLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return PostItem(post: post);
                },
              ),
            );
          } else if (state is PostsError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else {
            return const Center(
              child: Text('No posts available'),
            );
          }
        },
      ),
    );
  }
}
