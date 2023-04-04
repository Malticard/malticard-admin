import '/exports/exports.dart';
class StepperController extends Cubit<StepperModel>{
  StepperController():super(_count);
  static StepperModel _count = StepperModel(fields:0,text:<String>[]);
//
void updateCount(StepperModel c) => emit(c);
}