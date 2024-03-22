part of 'user_posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsLoading extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsLoaded extends PostsState {
  final List<PostModel> posts;

  const PostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostsError extends PostsState {
  final String message;

  const PostsError(this.message);

  @override
  List<Object> get props => [message];
}
