import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:dev_hive_test_task/repositories/users/models/user_model.dart';
import 'package:dev_hive_test_task/repositories/users/users_repository.dart';

part 'user_list_state.dart';

class UsersCubit extends Cubit<UserListState> {
  final UsersRepository _usersRepository;
  UsersCubit(this._usersRepository) : super(UserListInitial());

  Future<void> getAllUsers() async {
    try {
      emit(UserListLoading());
      final users = await _usersRepository.getAllUsers();
      emit(UserListLoaded(users));
    } catch (error) {
      emit(UserListError('Failed to fetch users: $error'));
    }
  }

  Future<void> saveLastUserId(int id) async {
    try {
      _usersRepository.saveLastUserId(id);
    } catch (error) {
      throw Exception('Failed to save last user id: $error');
    }
  }

  Future<int?> getLastUserId() async {
    try {
      final lastUserId = await _usersRepository.getLastUserId();
      return lastUserId;
    } catch (error) {
      throw Exception('Failed to get last user id: $error');
    }
  }
}
