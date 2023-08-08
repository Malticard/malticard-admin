import '/exports/exports.dart';
import 'components/GrapStats.dart';
import 'components/WeeklyTaps.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardTiles(),
          Space(),
          Divider(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Number of taps in a year",
                  style: TextStyles(context).getTitleStyle().copyWith(fontSize: 20),
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: Responsive.isMobile(context) ? MediaQuery.of(context).size.width :MediaQuery.of(context).size.width *0.3,
            child: BarChartPage(),
          ),
          //  Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(18.0),
          //       child: Text(
          //         "Weekly stats",
          //         style: TextStyles(context).getTitleStyle().copyWith(fontSize: 20),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width,
          //   height: Responsive.isMobile(context) ? MediaQuery.of(context).size.width :MediaQuery.of(context).size.width *0.3,
          //   child: WeeklyTaps(),
          // ),
          Space(
            space: 0.07,
          )
        ],
      ),
    );
  }
}
