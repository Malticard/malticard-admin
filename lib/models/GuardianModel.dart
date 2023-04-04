// To parse this JSON data, do
//
//     final guardianModel = guardianModelFromJson(jsonString);

import 'dart:convert';

GuardianModel guardianModelFromJson(String str) =>
    GuardianModel.fromJson(json.decode(str));

String guardianModelToJson(GuardianModel data) => json.encode(data.toJson());

class GuardianModel {
  GuardianModel({
    required this.id,
    required this.student,
    required this.relationship,
    required this.type,
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

  final String id;
  final student;
  final String relationship;
  final String type;
  final String guardianFname;
  final String guardianLname;
  final int guardianContact;
  final String guardianEmail;
  final String guardianGender;
  final String guardianProfilePic;
  final String guardianDateOfEntry;
  final List<GuardKey> guardianKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int guardianNo;
  final int v;

  factory GuardianModel.fromJson(Map<String, dynamic> json) => GuardianModel(
        id: json["_id"],
        student: json["student"],
        relationship: json["relationship"],
        type: json["type"],
        guardianFname: json["guardian_fname"],
        guardianLname: json["guardian_lname"],
        guardianContact: json["guardian_contact"],
        guardianEmail: json["guardian_email"],
        guardianGender: json["guardian_gender"],
        guardianProfilePic: json["guardian_profile_pic"],
        guardianDateOfEntry: json["guardian_dateOfEntry"],
        guardianKey: List<GuardKey>.from(
            json["guardian_key"].map((x) => GuardKey.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        guardianNo: json["guardian_no"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "student": student,
        "relationship": relationship,
        "type": type,
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
        "guardian_contact": guardianContact,
        "guardian_email": guardianEmail,
        "guardian_gender": guardianGender,
        "guardian_profile_pic": guardianProfilePic,
        "guardian_dateOfEntry": guardianDateOfEntry,
        "guardian_key": List<dynamic>.from(guardianKey.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "guardian_no": guardianNo,
        "__v": v,
      };
}

class GuardKey {
  GuardKey({
    required this.key,
    required this.id,
  });

  final key;
  final String id;

  factory GuardKey.fromJson(Map<String, dynamic> json) => GuardKey(
        key: json["key"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
      };
}
