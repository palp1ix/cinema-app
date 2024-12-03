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
                SomeInfoWidget(),
                PremiereWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SomeInfoWidget extends StatelessWidget {
  const SomeInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: theme.colorScheme.surfaceContainer,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 20,
                spreadRadius: 3,
                color: theme.hintColor.withOpacity(0.12)),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                'Скидки до 70%',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor),
              ),
              Text(
                'До 1 Января',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.hintColor),
              ),
            ],
          ),
          Image.asset(
            'assets/images/cinema.png',
            width: 160,
          )
        ],
      ),
    );
  }
}
