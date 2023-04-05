// To parse this JSON data, do
//
//     final schoolModel = schoolModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SchoolModel> schoolModelFromJson(String str) => List<SchoolModel>.from(json.decode(str).map((x) => SchoolModel.fromJson(x)));

String schoolModelToJson(List<SchoolModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchoolModel {
    SchoolModel({
        required this.id,
        required this.schoolName,
        required this.schoolMotto,
        required this.schoolBadge,
        required this.schoolAddress,
        required this.schoolContact,
        required this.schoolEmail,
        required this.schoolAbout,
        required this.schoolKey,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
    });

    final String id;
    final String schoolName;
    final String schoolMotto;
    final String schoolBadge;
    final String schoolAddress;
    final String schoolContact;
    final String schoolEmail;
    final String schoolAbout;
    final List<SchoolKey> schoolKey;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
        id: json["_id"],
        schoolName: json["school_name"],
        schoolMotto: json["school_motto"],
        schoolBadge: json["school_badge"],
        schoolAddress: json["school_address"],
        schoolContact: json["school_contact"],
        schoolEmail: json["school_email"],
        schoolAbout: json["school_about"],
        schoolKey: List<SchoolKey>.from(json["school_key"].map((x) => SchoolKey.fromJson(x))),
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school_name": schoolName,
        "school_motto": schoolMotto,
        "school_badge": schoolBadge,
        "school_address": schoolAddress,
        "school_contact": schoolContact,
        "school_email": schoolEmail,
        "school_about": schoolAbout,
        "school_key": List<dynamic>.from(schoolKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class SchoolKey {
    SchoolKey({
        required this.key,
        required this.id,
    });

    final dynamic key;
    final String id;

    factory SchoolKey.fromJson(Map<String, dynamic> json) => SchoolKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}
