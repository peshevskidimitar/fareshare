import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fareshare/domain/reservation.dart';

abstract class BaseReservationRepository {
  Stream<List<Reservation>> getAllReservationsByPostId(String postId);
  Future<DocumentReference?> addReservation(String postId, Reservation reservation);
}