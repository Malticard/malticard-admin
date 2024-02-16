import '/controllers/schools_controller.dart';

import '/exports/exports.dart';

class StudentsSchoolsView extends StatefulWidget {
  final Widget? child;
  const StudentsSchoolsView({super.key, this.child});

  @override
  State<StudentsSchoolsView> createState() => _StudentsSchoolsViewState();
}

class _StudentsSchoolsViewState extends State<StudentsSchoolsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlocBuilder<SchoolsController, Widget>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: state,
            );
          },
        ),
      ],
    );
  }
}
