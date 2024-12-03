// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reserve _$ReserveFromJson(Map<String, dynamic> json) => Reserve(
      userId: (json['userId'] as num).toInt(),
      sessionId: (json['sessionId'] as num).toInt(),
      seatIds: (json['seatIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$ReserveToJson(Reserve instance) => <String, dynamic>{
      'userId': instance.userId,
      'sessionId': instance.sessionId,
      'seatIds': instance.seatIds,
    };
