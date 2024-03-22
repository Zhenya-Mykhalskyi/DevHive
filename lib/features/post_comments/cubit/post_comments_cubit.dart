import 'package:dev_hive_test_task/repositories/comments/comments_repository.dart';
import 'package:dev_hive_test_task/repositories/comments/models/comment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsCubit extends Cubit<List<CommentModel>> {
  final CommentsRepository _commentsRepository;

  CommentsCubit(this._commentsRepository) : super([]);

  Future<void> getCommentsByPostId(int postId) async {
    final comments = await _commentsRepository.getCommentsByPostId(postId);
    emit(comments);
  }
}
