import 'dart:convert';

AdvertResponse advertResponseFromJson(String str) =>
    AdvertResponse.fromJson(json.decode(str));

String advertResponseToJson(AdvertResponse data) => json.encode(data.toJson());

class AdvertResponse {
  final int totalDocuments;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<AdvertModel> data;

  AdvertResponse({
    required this.totalDocuments,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.data,
  });

  factory AdvertResponse.fromJson(Map<String, dynamic> json) => AdvertResponse(
        totalDocuments: json["totalDocuments"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
        data: List<AdvertModel>.from(
            json["data"].map((x) => AdvertModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalDocuments": totalDocuments,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AdvertModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String targetUrl;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  AdvertModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.targetUrl,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AdvertModel.fromJson(Map<String, dynamic> json) => AdvertModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        targetUrl: json["targetUrl"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "targetUrl": targetUrl,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "isActive": isActive,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
