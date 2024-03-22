import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:dev_hive_test_task/repositories/users/models/user_model.dart';
import 'package:dev_hive_test_task/repositories/users/users_repository.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  final UsersRepository _usersRepository;
  UserListCubit(this._usersRepository) : super(UserListInitial());

  Future<void> getAllPosts() async {
    try {
      emit(UserListLoading());
      final users = await _usersRepository.getAllUsers();
      emit(UserListLoaded(users));
    } catch (error) {
      emit(UserListError('Failed to fetch posts: $error'));
    }
  }
}
