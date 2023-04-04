// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<StudentModel> studentModelFromJson(String str) => List<StudentModel>.from(json.decode(str).map((x) => StudentModel.fromJson(x)));

String studentModelToJson(List<StudentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentModel {
    StudentModel({
        required this.isComplete,
        required this.id,
        required this.studentFname,
        required this.studentLname,
        required this.studentContact,
        required this.studentEmail,
        required this.studentClass,
        required this.studentGender,
        required this.studentProfilePic,
        required this.createdAt,
        required this.updatedAt,
        required this.studentNo,
    });

    bool isComplete;
    String id;
    String studentFname;
    String studentLname;
    String studentContact;
    String studentEmail;
    String studentClass;
    String studentGender;
    String studentProfilePic;
    DateTime createdAt;
    DateTime updatedAt;
    int studentNo;

    factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        isComplete: json["isComplete"],
        id: json["_id"],
        studentFname: json["student_fname"],
        studentLname: json["student_lname"],
        studentContact: json["student_contact"].toString(),
        studentEmail: json["student_email"] ?? "",
        studentClass: json["student_class"],
        studentGender: json["student_gender"],
        studentProfilePic: json["student_profile_pic"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        studentNo: json["student_no"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "isComplete": isComplete,
        "_id": id,
        "student_fname": studentFname,
        "student_lname": studentLname,
        "student_contact": studentContact,
        "student_email": studentEmail,
        "student_class": studentClass,
        "student_gender": studentGender,
        "student_profile_pic": studentProfilePic,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "student_no": studentNo,
    };
}
