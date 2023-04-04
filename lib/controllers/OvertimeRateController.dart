import '/exports/exports.dart';

class OvertimeRateController extends Cubit<double> {
  OvertimeRateController() : super(rate);
  static double rate = 0.0;
  void setOvertimeRate(double d) => emit(d);
}
