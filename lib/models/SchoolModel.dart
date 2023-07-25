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
    final String schoolBadge;
    final String schoolContact;
    final String schoolEmail;

    Result({
        required this.id,
        required this.schoolName,
        required this.schoolBadge,
        required this.schoolContact,
        required this.schoolEmail,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        schoolName: json["school_name"],
        schoolBadge: json["school_badge"],
        schoolContact: json["school_contact"],
        schoolEmail: json["school_email"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "school_name": schoolName,
        "school_badge": schoolBadge,
        "school_contact": schoolContact,
        "school_email": schoolEmail,
    };
}
