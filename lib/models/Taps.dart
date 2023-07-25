// To parse this JSON data, do
//
//     final taps = tapsFromJson(jsonString);
import 'dart:convert';

List<Taps> tapsFromJson(String str) => List<Taps>.from(json.decode(str).map((x) => Taps.fromJson(x)));

String tapsToJson(List<Taps> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Taps {
    final String id;
    final String student;
    final List<String> guardian;
    final int count;
    final bool isComplete;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Taps({
        required this.id,
        required this.student,
        required this.guardian,
        required this.count,
        required this.isComplete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Taps.fromJson(Map<String, dynamic> json) => Taps(
        id: json["_id"],
        student: json["student"],
        guardian: List<String>.from(json["guardian"].map((x) => x)),
        count: json["count"],
        isComplete: json["isComplete"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "student": student,
        "guardian": List<dynamic>.from(guardian.map((x) => x)),
        "count": count,
        "isComplete": isComplete,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
