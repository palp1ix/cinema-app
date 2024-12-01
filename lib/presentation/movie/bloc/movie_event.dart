part of 'movie_bloc.dart';

class MovieEvent {}

class GetFilmById extends MovieEvent {
  final int id;

  GetFilmById({required this.id});
}
