import 'package:dev_hive_test_task/repositories/comments/models/comment_model.dart';

abstract class AbstractCommentsRepository {
  Future<List<CommentModel>> getCommentsByPostId(int postId);
}
