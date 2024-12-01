import 'package:cinema/repository/models/seat/seat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'confirm_state.dart';

class ConfirmCubit extends Cubit<ConfirmState> {
  ConfirmCubit() : super(ConfirmOff());
  bool timePicked = false;
  late String time;
  List<int> pickedSeatsIds = [];
  void changeTimePicked(bool value, String pickedTime) {
    timePicked = value;
    time = pickedTime;
    if (timePicked && pickedSeatsIds.isNotEmpty) {
      emit(ConfirmOn());
    } else {
      emit(ConfirmOff());
    }
  }

  void changeSeatPicked(Seat seat, bool isAdd) {
    isAdd == true
        ? pickedSeatsIds.add(seat.id)
        : pickedSeatsIds.remove(seat.id);
    if (timePicked && pickedSeatsIds.isNotEmpty) {
      emit(ConfirmOn());
    } else {
      emit(ConfirmOff());
    }
  }
}
