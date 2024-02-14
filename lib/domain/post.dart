import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fareshare/domain/reservation.dart';

class Post extends Equatable {
  final String? id;
  final String userId;
  final String departureCity;
  final String arrivalCity;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int passengerSeats;
  final double pricePerPassenger;
  final String vehicleImageUrl;
  final List<Reservation>? reservations;

  const Post({
    this.id,
    required this.userId,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.passengerSeats,
    required this.pricePerPassenger,
    required this.vehicleImageUrl,
    this.reservations,
  });

  factory Post.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Post(
      id: snapshot.id,
      userId: snapshot.get('userId') as String,
      departureCity: snapshot.get('departureCity'),
      arrivalCity: snapshot.get('arrivalCity'),
      departureTime: snapshot.get('departureTime').toDate(),
      arrivalTime: snapshot.get('arrivalTime').toDate(),
      passengerSeats: snapshot.get('passengerSeats'),
      vehicleImageUrl: snapshot.get('vehicleImageUrl'),
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
      'vehicleImageUrl': vehicleImageUrl,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        departureCity,
        arrivalCity,
        departureTime,
        arrivalTime,
        passengerSeats,
        pricePerPassenger,
        vehicleImageUrl,
        reservations,
      ];
}
