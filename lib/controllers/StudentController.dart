import '/exports/exports.dart';

class StudentController extends Cubit<dynamic> {
  StudentController() : super(text);
  //
  static var text;
  // ---------> mkkk ---
  void trackStudent(String student) => emit(student);
// -----
  //---> fetch available students
  void studentLists() {
    Client().get(Uri.parse(AppUrls.students)).then((value) {
      if (value.statusCode == 200) {
        emit(studentsFromJson(value.body));
      }
    });
  }
}
