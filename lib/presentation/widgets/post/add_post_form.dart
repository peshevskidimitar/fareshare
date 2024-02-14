import 'dart:io';

import 'package:fareshare/presentation/widgets/image_picker/image_picker_widget.dart';
import 'package:fareshare/service/blocs/app/app_bloc.dart';
import 'package:fareshare/service/blocs/post/post_bloc.dart';
import 'package:fareshare/domain/post.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddPostForm extends StatefulWidget {
  const AddPostForm({super.key});

  @override
  State<AddPostForm> createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _departureCityController =
      TextEditingController();
  final TextEditingController _arrivalCityController = TextEditingController();
  final TextEditingController _departureTimeController =
      TextEditingController();
  DateTime _departureTime = DateTime.now();
  final TextEditingController _arrivalTimeController = TextEditingController();
  DateTime _arrivalTime = DateTime.now().add(const Duration(hours: 1));
  final TextEditingController _passengerSeatsController =
      TextEditingController();
  final TextEditingController _pricePerPassengerController =
      TextEditingController();
  XFile? image;

  void _setImage(XFile? image) {
    this.image = image;
  }

  Future<String?> _saveImage() async {
    String uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(image!.path));
      return await referenceImageToUpload.getDownloadURL();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<DateTime?> pickDate(DateTime dateTime) => showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(76, 44, 60, 1.0),
                surface: Color.fromRGBO(254, 246, 244, 1.0),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: dateTime,
      );

  Future<TimeOfDay?> pickTime(DateTime dateTime) => showTimePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(76, 44, 60, 1.0),
                surface: Color.fromRGBO(254, 246, 244, 1.0),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialTime: TimeOfDay(
          hour: dateTime.hour,
          minute: dateTime.minute,
        ),
      );

  Future<void> _pickDepartureTime() async {
    DateTime? date = await pickDate(_departureTime);
    if (date == null) return;
    TimeOfDay? time = await pickTime(_departureTime);
    if (time == null) return;
    DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      _departureTime = dateTime;
      _departureTimeController.text =
          DateFormat('kk:mm dd.MM.yy').format(dateTime);
    });
  }

  Future<void> _pickArrivalTime() async {
    DateTime? date = await pickDate(_arrivalTime);
    if (date == null) return;
    TimeOfDay? time = await pickTime(_arrivalTime);
    if (time == null) return;
    DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      _arrivalTime = dateTime;
      _arrivalTimeController.text =
          DateFormat('kk:mm dd.MM.yy').format(dateTime);
    });
  }

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) return;
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Изберете слика.'),
        ),
      );
      return;
    }
    Navigator.pop(context);
    final user = context.read<AppBloc>().state.user;
    context.read<PostBloc>().add(
          AddPost(
            Post(
              userId: user.id,
              departureCity: _departureCityController.text.trim(),
              arrivalCity: _arrivalCityController.text.trim(),
              departureTime: _departureTime,
              arrivalTime: _arrivalTime,
              passengerSeats: int.parse(_passengerSeatsController.text.trim()),
              pricePerPassenger:
                  double.parse(_pricePerPassengerController.text.trim()),
              vehicleImageUrl: (await _saveImage())!,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _departureCityController,
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
                  label: Text('Град на поаѓање'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Внесете град на поаѓање.';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _arrivalCityController,
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
                  label: Text('Град на пристигнување'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Внесете град на пристигнување.';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _departureTimeController,
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
                  label: const Text('Време на поаѓање'),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: _pickDepartureTime,
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ),
                readOnly: true,
                onChanged: (_) => _departureTimeController.text =
                    DateFormat('kk:mm dd.MM.yy').format(_departureTime),
                onTap: _pickDepartureTime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Внесете време на поаѓање.';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _arrivalTimeController,
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
                  label: const Text('Време на пристигнување'),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: _pickArrivalTime,
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ),
                readOnly: true,
                onChanged: (_) => _arrivalTimeController.text =
                    DateFormat('kk:mm dd.MM.yy').format(_arrivalTime),
                onTap: _pickArrivalTime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Внесете време на пристигнување.';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _passengerSeatsController,
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
                  label: Text('Број на слободни патнички места.'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Внесете број на слободни патнички места.';
                  }
                  int? parsedValue = int.tryParse(value.trim());
                  if (parsedValue == null || parsedValue <= 0) {
                    return 'Внесете позитивен цел број.';
                  }
                  return null;
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _pricePerPassengerController,
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
                  label: Text('Цена по патник'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Внесете цена по патник.';
                  }
                  double? parsedValue = double.tryParse(value.trim());
                  if (parsedValue == null || parsedValue <= 0) {
                    return 'Внесете позитивен реален број.';
                  }
                  return null;
                },
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: true,
                ),
              ),
            ),
            ImagePickerWidget(
              setImage: _setImage,
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
                  child: const Text('Зачувај'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
