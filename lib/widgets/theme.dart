
import 'package:flutter/material.dart';

class MyTheme{
  static ThemeData lighttheme(BuildContext context) =>ThemeData(
    appBarTheme: AppBarTheme(
      color: Color(0xff4c505b),
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      //textTheme: Theme.of(context).textTheme,
    ),
    primarySwatch: Colors.indigo,
  );

  static ThemeData darktheme(BuildContext context) =>ThemeData(
    brightness: Brightness.dark,
  );
}