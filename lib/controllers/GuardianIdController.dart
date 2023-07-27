import 'package:flutter_bloc/flutter_bloc.dart';

class GuardianIdController extends Cubit<String> {
  GuardianIdController() : super('');
  void setGuardianId(String id){
    emit(id);
  }
}
