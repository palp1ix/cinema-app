import 'package:cinema/data/models/seat/seat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'confirm_state.dart';

class ConfirmCubit extends Cubit<ConfirmState> {
  ConfirmCubit() : super(ConfirmOff());
  bool timePicked = false;
  late String time;
  List<int> pickedSeatsIds = [];

  void changeSeatPicked(Seat seat, bool isAdd) {
    isAdd == true
        ? pickedSeatsIds.add(seat.id)
        : pickedSeatsIds.remove(seat.id);
    if (pickedSeatsIds.isNotEmpty) {
      emit(ConfirmOn());
    } else {
      emit(ConfirmOff());
    }
  }
}
