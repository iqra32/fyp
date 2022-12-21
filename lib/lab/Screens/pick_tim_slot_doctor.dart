import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacystore/lab/Screens/doctor_appointment_screen.dart';
import 'package:pharmacystore/lab/Screens/form_screen.dart';

class PickTimeSlotForDoctorAppointment extends StatefulWidget {
  final String docId;
  const PickTimeSlotForDoctorAppointment({
    Key? key,
    required this.docId,
  }) : super(key: key);

  @override
  _PickTimeSlotForDoctorAppointmentState createState() =>
      _PickTimeSlotForDoctorAppointmentState();
}

class _PickTimeSlotForDoctorAppointmentState
    extends State<PickTimeSlotForDoctorAppointment> {
  List<String> times = [];
  void getTimeSlots() {
    DateTime now = DateTime.now();
    DateTime startTime = DateTime(now.year, now.month, now.day, 8, 0, 0);
    DateTime endTime = DateTime(now.year, now.month, now.day, 22, 0, 0);
    Duration step = Duration(minutes: 30);

    List<String> timeSlots = [];

    while (startTime.isBefore(endTime)) {
      DateTime timeIncrement = startTime.add(step);
      timeSlots.add(DateFormat('hh:mm a').format(timeIncrement));
      startTime = timeIncrement;
    }
    setState(() {
      times = timeSlots;
    });
  }

  @override
  initState() {
    getTimeSlots();
    super.initState();
  }

  int? selected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(31),
        child: Column(
          children: [
            Text(
              'Please Pick time for Appointment',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 21,
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 41,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              shrinkWrap: true,
              itemCount: times.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DoctorAppointmentScreen(
                          docId: widget.docId, appointmentTime: times[index]);
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text('${times[index]}'),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    ));
  }
}
