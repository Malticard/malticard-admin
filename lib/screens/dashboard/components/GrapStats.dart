// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fl_chart/fl_chart.dart';

// import '../../../constants/app_urls.dart';

// class TapData {
//   int month;
//   int tapCount;

//   TapData(this.month, this.tapCount);
// }

// class BarChartPage extends StatefulWidget {
//   @override
//   _BarChartPageState createState() => _BarChartPageState();
// }

// class _BarChartPageState extends State<BarChartPage> {
//   List<TapData> _tapDataList = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchTapData();
//   }

//   void fetchTapData() async {
//     // Replace with your API endpoint
//     final response = await http.get(Uri.parse(AppUrls.getTaps));

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       List<TapData> tapDataList = [];

//       for (var item in data) {
//         int month = DateTime.parse(item['createdAt']).month;
//         int tapCount = item['count'];
//         tapDataList.add(TapData(month, tapCount + 1));
//       }

//       setState(() {
//         _tapDataList = tapDataList;
//       });
//     }
//   }

//   List<BarChartGroupData> getBarGroups() {
//     List<BarChartGroupData> barGroups = [];

//     for (int month = 1; month <= 12; month++) {
//       int tapCountSum = _tapDataList
//           .where((data) => data.month == month)
//           .map((data) => data.tapCount)
//           .fold(0, (sum, count) => sum + count);

//       barGroups.add(
//         BarChartGroupData(
//           x: month,
//           barRods: [
//             BarChartRodData(
//               borderRadius: BorderRadius.zero,
//               toY: tapCountSum.toDouble(),
//               width: 20,
//               color: Theme.of(context).primaryColor,
//             ),
//           ],
//         ),
//       );
//     }

//     return barGroups;
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<BarChartGroupData> barGroups = getBarGroups();

//     return Container(
//       width: MediaQuery.of(context).size.width,
//       margin: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         color: Theme.of(context).brightness == Brightness.light
//             ? Colors.white
//             : Theme.of(context).canvasColor,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: BarChart(
//           BarChartData(
//             gridData: FlGridData(show: true),
//             titlesData: FlTitlesData(
//               show: true,
//               topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               bottomTitles: AxisTitles(
//                 axisNameWidget: Text(
//                   'Months',
//                   style: TextStyle(
//                     color: Theme.of(context).brightness == Brightness.light
//                         ? Colors.black
//                         : Colors.white,
//                   ),
//                 ),
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: (value, x) {
//                     switch (value.toInt()) {
//                       case 1:
//                         return Text('Jan');
//                       case 2:
//                         return Text('Feb');
//                       case 3:
//                         return Text('Mar');
//                       case 4:
//                         return Text('Apr');
//                       case 5:
//                         return Text('May');
//                       case 6:
//                         return Text('Jun');
//                       case 7:
//                         return Text('Jul');
//                       case 8:
//                         return Text('Aug');
//                       case 9:
//                         return Text('Sep');
//                       case 10:
//                         return Text('Oct');
//                       case 11:
//                         return Text('Nov');
//                       case 12:
//                         return Text('Dec');
//                       default:
//                         return Text('');
//                     }
//                   },
//                 ),
//               ),
//               rightTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: (value, x) {
//                     return (value == 0) ? Text('')
//                     : Text('${value.toInt()}');
//                   },
//                 ),
//               ),
//             ),
//             borderData: FlBorderData(show: true),
//             barGroups: barGroups,
//             alignment: BarChartAlignment.spaceAround,
//             barTouchData: BarTouchData(enabled: true),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

import '../../../constants/app_urls.dart';

class TapData {
  int month;
  int tapCount;

  TapData(this.month, this.tapCount);
}

class BarChartPage extends StatefulWidget {
  @override
  _BarChartPageState createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  List<List<TapData>> _tapDataForMonths = List.generate(12, (_) => []);
  List<TapData> _tapDataList = [];

  @override
  void initState() {
    super.initState();
    fetchTapData();
  }

  void fetchTapData() async {
    try {
      // Replace with your API endpoint
      final response = await http.get(Uri.parse(AppUrls.getTaps));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var item in data) {
          int month = DateTime.parse(item['createdAt']).month;
          int tapCount = item['count'] + 1;
          _tapDataForMonths[month - 1].add(TapData(month, tapCount));
        }

        List<TapData> accumulatedDataList = [];
        int accumulatedTapCount = 0;

        for (int month = 1; month <= 12; month++) {
          if (_tapDataForMonths[month - 1].isNotEmpty) {
            int lastCount = _tapDataForMonths[month - 1].last.tapCount;
            accumulatedTapCount += lastCount;
            accumulatedDataList.add(TapData(month, accumulatedTapCount));
          }
        }
        if (mounted) {
          setState(() {
            _tapDataList = accumulatedDataList;
          });
        }
      }
    } on http.ClientException catch (e, x) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Theme.of(context).canvasColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BarChart(
          BarChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, x) {
                    switch (value.toInt()) {
                      case 1:
                        return Text('Jan');
                      case 2:
                        return Text('Feb');
                      case 3:
                        return Text('Mar');
                      case 4:
                        return Text('Apr');
                      case 5:
                        return Text('May');
                      case 6:
                        return Text('Jun');
                      case 7:
                        return Text('Jul');
                      case 8:
                        return Text('Aug');
                      case 9:
                        return Text('Sep');
                      case 10:
                        return Text('Oct');
                      case 11:
                        return Text('Nov');
                      case 12:
                        return Text('Dec');
                      default:
                        return Text('');
                    }
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, x) {
                    if (value == 0) return Text('0');
                    return Text('${value.toInt()}');
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: true),
            barGroups: _tapDataList.map((e) {
              return BarChartGroupData(
                x: e.month,
                barRods: [
                  BarChartRodData(
                    toY: e.tapCount.toDouble(),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              );
            }).toList(),
            alignment: BarChartAlignment.spaceAround,
            barTouchData: BarTouchData(enabled: false),
          ),
        ),
      ),
    );
  }
}
