class AppointmentModel {
  final String name;
  final String fName;
  final String age;
  final String testType;
  final String labName;
  final String docName;
  final String time;
  final String address;
  final String gender;
  final String phoneNumber;
  final String doctorConsultation;
  final String uid;
  final String nodeId;
  AppointmentModel({
    required this.nodeId,
    required this.doctorConsultation,
    required this.uid,
    required this.labName,
    required this.phoneNumber,
    required this.address,
    required this.fName,
    required this.gender,
    required this.name,
    required this.age,
    required this.testType,
    required this.docName,
    required this.time,
  });
}
