import 'package:dev_hive_test_task/repositories/comments/abstract_comments_repository.dart';
import 'package:dio/dio.dart';

import 'package:dev_hive_test_task/repositories/comments/models/comment_model.dart';

class CommentsRepository implements AbstractCommentsRepository {
  final Dio dio;

  CommentsRepository({required this.dio});

  @override
  Future<List<CommentModel>> getCommentsByPostId(int postId) async {
    try {
      final response = await dio
          .get('https://jsonplaceholder.typicode.com/comments?postId=$postId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CommentModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception('Failed to load comments');
    }
  }
}
