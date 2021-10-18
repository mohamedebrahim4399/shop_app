import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme=ThemeData(
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    elevation: 20,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness:Brightness.dark,
        statusBarColor: Colors.white
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 20,
    ),
  ),
  textTheme: TextTheme(bodyText1: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
  )),
);
ThemeData darkTheme=ThemeData(
  scaffoldBackgroundColor: Color(0xFF333739),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xFF333739),
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness:Brightness.light,
        statusBarColor: Color(0xFF333739)
    ),
    backgroundColor: Color(0xFF333739),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20,
    ),
  ),
  textTheme: TextTheme(bodyText1: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
  )),
);