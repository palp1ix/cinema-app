import 'package:cinema/presentation/home/widgets/premiere_widget.dart';
import 'package:cinema/presentation/home/widgets/shown_today_widget.dart';
import 'package:cinema/presentation/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [CinemaSearchBar(), ShownTodayWidget(), PremiereWidget()],
        ),
      ),
    );
  }
}
