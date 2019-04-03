import 'package:flutter/material.dart';

final deepBlue = const Color.fromRGBO(71, 153, 247, 1);
final greyBlue = const Color.fromRGBO(91, 120, 151, 1);
final grey = const Color.fromRGBO(239, 242, 245, 1);

final themeData = ThemeData(
  primaryColor: deepBlue,
  accentColor: greyBlue,
  backgroundColor: grey,
  fontFamily: 'Product Sans',
  scaffoldBackgroundColor: grey,
  primaryTextTheme: TextTheme(
    subtitle: TextStyle(
      fontWeight: FontWeight.w700,
      color: deepBlue,
      fontSize: 18,
    ),
    headline: TextStyle(
      color: greyBlue,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w300,
    ),
    title: TextStyle(
      color: greyBlue,
      fontSize: 22,
      letterSpacing: 0.4,
    ),
  ).apply(
      // displayColor: greyBlue,
      // bodyColor: greyBlue,
      ),
);
