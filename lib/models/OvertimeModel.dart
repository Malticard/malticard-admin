// To parse this JSON data, do
//
//     final overtimeModel = overtimeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<OvertimeModel> overtimeModelFromJson(String str) => List<OvertimeModel>.from(json.decode(str).map((x) => OvertimeModel.fromJson(x)));

String overtimeModelToJson(List<OvertimeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OvertimeModel {
    OvertimeModel({
        required this.id,
        required this.student,
        required this.guardian,
        required this.settings,
        required this.staff,
        required this.actualTime,
        required this.overtimeCharge,
        required this.status,
        required this.overtimeKey,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final Student student;
    final Guardian guardian;
    final Settings settings;
    final Staff staff;
    final int actualTime;
    final int overtimeCharge;
    final String status;
    final List<OvertimeKey> overtimeKey;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory OvertimeModel.fromJson(Map<String, dynamic> json) => OvertimeModel(
        id: json["_id"],
        student: Student.fromJson(json["student"]),
        guardian: Guardian.fromJson(json["guardian"]),
        settings: Settings.fromJson(json["settings"]),
        staff: Staff.fromJson(json["staff"]),
        actualTime: json["actual_time"],
        overtimeCharge: json["overtime_charge"],
        status: json["status"],
        overtimeKey: List<OvertimeKey>.from(json["overtime_key"].map((x) => OvertimeKey.fromJson(x))),
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "student": student.toJson(),
        "guardian": guardian.toJson(),
        "settings": settings.toJson(),
        "staff": staff.toJson(),
        "actual_time": actualTime,
        "overtime_charge": overtimeCharge,
        "status": status,
        "overtime_key": List<dynamic>.from(overtimeKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Guardian {
    Guardian({
        required this.guardianFname,
        required this.guardianLname,
    });

    final String guardianFname;
    final String guardianLname;

    factory Guardian.fromJson(Map<String, dynamic> json) => Guardian(
        guardianFname: json["guardian_fname"],
        guardianLname: json["guardian_lname"],
    );

    Map<String, dynamic> toJson() => {
        "guardian_fname": guardianFname,
        "guardian_lname": guardianLname,
    };
}

class OvertimeKey {
    OvertimeKey({
        required this.key,
        required this.id,
    });

    final dynamic key;
    final String id;

    factory OvertimeKey.fromJson(Map<String, dynamic> json) => OvertimeKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}

class Settings {
    Settings({
        required this.pickUpEndTime,
        required this.overtimeInterval,
        required this.overtimeRate,
    });

    final int pickUpEndTime;
    final int overtimeInterval;
    final int overtimeRate;

    factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        pickUpEndTime: json["pick_up_end_time"],
        overtimeInterval: json["overtime_interval"],
        overtimeRate: json["overtime_rate"],
    );

    Map<String, dynamic> toJson() => {
        "pick_up_end_time": pickUpEndTime,
        "overtime_interval": overtimeInterval,
        "overtime_rate": overtimeRate,
    };
}

class Staff {
    Staff({
        required this.staffFname,
        required this.staffLname,
    });

    final String staffFname;
    final String staffLname;

    factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        staffFname: json["staff_fname"],
        staffLname: json["staff_lname"],
    );

    Map<String, dynamic> toJson() => {
        "staff_fname": staffFname,
        "staff_lname": staffLname,
    };
}

class Student {
    Student({
        required this.studentFname,
        required this.studentLname,
    });

    final String studentFname;
    final String studentLname;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        studentFname: json["student_fname"],
        studentLname: json["student_lname"],
    );

    Map<String, dynamic> toJson() => {
        "student_fname": studentFname,
        "student_lname": studentLname,
    };
}
