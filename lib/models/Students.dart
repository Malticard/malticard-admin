import 'dart:convert';

List<Students> studentsFromJson(String str) =>
    List<Students>.from(json.decode(str).map((x) => Students.fromJson(x)));

String studentsToJson(List<Students> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Students {
  Students(
      {required this.id,
      required this.student_fname,
      required this.name,
      required this.student_class,
      required this.student_lname});

  String id;
  String student_fname, student_lname, name, student_class;

  factory Students.fromJson(Map<String, dynamic> json) => Students(
        id: json["_id"],
        student_fname: json["student_fname"],
        student_lname: json["student_lname"],
        student_class: json["student_class"],
        name: '${json["student_fname"]} ${json["student_lname"]}',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "student_fname": student_fname,
        "student_lname": student_lname,
        "name": name,
        "class": student_class,
      };
}
