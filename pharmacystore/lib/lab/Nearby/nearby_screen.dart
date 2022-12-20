import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmacystore/lab/Screens/doctor_detail_screen.dart';
import 'package:pharmacystore/lab/Screens/lab_detailed_screen.dart';

import '../Doctor/Services/services.dart';
import '../Services/auth_services.dart';
import 'location_model.dart';
import 'location_services.dart';

class NearByScreen extends StatefulWidget {
  const NearByScreen({Key? key}) : super(key: key);

  @override
  _NearByScreenState createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  var mapType = MapType.normal;
  var myLat;
  var myLong;
  bool loader = true;
  Set<Marker> _markers = {};
  BitmapDescriptor? _mapMarker;
  GoogleMapController? _googleController;
  void setCustomMarker() async {
    // _mapMarker=await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/standing-up-man-.png');
    // _mapMarker=BitmapDescriptor.getBytesFromAsset('assets/images/flutter.png', 100);
  }
  void _onMapCreated(GoogleMapController controller) async {
    var random = Random();
    _googleController = controller;
    final data = await Services().getLabs();

    // final myData = await DatabaseServices().getMyLocation();
    // int id = random.nextInt(10);
    // String latitude = myData.get('Position')[0]['Latitude'];
    // double latD = double.parse(latitude);
    // String longitude = myData.get('Position')[0]['Longitude'];
    // double longD = double.parse(longitude);
    final Uint8List myMarkerIcon = await LocationServices()
        .getBytesFromAsset('assets/myLocatioLogo.png', 100);
    // setState(() {
    //   _markers.add(Marker(
    //     icon: BitmapDescriptor.fromBytes(myMarkerIcon),
    //     markerId: MarkerId(id.toString()),
    //     position: LatLng(latD, longD),
    //   ));
    // });
    var listOfLabs = data.docs;
    final doctor = await Services().getDoctors();

    var listOfDoctors = doctor.docs;
    for (var i = 0;
        _markers.length != listOfDoctors.length + listOfLabs.length;
        i++) {
      for (var doctor in listOfDoctors) {
        if (doctor.get('Position')[0]['Latitude'] != null) {
          // keep this somewhere in a static variable. Just make sure to initialize only once.
          int id = random.nextInt(10);
          print(id);
          String clinicName = doctor.get('clinicName');
          String clinicAddress = doctor.get('clinicAddress');
          String docName = doctor.get('docName');
          String phoneNumber = doctor.get('phoneNumber');
          // String docQualification = doctor.get('docQualification');
          String docterId = doctor.get('Doctor Id');
          String latitude = doctor.get('Position')[0]['Latitude'];
          double latD = double.parse(latitude);
          String longitude = doctor.get('Position')[0]['Longitude'];
          double longD = double.parse(longitude);
          dev.log(docterId.toString());
          dev.log(latD.toString());
          // dev.log(doctor.docs[0].get('Position')[0]['Latitude']);
          // dev.log(doctor.docs[0].get('Position')[0]['Longitude']);
          //
          final Uint8List markerIcon = await LocationServices()
              .getBytesFromAsset('assets/locationLogo.png', 100);
          setState(() {
            _markers.add(
              Marker(
                icon: BitmapDescriptor.fromBytes(markerIcon),
                markerId: MarkerId(id.toString()),
                position: LatLng(latD, longD),
                infoWindow: InfoWindow(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DoctorDetailedScreen(
                          labName: clinicName,
                          docName: docName,
                          address: clinicAddress,
                          docId: docterId,
                          phoneNumber: phoneNumber,
                        );
                      }));
                    },
                    title: docName,
                    snippet: phoneNumber),
              ),
            );
            log(_markers.length);
          });
        }
      }
      for (var lab in listOfLabs) {
        if (lab.get('Position').length != 0) {
          // keep this somewhere in a static variable. Just make sure to initialize only once.
          int id = random.nextInt(10);
          print(id);
          String name = lab.get('Lab Name');
          String doctorName = lab.get('Doctor');
          String address = lab.get('Address');
          String labId = lab.id;
          String number = lab.get('Phone Number');
          String latitude = lab.get('Position')[0]['Latitude'];
          double latD = double.parse(latitude);
          String longitude = lab.get('Position')[0]['Longitude'];
          double longD = double.parse(longitude);
          dev.log(labId);
          dev.log(latD.toString());

          //
          final Uint8List markerIcon = await LocationServices()
              .getBytesFromAsset('assets/locationLogo.png', 100);
          setState(() {
            _markers.add(Marker(
                icon: BitmapDescriptor.fromBytes(markerIcon),
                markerId: MarkerId(id.toString()),
                position: LatLng(latD, longD),
                infoWindow: InfoWindow(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LabDetailedScreen(
                          labName: name,
                          docName: doctorName,
                          address: address,
                          labId: labId,
                          phoneNumber: number,
                        );
                      }));
                    },
                    title: name,
                    snippet: number)));
          });
        }
      }
    }

    /**
    * Get Doctors
    */
  }

  storeLocationInDatabase() async {
    LocationModel model = await LocationServices().getCurrentLocation();
    myLat = model.latitude;
    myLong = model.longitude;
    setState(() {
      loader = false;
    });
    print(loader);
    List position = [];
    position.add({
      'Latitude': model.latitude.toString(),
      'Longitude': model.longitude.toString()
    });
    LocationServices().storeLocation(position, AuthServices().getUid());
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
    storeLocationInDatabase();
  }

  @override
  void dispose() {
    _googleController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loader
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: GoogleMap(
              mapType: mapType,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(myLat, myLong),
                zoom: 15,
              ),
              onMapCreated: _onMapCreated,
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: FloatingActionButton(
                      backgroundColor:
                          mapType == MapType.normal ? Colors.blue : Colors.red,
                      onPressed: () {
                        if (mapType == MapType.normal) {
                          setState(() {
                            mapType = MapType.hybrid;
                          });
                        } else {
                          setState(() {
                            mapType = MapType.normal;
                          });
                        }
                      },
                      child: Icon(
                        Icons.add_location_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      _googleController!
                          .animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(myLat, myLong),
                          zoom: 15,
                        ),
                      ));
                    },
                    child: Icon(
                      Icons.api_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
