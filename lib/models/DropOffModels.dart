// To parse this JSON data, do
//
//     final dropOffModel = dropOffModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DropOffModel> dropOffModelFromJson(String str) => List<DropOffModel>.from(json.decode(str).map((x) => DropOffModel.fromJson(x)));

String dropOffModelToJson(List<DropOffModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DropOffModel {
    DropOffModel({
        required this.id,
        required this.schoolName,
        required this.studentName,
        required this.dropOffTime,
        required this.droppedBy,
        required this.authorizedBy,
        required this.comments,
        required this.dropoffKey,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final String schoolName;
    final dynamic studentName;
    final String dropOffTime;
    final DroppedBy droppedBy;
    final dynamic authorizedBy;
    final String comments;
    final List<DropoffKey> dropoffKey;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory DropOffModel.fromJson(Map<String, dynamic> json) => DropOffModel(
        id: json["_id"],
        schoolName: json["school_name"],
        studentName: json["student_name"],
        dropOffTime: json["drop_off_time"],
        droppedBy: DroppedBy.fromJson(json["dropped_by"] ?? {}),
        authorizedBy: json["authorized_by"],
        comments: json["comments"],
        dropoffKey: List<DropoffKey>.from(json["dropoff_key"].map((x) => DropoffKey.fromJson(x))),
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school_name": schoolName,
        "student_name": studentName,
        "drop_off_time": dropOffTime,
        "dropped_by": droppedBy.toJson(),
        "authorized_by": authorizedBy,
        "comments": comments,
        "dropoff_key": List<dynamic>.from(dropoffKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class DropoffKey {
    DropoffKey({
        required this.key,
        required this.id,
    });

    final dynamic key;
    final String id;

    factory DropoffKey.fromJson(Map<String, dynamic> json) => DropoffKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}

class DroppedBy {
    DroppedBy({
        required this.guardianFname,
        required this.guardianLname,
    });

    final String guardianFname;
    final String guardianLname;

    factory DroppedBy.fromJson(Map<String, dynamic> json) => DroppedBy(
        guardianFname: json["guardian_fname"] ?? "",
        guardianLname: json["guardian_lname"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
    };
}
