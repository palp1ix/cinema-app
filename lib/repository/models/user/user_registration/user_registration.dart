import 'package:cinema/repository/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_registration.g.dart';

@JsonSerializable()
class UserRegistration extends User {
  UserRegistration(
      {required this.email, required super.username, required super.password});

  final String email;

  factory UserRegistration.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserRegistrationToJson(this);
}
