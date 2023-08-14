import 'dart:developer';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:malticard/controllers/DashbaordWidgetController.dart';

import '/exports/exports.dart';
import 'controllers/BreadCrumbController.dart';
import 'controllers/GuardianIdController.dart';
import 'controllers/MenuAppController.dart';
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
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
        BlocProvider(create: (context) => BreadCrumbController()),
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
