part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class LoadPosts extends PostEvent {}

class UpdatePosts extends PostEvent {
  final List<Post> posts;

  const UpdatePosts(this.posts);

  @override
  List<Object> get props => [posts];
}

class AddPost extends PostEvent {
  final Post post;

  const AddPost(this.post);

  @override
  List<Object> get props => [post];
}

class DeletePost extends PostEvent {
  final String postId;

  const DeletePost(this.postId);

  @override
  List<Object> get props => [postId];
}