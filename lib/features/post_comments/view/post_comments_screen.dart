import 'package:dev_hive_test_task/features/post_comments/cubit/post_comments_cubit.dart';
import 'package:dev_hive_test_task/features/post_comments/widgets/comment_item.dart';
import 'package:dev_hive_test_task/repositories/comments/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCommentsScreen extends StatefulWidget {
  final int postId;

  const PostCommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostCommentsScreen> createState() => _PostCommentsScreenState();
}

class _PostCommentsScreenState extends State<PostCommentsScreen> {
  late final CommentsCubit _commentsCubit;

  @override
  void initState() {
    super.initState();
    _commentsCubit = context.read<CommentsCubit>();
    _commentsCubit.getCommentsByPostId(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CommentsCubit, List<CommentModel>>(
          builder: (context, state) {
            return Text('Comments (${state.length})');
          },
        ),
      ),
      body: BlocBuilder<CommentsCubit, List<CommentModel>>(
        builder: (context, commentsList) {
          return commentsList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: ListView.builder(
                    itemCount: commentsList.length,
                    itemBuilder: (context, index) {
                      final comment = commentsList[index];
                      return CommentItem(comment: comment);
                    },
                  ),
                );
        },
      ),
    );
  }
}
