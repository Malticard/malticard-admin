import '../exports/exports.dart';

class SchoolController extends Cubit<Map<String, dynamic>> {
  SchoolController() : super(initialData);
  static Map<String, dynamic> initialData = {};

  // method to save school data from shared preferences
  void setSchoolData(Map<String, dynamic> data) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('schoolData', jsonEncode(data));
    });
    // save details to shared preferences
    emit(data);
  }

  // method to get school data from shared preferences
  void getSchoolData() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('schoolData')) {
        emit(jsonDecode(prefs.getString('schoolData')!));
      }
    });
  }
  // 
  logout(){
    SharedPreferences.getInstance().then((value) => value.clear());
  }
}
