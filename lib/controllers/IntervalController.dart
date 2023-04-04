import '/exports/exports.dart';

class IntervalController extends Cubit<double> {
  IntervalController() : super(index);
  static double index = 0;

  computeInterval(double value) => emit(value);
}
