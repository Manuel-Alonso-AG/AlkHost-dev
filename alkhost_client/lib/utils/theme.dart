import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  cardTheme: CardThemeData(color: Color.fromARGB(255, 36, 43, 44)),
  colorScheme: ColorScheme.dark(
    surface: Color.fromRGBO(28, 33, 36, 1),
    primary: Color(0xFF2AAF4B),
  ),
);

final ThemeData lightTheme = ThemeData(colorScheme: ColorScheme.light());
