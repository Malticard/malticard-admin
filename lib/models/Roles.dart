// To parse this JSON data, do
//
//     final roles = rolesFromJson(jsonString);

import 'dart:convert';

List<Roles> rolesFromJson(String str) =>
    List<Roles>.from(json.decode(str).map((x) => Roles.fromJson(x)));

String rolesToJson(List<Roles> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Roles {
  Roles({
    required this.id,
    required this.roleType,
    required this.roleKey,
    required this.createdAt,
    required this.updatedAt,
    required this.roleNo,
    required this.v,
  });

  String id;
  String roleType;
  List<RoleKey> roleKey;
  DateTime createdAt;
  DateTime updatedAt;
  int roleNo;
  int v;

  factory Roles.fromJson(Map<String, dynamic> json) => Roles(
        id: json["_id"],
        roleType: json["role_type"],
        roleKey: List<RoleKey>.from(
            json["role_key"].map((x) => RoleKey.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        roleNo: json["role_no"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "role_type": roleType,
        "role_key": List<dynamic>.from(roleKey.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "role_no": roleNo,
        "__v": v,
      };
}

class RoleKey {
  RoleKey({
    this.key,
    required this.id,
  });

  dynamic key;
  String id;

  factory RoleKey.fromJson(Map<String, dynamic> json) => RoleKey(
        key: json["key"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "_id": id,
      };
}
