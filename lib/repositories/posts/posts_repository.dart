import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:dev_hive_test_task/repositories/posts/models/post_model.dart';
import 'package:dev_hive_test_task/repositories/posts/abstract_posts_repository.dart';

class PostsRepository implements AbstractPostsRepository {
  PostsRepository({
    required this.dio,
    required this.userPostsBox,
    required this.userNameBox,
  });

  final Dio dio;
  final Box<PostModel> userPostsBox;
  final Box<String> userNameBox;

  @override
  Future<List<PostModel>> getPostsByUserId(int userId) async {
    var userPostsList = <PostModel>[];
    try {
      userPostsList = await _fetchUserPostsFromApi(userId);
      final userPostsMap = {for (var e in userPostsList) e.id: e};
      userPostsBox.clear();
      userPostsBox.putAll(userPostsMap);
    } catch (e) {
      userPostsList = userPostsBox.values.toList();
    }
    return userPostsList;
  }

  Future<List<PostModel>> _fetchUserPostsFromApi(int userId) async {
    final response = await dio
        .get('https://jsonplaceholder.typicode.com/posts?userId=$userId');

    final List<dynamic> data = response.data;
    return data.map((json) => PostModel.fromJson(json)).toList();
  }

  @override
  Future<String> getUserNameById(int userId) async {
    var userName = '';
    try {
      userName = await _fetchUserNameFromApi(userId);
      userNameBox.put('userName', userName);
    } catch (e) {
      userName = userNameBox.values.first;
    }
    return userName;
  }

  Future<dynamic> _fetchUserNameFromApi(int userId) async {
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/users/$userId');
    final Map<String, dynamic> userData = response.data;
    return userData['name'];
  }
}
