import 'package:cinema/data/models/reserve/reserve.dart';
import 'package:cinema/domain/auth_manager/auth_manager.dart';
import 'package:cinema/domain/repository/reserve_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'reserve_event.dart';
part 'reserve_state.dart';

class ReserveBloc extends Bloc<ReserveEvent, ReserveState> {
  final talker = GetIt.I<Talker>();
  final ReserveRepository repository;
  ReserveBloc(this.repository) : super(ReserveInitial()) {
    on<ReserveSeatsEvent>((event, emit) async {
      emit(ReserveInProgress());
      try {
        // FIXME: Delete this logic
        await Future.delayed(const Duration(seconds: 1));
        final userId = await GetIt.I<AuthManager>().getId();
        final reserve = Reserve(
            userId: userId, sessionId: event.sessionId, seatIds: event.seatIds);
        await repository.reserve(reserve);
        emit(ReserveDone(reserve: reserve));
      } catch (e, st) {
        talker.handle(e, st);
        emit(ReserveError(message: e.toString()));
      }
    });
  }
}
