import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dev_hive_test_task/features/users_list/widgets/user_list_item.dart';
import 'package:dev_hive_test_task/features/users_list/cubit/user_list_cubit.dart';
import 'package:dev_hive_test_task/widgets/custom_error_widget.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late final UserListCubit _userListCubit;

  @override
  void initState() {
    super.initState();
    _userListCubit = context.read<UserListCubit>();
    _userListCubit.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DevHive'),
      ),
      body: BlocBuilder<UserListCubit, UserListState>(
        builder: (context, state) {
          if (state is UserListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserListLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return UserListItem(
                    user: user,
                  );
                },
              ),
            );
          } else if (state is UserListError) {
            return CustomErrorWidget(
              errorMessage: state.message,
              onPressed: () {
                _userListCubit.getAllPosts();
              },
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
