part of 'signin_bloc.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInProcced extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {}
