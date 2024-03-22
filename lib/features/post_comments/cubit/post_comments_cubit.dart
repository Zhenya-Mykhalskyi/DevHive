import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:dev_hive_test_task/repositories/comments/comments_repository.dart';
import 'package:dev_hive_test_task/repositories/comments/models/comment_model.dart';

part 'post_comments_state.dart';

class PostCommentsCubit extends Cubit<PostCommentsState> {
  final CommentsRepository _commentsRepository;

  PostCommentsCubit(this._commentsRepository) : super(PostCommentsInitial());

  Future<void> getCommentsByPostId(int postId) async {
    try {
      emit(PostCommentsLoading());
      final comments = await _commentsRepository.getCommentsByPostId(postId);
      emit(PostCommentsLoaded(comments));
    } catch (e) {
      emit(PostCommentsError('Failed to load comments: $e'));
    }
  }
}
