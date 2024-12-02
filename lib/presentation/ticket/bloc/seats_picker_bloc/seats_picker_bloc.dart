import 'package:cinema/repository/models/seat/seat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seats_picker_event.dart';
part 'seats_picker_state.dart';

class SeatsPickerBloc extends Bloc<SeatsPickerEvent, SeatsPickerState> {
  double price = 0;
  final double initialPrice;
  SeatsPickerBloc(this.initialPrice) : super(SeatsPickerInitial()) {
    on<AddSeat>((event, emit) {
      price += initialPrice;
      final roundedPrice = double.parse(price.toStringAsFixed(1));
      emit(PriceCounted(price: roundedPrice));
    });
    on<DeleteSeat>((event, emit) {
      price -= initialPrice;
      final roundedPrice = double.parse(price.toStringAsFixed(1));
      emit(PriceCounted(price: roundedPrice));
    });
  }
}
