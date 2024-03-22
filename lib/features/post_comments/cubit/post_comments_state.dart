part of 'post_comments_cubit.dart';

abstract class PostCommentsState extends Equatable {
  const PostCommentsState();

  @override
  List<Object> get props => [];
}

class PostCommentsInitial extends PostCommentsState {
  @override
  List<Object> get props => [];
}

class PostCommentsLoading extends PostCommentsState {
  @override
  List<Object> get props => [];
}

class PostCommentsLoaded extends PostCommentsState {
  final List<CommentModel> comments;

  const PostCommentsLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}

class PostCommentsError extends PostCommentsState {
  final String message;

  const PostCommentsError(this.message);

  @override
  List<Object> get props => [message];
}
