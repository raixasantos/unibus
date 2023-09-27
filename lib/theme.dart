import 'package:flutter/material.dart';
import 'package:unibus/constants/colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: mainText,
        fontFamily: 'Inter',
        fontSize: 32,
        fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
        color: mainText,
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.bold),
    displaySmall: TextStyle(
        color: mainText,
        fontFamily: 'Inter',
        fontSize: 15,
        fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        color: secondaryText,
        fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 15,
        color: secondaryText,
        fontWeight: FontWeight.w500),
    bodySmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        color: secondaryText,
        fontWeight: FontWeight.w500),
  ),
  appBarTheme: const AppBarTheme(
    color: primary,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
);
