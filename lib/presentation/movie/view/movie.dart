import 'package:cinema/core/widgets/widgets.dart';
import 'package:cinema/presentation/movie/widgets/advanced_information_widget.dart';
import 'package:cinema/presentation/movie/widgets/information_container.dart';
import 'package:cinema/presentation/movie/widgets/trailer_view_widget.dart';
import 'package:cinema/presentation/ticket/view/ticket_page.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key, required this.title, required this.imageUrl});
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                        imageUrl,
                        width: 220,
                      ),
                    ),
                  ),
                  const AdvancedInformationWidget()
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
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                    ),
                  )),
            ),
            const SliverToBoxAdapter(child: InformationContainer()),
            const SliverToBoxAdapter(
              child: MainContainer(
                  title: 'Описание',
                  child: Text(
                    'Приспособившись к совместному существованию, Эдди и Веном стали друзьями и вместе сражаются со злодеями. Но теперь за Эдди охотятся военные, а за Веномом — его инопланетные сородичи, угрожающие всему живому.',
                    style: TextStyle(fontSize: 16),
                  )),
            ),
            SliverToBoxAdapter(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const TrailerViewWidget()),
            ),
            SliverToBoxAdapter(
              child: CinemaButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TicketPage()));
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
