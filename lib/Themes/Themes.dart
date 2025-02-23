import '../exports/exports.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: creamColor,
    canvasColor: snowColor,
    primaryColor: Color(0xFF1949B9),
    highlightColor: Colors.white,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF1949B9),
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
    primaryColor: Color(0xFF1949B9),
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
      seedColor: Color(0xFF1949B9),
      brightness: Brightness.dark,
    ),
  );
}
