import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fareshare/domain/post.dart';
import 'package:fareshare/repository/post/base_post_repository.dart';

class PostRepository extends BasePostRepository {
  final FirebaseFirestore _firebaseFirestore;

  PostRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Post>> getAllPosts() {
    return _firebaseFirestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<Post>> getAllPostsByUserId(String userId) {
    return _firebaseFirestore
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<DocumentReference> addPost(Post post) {
    return _firebaseFirestore.collection('posts').add(post.toJson());
  }
}
