// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistration _$UserRegistrationFromJson(Map<String, dynamic> json) =>
    UserRegistration(
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserRegistrationToJson(UserRegistration instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
    };
