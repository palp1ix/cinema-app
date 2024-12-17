import 'package:cinema/data/remote_data_source/dio_interseptor.dart';
import 'package:cinema/domain/auth_manager/auth_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> di() async {
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
    TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(printResponseData: false)),
  );
  Bloc.observer = TalkerBlocObserver(talker: talker);
  getIt.registerSingleton<Dio>(dio);

  const secureStorage = FlutterSecureStorage();
  dio.interceptors.add(JwtInterceptor(secureStorage: secureStorage));
  getIt.registerSingleton<FlutterSecureStorage>(secureStorage);

  final authManager = AuthManager();
  await authManager.logout();
  await authManager.initUser();
  getIt.registerSingleton<AuthManager>(authManager);
}
