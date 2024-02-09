import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fareshare/domain/post.dart';

abstract class BasePostRepository {
  Stream<List<Post>> getAllPosts();
  Future<DocumentReference> addPost(Post post);
}