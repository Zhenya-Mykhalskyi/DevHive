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
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  surfaceTintColor: Theme.of(context).dialogBackgroundColor,
                  title: Text(
                    comment.email,
                    style: const TextStyle(fontSize: 15),
                  ),
                  content: SingleChildScrollView(
                    child: Text(comment.body),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        Divider(color: Theme.of(context).dividerColor),
      ],
    );
  }
}
