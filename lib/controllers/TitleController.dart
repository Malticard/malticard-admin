import '/exports/exports.dart';

class TitleController extends Cubit<String> {
  TitleController() : super(_title);
  static const String _title = "Login";
  void setTitle(String title) {
    SharedPreferences.getInstance().then((value) {
      value.setString('malticard_title', title);
    });
    emit(title);
  }

  void showTitle() {
    SharedPreferences.getInstance().then((value) {
      emit(value.getString('malticard_title') ?? "");
    });
  }
}
