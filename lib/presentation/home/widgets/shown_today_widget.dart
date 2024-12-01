import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema/core/widgets/main_container.dart';
import 'package:cinema/presentation/home/bloc/sessions_bloc.dart';
import 'package:cinema/presentation/movie/view/movie.dart';
import 'package:cinema/repository/models/session/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShownTodayWidget extends StatefulWidget {
  const ShownTodayWidget({super.key});

  @override
  State<ShownTodayWidget> createState() => _ShownTodayWidgetState();
}

class _ShownTodayWidgetState extends State<ShownTodayWidget> {
  late SessionsBloc _bloc;
  @override
  void initState() {
    _bloc = context.read<SessionsBloc>();
    _bloc.add(GetSessions(date: DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionsBloc, SessionsState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is SessionsLoaded) {
          return MainContainer(
              title: 'Сегодня',
              child: CarouselSlider.builder(
                itemCount: state.sessions.length,
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  Session session = state.sessions[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MoviePage(
                                imageUrl: session.film.coverLink,
                                title: session.film.title)));
                      },
                      child: Image.network(
                        session.film.coverLink,
                        height: 320,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                    autoPlay: true, height: 320, viewportFraction: 0.68),
              ));
        } else {
          return Center(
              child: Container(
                  margin: const EdgeInsets.all(30),
                  child: const CircularProgressIndicator.adaptive()));
        }
      },
    );
  }
}
