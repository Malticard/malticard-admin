import '/exports/exports.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyFiles(),
        const SizedBox(height: defaultPadding),
        // const OvertimeReports(overtimeStatus: "Pending",label:"Pending "
        //     "Overtime"),
        // if (Responsive.isMobile(context))
        //   const SizedBox(height: defaultPadding),
        // if (Responsive.isMobile(context)) const StarageDetails(),
      ],
    );
  }
}
