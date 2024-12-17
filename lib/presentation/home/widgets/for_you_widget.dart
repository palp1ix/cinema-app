import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/data/repository/films_repository.dart';
import 'package:cinema/presentation/home/bloc/films_bloc/film_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:palette_generator/palette_generator.dart';

class ForYouWidget extends StatefulWidget {
  const ForYouWidget({
    super.key,
  });

  @override
  State<ForYouWidget> createState() => _ForYouWidgetState();
}

class _ForYouWidgetState extends State<ForYouWidget> {
  final filmBloc = FilmBloc(FilmsRepositoryImpl(GetIt.I<Dio>()));
  final Map<String, Color> _accentColors = {};

  @override
  void initState() {
    filmBloc.add(GetAllFilmsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<FilmBloc, FilmState>(
      bloc: filmBloc,
      builder: (context, state) {
        if (state is AllFilmLoaded) {
          return SliverList.builder(
              itemCount: state.films.length,
              itemBuilder: (context, index) {
                final film = state.films[index];
                final accentColor = _accentColors[film.title] ??
                    theme.colorScheme.surfaceContainer;
                return Container(
                  key: ValueKey(film.title),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        accentColor.withOpacity(0.2),
                        accentColor.withOpacity(0.3),
                        accentColor.withOpacity(0.4),
                        accentColor.withOpacity(0.7),
                      ]),
                      border: Border.all(
                          color: theme.colorScheme.surfaceContainer, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: film.coverLink,
                            width: 120,
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) {
                              _updateAccentColor(film.title, imageProvider);
                              return Image(image: imageProvider);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            film.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/icons/star.png',
                                color: Colors.amber,
                                width: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                film.rating.toString(),
                                style: const TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            film.genre,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ))
                    ],
                  ),
                );
              });
        } else if (state is AllFilmLoading) {
          return const SliverToBoxAdapter(
              child: Center(
            child: CircularProgressIndicator.adaptive(),
          ));
        } else {
          return const SliverToBoxAdapter(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }

  Future<void> _updateAccentColor(
      String filmId, ImageProvider imageProvider) async {
    if (_accentColors.containsKey(filmId)) return;

    final palette = await PaletteGenerator.fromImageProvider(imageProvider);
    if (palette.dominantColor != null) {
      setState(() {
        _accentColors[filmId] = palette.dominantColor!.color;
      });
    }
  }
}
