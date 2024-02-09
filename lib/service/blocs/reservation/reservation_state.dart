part of 'reservation_bloc.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object?> get props => [];
}

class ReservationsLoading extends ReservationState {}

class ReservationsLoaded extends ReservationState {
  final String postId;
  final List<Reservation> reservations;

  const ReservationsLoaded({required this.postId, this.reservations = const <Reservation>[]});

  @override
  List<Object?> get props => [postId, reservations];
}

class AddedReservation extends ReservationState {}

class AbortedReservation extends ReservationState {}