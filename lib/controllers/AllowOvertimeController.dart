import '../exports/exports.dart';

class AllowOvertimeController extends Cubit<bool> {
  AllowOvertimeController() : super(allow);
  static bool allow = false;

  allowOvertime(bool overtime) => emit(overtime);
}
