import 'package:flutter_native_splash/flutter_native_splash.dart';
import '/controllers/DashbaordWidgetController.dart';
import 'package:url_strategy/url_strategy.dart';
import '/exports/exports.dart';
import 'controllers/GuardianIdController.dart';
import 'controllers/LoaderController.dart';
import 'controllers/MenuAppController.dart';
import 'controllers/SidebarController.dart';

void main() async {
  // Obtain shared preferences.
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  Bloc.observer = const Observer();
  var prefs = await SharedPreferences.getInstance();
  // prefs.clear();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(create: (context) => WidgetController()),
        BlocProvider(create: (context) => ImageUploadController()),
        BlocProvider(create: (context) => SidebarController()),
        ChangeNotifierProvider(create: (context) => MainController()),
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
        ChangeNotifierProvider(create: (context) => LoaderController()),
        BlocProvider(create: (context) => ThemeController()),
        BlocProvider(create: (context) => GuardianIdController()),
        BlocProvider(create: (context) => MalticardController()),
        BlocProvider(create: (context) => DashboardWidgetController()),
        BlocProvider(create: (context) => OnlineCheckerController()),
        BlocProvider(create: (context) => TitleController()),
        BlocProvider(create: (context) => DashboardController()),
      ],
      child: BlocBuilder<ThemeController, ThemeData>(
        builder: (context, theme) {
          // BlocProvider.
          // school data
          return BlocBuilder<TitleController, String>(
            builder: (context, title) {
              return MaterialApp(
                title: "Malticard | $title",
                debugShowCheckedModeBanner: false,
                themeMode: theme.brightness == Brightness.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
                theme: theme,
                initialRoute: (prefs.getBool('isLogin') == true) &&
                        (prefs.getString("schoolData") == null)
                    ? Routes.home
                    : Routes.login,
                routes: routes(context),
              );
            },
          );
        },
      ),
    ),
  );
  FlutterNativeSplash.remove();
}
