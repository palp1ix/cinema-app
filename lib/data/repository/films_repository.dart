import 'package:cinema/data/remote_data_source/film_request.dart';
import 'package:cinema/domain/repository/films_repository.dart';
import 'package:dio/dio.dart';

class FilmsRepositoryImpl implements FilmsRepository {
  FilmsRepositoryImpl(this.dio);

  final Dio dio;

  @override
  Future getFilms() {
    final filmRequest = FilmRequest(dio: dio);
    final filmsList = filmRequest.getAllFilms();
    return filmsList;
  }
}
