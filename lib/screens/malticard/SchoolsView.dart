import '/controllers/DashbaordWidgetController.dart';

import '/exports/exports.dart';

class SchoolsView extends StatefulWidget {
  const SchoolsView({super.key});

  @override
  State<SchoolsView> createState() => _SchoolsViewState();
}

class _SchoolsViewState extends State<SchoolsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocConsumer<DashboardWidgetController, Widget>(
          builder: (context, state) {
            return state;
          },
          listener: (context, state) {},
        ),
      ],
    );
  }
}
