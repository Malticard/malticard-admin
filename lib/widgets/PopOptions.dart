import 'dart:ui';

import '../../../exports/exports.dart';

class PopOptions extends StatelessWidget {
  PopOptions({super.key});
  List<Map<String, dynamic>> options = [
    {
      "title": "Add new Staff",
      "icon": Icons.person_add_alt_1_rounded,
    },
    {
      "title": "Add new Student",
      "icon": Icons.person_add_alt_1_rounded,
      // "route": Routes.newStudent,
    },
    {
      "title": "Add new Guardian",
      "icon": Icons.person_add_alt_1_rounded,
      // "route": Routes.newGuardian,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            children: List.generate(
              options.length,
              (index) => ListTileTheme(
                contentPadding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: ListTile(
                    leading: CircleAvatar(
                        child:
                            Icon(options[index]['icon'], color: Colors.white)),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${options[index]['title']}",
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Routes.popPage(context);
                      Routes.namedRoute(
                        context,
                        options[index]['route'],
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Routes.popPage(context),
          child: const Icon(Icons.close)),
    );
  }
}
