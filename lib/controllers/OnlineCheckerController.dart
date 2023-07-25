import '/exports/exports.dart';

class OnlineCheckerController extends Cubit<bool> {
  //
  OnlineCheckerController() : super(online);
  static bool online = false;
  // method to check online status
  void checkOnline() {
    InternetConnectionChecker.createInstance().hasConnection.then((value) {
      if (value == true) {
        emit(value);
      } else {
        emit(value);
      }
    });
  }

  void updateChecker(bool online) => emit(online);
}
