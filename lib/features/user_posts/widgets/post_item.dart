import 'package:dev_hive_test_task/features/post_comments/view/post_comments_screen.dart';
import 'package:dev_hive_test_task/repositories/posts/models/post_model.dart';
import 'package:flutter/material.dart';

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
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PostCommentsScreen(postId: post.id),
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
