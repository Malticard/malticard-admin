import 'package:malticard/exports/exports.dart';
// import 'package:malticard/screens/malticard/Schools.dart';
import 'package:malticard/screens/malticard/school_students.dart';

class DashboardWidgetController extends Cubit<Widget> {
  DashboardWidgetController() : super(currentWidget);
  static Widget currentWidget = SchoolStudents();

  void changeWidget(Widget widget) {
    emit(widget);
  }
}
