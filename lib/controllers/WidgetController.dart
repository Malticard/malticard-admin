import '/screens/malticard/advert_manager_view.dart';
// import '../screens/malticard/StudentSchoolsView.dart';
import '/screens/malticard/SchoolsView.dart';
import '/exports/exports.dart';

class WidgetController extends Cubit<Widget> {
  WidgetController() : super(object);
  static Widget object = const Dashboard();
  static List<Widget> pages = [
    Dashboard(),
    SchoolsView(),
    AdvertManagerView(),
  ];
  void pushWidget(int page) {
    SharedPreferences.getInstance().then((value) {
      value.setInt('widget_index', page);
    });
    emit(pages[page]);
  }

  void showCurrentPage() {
    SharedPreferences.getInstance().then((value) {
      emit(pages[value.getInt('widget_index') ?? 0]);
    });
  }
}
