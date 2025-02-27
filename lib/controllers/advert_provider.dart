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
  Future<void> fetchActiveAds(int page, int limit) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _ads = await AdvertService.getAllAds(page, limit);
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Schedule periodic refresh to check for ad expiration
  void startPeriodicRefresh(Duration refreshInterval, int page, int limit) {
    Future.delayed(refreshInterval, () async {
      await fetchActiveAds(page, limit);
      startPeriodicRefresh(refreshInterval, page, limit);
    });
  }
}
