part of 'movie_bloc.dart';

class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}

class MovieLoaded extends MovieState {
  final Film film;

  MovieLoaded(this.film);
}
