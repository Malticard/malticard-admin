import '../exports/exports.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: creamColor,
    canvasColor: snowColor,
    primaryColor: Colors.blueAccent,
    primarySwatch: Colors.blue,
    backgroundColor: const Color.fromARGB(204, 9, 87, 139),
    highlightColor: Colors.white,
    cardColor: Colors.grey[200],
    brightness: Brightness.light,
  );
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: bgColor,
    canvasColor: secondaryColor,
    primaryColor: Colors.blueAccent,
    primarySwatch: Colors.blue,
    backgroundColor: Colors.black,
    highlightColor: Colors.blueAccent,
    brightness: Brightness.dark,
  );
}
