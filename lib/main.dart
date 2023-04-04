import '/exports/exports.dart';

void main() async {
  // Obtain shared preferences.
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  // );
  Bloc.observer = const Observer();
  var prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(create: (context) => WidgetController()),
        ChangeNotifierProvider(create: (context) => MainController()),
        BlocProvider(create: (context) => ThemeController()),
        BlocProvider(create: (context) => IntervalController()),
        BlocProvider(create: (context) => OvertimeRateController()),
        BlocProvider(create: (context) => PickUpController()),
        BlocProvider(create: (context) => DropOffController()),
        BlocProvider(create: (context) => SchoolController()),
        BlocProvider(create: (context) => AllowOvertimeController()),
        BlocProvider(create: (context) => LightDarkController()),
        BlocProvider(create: (context) => OnlineCheckerController()),
        BlocProvider(create: (context) => StudentController()),
        BlocProvider(create: (context) => TitleController()),
        BlocProvider(create: (context) => DashboardController()),
        BlocProvider(create: (context) => StepperController()),
      ],
      child: BlocBuilder<ThemeController, ThemeData>(builder: (context, theme) {
        // school data
        // retrive app state
        // BlocProvider.of<SchoolController>(context).getSchoolData();

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: theme.brightness == Brightness.light
              ? ThemeMode.light
              : ThemeMode.dark,
          theme: theme.copyWith(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
              bodyColor: theme.brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              displayColor: theme.brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          // initialRoute: Routes.malticard,
          initialRoute: (prefs.getString('schoolData') != null &&
                  (prefs.getString('role') == 'SuperAdmin' || prefs.getString('role') == 'Admin' ||
                      prefs.getString('role') == 'Finance'))
              ? Routes.home
              : Routes.login,
          routes: routes(context),
        );
      }),
    ),
  );
}
