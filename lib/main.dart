import '/exports/exports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkoolTym-Malticard',
      theme: ThemeData(),
      initialRoute: Routes.superAdminView,
      routes: routes(context),
    );
  }
}
