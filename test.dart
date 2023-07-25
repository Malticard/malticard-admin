import 'package:http/http.dart';
import 'package:malticard/constants/app_urls.dart';
import 'package:malticard/models/Taps.dart';void main(List<String> args) {
  Client().get(Uri.parse(AppUrls.getTaps)).then((value) {
    var data = tapsFromJson(value.body);
    Map<int, int> monthCounts = {}; // Map to store counts for each month

    // Initialize the monthCounts map with default values (0 counts) for all months
    for (int month = 1; month <= 12; month++) {
      monthCounts[month] = 0;
    }

    data.forEach((element) {
      int month = element.createdAt.month;
      int count = element.count;
      monthCounts[month] = count; // Update the count for the specific month
    });

    int totalTapsInYear = monthCounts.values.reduce((sum, count) => sum + count);
    print("Total Taps in the Year: $totalTapsInYear");
  });
}
