part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object?> get props => [];
}

class LoadReservations extends ReservationEvent {
  final String postId;

  const LoadReservations(this.postId);

  @override
  List<Object?> get props => [postId];
}

class UpdateReservations extends ReservationEvent {
  final String postId;
  final List<Reservation> reservations;

  const UpdateReservations(this.postId, this.reservations);

  @override
  List<Object?> get props => [postId, reservations];
}

class AddReservation extends ReservationEvent {
  final String postId;
  final Reservation reservation;

  const AddReservation(this.postId, this.reservation);

  @override
  List<Object?> get props => [postId, reservation];
}