import 'package:flutter/material.dart';

import 'package:dev_hive_test_task/repositories/comments/models/comment_model.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          visualDensity: VisualDensity.comfortable,
          title: Text(
            comment.email,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            comment.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Divider(color: Theme.of(context).dividerColor),
      ],
    );
  }
}
