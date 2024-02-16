import 'package:malticard/exports/exports.dart';
// import 'package:malticard/screens/malticard/Schools.dart';
import '/screens/malticard/schools.dart';

class DashboardWidgetController extends Cubit<Widget> {
  DashboardWidgetController() : super(currentWidget);
  static Widget currentWidget = Schools();

  void changeWidget(Widget widget) {
    emit(widget);
  }
}
