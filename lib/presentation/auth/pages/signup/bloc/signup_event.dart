part of 'signup_bloc.dart';

abstract class SignUpEvent {}

class SignUpWithEmailPassword extends SignUpEvent {
  final String email;
  final String password;

  SignUpWithEmailPassword({required this.email, required this.password});
}
