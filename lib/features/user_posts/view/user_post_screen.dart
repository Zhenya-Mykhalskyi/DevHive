import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dev_hive_test_task/features/user_posts/cubit/user_posts_cubit.dart';
import 'package:dev_hive_test_task/features/user_posts/widgets/post_item.dart';
import 'package:dev_hive_test_task/repositories/posts/models/post_model.dart';

class UserPostsScreen extends StatefulWidget {
  final int userId;

  const UserPostsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  late final PostsCubit _postCubit;

  @override
  void initState() {
    super.initState();
    _postCubit = context.read<PostsCubit>();
    _postCubit.getPostsAndNameByUserId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<PostsCubit, List<PostModel>>(
          builder: (context, state) {
            if (state.isNotEmpty) {
              return Text(_postCubit.userName);
            } else {
              return const Text('User Posts');
            }
          },
        ),
      ),
      body: BlocBuilder<PostsCubit, List<PostModel>>(
        builder: (context, postList) {
          return postList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      final post = postList[index];
                      return PostItem(post: post);
                    },
                  ),
                );
        },
      ),
    );
  }
}
