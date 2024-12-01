import 'package:cinema/repository/models/session/session.dart';
import 'package:cinema/repository/request/film_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'sessions_event.dart';
part 'sessions_state.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  SessionsBloc() : super(SessionsInitial()) {
    on<GetSessions>((event, emit) async {
      emit(SessionsLoading());
      try {
        final today = DateTime.now().day;
        final dayOffset = event.date.day - today;
        final dio = GetIt.I<Dio>();
        final filmRequest = FilmRequest(dio: dio);
        final List<Session> sessions =
            await filmRequest.getSessionsByOffset(dayOffset);
        emit(SessionsLoaded(sessions));
      } catch (e) {
        emit(SessionsError(e.toString()));
      }
    });
  }
}
