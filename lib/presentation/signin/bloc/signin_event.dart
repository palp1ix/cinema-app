part of 'signin_bloc.dart';

abstract class SignInEvent {}

class SignInWithEmailPassword extends SignInEvent {
  final String email;
  final String password;

  SignInWithEmailPassword({required this.email, required this.password});
}
