// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);
import 'dart:convert';

List<StudentModel> studentModelFromJson(String str) => List<StudentModel>.from(json.decode(str).map((x) => StudentModel.fromJson(x)));

String studentModelToJson(List<StudentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentModel {
    final String id;
    final String school;
    final Class studentModelClass;
    final List<dynamic> guardians;
    final String studentFname;
    final String studentLname;
    final String otherName;
    final String username;
    // final Stream_ stream;
    final String studentGender;
    final String studentProfilePic;
    final List<StudentKey> studentKey;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    StudentModel({
        required this.id,
        required this.school,
        required this.studentModelClass,
        required this.guardians,
        required this.studentFname,
        required this.studentLname,
        required this.otherName,
        required this.username,
        // required this.stream,
        required this.studentGender,
        required this.studentProfilePic,
        required this.studentKey,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        id: json["_id"],
        school: json["school"],
        studentModelClass: Class.fromJson(json["_class"] ?? {}),
        guardians: List<dynamic>.from(json["guardians"].map((x) => x)),
        studentFname: json["student_fname"],
        studentLname: json["student_lname"],
        otherName: json["other_name"],
        username: json["username"],
        // stream: Stream_.fromJson(json["stream"]),
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
        "_class": studentModelClass.toJson(),
        "guardians": List<dynamic>.from(guardians.map((x) => x)),
        "student_fname": studentFname,
        "student_lname": studentLname,
        "other_name": otherName,
        "username": username,
        // "stream": stream.toJson(),
        "student_gender": studentGender,
        "student_profile_pic": studentProfilePic,
        "student_key": List<dynamic>.from(studentKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Stream_ {
    final String streamName;

    Stream_({
        required this.streamName,
    });

    factory Stream_.fromJson(Map<String, dynamic> json) => Stream_(
        streamName: json["stream_name"],
    );

    Map<String, dynamic> toJson() => {
        "stream_name": streamName,
    };
}

class StudentKey {
    final dynamic key;
    final String id;

    StudentKey({
        required this.key,
        required this.id,
    });

    factory StudentKey.fromJson(Map<String, dynamic> json) => StudentKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}

class Class {
    final String className;

    Class({
        required this.className,
    });

    factory Class.fromJson(Map<String, dynamic> json) => Class(
        className: json["class_name"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "class_name": className,
    };
}
