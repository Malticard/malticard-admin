import '../models/advert_model.dart';
import '../tools/advert_service.dart';
import '/exports/exports.dart';

class AdvertProvider with ChangeNotifier {
  AdvertResponse? _ads;
  bool _loading = false;
  String? _error;

  AdvertResponse? get ads => _ads;
  bool get loading => _loading;
  String? get error => _error;

  // Get active ads for end users
  void fetchActiveAds(int page, int limit) {
    _loading = true;
    AdvertService.getAllAds(page, limit).then((value) {
      _loading = false;
      _ads = value;
      notifyListeners();
    });
  }

  // Schedule periodic refresh to check for ad expiration
  void startPeriodicRefresh(Duration refreshInterval, int page, int limit) {
    Future.delayed(refreshInterval, () {
      fetchActiveAds(page, limit);
      startPeriodicRefresh(refreshInterval, page, limit);
    });
  }
}
