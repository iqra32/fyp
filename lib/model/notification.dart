import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  NotificationModel({
    this.sentby,
    this.sentFor,
    this.isRead,
    this.title,
    this.description,
    this.timestamp,
    this.medId,
    this.type,
    this.deliveryStatus,
    this.location,
  });

  NotificationModel.fromJson(dynamic json) {
    sentby = json['sentby'];
    sentFor = json['sentFor'];
    isRead = json['isRead'];
    title = json['title'];
    description = json['description'];
    timestamp = json['timestamp'];
    medId = json['medId'];
    type = json['type'];
    deliveryStatus = json['deliveryStatus'];
    location = json['location'];
  }
  String? sentby;
  String? sentFor;
  bool? isRead;
  String? title;
  String? description;
  Timestamp? timestamp;
  String? medId;
  String? type;
  String? deliveryStatus;
  GeoPoint? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sentby'] = sentby;
    map['sentFor'] = sentFor;
    map['isRead'] = isRead;
    map['title'] = title;
    map['description'] = description;
    map['timestamp'] = timestamp;
    map['deliveryStatus'] = deliveryStatus;
    map['type'] = type;
    map['medId'] = medId;
    return map;
  }
}
