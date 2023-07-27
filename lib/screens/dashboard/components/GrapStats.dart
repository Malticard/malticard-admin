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

class LineChartPage extends StatefulWidget {
  @override
  _LineChartPageState createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  List<TapData> _tapDataList = [];

  @override
  void initState() {
    super.initState();
    fetchTapData();
  }

  void fetchTapData() async {
    // Replace with your API endpoint
    final response = await http.get(Uri.parse(AppUrls.getTaps));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<TapData> tapDataList = [];

      for (var item in data) {
        int month = DateTime.parse(item['createdAt']).month;
        int tapCount = item['count'];
        tapDataList.add(TapData(month, tapCount + 1));
      }

      setState(() {
        _tapDataList = tapDataList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).brightness == Brightness.light? Colors.white: Theme.of(context).canvasColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: LineChart(
          LineChartData(
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
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              leftTitles: AxisTitles(
                axisNameWidget: Text('Number of Taps'),
                  sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, x) {
                  if (value == 0) return Text('0');
                  return Text('${value.toInt()}');
                },
              )),
            ),
            borderData: FlBorderData(show: false),
            minX: 1,
            maxX: 12,
            minY: 0,
            maxY: _tapDataList.isNotEmpty
                ? _tapDataList
                        .map((e) => e.tapCount)
                        .reduce((max, value) => max > value ? max : value)
                        .toDouble() +
                    2
                : 1,
            lineBarsData: [
              LineChartBarData(
                spots: _tapDataList
                    .map((e) =>
                        FlSpot(e.month.toDouble(), e.tapCount.toDouble()))
                    .toList(),
                isCurved: false,
                color: Theme.of(context).primaryColor,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
