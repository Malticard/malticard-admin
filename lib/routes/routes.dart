import '/exports/exports.dart';

class Routes {
  static const String login = "/userlogin";
  static const String onboardScreen = '/introductionScreen';
  static const String network = '/network';
  // static const String o = '/n';
  static const String forgotPassword = '/forgotPassword';
  static const String home = '/wksktyui';
  static const String malticard = '/malticard';
  static void push(Widget widget, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => widget, fullscreenDialog: true),
    );
  }

  static void namedRoute(BuildContext context, String route) {
    debugPrint("moved $route");
    Navigator.of(context).pushNamed(route);
  }

  static void namedRemovedUntilRoute(BuildContext context, String route) {
    debugPrint("moved $route");
    Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => true);
  }

  static void popPage(BuildContext context) {
    Navigator.pop(context);
  }

  static void logout(BuildContext context) {
    // clear all set data
    SharedPreferences.getInstance()
        .then((value) => value.clear())
        .whenComplete(() {
      //
      showMessage(
          context: context, type: 'info', msg: 'Signed out successfully');
      namedRemovedUntilRoute(context, login);
    });
  }
}

Map<String, Widget Function(BuildContext)> routes(BuildContext context) {
  return {
    Routes.home: (context) => const MainScreen(),
    Routes.login: (context) => LoginScreen(),
    Routes.malticard:(context) => MalticardView()
  };
}
