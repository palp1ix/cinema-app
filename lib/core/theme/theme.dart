import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
      surface: Color.fromARGB(255, 15, 15, 15),
      surfaceContainer: Color(0xFF242423),
      onSurface: Color(0xFFFAF7F0),
      onSecondary: Color(0xFFff0000)),
  inputDecorationTheme: const InputDecorationTheme(
    // prefixIcon: Icon(Icons.email),
    filled: true,
    fillColor: Color(0xFF21364A),
    hintStyle: TextStyle(color: Color(0xFF8FADCC)),
    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.transparent)),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.transparent)),
  ),
  indicatorColor: Colors.red,
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: const Color(0xFFfca311),
  canvasColor: Colors.black,
  fontFamily: GoogleFonts.getFont('Nunito').fontFamily,
);
