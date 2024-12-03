import 'package:json_annotation/json_annotation.dart';

part 'film.g.dart';

@JsonSerializable()
class Film {
  Film({
    required this.title,
    required this.description,
    required this.releaseDate,
    required this.genre,
    required this.rating,
    required this.cast,
    required this.duration,
    required this.trailerYoutubeLink,
    required this.coverLink,
  });

  final String title;
  final String description;
  final String releaseDate;
  final String genre;
  final int rating;
  final String cast;
  final String duration;
  final String trailerYoutubeLink;
  final String coverLink;

  /// Connect the generated [_$FilmFromJson] function to the `fromJson`
  /// factory.
  factory Film.fromJson(Map<String, dynamic> json) => _$FilmFromJson(json);

  /// Connect the generated [_$FilmToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FilmToJson(this);
}
