part of 'seats_picker_bloc.dart';

abstract class SeatsPickerEvent {}

class AddSeat extends SeatsPickerEvent {
  final Seat seat;
  AddSeat({required this.seat});
}

class DeleteSeat extends SeatsPickerEvent {
  final Seat seat;
  DeleteSeat({required this.seat});
}
