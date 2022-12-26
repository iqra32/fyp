import 'package:pharmacystore/view/models/user_model.dart';

import '../model/search_filter_model.dart';

class AppUser {
  static Users? data;
}

class Data {
  static const String ALL = "all",
      MEDICINES = "medicines",
      DOCTORS = "doctor",
      MEDICAL_STORE = "Pharmacist",
      LABORATORY = "lab",
      DISEASES = "diseases";
  int allListing = 0,
      isMedicine = 1,
      isDoctor = 2,
      isMedicalStore = 3,
      isLaboratory = 4,
      isDisease = 5;

  List<SearchFilterModel> searchFilters = [
    SearchFilterModel(
      title: "All",
      key: ALL,
    ),
    SearchFilterModel(
      title: "Medicines",
      key: MEDICINES,
    ),
    SearchFilterModel(
      title: "Diseases",
      key: DISEASES,
    ),
    SearchFilterModel(
      title: "Doctors",
      key: DOCTORS,
    ),
    SearchFilterModel(
      title: "Medical Stores",
      key: MEDICAL_STORE,
    ),
    SearchFilterModel(
      title: "Laboratory",
      key: LABORATORY,
    ),
  ];
}
