import 'package:flutter/material.dart';

import 'package:dev_hive_test_task/features/post_comments/view/post_comments_screen.dart';
import 'package:dev_hive_test_task/repositories/posts/models/post_model.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          visualDensity: VisualDensity.comfortable,
          title: Text(
            post.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            post.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.comment_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PostCommentsScreen(
                    postId: post.id,
                  ),
                ),
              );
            },
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                surfaceTintColor: Theme.of(context).dialogBackgroundColor,
                title: Text(post.title),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(post.body),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          },
        ),
        Divider(
          color: Theme.of(context).dividerColor,
        ),
      ],
    );
  }
}
