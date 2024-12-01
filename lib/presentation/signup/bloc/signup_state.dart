part of 'signup_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpProcced extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {}
