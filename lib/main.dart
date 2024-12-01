import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cinema/presentation/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;
  final talker = TalkerFlutter.init();
  getIt.registerSingleton<Talker>(talker);
  // Load the .env file
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    talker.error('Something went wrong in .env file loading');
  }
  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(talker: talker),
  );
  Bloc.observer = TalkerBlocObserver(talker: talker);
  getIt.registerSingleton<Dio>(dio);
  runApp(const CinemaApp());
}
