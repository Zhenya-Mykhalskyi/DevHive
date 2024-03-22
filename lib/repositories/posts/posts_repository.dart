import 'package:dio/dio.dart';

import 'package:dev_hive_test_task/repositories/posts/models/post_model.dart';
import 'package:dev_hive_test_task/repositories/posts/abstract_posts_repository.dart';

class PostsRepository implements AbstractPostsRepository {
  PostsRepository({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<List<PostModel>> getPostsByUserId(int userId) async {
    try {
      final response = await dio
          .get('https://jsonplaceholder.typicode.com/posts?userId=$userId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to load posts by user id');
    }
  }

  @override
  Future<String> getUserNameById(int userId) async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/users/$userId');
      final Map<String, dynamic> userData = response.data;

      return userData['name'];
    } catch (error) {
      throw Exception('Failed to load user name');
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to load posts');
    }
  }
}
