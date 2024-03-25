import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dev_hive_test_task/features/user_posts/cubit/user_posts_cubit.dart';
import 'package:dev_hive_test_task/features/user_posts/widgets/post_item.dart';
import 'package:dev_hive_test_task/features/users_list/view/user_list_screen.dart';
import 'package:dev_hive_test_task/widgets/custom_error_widget.dart';
import 'package:dev_hive_test_task/features/users_list/cubit/user_list_cubit.dart';

class UserPostsScreen extends StatefulWidget {
  final int? userId;

  const UserPostsScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  late final UserPostsCubit _postCubit;
  late final UsersCubit _usersCubit;
  int _lastUserId = 1;

  @override
  void initState() {
    super.initState();
    _postCubit = context.read<UserPostsCubit>();
    _usersCubit = context.read<UsersCubit>();

    _fetchUserPostsAndName();
  }

  Future<void> _fetchUserPostsAndName() async {
    try {
      _lastUserId = widget.userId ?? (await _usersCubit.getLastUserId())!;
      _postCubit.getUserPostsAndNameById(_lastUserId);
    } catch (e) {
      throw Exception('Failed to fetch last user posts and name: $e');
    }
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
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/userIcon.png',
              width: 20,
              height: 20,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UsersListScreen()));
            },
          ),
        ],
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
              child: CustomErrorWidget(
                errorMessage: state.message,
                onPressed: () {
                  _postCubit.getUserPostsAndNameById(_lastUserId);
                },
              ),
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
