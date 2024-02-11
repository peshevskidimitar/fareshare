import 'package:fareshare/presentation/pages/post/user_post_details_page.dart';
import 'package:fareshare/service/blocs/reservation/reservation_bloc.dart';
import 'package:fareshare/domain/post.dart';
import 'package:fareshare/presentation/pages/post/post_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UserPostListTile extends StatefulWidget {
  final Post post;

  const UserPostListTile({super.key, required this.post});

  @override
  State<UserPostListTile> createState() => _UserPostListTileState();
}

class _UserPostListTileState extends State<UserPostListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(224, 192, 195, 1.0),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 8, 0),
        title: Row(
          children: [
            Text(
              '${widget.post.departureCity} - ${widget.post.arrivalCity}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    child: Icon(Icons.calendar_today, size: 12),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd').format(widget.post.departureTime),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Icon(Icons.access_time_outlined, size: 14),
                ),
                Text(
                  DateFormat('kk:mm').format(widget.post.departureTime),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text(
                    '-',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  DateFormat('kk:mm').format(widget.post.arrivalTime),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 3.0),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(168, 133, 144, 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: BlocBuilder<ReservationBloc, ReservationState>(
                    builder: (BuildContext context, ReservationState state) {
                      return switch (state) {
                        ReservationsLoading() => const Text(
                            ' ',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(76, 44, 60, 1.0),
                            ),
                          ),
                        ReservationsLoaded() => Text(
                            '${widget.post.passengerSeats - state.reservations.length}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(76, 44, 60, 1.0),
                            ),
                          ),
                        _ => const Text('')
                      };
                    },
                  ),
                ),
                const Text(
                  'СЛОБОДНИ МЕСТА',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(168, 133, 144, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Text(
                '${widget.post.pricePerPassenger.toStringAsFixed(0)} МКД',
                style: const TextStyle(
                  color: Color.fromRGBO(76, 44, 60, 1.0),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 3.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return BlocProvider.value(
                          value: BlocProvider.of<ReservationBloc>(context),
                          child: UserPostDetailsPage(
                            post: widget.post,
                          ),
                        );
                      }),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    backgroundColor: const Color.fromRGBO(76, 44, 60, 1.0),
                  ),
                  child: const Text(
                    'ПРЕГЛЕДАЈ',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
