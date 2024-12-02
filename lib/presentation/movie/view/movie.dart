import 'package:cinema/core/widgets/widgets.dart';
import 'package:cinema/presentation/movie/widgets/advanced_information_widget.dart';
import 'package:cinema/presentation/movie/widgets/information_container.dart';
import 'package:cinema/presentation/movie/widgets/trailer_view_widget.dart';
import 'package:cinema/presentation/ticket/view/ticket_page.dart';
import 'package:cinema/repository/models/session/session.dart';
import 'package:flutter/material.dart';

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
            const CinemaSliverAppBar(),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Image.network(
                        session.film.coverLink,
                        width: 220,
                      ),
                    ),
                  ),
                  AdvancedInformationWidget(
                    rating: session.film.rating,
                    genre: session.film.genre,
                    duration: session.film.duration,
                  )
                ],
              ),
            ),
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TicketPage(
                          title: session.film.title, session: session)));
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
      ),
    );
  }
}
