// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<StudentModel> studentModelFromJson(String str) => List<StudentModel>.from(json.decode(str).map((x) => StudentModel.fromJson(x)));

String studentModelToJson(List<StudentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentModel {
    StudentModel({
        required this.id,
        required this.school,
        required this.studentModelClass,
        required this.stream,
        required this.guardians,
        required this.studentFname,
        required this.studentLname,
        required this.otherName,
        required this.username,
        required this.studentGender,
        required this.studentProfilePic,
        required this.studentKey,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final String school;
    final String studentModelClass;
    final String stream;
    final List<dynamic> guardians;
    final String studentFname;
    final String studentLname;
    final String otherName;
    final String username;
    final String studentGender;
    final String studentProfilePic;
    final List<StudentKey> studentKey;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        id: json["_id"],
        school: json["school"],
        studentModelClass: json["_class"],
        stream: json["stream"],
        guardians: List<dynamic>.from(json["guardians"].map((x) => x)),
        studentFname: json["student_fname"],
        studentLname: json["student_lname"],
        otherName: json["other_name"],
        username: json["username"],
        studentGender: json["student_gender"],
        studentProfilePic: json["student_profile_pic"],
        studentKey: List<StudentKey>.from(json["student_key"].map((x) => StudentKey.fromJson(x))),
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school": school,
        "_class": studentModelClass,
        "stream": stream,
        "guardians": List<dynamic>.from(guardians.map((x) => x)),
        "student_fname": studentFname,
        "student_lname": studentLname,
        "other_name": otherName,
        "username": username,
        "student_gender": studentGender,
        "student_profile_pic": studentProfilePic,
        "student_key": List<dynamic>.from(studentKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class StudentKey {
    StudentKey({
        required this.key,
        required this.id,
    });

    final dynamic key;
    final String id;

    factory StudentKey.fromJson(Map<String, dynamic> json) => StudentKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}
