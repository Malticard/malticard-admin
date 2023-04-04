// To parse this JSON data, do
//
//     final guardians = guardiansFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Guardians> guardiansFromJson(String str) => List<Guardians>.from(json.decode(str).map((x) => Guardians.fromJson(x)));

String guardiansToJson(List<Guardians> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Guardians {
    Guardians({
        required this.type,
        required this.isComplete,
        required this.id,
        required this.student,
        required this.relationship,
        required this.guardianFname,
        required this.guardianLname,
        required this.guardianContact,
        required this.guardianEmail,
        required this.guardianGender,
        required this.guardianProfilePic,
        required this.guardianDateOfEntry,
        required this.guardianKey,
        required this.createdAt,
        required this.updatedAt,
        required this.guardianNo,
        required this.v,
    });

    String type;
    bool isComplete;
    String id;
    Student_ student;
    String relationship;
    String guardianFname;
    String guardianLname;
    int guardianContact;
    String guardianEmail;
    String guardianGender;
    String guardianProfilePic;
    DateTime guardianDateOfEntry;
    List<GuardianKey> guardianKey;
    DateTime createdAt;
    DateTime updatedAt;
    int guardianNo;
    int v;

    factory Guardians.fromJson(Map<String, dynamic> json) => Guardians(
        type: json["type"].toString(),
        isComplete: json["isComplete"],
        id: json["_id"],
        student: Student_.fromJson(json["student"] ?? {}),
        relationship: json["relationship"],
        guardianFname: json["guardian_fname"],
        guardianLname: json["guardian_lname"],
        guardianContact: json["guardian_contact"],
        guardianEmail: json["guardian_email"],
        guardianGender: json["guardian_gender"],
        guardianProfilePic: json["guardian_profile_pic"],
        guardianDateOfEntry: DateTime.parse(json["guardian_dateOfEntry"]),
        guardianKey: List<GuardianKey>.from(json["guardian_key"].map((x) => GuardianKey.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        guardianNo: json["guardian_no"] ?? 0,
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "isComplete": isComplete,
        "_id": id,
        "student": student.toJson(),
        "relationship": relationship,
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
        "guardian_contact": guardianContact,
        "guardian_email": guardianEmail,
        "guardian_gender": guardianGender,
        "guardian_profile_pic": guardianProfilePic,
        "guardian_dateOfEntry": guardianDateOfEntry.toIso8601String(),
        "guardian_key": List<dynamic>.from(guardianKey.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "guardian_no": guardianNo,
        "__v": v,
    };
}

class GuardianKey {
    GuardianKey({
        required this.key,
        required this.id,
    });

    dynamic key;
    String id;

    factory GuardianKey.fromJson(Map<String, dynamic> json) => GuardianKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}

class Student_ {
    Student_({
        required this.studentFname,
        required this.studentLname,
    });

    String studentFname;
    String studentLname;

    factory Student_.fromJson(Map<String, dynamic> json) => Student_(
        studentFname: json["student_fname"] ?? "",
        studentLname: json["student_lname"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "student_fname": studentFname,
        "student_lname": studentLname,
    };
}
