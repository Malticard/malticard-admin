// To parse this JSON data, do
//
//     final staffModel = staffModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<StaffModel> staffModelFromJson(String str) =>
    List<StaffModel>.from(json.decode(str).map((x) => StaffModel.fromJson(x)));

String staffModelToJson(List<StaffModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffModel {
  StaffModel({
    required this.isComplete,
    required this.id,
    required this.staffSchool,
    required this.staffFname,
    required this.staffLname,
    required this.staffContact,
    required this.staffEmail,
    required this.staffRole,
    required this.staffGender,
    required this.staffProfilePic,
    required this.staffPassword,
    required this.createdAt,
    required this.updatedAt,
    required this.staffNo,
    required this.v,
  });

  final bool isComplete;
  final String id;
  final String staffSchool;
  final String staffFname;
  final String staffLname;
  final String staffContact;
  final String staffEmail;
  final String staffRole;
  final String staffGender;
  final String staffProfilePic;
  final String staffPassword;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int staffNo;
  final int v;

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
        isComplete: json["isComplete"],
        id: json["_id"],
        staffSchool: json["staff_school"],
        staffFname: json["staff_fname"],
        staffLname: json["staff_lname"],
        staffContact: json["staff_contact"].toString(),
        staffEmail: json["staff_email"],
        staffRole: json["staff_role"],
        staffGender: json["staff_gender"],
        staffProfilePic: json["staff_profilePic"],
        staffPassword: json["staff_password"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        staffNo: json["staff_no"] ?? 0,
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "isComplete": isComplete,
        "_id": id,
        "staff_school": staffSchool,
        "staff_fname": staffFname,
        "staff_lname": staffLname,
        "staff_contact": staffContact,
        "staff_email": staffEmail,
        "staff_role": staffRole,
        "staff_gender": staffGender,
        "staff_profilePic": staffProfilePic,
        "staff_password": staffPassword,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "staff_no": staffNo,
        "__v": v,
      };
}
