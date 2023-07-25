import 'package:malticard/exports/exports.dart';

class BreadCrumbController extends Cubit<List<BreadCrumbItem>> {
  BreadCrumbController() : super(items);

  static List<BreadCrumbItem> items = [
    BreadCrumbItem(
      content: Text(
        "Schools",
        style: TextStyle(fontSize: 18),
      ),
    ),
  ];
  Widget divider = Icon(Icons.chevron_right);

  void addItem(BreadCrumbItem item) {
    items.add(item);
    emit(items);
  }
//  function remove an item from list basing on its index
  void removeItem(int index) {
    items.removeAt(index);
    emit(items);
  }

  void clear() {
    items.clear();
    emit(items);
  }
}
