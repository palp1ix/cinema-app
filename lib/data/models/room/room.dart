import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  const Room({
    required this.id,
  });

  final int id;

  /// Connect the generated [_$RoomFromJson] function to the `fromJson`
  /// factory.
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  /// Connect the generated [_$RoomToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
