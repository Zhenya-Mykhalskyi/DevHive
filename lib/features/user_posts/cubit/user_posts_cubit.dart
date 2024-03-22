import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dev_hive_test_task/repositories/posts/models/post_model.dart';
import 'package:dev_hive_test_task/repositories/posts/posts_repository.dart';

class PostsCubit extends Cubit<List<PostModel>> {
  PostsCubit(this._postRepository) : super([]);
  final PostsRepository _postRepository;

  String _userName = '';

  Future<void> getPostsAndNameByUserId(int userId) async {
    final posts = await _postRepository.getPostsByUserId(userId);
    _userName = await _postRepository.getUserNameById(userId);
    emit(posts);
  }

  Future<void> getAllPosts() async {
    final posts = await _postRepository.getAllPosts();
    emit(posts);
  }

  String get userName => _userName;
}
