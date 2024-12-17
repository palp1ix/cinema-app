import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema/presentation/core/widgets/main_container.dart';
import 'package:cinema/presentation/home/bloc/session_bloc/sessions_bloc.dart';
import 'package:cinema/data/models/session/session.dart';
import 'package:cinema/router/router.dart';
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
              title: 'Today',
              child: CarouselSlider.builder(
                itemCount: state.sessions.length,
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  Session session = state.sessions[index];
                  return GestureDetector(
                    onTap: () {
                      context.router.push(MovieRoute(session: session));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: session.film.coverLink,
                        height: 250,
                        fit: BoxFit.fill,
                        imageBuilder: (context, imageProvider) {
                          return Image(image: imageProvider);
                        },
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
