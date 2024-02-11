import 'package:fareshare/domain/reservation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReservationListTile extends StatefulWidget {
  final Reservation reservation;

  const ReservationListTile({super.key, required this.reservation});

  @override
  State<ReservationListTile> createState() => _ReservationListTileState();
}

class _ReservationListTileState extends State<ReservationListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Име и презиме: ${widget.reservation.fullName}',
              style: const TextStyle(color: Color.fromRGBO(76, 44, 60, 1.0)),
            ),
            Text(
              'Адреса: ${widget.reservation.address}',
              style: const TextStyle(color: Color.fromRGBO(76, 44, 60, 1.0)),
            ),
            Text(
              'Телефонски број: ${widget.reservation.phoneNumber}',
              style: const TextStyle(color: Color.fromRGBO(76, 44, 60, 1.0)),
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    double.parse(widget.reservation.location.split(', ')[0]),
                    double.parse(widget.reservation.location.split(', ')[1]),
                  ),
                  zoom: 15,
                ),
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                zoomGesturesEnabled: false,
                markers: {
                  Marker(
                    markerId: const MarkerId('location'),
                    position: LatLng(
                      double.parse(widget.reservation.location.split(', ')[0]),
                      double.parse(widget.reservation.location.split(', ')[1]),
                    ),
                  )
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
