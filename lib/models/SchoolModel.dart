// To parse this JSON data, do
import 'dart:convert';

SchoolModel schoolModelFromJson(String str) => SchoolModel.fromJson(json.decode(str));

String schoolModelToJson(SchoolModel data) => json.encode(data.toJson());

class SchoolModel {
    final int totalDocuments;
    final int totalPages;
    final int currentPage;
    final int pageSize;
    final List<Result> results;

    SchoolModel({
        required this.totalDocuments,
        required this.totalPages,
        required this.currentPage,
        required this.pageSize,
        required this.results,
    });

    factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
        totalDocuments: json["totalDocuments"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalDocuments": totalDocuments,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    final String id;
    final String schoolName;
    final String schoolType;
    final String schoolBadge;
    final String schoolAddress;
    final String schoolContact;
    final String schoolEmail;
    final String schoolNature;
    // final String username;
    final List<SchoolKey> schoolKey;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;

    Result({
        required this.id,
        required this.schoolName,
        required this.schoolType,
        required this.schoolBadge,
        required this.schoolAddress,
        required this.schoolContact,
        required this.schoolEmail,
        required this.schoolNature,
        // required this.username,
        required this.schoolKey,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        schoolName: json["school_name"],
        schoolType: json["school_type"],
        schoolBadge: json["school_badge"],
        schoolAddress: json["school_address"],
        schoolContact: json["school_contact"],
        schoolEmail: json["school_email"],
        schoolNature: json["school_nature"],
        // username: json["username"],
        schoolKey: List<SchoolKey>.from(json["school_key"].map((x) => SchoolKey.fromJson(x))),
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school_name": schoolName,
        "school_type": schoolType,
        "school_badge": schoolBadge,
        "school_address": schoolAddress,
        "school_contact": schoolContact,
        "school_email": schoolEmail,
        "school_nature": schoolNature,
        // "username": username,
        "school_key": List<dynamic>.from(schoolKey.map((x) => x.toJson())),
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class SchoolKey {
    final dynamic key;
    final String id;

    SchoolKey({
        required this.key,
        required this.id,
    });

    factory SchoolKey.fromJson(Map<String, dynamic> json) => SchoolKey(
        key: json["key"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
    };
}
