part of 'sessions_bloc.dart';

class SessionsState {}

class SessionsInitial extends SessionsState {}

class SessionsLoading extends SessionsState {}

class SessionsLoaded extends SessionsState {
  final List<Session> sessions;

  SessionsLoaded(this.sessions);
}

class SessionsError extends SessionsState {
  final String message;

  SessionsError(this.message);
}
