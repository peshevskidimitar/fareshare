import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fareshare/domain/reservation.dart';
import 'package:fareshare/repository/reservation/base_reservation_repository.dart';

class ReservationRepository extends BaseReservationRepository {
  final FirebaseFirestore _firebaseFirestore;

  ReservationRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Reservation>> getAllReservationsByPostId(String postId) {
    return _firebaseFirestore
        .collection('posts')
        .doc(postId)
        .collection('reservations')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Reservation.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<DocumentReference?> addReservation(
      String postId, Reservation reservation) {
    final DocumentReference postDocRef =
        _firebaseFirestore.collection('posts').doc(postId);
    return _firebaseFirestore.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot = await transaction.get(postDocRef);
      int passengerSeats = documentSnapshot.get('passengerSeats');
      AggregateQuerySnapshot aggregateQuerySnapshot = await documentSnapshot
          .reference
          .collection('reservations')
          .count()
          .get();
      int reservedSeats = aggregateQuerySnapshot.count!;
      if (reservedSeats < passengerSeats) {
        return await documentSnapshot.reference
            .collection('reservations')
            .add(reservation.toJson());
      }
      return null;
    });
  }
}
