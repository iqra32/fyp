import 'dart:convert';

DiseaseAndMedicines diseaseAndMedicinesFromJson(String str) =>
    DiseaseAndMedicines.fromJson(json.decode(str));

String diseaseAndMedicinesToJson(DiseaseAndMedicines data) =>
    json.encode(data.toJson());

// Title, description, id, addedBy parameters will be present in both medicines and diseases
// IsMedicine, IsDisease parameters will help in deciding best UI for app side logic
// imageurl, price, medications are optional as:
// imageurl and price are parameters of medicine
// medications is parameter of disease

class DiseaseAndMedicines {
  DiseaseAndMedicines({
    required this.id,
    required this.title,
    required this.description,
    required this.addedBy,
    required this.isMedicine,
    required this.isDisease,
    this.imageurl,
    this.price,
    this.medications,
  });

  int id;
  String title;
  String description;
  String addedBy;
  String? imageurl;
  String? price;
  bool isMedicine;
  bool isDisease;
  List<String>? medications;

  factory DiseaseAndMedicines.fromJson(Map<String, dynamic> json) =>
      DiseaseAndMedicines(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        addedBy: json["addedBy"],
        isMedicine: json["is_medicine"],
        isDisease: json["is_disease"],
        imageurl: json["imageurl"],
        price: json["price"],
        medications: json["medications"] == null
            ? null
            : List<String>.from(json["medications"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "addedBy": addedBy,
        "is_medicine": isMedicine,
        "is_disease": isDisease,
        "imageurl": imageurl,
        "price": price,
        "medications": medications == null
            ? null
            : List<dynamic>.from(medications!.map((x) => x)),
      };
}
