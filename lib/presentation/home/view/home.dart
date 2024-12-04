import 'package:auto_route/auto_route.dart';
import 'package:cinema/presentation/home/bloc/sessions_bloc.dart';
import 'package:cinema/presentation/home/widgets/premiere_widget.dart';
import 'package:cinema/presentation/home/widgets/shown_today_widget.dart';
import 'package:cinema/presentation/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionsBloc(),
      child: const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CinemaSearchBar(),
                ShownTodayWidget(),
                PremiereWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
