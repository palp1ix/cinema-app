import 'package:cinema/data/models/film/film.dart';
import 'package:cinema/data/models/room/room.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  final int id;
  final int filmId;
  final String date;
  final Film film;
  final Room room;

  Session({
    required this.id,
    required this.filmId,
    required this.date,
    required this.film,
    required this.room,
  });

  /// Connect the generated [_$SessionFromJson] function to the `fromJson`
  /// factory.
  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  /// Connect the generated [_$SessionToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
