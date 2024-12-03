import 'package:auto_route/auto_route.dart';
import 'package:cinema/presentation/core/widgets/widgets.dart';
import 'package:cinema/presentation/movie/widgets/advanced_information_widget.dart';
import 'package:cinema/presentation/movie/widgets/information_container.dart';
import 'package:cinema/presentation/movie/widgets/trailer_view_widget.dart';
import 'package:cinema/data/models/session/session.dart';
import 'package:cinema/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MoviePage extends StatefulWidget {
  const MoviePage({
    super.key,
    required this.session,
  });
  final Session session;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Scaffold(
          body: CustomScrollView(
            controller: controller,
            slivers: [
              MovieAppBar(
                session: widget.session,
                scrollController: controller,
              ),
              SliverToBoxAdapter(
                  child: AdvancedInformationWidget(
                rating: widget.session.film.rating,
                genre: widget.session.film.genre,
                duration: widget.session.film.duration,
              )),
              SliverToBoxAdapter(
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.session.film.title,
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
                      widget.session.film.description,
                      style: const TextStyle(fontSize: 16),
                    )),
              ),
              SliverToBoxAdapter(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: TrailerViewWidget(
                        trailerUrl: widget.session.film.trailerYoutubeLink)),
              ),
              SliverToBoxAdapter(
                child: CinemaButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  onPressed: () {
                    context.router.push(TicketRoute(
                        title: widget.session.film.title,
                        session: widget.session));
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

class MovieAppBar extends StatefulWidget {
  const MovieAppBar({
    super.key,
    required this.session,
    required this.scrollController,
  });

  final Session session;
  final ScrollController scrollController;

  @override
  State<MovieAppBar> createState() => _MovieAppBarState();
}

class _MovieAppBarState extends State<MovieAppBar> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      final opacity = widget.scrollController.offset /
          (500); // Adjust this value to change when dimming starts
      setState(() {
        _opacity = opacity.clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

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
              widget.session.film.coverLink,
              fit: BoxFit.cover,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.surface.withOpacity(_opacity),
                    theme.colorScheme.surface.withOpacity(_opacity),
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