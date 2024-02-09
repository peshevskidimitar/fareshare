import 'package:fareshare/presentation/widgets//map/map_widget.dart';
import 'package:fareshare/service/blocs/reservation/reservation_bloc.dart';
import 'package:fareshare/domain/post.dart';
import 'package:fareshare/domain/reservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fareshare/service/location/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReservationForm extends StatefulWidget {
  final Post post;

  const ReservationForm({super.key, required this.post});

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  void _submitData() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ReservationBloc>().add(
          AddReservation(
            widget.post.id!,
            Reservation(
              fullName: _fullNameController.text.trim(),
              address: _addressController.text.trim(),
              phoneNumber: _phoneNumberController.text.trim(),
              location: _locationController.text.trim(),
            ),
          ),
        );
  }

  void _updateLocation(LatLng location) {
    _locationController.text = '${location.latitude}, ${location.longitude}';
  }

  _chooseLocation() {
    showDialog(
        context: context,
        builder: (context) => MapWidget(
              updateLocation: _updateLocation,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocListener<ReservationBloc, ReservationState>(
        listener: (BuildContext context, ReservationState state) {
          if (state is AddedReservation) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Успешна резервација.')),
            );
            context
                .read<ReservationBloc>()
                .add(LoadReservations(widget.post.id!));
            Navigator.pop(context);
          } else if (state is AbortedReservation) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Неуспешна резервација.')),
            );
            context
                .read<ReservationBloc>()
                .add(LoadReservations(widget.post.id!));
            Navigator.pop(context);
          }
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(74, 44, 60, 1.0),
                      width: 3.0,
                    ),
                  ),
                  labelStyle: TextStyle(color: Color.fromRGBO(74, 44, 60, 1.0)),
                  isDense: true,
                  border: OutlineInputBorder(),
                  label: Text('Име и презиме'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Внесете име и презиме.';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(74, 44, 60, 1.0),
                      width: 3.0,
                    ),
                  ),
                  labelStyle: TextStyle(color: Color.fromRGBO(74, 44, 60, 1.0)),
                  isDense: true,
                  border: OutlineInputBorder(),
                  label: Text('Адреса'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Внесете адреса.';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(74, 44, 60, 1.0),
                      width: 3.0,
                    ),
                  ),
                  labelStyle: TextStyle(color: Color.fromRGBO(74, 44, 60, 1.0)),
                  isDense: true,
                  border: OutlineInputBorder(),
                  label: Text('Телефонски број'),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Внесете телефонски број.';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(74, 44, 60, 1.0),
                      width: 3.0,
                    ),
                  ),
                  labelStyle:
                      const TextStyle(color: Color.fromRGBO(74, 44, 60, 1.0)),
                  isDense: true,
                  border: const OutlineInputBorder(),
                  label: const Text('Локација'),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () async {
                        await LocationService.isLocationEnabled();
                        _chooseLocation();
                      },
                      icon: const Icon(Icons.location_on),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Изберете локација.';
                  }
                  return null;
                },
                readOnly: true,
                onTap: () async {
                  await LocationService.isLocationEnabled();
                  _chooseLocation();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Назад',
                      style: TextStyle(color: Color.fromRGBO(72, 40, 61, 1.0)),
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: _submitData,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(72, 40, 61, 1.0),
                  ),
                  child: const Text('РЕЗЕРВИРАЈ'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
