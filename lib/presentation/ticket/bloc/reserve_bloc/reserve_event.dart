part of 'reserve_bloc.dart';

sealed class ReserveEvent {}

class ReserveSeatsEvent extends ReserveEvent {
  final int sessionId;
  final List<int> seatIds;

  ReserveSeatsEvent({required this.sessionId, required this.seatIds});
}
