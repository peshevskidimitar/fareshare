import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:fareshare/domain/post.dart';
import 'package:fareshare/repository/post/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_state.dart';

part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  StreamSubscription? _postSubscription;

  PostBloc({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostsLoading()) {
    on<LoadPosts>(_onLoadPosts);
    on<UpdatePosts>(_onUpdatePosts);
    on<AddPost>(_onAddPost);
  }

  FutureOr<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    _postSubscription?.cancel();
    _postSubscription = _postRepository.getAllPosts().listen((posts) {
      add(UpdatePosts(posts));
    });
  }

  FutureOr<void> _onUpdatePosts(
      UpdatePosts event, Emitter<PostState> emit) async {
    emit(PostsLoaded(posts: event.posts));
  }

  FutureOr<void> _onAddPost(AddPost event, Emitter<PostState> emit) {
    _postRepository.addPost(event.post);
    add(LoadPosts());
  }
}
