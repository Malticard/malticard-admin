import '/exports/exports.dart';

class TitleController extends Cubit<String> {
  TitleController() : super(_title);
  static const String _title = "Login";
  void setTitle(String title) => emit(title);
}
