import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fareshare/domain/reservation.dart';

class Post {
  final String? id;
  final String userId;
  final String departureCity;
  final String arrivalCity;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int passengerSeats;
  final double pricePerPassenger;
  final List<Reservation>? reservations;

  Post({
    this.id,
    required this.userId,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.passengerSeats,
    required this.pricePerPassenger,
    this.reservations,
  });

  factory Post.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Post(
      id: snapshot.id,
      userId: snapshot.get('userId'),
      departureCity: snapshot.get('departureCity'),
      arrivalCity: snapshot.get('arrivalCity'),
      departureTime: snapshot.get('departureTime').toDate(),
      arrivalTime: snapshot.get('arrivalTime').toDate(),
      passengerSeats: snapshot.get('passengerSeats'),
      pricePerPassenger: snapshot.get('pricePerPassenger').toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'departureCity': departureCity,
      'arrivalCity': arrivalCity,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'passengerSeats': passengerSeats,
      'pricePerPassenger': pricePerPassenger,
    };
  }
}
