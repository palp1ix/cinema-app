// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cinema/data/models/film/film.dart';
import 'package:cinema/domain/repository/films_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'film_event.dart';
part 'film_state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final FilmsRepository filmRepository;
  final Talker talker = GetIt.I<Talker>();
  FilmBloc(
    this.filmRepository,
  ) : super(FilmInitial()) {
    on<FilmEvent>((event, emit) async {
      try {
        emit(AllFilmLoading());
        final films = await filmRepository.getFilms();
        emit(AllFilmLoaded(films: films));
      } catch (e, st) {
        talker.handle(e, st);
        emit(AllFilmError(message: e.toString()));
      }
    });
  }
}
