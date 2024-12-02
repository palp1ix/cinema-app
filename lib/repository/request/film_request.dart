import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:cinema/repository/models/film/film.dart';
import 'package:cinema/repository/models/session/session.dart';

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

  Future<void> setFilm(Film film) async {
    try {
      final data = film.toJson();
      await dio.post('$endpoint/api/films', data: data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setRoom() async {
    try {
      await dio.post('$endpoint/api/rooms', data: {'seats': []});
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setSession(int filmId, int roomId) async {
    try {
      await dio.post('$endpoint/api/sessions', data: {
        'filmId': filmId,
        'roomId': roomId,
        'date': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Session>> getSessionsByOffset(int dayOffset) async {
    try {
      // await setNewFilmRoomSession();
      // await changeFilmParam();
      // FIXME: Delete -1
      final response = await dio
          .get('$endpoint/api/sessions/current?daysOffset=${dayOffset - 1}');
      final data = response.data as List<dynamic>;
      final List<Session> sessions =
          data.map((e) => Session.fromJson(e)).toList();
      return sessions;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> changeFilmParam() async {
    await dio.patch('$endpoint/api/films/4', data: {
      'description':
          'Марсианская миссия «Арес-3» в процессе работы была вынуждена экстренно покинуть планету из-за надвигающейся песчаной бури. Инженер и биолог Марк Уотни получил повреждение скафандра во время песчаной бури. Сотрудники миссии, посчитав его погибшим, эвакуировались с планеты, оставив Марка одного. Очнувшись, Уотни обнаруживает, что связь с Землёй отсутствует, но при этом полностью функционирует жилой модуль. Главный герой начинает искать способ продержаться на имеющихся запасах еды, витаминов, воды и воздуха ещё 4 года до прилёта следующей миссии «Арес-4».'
    });
  }

  Future<void> setNewFilmRoomSession() async {
    await setFilm(Film(
        title: 'Марсианин',
        description: '',
        releaseDate: DateTime.now().toIso8601String(),
        genre: 'Фантастика',
        rating: 10,
        cast: '',
        duration: '2 ч 24 мин',
        trailerYoutubeLink: 'https://youtu.be/ej3ioOneTy8',
        coverLink:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/1900788/6f631486-e947-487d-94d6-41c2b5a8f5a0/600x900'));
    await setRoom();
    await setSession(4, 4);
  }
}
