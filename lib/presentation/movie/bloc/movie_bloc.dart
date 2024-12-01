import 'package:cinema/repository/models/film/film.dart';
import 'package:cinema/repository/request/film_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'movie_state.dart';
part 'movie_event.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<GetFilmById>((event, emit) async {
      emit(MovieLoading());
      try {
        final dio = GetIt.I<Dio>();
        final filmRequest = FilmRequest(dio: dio);
        final filmInfo = await filmRequest.getFilmById(event.id);
        emit(MovieLoaded(filmInfo));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
  }
}
