import '/exports/exports.dart';

class DropOffController extends Cubit<double> {
  DropOffController() : super(_time);
  static final double _time = 0;
  setDropOffAllowanceTime(double time) => emit(time);
}
