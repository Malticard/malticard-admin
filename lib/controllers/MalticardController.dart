import 'dart:developer';

import '../exports/exports.dart';

class MalticardController extends Cubit<Map<String, dynamic>> {
  MalticardController() : super(initialData);
  static Map<String, dynamic> initialData = {};

  // method to save Malticard data from shared preferences
  void setMalticardData(Map<String, dynamic> data) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isLogin', true);
      prefs.setString('MalticardData', jsonEncode(data));
    });
    // save details to shared preferences
    emit(data);
  }

  // method to get Malticard data from shared preferences
  void getMalticardData() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('MalticardData')) {
        String? s = prefs.getString('MalticardData');
        log("Contains MalticardData");
        if (s != null) {
          emit(jsonDecode(s));
        }
      }
    });
  }

  //
  logout() {
    SharedPreferences.getInstance().then((value) => value.clear());
  }
}
