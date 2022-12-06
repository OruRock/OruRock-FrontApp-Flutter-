import 'package:flutter/material.dart';
import 'package:oru_rock/constant/style/size.dart';

final ThemeData mainTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[100],
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    titleSpacing: 20,
    titleTextStyle: TextStyle(
        fontFamily: "NotoB",
        fontSize: FontSize.xLarge,
        height: 1.7,
        color: Colors.black),
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
    backgroundColor: Colors.white,
    elevation: 1,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
    unselectedLabelStyle: TextStyle(
        fontFamily: "NotoR", color: Colors.black, fontSize: FontSize.xSmall),
    selectedLabelStyle: TextStyle(
        fontFamily: "NotoB", color: Colors.red, fontSize: FontSize.xSmall),
    selectedItemColor: Colors.black,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    side: BorderSide(color: Colors.grey[200]!, width: 1),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100))),
  )),
);
