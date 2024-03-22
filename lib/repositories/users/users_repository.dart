import 'package:dio/dio.dart';

import 'package:dev_hive_test_task/repositories/users/abstract_users_repository.dart';
import 'package:dev_hive_test_task/repositories/users/models/user_model.dart';

class UsersRepository implements AbstractUsersRepository {
  UsersRepository({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to load posts');
    }
  }
}
