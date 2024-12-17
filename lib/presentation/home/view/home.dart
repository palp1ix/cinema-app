import 'package:auto_route/auto_route.dart';
import 'package:cinema/presentation/home/bloc/session_bloc/sessions_bloc.dart';
import 'package:cinema/presentation/home/widgets/for_you_widget.dart';
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
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CinemaSearchBar(),
              ),
              SliverToBoxAdapter(child: ShownTodayWidget()),
              SliverToBoxAdapter(child: PremiereWidget()),
              SliverToBoxAdapter(
                  child: Center(
                      child: Text(
                'For you',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ))),
              ForYouWidget()
            ],
          ),
        ),
      ),
    );
  }
}
