part of 'seats_picker_bloc.dart';

class SeatsPickerState {}

class SeatsPickerInitial extends SeatsPickerState {}

class PriceCounted extends SeatsPickerState {
  final double price;

  PriceCounted({required this.price});
}
