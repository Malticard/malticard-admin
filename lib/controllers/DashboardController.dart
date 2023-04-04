import '../exports/exports.dart';

class DashboardController extends Cubit<dynamic> {
  DashboardController() : super(_data);
  static dynamic _data = 0;
  // compute dropOffs
  void computeDropOffs() async {
    Client().get(Uri.parse(AppUrls.dropOffs)).then((value) {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);

        emit(data['data']);
      }
    });
  }
}
