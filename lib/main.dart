import 'package:malticard/controllers/DashbaordWidgetController.dart';

import '/exports/exports.dart';
import 'controllers/BreadCrumbController.dart';
import 'controllers/SidebarController.dart';

void main() async {
  // Obtain shared preferences.
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const Observer();
  var prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(create: (context) => WidgetController()),
        BlocProvider(create: (context) => ImageUploadController()),
        BlocProvider(create: (context) => SidebarController()),
        ChangeNotifierProvider(create: (context) => MainController()),
        BlocProvider(create: (context) => BreadCrumbController()),
        BlocProvider(create: (context) => ThemeController()),
        BlocProvider(create: (context) => SchoolController()),
        BlocProvider(create: (context) => DashboardWidgetController()),
        BlocProvider(create: (context) => LightDarkController()),
        BlocProvider(create: (context) => OnlineCheckerController()),
        BlocProvider(create: (context) => TitleController()),
        BlocProvider(create: (context) => DashboardController()),
      ],
      child: BlocBuilder<ThemeController, ThemeData>(
        builder: (context, theme) {
          // school data
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: theme.brightness == Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
            theme: theme.copyWith(
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                      .apply(
                bodyColor: theme.brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                displayColor: theme.brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            initialRoute: (prefs.getBool('isLogin') == true) &&
                    (prefs.getString("schoolData") == null)
                ? Routes.home
                : Routes.login,
            routes: routes(context),
          );
        },
      ),
    ),
  );
}
