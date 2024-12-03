import 'package:json_annotation/json_annotation.dart';

part 'reserve.g.dart';

@JsonSerializable()
class Reserve {
  Reserve(
      {required this.userId, required this.sessionId, required this.seatIds});

  final int userId;
  final int sessionId;
  final List<int> seatIds;

  /// Connect the generated [_$ReserveFromJson] function to the `fromJson`
  /// factory.
  factory Reserve.fromJson(Map<String, dynamic> json) =>
      _$ReserveFromJson(json);

  /// Connect the generated [_$ReserveToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReserveToJson(this);
}
