import 'package:cinema/presentation/home/view/home.dart';
import 'package:flutter/material.dart';
import 'package:cinema/core/theme/theme.dart';

class CinemaApp extends StatelessWidget {
  const CinemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const HomePage(),
    );
  }
}
