import 'package:dev_hive_test_task/repositories/users/models/user_model.dart';

abstract class AbstractUsersRepository {
  Future<List<UserModel>> getAllUsers();
}
