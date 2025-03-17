import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF8687E7),
  scaffoldBackgroundColor: Color(0xFF121212), 
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF121212),
  ),
  cardColor: Color(0xFF363636),
  dialogBackgroundColor: Color(0xFF363636), 
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, 
      backgroundColor: Color(0xFF8687E7), 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF8687E7), 
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 18, color: Colors.white, fontFamily: "Lato"),
    bodyMedium: TextStyle(fontSize: 18, color: Colors.white70, fontFamily: "Lato"),
  ),
  inputDecorationTheme: InputDecorationTheme(
  filled: true,
  fillColor: Color(0xFF363636), 
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.white, width: 2), 
  ),
  labelStyle: TextStyle(color: Colors.white70),
),

  iconTheme: IconThemeData(color: Colors.white70),
);
