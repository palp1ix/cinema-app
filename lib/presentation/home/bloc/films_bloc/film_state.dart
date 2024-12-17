part of 'film_bloc.dart';

sealed class FilmState {}

final class FilmInitial extends FilmState {}

class AllFilmLoading extends FilmState {}

class AllFilmLoaded extends FilmState {
  final List<Film> films;

  AllFilmLoaded({required this.films});
}

class AllFilmError extends FilmState {
  final String message;

  AllFilmError({required this.message});
}
