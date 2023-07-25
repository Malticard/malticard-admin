import 'package:malticard/exports/exports.dart';

class SidebarController extends Cubit<int>{
  SidebarController() : super(0);

  void changeView(int index){
    emit(index);
  }
}