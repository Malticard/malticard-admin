import 'package:malticard/exports/exports.dart';
import 'package:malticard/screens/malticard/school_students.dart';

class SchoolsController extends Cubit<Widget> {
  SchoolsController() : super(currentWidget);
  static Widget currentWidget = SchoolStudents();

  void changeWidget(Widget widget) {
    emit(widget);
  }
}
