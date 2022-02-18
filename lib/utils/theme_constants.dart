import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal,
    ),
    fontFamily: 'Gotham');

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Gotham',
  primarySwatch: Colors.indigo,
);
