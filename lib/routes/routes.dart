import '/exports/exports.dart';

class Routes {
  static const String superAdminView = "/sdfghjkd345673lddf";

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
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }

  static void popPage(BuildContext context) {
    Navigator.pop(context);
  }

  static void logout(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      value.clear();
    }).whenComplete(() => showMessage(
        context: context, type: 'info', msg: 'Signed out successfully'));
    // namedRemovedUntilRoute(context, login); // navigates back login screen
  }
}

Map<String, Widget Function(BuildContext)> routes(BuildContext context) {
  return {
    Routes.superAdminView: (context) => const SuperAdminView(),
  };
}
