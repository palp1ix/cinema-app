import 'package:cinema/router/router.dart';
import 'package:flutter/material.dart';
import 'package:cinema/presentation/core/theme/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CinemaApp extends StatelessWidget {
  CinemaApp({super.key});

  final talker = GetIt.I<Talker>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      routerConfig: AppRouter().config(
        navigatorObservers: () => [
          TalkerRouteObserver(talker),
        ],
      ),
    );
  }
}
