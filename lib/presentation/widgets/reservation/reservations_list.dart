import 'package:fareshare/domain/reservation.dart';
import 'package:fareshare/presentation/widgets/reservation/reservation_list_tile.dart';
import 'package:flutter/material.dart';

class ReservationsList extends StatefulWidget {
  final List<Reservation> reservations;

  const ReservationsList({super.key, required this.reservations});

  @override
  State<ReservationsList> createState() => _ReservationsListState();
}

class _ReservationsListState extends State<ReservationsList> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: widget.reservations.length,
            (BuildContext context, int index) {
          return ReservationListTile(reservation: widget.reservations[index]);
        },
      ),
    );
  }
}
