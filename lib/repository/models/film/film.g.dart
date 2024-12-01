// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Film _$FilmFromJson(Map<String, dynamic> json) => Film(
      title: json['title'] as String,
      releaseDate: json['releaseDate'] as String,
      genre: json['genre'] as String,
      rating: (json['rating'] as num).toInt(),
      cast: json['cast'] as String,
      duration: json['duration'] as String,
      trailerYoutubeLink: json['trailerYoutubeLink'] as String,
      coverLink: json['coverLink'] as String,
    );

Map<String, dynamic> _$FilmToJson(Film instance) => <String, dynamic>{
      'title': instance.title,
      'releaseDate': instance.releaseDate,
      'genre': instance.genre,
      'rating': instance.rating,
      'cast': instance.cast,
      'duration': instance.duration,
      'trailerYoutubeLink': instance.trailerYoutubeLink,
      'coverLink': instance.coverLink,
    };
