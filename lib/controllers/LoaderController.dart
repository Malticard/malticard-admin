import '../exports/exports.dart';

class LoaderController with ChangeNotifier {
  bool isLoading = false;
  void showLoader() {
    isLoading = true;
    notifyListeners();
  }

  void hideLoader() {
    isLoading = false;
    notifyListeners();
  }
}
