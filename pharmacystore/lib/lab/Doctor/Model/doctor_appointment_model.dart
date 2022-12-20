class DoctorAppointmentModel {
  final String name;
  final String fName;
  final String age;
  final String doctorId;
  final String time;
  // final String address;
  final String gender;
  final String phoneNumber;
  final String doctorConsultation;
  final String uid;
  // final String nodeId;
  DoctorAppointmentModel({
    // required this.nodeId,
    required this.doctorConsultation,
    required this.uid,
    required this.doctorId,
    required this.phoneNumber,
    // required this.address,
    required this.fName,
    required this.gender,
    required this.name,
    required this.age,
    required this.time,
  });
}
