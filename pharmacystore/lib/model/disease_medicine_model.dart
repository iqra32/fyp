import 'dart:convert';

import '../view/models/user_model.dart';

DiseaseMedicinesUsers diseaseAndMedicinesFromJson(String str) =>
    DiseaseMedicinesUsers.fromJson(json.decode(str));

String diseaseAndMedicinesToJson(DiseaseMedicinesUsers data) =>
    json.encode(data.toJson());

// Title, description, id, addedBy parameters will be present in both medicines and diseases
// IsMedicine, IsDisease parameters will help in deciding best UI for app side logic
// imageurl, price, medications are optional as:
// imageurl and price are parameters of medicine
// medications is parameter of disease

class DiseaseMedicinesUsers {
  DiseaseMedicinesUsers({
    this.id,
    this.title,
    this.description,
    this.addedBy,
    required this.isMedicine,
    required this.isDisease,
    this.isUser, // is user true when showing results from users collection and also this take user model parameter
    this.user,
    this.imageurl,
    this.price,
    this.medications,
  });

  String? id;
  String? title;
  String? description;
  String? addedBy;
  String? imageurl;
  String? price;
  bool isMedicine;
  bool isDisease;
  bool? isUser;
  Users? user;
  List<String>? medications;

  factory DiseaseMedicinesUsers.fromJson(Map<String, dynamic> json) =>
      DiseaseMedicinesUsers(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        addedBy: json["addedBy"],
        isMedicine: json["is_medicine"],
        isDisease: json["is_disease"],
        isUser: json["is_user"],
        user: json["user"],
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
        "is_user": isUser,
        "user": user,
        "imageurl": imageurl,
        "price": price,
        "medications": medications == null
            ? null
            : List<dynamic>.from(medications!.map((x) => x)),
      };
}
