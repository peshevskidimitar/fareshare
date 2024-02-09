import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fareshare/domain/reservation.dart';
import 'package:fareshare/repository/reservation/reservation_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reservation_event.dart';

part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository _reservationRepository;
  final Map<String, StreamSubscription> _streamSubscriptionsByPostId = {};

  ReservationBloc({required ReservationRepository reservationRepository})
      : _reservationRepository = reservationRepository,
        super(ReservationsLoading()) {
    on<LoadReservations>(_onLoadReservations);
    on<UpdateReservations>(_onUpdateReservations);
    on<AddReservation>(_onAddReservation);
  }

  FutureOr<void> _onLoadReservations(
      LoadReservations event, Emitter<ReservationState> emit) {
    _streamSubscriptionsByPostId[event.postId]?.cancel();
    _streamSubscriptionsByPostId[event.postId] = _reservationRepository
        .getAllReservationsByPostId(event.postId)
        .listen((reservations) {
      add(UpdateReservations(event.postId, reservations));
    });
  }

  FutureOr<void> _onUpdateReservations(
      UpdateReservations event, Emitter<ReservationState> emit) {
    emit(ReservationsLoaded(
      postId: event.postId,
      reservations: event.reservations,
    ));
  }

  FutureOr<void> _onAddReservation(
    AddReservation event,
    Emitter<ReservationState> emit,
  ) async {
    DocumentReference? docRef = await _reservationRepository.addReservation(
      event.postId,
      event.reservation,
    );
    if (docRef == null) {
     emit(AbortedReservation());
    } else {
      emit(AddedReservation());
    }
  }
}
