import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final String? id;
  final String fullName;
  final String address;
  final String phoneNumber;
  final String location;

  const Reservation({
    this.id,
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    required this.location
  });

  factory Reservation.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Reservation(
      id: snapshot.id,
      fullName: snapshot.get('fullName') as String,
      address: snapshot.get('address') as String,
      phoneNumber: snapshot.get('phoneNumber') as String,
      location: snapshot.get('location') as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'address': address,
      'phoneNumber': phoneNumber,
      'location': location,
    };
  }

  @override
  List<Object?> get props => [
    id,
    fullName,
    address,
    phoneNumber,
    location,
  ];
}
