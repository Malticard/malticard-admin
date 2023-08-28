import '/exports/exports.dart';
import 'components/GrapStats.dart';
// import 'components/WeeklyTaps.dart';

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
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: DashboardTiles(),
          ),
          Space(),
          Divider(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Number of taps in a year",
                  style: TextStyles(context)
                      .getTitleStyle()
                      .copyWith(fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: Responsive.isMobile(context)
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width * 0.3,
            child: BarChartPage(),
          ),
          Space(
            space: 0.07,
          )
        ],
      ),
    );
  }
}
