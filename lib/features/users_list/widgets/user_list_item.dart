import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dev_hive_test_task/repositories/users/models/user_model.dart';
import 'package:dev_hive_test_task/features/user_posts/view/user_posts_screen.dart';
import 'package:dev_hive_test_task/features/users_list/cubit/user_list_cubit.dart';

class UserListItem extends StatelessWidget {
  final UserModel user;
  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          visualDensity: VisualDensity.comfortable,
          title: Text(
            '${user.name} (${user.username})',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => UserPostsScreen(userId: user.id),
              ),
              (route) => false,
            );
            final usersCubit = context.read<UsersCubit>();
            usersCubit.saveLastUserId(user.id);
          },
        ),
        Divider(
          color: Theme.of(context).dividerColor,
        ),
      ],
    );
  }
}
