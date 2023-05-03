// ignore_for_file: camel_case_types
//theme data for the whole app
import 'package:flutter/material.dart';

class themes {
  static final darktheme = ThemeData(
      inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
      splashColor: Colors.black,
      appBarTheme: AppBarTheme(
          foregroundColor: Colors.white, backgroundColor: Colors.black),
      cardTheme: CardTheme(
        color: Colors.transparent.withOpacity(0.4),
      ),
      expansionTileTheme: ExpansionTileThemeData(
          collapsedTextColor: Colors.white,
          textColor: Colors.white,
          collapsedIconColor: Colors.white,
          iconColor: Colors.white,
          backgroundColor: Colors.blueGrey.withOpacity(0.4),
          collapsedBackgroundColor: Colors.blueGrey.withOpacity(0.4)),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white)),
      focusColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        //  side: BorderSide(color: Colors.white)
      )),
      fontFamily: 'oswald',
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.dark());

  static final lighttheme = ThemeData(
      inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
      splashColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
          foregroundColor: Colors.black, backgroundColor: Colors.white),
      cardTheme: CardTheme(
        color: Colors.transparent.withOpacity(0.4),
      ),
      expansionTileTheme: ExpansionTileThemeData(
          collapsedTextColor: Colors.black,
          textColor: Colors.black,
          collapsedIconColor: Colors.black,
          iconColor: Colors.black,
          backgroundColor: Colors.blueGrey.withOpacity(0.4),
          collapsedBackgroundColor: Colors.blueGrey.withOpacity(0.4)),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black)),
      focusColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              side: BorderSide(color: Colors.black))),
      fontFamily: 'oswald',
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light());
}

class themechange extends ChangeNotifier {
  ThemeMode thememode = ThemeMode.dark;

  bool get isdark => thememode == ThemeMode.dark;
}
