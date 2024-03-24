import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final List<dynamic> data = response.data;
      return data.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load all users: $e');
    }
  }

  Future<void> saveLastUserId(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('lastUserId', id);
    } catch (e) {
      throw Exception('Failed to save last user id: $e');
    }
  }

  Future<int?> getLastUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final lastUserId = prefs.getInt('lastUserId');
      return lastUserId ?? 1;
    } on Exception catch (e) {
      throw Exception('Failed to get last user id: $e');
    }
  }
}
