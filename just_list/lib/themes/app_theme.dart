import 'package:flutter/material.dart';
import 'package:just_list/common/colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      //textTheme: TextTheme(bodyLarge: ),
      scaffoldBackgroundColor: tBlack,
      colorScheme: const ColorScheme(
          background: Colors.black,
          brightness: Brightness.dark,
          primary: tPrimaryColor,
          onPrimary: tSecondaryColor,
          secondary: tSecondaryColor,
          onSecondary: tSecondaryColor,
          error: tRedDelete,
          onError: tRedDelete,
          onBackground: Color.fromARGB(255, 255, 120, 120),
          surface: Color.fromARGB(137, 176, 70, 70),
          onSurface: tWhite));

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: tWhite,
      colorScheme: const ColorScheme(
          background: Color.fromARGB(255, 255, 255, 255),
          brightness: Brightness.light,
          primary: tPrimaryColor,
          onPrimary: tDarker,
          secondary: tSecondaryColor,
          onSecondary: tSecondaryColor,
          error: tRedDelete,
          onError: tRedDelete,
          onBackground: Color.fromARGB(255, 255, 120, 120),
          surface: Color.fromARGB(137, 176, 70, 70),
          onSurface: tWhite));
}
