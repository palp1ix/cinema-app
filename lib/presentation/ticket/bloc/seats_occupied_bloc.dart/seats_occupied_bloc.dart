import 'package:cinema/repository/request/seats_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SeatsOccupiedBloc extends Bloc<SeatsOccupiedEvent, SeatsOccupiedState> {
  SeatsOccupiedBloc() : super(SeatsOccupiedInitial()) {
    on<GetOccupiedSeats>((event, emit) async {
      emit(SeatsLoading());
      try {
        final seatsRequest = SeatsRequest(dio: GetIt.I<Dio>());
        await seatsRequest.getOccupiedSeats(event.sessionId).then((value) {
          emit(SeatsLoaded(seats: value));
        });
      } catch (e) {
        emit(SeatsError(error: e.toString()));
      }
    });
  }
}

class SeatsOccupiedEvent {}

class GetOccupiedSeats extends SeatsOccupiedEvent {
  final int sessionId;
  GetOccupiedSeats({required this.sessionId});
}

class SeatsOccupiedState {}

class SeatsOccupiedInitial extends SeatsOccupiedState {}

class SeatsLoading extends SeatsOccupiedState {}

class SeatsLoaded extends SeatsOccupiedState {
  final List<int> seats;

  SeatsLoaded({required this.seats});
}

class SeatsError extends SeatsOccupiedState {
  final String error;

  SeatsError({required this.error});
}
