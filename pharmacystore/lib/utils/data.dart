import 'package:pharmacystore/view/models/user_model.dart';

import '../model/search_filter_model.dart';

class AppUser {
  static Users? data;
}

class Data {
  static const String ALL = "all",
      MEDICINES = "medicines",
      DOCTORS = "doctors",
      DISEASES = "diseases";
  int allListing = 0, isMedicine = 1, isDoctor = 2, isDisease = 3;

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
    // SearchFilterModel(
    //   title: "Doctors",
    //   key: DOCTORS,
    // ),
  ];
}
