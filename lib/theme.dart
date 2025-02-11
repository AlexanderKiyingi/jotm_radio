// import 'package:flutter/material.dart';

// class AppTheme extends InheritedWidget {
//   // Define colors as instance variables
//   final Color transparent;
//   final Color success;
//   final Color info;
//   final Color danger;
//   final Color warning;
//   final Color primaryColor;
//   final Color secondaryColor;
//   final Color primaryBackgroundColor;
//   final Color secondaryBackgroundColor;
//   final Color primaryTextColor;
//   final Color secondaryTextColor;
//   final Color alternate;

//   // Define text styles
//   final TextStyle headline1;
//   final TextStyle bodyText1;
//   final TextStyle bodyMedium;

//   // Constructor for AppTheme
//   const AppTheme({
//     Key? key,
//     required this.transparent,
//     required this.success,
//     required this.info,
//     required this.danger,
//     required this.warning,
//     required this.primaryColor,
//     required this.secondaryColor,
//     required this.primaryBackgroundColor,
//     required this.secondaryBackgroundColor,
//     required this.primaryTextColor,
//     required this.secondaryTextColor,
//     required this.alternate,
//     required this.headline1,
//     required this.bodyText1,
//     required this.bodyMedium,
//     required Widget child,
//   }) : super(key: key, child: child);

//   // Method to provide theme based on context
//   static AppTheme of(BuildContext context) {
//     final AppTheme? theme =
//         context.dependOnInheritedWidgetOfExactType<AppTheme>();
//     if (theme == null) {
//       throw FlutterError(
//           'AppTheme.of() called with a context that does not contain an AppTheme.');
//     }
//     return theme;
//   }

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return true; // Return true if theme updates should rebuild dependent widgets
//   }
// }

// // Extend TextStyle for easy overriding
// extension TextStyleExtension on TextStyle {
//   TextStyle override({
//     String? fontFamily,
//     Color? color,
//     double? fontSize,
//     FontWeight? fontWeight,
//     double? letterSpacing,
//   }) {
//     return copyWith(
//       fontFamily: fontFamily,
//       color: color,
//       fontSize: fontSize,
//       fontWeight: fontWeight,
//       letterSpacing: letterSpacing,
//     );
//   }
// }

// // Define the full ThemeData using AppTheme
// final ThemeData appTheme = ThemeData(
//   colorScheme: const ColorScheme(
//     primary: Color(0xFF2196F3),
//     primaryContainer: Color(0xFF2196F3),
//     secondary: Color(0xFFFFC107),
//     secondaryContainer: Color(0xFFF1F4F8),
//     surface: Colors.white,
//     error: Colors.red,
//     onPrimary: Colors.white,
//     onSecondary: Color(0xFF1A1A1A),
//     onSurface: Color(0xFF1A1A1A),
//     onSurfaceVariant: Color(0xFF1A1A1A),
//     onError: Colors.white,
//     brightness: Brightness.light,
//   ),
//   textTheme: const TextTheme(
//     displayLarge: TextStyle(
//       fontSize: 32,
//       fontWeight: FontWeight.bold,
//       color: Color(0xFF1A1A1A),
//       fontFamily: 'Readex Pro',
//     ),
//     bodyLarge: TextStyle(
//       fontSize: 16,
//       fontWeight: FontWeight.normal,
//       color: Color(0xFF1A1A1A),
//       fontFamily: 'Readex Pro',
//     ),
//     bodyMedium: TextStyle(
//       fontSize: 16,
//       fontWeight: FontWeight.normal,
//       color: Color(0xFF1A1A1A),
//       fontFamily: 'Readex Pro',
//     ),
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Color(0xFF2196F3),
//       foregroundColor: Colors.white,
//       textStyle: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w600,
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//     ),
//   ),
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Color(0xFF2196F3),
//     elevation: 4,
//     iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
//     titleTextStyle: const TextStyle(
//       fontSize: 32,
//       fontWeight: FontWeight.bold,
//       color: Colors.white,
//       fontFamily: 'Readex Pro',
//     ),
//   ),
// );

import 'package:flutter/material.dart';

class AppTheme {
  // Define colors
  static const Color transparent = Color.fromARGB(255, 251, 250, 250);
  static const Color success = Color.fromARGB(255, 2, 130, 51);
  static const Color info = Color(0xFF2196F3);
  static const Color danger = Color.fromARGB(255, 247, 16, 16);
  static const Color warning = Color(0xFFFFC107);
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFFFFC107);
  static const Color primaryBackgroundColor = Color(0xFFFFFFFF);
  static const Color secondaryBackgroundColor = Color(0xFFF1F4F8);
  static const Color primaryTextColor = Color(0xFF1A1A1A);
  static const Color secondaryTextColor = Color(0xFF757575);
  static const Color alternate = Color.fromARGB(255, 40, 1, 36);

  // Define text styles
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: primaryTextColor,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: primaryTextColor,
  );

  // Define button styles
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor:
        Colors.white, // 'onPrimary' is replaced with 'foregroundColor'
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  );
}

// Extend TextStyle for easy overriding
extension TextStyleExtension on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return copyWith(
      fontFamily: fontFamily,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }
}

final ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme(
    primary: AppTheme.primaryColor,
    primaryContainer: AppTheme.primaryColor,
    secondary: AppTheme.secondaryColor,
    secondaryContainer: AppTheme.secondaryBackgroundColor,
    surface: Colors.white,
    // background: AppTheme.primaryBackgroundColor, // Added background
    error: Colors.red,
    onPrimary: Colors.white, // Color to use on primary color
    onSecondary: AppTheme.primaryTextColor, // Color to use on secondary color
    onSurface: AppTheme.primaryTextColor, // Color to use on surface color
    onSurfaceVariant:
        AppTheme.primaryTextColor, // Color to use on background color
    onError: Colors.white, // Color to use on error color
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    displayLarge: AppTheme.headline1,
    bodyLarge: AppTheme.bodyText1,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: AppTheme.buttonStyle,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppTheme.primaryColor,
    elevation: 4,
    iconTheme: const IconThemeData(color: AppTheme.primaryTextColor),
    titleTextStyle: AppTheme.headline1.copyWith(color: Colors.white),
  ),
);

// import 'package:flutter/material.dart';

// class AppTheme {
//   // Define colors
//   static const Color transparent = Color.fromARGB(255, 251, 250, 250);
//   static const Color success = Color.fromARGB(255, 2, 130, 51);
//   static const Color info = Color(0xFF2196F3);
//   static const Color danger = Color.fromARGB(255, 247, 16, 16);
//   static const Color warning = Color(0xFFFFC107);
//   static const Color primaryColor = Color(0xFF2196F3);
//   static const Color secondaryColor = Color(0xFFFFC107);
//   static const Color primaryBackgroundColor = Color(0xFFFFFFFF);
//   static const Color secondaryBackgroundColor = Color(0xFFF1F4F8);
//   static const Color primaryTextColor = Color(0xFF1A1A1A);
//   static const Color secondaryTextColor = Color(0xFF757575);

//   // Define text styles
//   static const TextStyle headline1 = TextStyle(
//     fontSize: 32,
//     fontWeight: FontWeight.bold,
//     color: primaryTextColor,
//   );

//   static const TextStyle bodyText1 = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.normal,
//     color: primaryTextColor,
//   );

//    static const TextStyle bodyMedium = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.normal,
//     color: primaryTextColor,
//   );

//   // Define button styles
//   static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
//     backgroundColor: primaryColor,
//     foregroundColor:
//         Colors.white, // 'onPrimary' is replaced with 'foregroundColor'
//     textStyle: const TextStyle(
//       fontSize: 16,
//       fontWeight: FontWeight.w600,
//     ),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//   );
// }

// final ThemeData appTheme = ThemeData(
//   colorScheme: const ColorScheme(
//     primary: AppTheme.primaryColor,
//     primaryContainer: AppTheme.primaryColor,
//     secondary: AppTheme.secondaryColor,
//     secondaryContainer: AppTheme.secondaryBackgroundColor,
//     surface: Colors.white,
//     // background: AppTheme.primaryBackgroundColor, // Added background
//     error: Colors.red,
//     onPrimary: Colors.white, // Color to use on primary color
//     onSecondary: AppTheme.primaryTextColor, // Color to use on secondary color
//     onSurface: AppTheme.primaryTextColor, // Color to use on surface color
//     onSurfaceVariant:
//         AppTheme.primaryTextColor, // Color to use on background color
//     onError: Colors.white, // Color to use on error color
//     brightness: Brightness.light,
//   ),
//   textTheme: const TextTheme(
//     displayLarge: AppTheme.headline1,
//     bodyLarge: AppTheme.bodyText1,
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: AppTheme.buttonStyle,
//   ),
//   appBarTheme: AppBarTheme(
//     backgroundColor: AppTheme.primaryColor,
//     elevation: 4,
//     iconTheme: const IconThemeData(color: AppTheme.primaryTextColor),
//     titleTextStyle: AppTheme.headline1.copyWith(color: Colors.white),
//   ),
// );
