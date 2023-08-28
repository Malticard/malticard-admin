import '../exports/exports.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: creamColor,
    canvasColor: snowColor,
    primaryColor: const Color.fromARGB(204, 9, 87, 139),
    highlightColor: Colors.white,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(204, 9, 87, 139),
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.aBeeZeeTextTheme().apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    drawerTheme: const DrawerThemeData(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: bgColor,
    ),
    cardColor: Colors.grey[200],
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: bgColor,
    canvasColor: secondaryColor,
    primaryColor: const Color.fromARGB(204, 9, 87, 139),
    useMaterial3: true,
    drawerTheme: const DrawerThemeData(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: bgColor,
    ),
    textTheme: GoogleFonts.aBeeZeeTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(204, 9, 87, 139),
      brightness: Brightness.dark,
    ),
  );
}
