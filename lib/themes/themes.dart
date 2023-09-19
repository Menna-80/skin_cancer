import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lighttheme = ThemeData(
  // primaryColor: Colors.deepOrange,
  primarySwatch: Colors.blueGrey,
  appBarTheme: AppBarTheme(
    titleSpacing: 16.0,
    backgroundColor: Colors.blueGrey[600],
    elevation: 1.5,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 30.0,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      elevation: 20.0,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black),
  fontFamily: 'fonts',
);