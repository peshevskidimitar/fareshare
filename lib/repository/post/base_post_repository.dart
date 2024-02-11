import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fareshare/domain/post.dart';

abstract class BasePostRepository {
  Stream<List<Post>> getAllPosts();
  Stream<List<Post>> getAllPostsByUserId(String userId);
  Future<DocumentReference> addPost(Post post);
}