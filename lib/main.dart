import 'package:cinema/di.dart';
import 'package:flutter/material.dart';
import 'package:cinema/presentation/app.dart';

void main() async {
  await di();
  runApp(const CinemaApp());
}
