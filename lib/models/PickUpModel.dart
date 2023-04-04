
// To parse this JSON data, do
//
//     final pickUpModel = pickUpModelFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<PickUpModel> pickUpModelFromJson(String str) => List<PickUpModel>.from(json.decode(str).map((x) => PickUpModel.fromJson(x)));

String pickUpModelToJson(List<PickUpModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PickUpModel {
  PickUpModel({
    required this.id,
    required this.schoolName,
    required this.studentName,
    required this.pickUpTime,
    required this.pickedBy,
    required this.authorizedBy,
    required this.comments,
    required this.pickupKey,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String schoolName;
  final String? studentName;
  final String pickUpTime;
  final String pickedBy;
  final String authorizedBy;
  final String comments;
  final List<dynamic> pickupKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory PickUpModel.fromJson(Map<String, dynamic> json) => PickUpModel(
    id: json["_id"],
    schoolName: json["school_name"],
    studentName: json["student_name"].toString(),
    pickUpTime: json["pick_up_time"],
    pickedBy: json["picked_by"] ?? "",
    authorizedBy: json["authorized_by"] ?? "",
    comments: json["comments"],
    pickupKey: List<dynamic>.from(json["pickup_key"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "school_name": schoolName,
    "student_name": studentName,
    "pick_up_time": pickUpTime,
    "picked_by": pickedBy,
    "authorized_by": authorizedBy,
    "comments": comments,
    "pickup_key": List<dynamic>.from(pickupKey.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
