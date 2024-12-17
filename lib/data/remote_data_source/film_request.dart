import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:cinema/data/models/film/film.dart';
import 'package:cinema/data/models/session/session.dart';

class FilmRequest {
  FilmRequest({
    required this.dio,
  });
  final Dio dio;
  final endpoint = dotenv.get('ENDPOINT');

  Future<Film> getFilmById(int id) async {
    try {
      final response = await dio.get('$endpoint/api/films/$id');
      final data = response.data;
      final Film film = Film.fromJson(data);
      return film;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Film>> getAllFilms() async {
    try {
      final response = await dio.get('$endpoint/api/films/');
      final data = response.data;
      if (data.isEmpty) throw Exception('Films list is empty');
      final List<Film> films = List.from(data.map((e) => Film.fromJson(e)));
      return films;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Session>> getSessionsByOffset(int dayOffset) async {
    try {
      // FIXME: Delete -16
      final response = await dio
          .get('$endpoint/api/sessions/current?daysOffset=${dayOffset - 16}');
      final data = response.data as List<dynamic>;
      if (data.isEmpty) throw Exception('Sessions list is empty');
      final List<Session> sessions =
          data.map((e) => Session.fromJson(e)).toList();
      return sessions;
    } catch (e) {
      throw Exception(e);
    }
  }
}
