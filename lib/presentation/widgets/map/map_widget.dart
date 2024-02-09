import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final void Function(LatLng location) updateLocation;

  const MapWidget({super.key, required this.updateLocation});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Map<String, Marker> _markers = {};
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(41.62132110887857, 21.75284758067768),
    zoom: 7.5,
  );
  GoogleMapController? _mapController;
  LatLng? _location;

  _pinLocation(LatLng location) {
    setState(() {
      _markers.clear();
      Marker marker = Marker(
        markerId: const MarkerId('location'),
        position: location,
      );
      _markers['location'] = marker;
      _location = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 128.0),
        child: Stack(
          children: [
            Container(
              color: const Color.fromRGBO(254, 246, 244, 1.0),
            ),
            GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController mapController) {
                _mapController = mapController;
              },
              onTap: _pinLocation,
              zoomGesturesEnabled: false,
              markers: _markers.values.toSet(),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Откажи',
                          style:
                              TextStyle(color: Color.fromRGBO(72, 40, 61, 1.0)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: FilledButton(
                        onPressed: () {
                          if (_location != null) {
                            widget.updateLocation(_location!);
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Изберете локација.')),
                            );
                          }
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(72, 40, 61, 1.0),
                        ),
                        child: const Text('Зачувај'),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
