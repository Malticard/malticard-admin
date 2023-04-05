import '/exports/exports.dart';

class StaffPopUpOptions {
  String? title;
  IconData? icon;

  StaffPopUpOptions({this.title, this.icon});

  static final List<StaffPopUpOptions> options = [
    StaffPopUpOptions(
      title: "Logout",
      icon: Icons.exit_to_app_rounded,
    ),
  ];
}
