import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:malticard/exports/exports.dart';

class WeeklyTaps extends StatefulWidget {
  @override
  _WeeklyTapsState createState() => _WeeklyTapsState();
}

class _WeeklyTapsState extends State<WeeklyTaps> {
  // Sample data - Replace this with your actual data
  final List<int> tapsData = [10, 15, 12, 25, 30, 22, 18, 35, 28, 20, 15, 20];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        _generateLineChartData(),
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  LineChartData _generateLineChartData() {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        topTitles: AxisTitles(
          axisNameWidget: Text(
            'Weekly Tap Count Line Graph',
            style: TextStyles(context).getRegularStyle(),
          ),
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, x) {
            // Replace this with labels corresponding to your weekly data
            int weekNumber = value.toInt();
            if (weekNumber >= 1 && weekNumber <= tapsData.length) {
              return Transform.translate(
                offset: Offset(-20, 40),
                child: Transform.rotate(
                  angle: -45,
                  child: Text(
                    'Week $weekNumber',
                  ),
                ),
              );
            }
            return Text('');
          },
        )),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      minX: 1,
      maxX: tapsData.length.toDouble(),
      minY: 0,
      maxY: tapsData
              .reduce((value, element) => value > element ? value : element) +
          5,
      lineBarsData: [
        LineChartBarData(
          spots: _generateLineChartSpots(),
          isCurved: true,
          color: Theme.of(context).primaryColor,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(show: true),
        ),
      ],
    );
  }

  List<FlSpot> _generateLineChartSpots() {
    return tapsData.asMap().entries.map((entry) {
      final int index = entry.key + 1;
      final int taps = entry.value;
      return FlSpot(index.toDouble(), taps.toDouble());
    }).toList();
  }
}
