import "../models/school_student_model.dart";
import "/exports/exports.dart";

// function to search for students
Future<SchoolStudentsModel> searchSchoolStudents(String schoolId, String query,
    {int page = 1, int limit = 20000}) async {
  Response response = await Client().get(Uri.parse(
      "${AppUrls.searchStudents}$schoolId?query=$query&page=$page&pageSize=$limit"));
  return schoolStudentsModelFromJson(response.body);
}
