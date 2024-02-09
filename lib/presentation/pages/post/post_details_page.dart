import 'package:fareshare/domain/post.dart';
import 'package:fareshare/presentation/widgets/reservation/reservation_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDetailsPage extends StatefulWidget {
  final Post post;

  const PostDetailsPage({super.key, required this.post});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(164, 139, 156, 1.0),
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12.0))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              'МЕЃУГРАДСКИ ПАТЕН ПРЕВОЗ',
                              style: TextStyle(
                                color: Color.fromRGBO(29, 27, 32, 1.0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Град на поаѓање: ${widget.post.departureCity}',
                            style: const TextStyle(
                                color: Color.fromRGBO(76, 44, 60, 1.0)),
                          ),
                          Text(
                            'Град на пристигнување: ${widget.post.arrivalCity}',
                            style: const TextStyle(
                                color: Color.fromRGBO(76, 44, 60, 1.0)),
                          ),
                          Text(
                            'Време на поаѓање: ${DateFormat("kk:mm dd.MM.yy").format(widget.post.departureTime)}',
                            style: const TextStyle(
                                color: Color.fromRGBO(76, 44, 60, 1.0)),
                          ),
                          Text(
                            'Време на пристигнување: ${DateFormat("kk:mm dd.MM.yy").format(widget.post.arrivalTime)}',
                            style: const TextStyle(
                                color: Color.fromRGBO(76, 44, 60, 1.0)),
                          ),
                          Text(
                            'Слободни патнички места: ${widget.post.passengerSeats}',
                            style: const TextStyle(
                                color: Color.fromRGBO(76, 44, 60, 1.0)),
                          ),
                          Text(
                            'Цена по патник: ${widget.post.pricePerPassenger.toStringAsFixed(0)} МКД',
                            style: const TextStyle(
                                color: Color.fromRGBO(76, 44, 60, 1.0)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReservationForm(post: widget.post),
              ),
            ],
          ),
        ));
  }
}
