import 'package:malticard/exports/exports.dart';

class SidebarController extends Cubit<int> {
  SidebarController() : super(_page);
  static int _page = 0;
  void changeView(int index) {
    SharedPreferences.getInstance().then((value) {
      value.setInt('sidebar_index', index);
    });
    emit(index);
  }

  void getCurrentView() {
    SharedPreferences.getInstance().then((value) {
      emit(value.getInt('sidebar_index')!);
    });
  }
}
