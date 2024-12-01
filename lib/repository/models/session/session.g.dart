// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: (json['id'] as num).toInt(),
      filmId: (json['filmId'] as num).toInt(),
      date: json['date'] as String,
      film: Film.fromJson(json['film'] as Map<String, dynamic>),
      room: Room.fromJson(json['room'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'filmId': instance.filmId,
      'date': instance.date,
      'film': instance.film,
      'room': instance.room,
    };
