part of 'reserve_bloc.dart';

sealed class ReserveState {}

final class ReserveInitial extends ReserveState {}

final class ReserveDone extends ReserveState {
  final Reserve reserve;

  ReserveDone({required this.reserve});
}

final class ReserveInProgress extends ReserveState {}

final class ReserveError extends ReserveState {
  final String message;
  ReserveError({required this.message});
}
