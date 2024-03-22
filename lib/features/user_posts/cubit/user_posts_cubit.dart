import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:dev_hive_test_task/repositories/posts/models/post_model.dart';
import 'package:dev_hive_test_task/repositories/posts/posts_repository.dart';

part 'user_posts_state.dart';

class UserPostsCubit extends Cubit<PostsState> {
  final PostsRepository _postRepository;

  UserPostsCubit(this._postRepository) : super(PostsInitial());

  String _userName = '';

  Future<void> getUserPostsAndNameById(int userId) async {
    try {
      emit(PostsLoading());
      final posts = await _postRepository.getPostsByUserId(userId);
      _userName = await _postRepository.getUserNameById(userId);

      emit(PostsLoaded(posts));
    } catch (error) {
      emit(PostsError('Failed to fetch posts: $error'));
    }
  }

  String get userName => _userName;
}
