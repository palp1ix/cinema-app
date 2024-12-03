import 'package:auto_route/auto_route.dart';
import 'package:cinema/presentation/core/widgets/widgets.dart';
import 'package:cinema/presentation/movie/widgets/advanced_information_widget.dart';
import 'package:cinema/presentation/movie/widgets/information_container.dart';
import 'package:cinema/presentation/movie/widgets/trailer_view_widget.dart';
import 'package:cinema/data/models/session/session.dart';
import 'package:cinema/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MoviePage extends StatelessWidget {
  const MoviePage({
    super.key,
    required this.session,
  });
  final Session session;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              MovieAppBar(session: session),
              SliverToBoxAdapter(
                  child: AdvancedInformationWidget(
                rating: session.film.rating,
                genre: session.film.genre,
                duration: session.film.duration,
              )),
              SliverToBoxAdapter(
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          session.film.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ),
                    )),
              ),
              const SliverToBoxAdapter(child: InformationContainer()),
              SliverToBoxAdapter(
                child: MainContainer(
                    title: 'Описание',
                    child: Text(
                      session.film.description,
                      style: const TextStyle(fontSize: 16),
                    )),
              ),
              SliverToBoxAdapter(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: TrailerViewWidget(
                        trailerUrl: session.film.trailerYoutubeLink)),
              ),
              SliverToBoxAdapter(
                child: CinemaButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  onPressed: () {
                    context.router.push(TicketRoute(
                        title: session.film.title, session: session));
                  },
                  child: const Text(
                    'Забронировать',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 500,
      stretch: true, // Enables stretching effect
      backgroundColor:
          Colors.transparent, // Makes the AppBar background transparent
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              session.film.coverLink,
              fit: BoxFit.cover,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    theme.colorScheme.surface,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// SliverToBoxAdapter(
//                 child: AdvancedInformationWidget(
//               rating: session.film.rating,
//               genre: session.film.genre,
//               duration: session.film.duration,
//             )),
//             SliverToBoxAdapter(
//               child: Align(
//                   alignment: Alignment.center,
//                   child: Container(
//                     margin: const EdgeInsets.only(left: 0),
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(
//                         session.film.title,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 28),
//                       ),
//                     ),
//                   )),
//             ),
//             const SliverToBoxAdapter(child: InformationContainer()),
//             SliverToBoxAdapter(
//               child: MainContainer(
//                   title: 'Описание',
//                   child: Text(
//                     session.film.description,
//                     style: const TextStyle(fontSize: 16),
//                   )),
//             ),
//             SliverToBoxAdapter(
//               child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: TrailerViewWidget(
//                       trailerUrl: session.film.trailerYoutubeLink)),
//             ),
//             SliverToBoxAdapter(
//               child: CinemaButton(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                 onPressed: () {
//                   context.router.push(
//                       TicketRoute(title: session.film.title, session: session));
//                 },
//                 child: const Text(
//                   'Забронировать',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
//                 ),
//               ),
//             )