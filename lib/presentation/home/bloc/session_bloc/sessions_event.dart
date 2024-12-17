part of 'sessions_bloc.dart';

class SessionsEvent {}

class GetSessions extends SessionsEvent {
  final DateTime date;

  GetSessions({required this.date});
}
