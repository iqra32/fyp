import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class GoogleMapForPharmacy extends StatefulWidget {
  final LatLng pharmacyLocation;

  const GoogleMapForPharmacy({Key? key, required this.pharmacyLocation})
      : super(key: key);

  @override
  State<GoogleMapForPharmacy> createState() => _GoogleMapForPharmacyState();
}

class _GoogleMapForPharmacyState extends State<GoogleMapForPharmacy> {
  final Set<Marker> _markers = {};
  _init() {
    setState(() {
      _markers.add(Marker(
          markerId: const MarkerId("id.toString()"),
          position: widget.pharmacyLocation,
          infoWindow: const InfoWindow(
            title: "Pharmacy",
          )));
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          mapType: MapType.terrain,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: widget.pharmacyLocation,
            zoom: 10,
          ),
          onTap: (v) {
            MapsLauncher.launchCoordinates(widget.pharmacyLocation.latitude,
                widget.pharmacyLocation.longitude);
          },
        ),
      ),
    );
  }
}
