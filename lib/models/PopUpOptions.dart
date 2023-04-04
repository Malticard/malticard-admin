import '/exports/exports.dart';

class PopUpOptions {
  String? title;
  IconData? icon;
  // final String route;
  PopUpOptions({this.title, this.icon});

  static final List<PopUpOptions> options = [
    PopUpOptions(title: "Settings", icon: Icons.settings),
    PopUpOptions(title: "Logout", icon: Icons.logout),
  ];
}
