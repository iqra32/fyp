import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  FeedbackModel({
    this.userRef,
    this.rating,
    this.comment,
    this.reviewForRef,
    this.reviewedAt,
  });

  FeedbackModel.fromJson(dynamic json) {
    userRef = json['user_ref'];
    rating = json['rating'];
    comment = json['comment'];
    reviewForRef = json['review_for_ref'];
    reviewedAt = json['reviewed_at'];
  }
  DocumentReference? userRef;
  int? rating;
  String? comment;
  DocumentReference? reviewForRef;
  Timestamp? reviewedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_ref'] = userRef;
    map['rating'] = rating;
    map['comment'] = comment;
    map['review_for_ref'] = reviewForRef;
    map['reviewed_at'] = reviewedAt;
    return map;
  }
}
