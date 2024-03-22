part of 'user_list_cubit.dart';

sealed class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {
  @override
  List<Object> get props => [];
}

class UserListLoading extends UserListState {
  @override
  List<Object> get props => [];
}

class UserListLoaded extends UserListState {
  final List<UserModel> users;
  const UserListLoaded(this.users);
  @override
  List<Object> get props => [users];
}

class UserListError extends UserListState {
  final String message;
  const UserListError(this.message);

  @override
  List<Object> get props => [message];
}
