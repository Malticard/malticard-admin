import '/exports/exports.dart';

class PickUpController extends Cubit<double> {
  PickUpController() : super(_time);
  static double _time = 0.0;
  setPickUpAllowanceTime(double time) => emit(time);
}
