import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dev_hive_test_task/features/post_comments/cubit/post_comments_cubit.dart';
import 'package:dev_hive_test_task/features/post_comments/widgets/comment_item.dart';

class PostCommentsScreen extends StatefulWidget {
  final int postId;

  const PostCommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostCommentsScreen> createState() => _PostCommentsScreenState();
}

class _PostCommentsScreenState extends State<PostCommentsScreen> {
  late final PostCommentsCubit _commentsCubit;

  @override
  void initState() {
    super.initState();
    _commentsCubit = context.read<PostCommentsCubit>();
    _commentsCubit.getCommentsByPostId(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<PostCommentsCubit, PostCommentsState>(
          builder: (context, state) {
            if (state is PostCommentsLoaded && state.comments.isNotEmpty) {
              return Text('Comments (${state.comments.length})');
            } else {
              return const Text('Comments');
            }
          },
        ),
      ),
      body: BlocBuilder<PostCommentsCubit, PostCommentsState>(
        builder: (context, state) {
          if (state is PostCommentsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PostCommentsLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: ListView.builder(
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  final comment = state.comments[index];
                  return CommentItem(comment: comment);
                },
              ),
            );
          } else if (state is PostCommentsError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else {
            return const Center(
              child: Text('No comments available'),
            );
          }
        },
      ),
    );
  }
}
