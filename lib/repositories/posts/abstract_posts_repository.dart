import 'package:dev_hive_test_task/repositories/posts/models/post_model.dart';

abstract class AbstractPostsRepository {
  Future<List<PostModel>> getPostsByUserId(int userId);
  Future<String> getUserNameById(int userId);
}
