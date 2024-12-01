import 'package:cinema/presentation/ticket/bloc/seats_picker_bloc/seats_picker_bloc.dart';
import 'package:cinema/presentation/ticket/bloc/seats_picker_cubit/confirm_cubit.dart';
import 'package:cinema/repository/models/seat/seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatSelectionWidget extends StatefulWidget {
  final List<Seat> seats;

  const SeatSelectionWidget({
    super.key,
    required this.seats,
  });

  @override
  State<SeatSelectionWidget> createState() => _SeatSelectionWidgetState();
}

class _SeatSelectionWidgetState extends State<SeatSelectionWidget> {
  final List<Seat> selectedSeats = [];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<SeatsPickerBloc>();
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6, // Number of rows
      itemBuilder: (context, rowIndex) {
        int seatsInRow =
            7 + (rowIndex * 2); // Starts with 4 seats, adds 2 each row
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(seatsInRow, (seatIndex) {
              // Calculate index based on the sum of seats in previous rows plus current seat index
              int index = 0;
              for (int i = 0; i < rowIndex; i++) {
                index += 7 + (i * 2); // Add seats from previous rows
              }
              index += seatIndex; // Add current seat position
              final seat =
                  index < widget.seats.length ? widget.seats[index] : null;

              if (seat == null) return const SizedBox(width: 20, height: 20);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.65),
                child: GestureDetector(
                  onTap: () {
                    if (seat.status == SeatStatus.free) {
                      final cubitConfirm = context.read<ConfirmCubit>();
                      setState(() {
                        if (selectedSeats.contains(seat)) {
                          selectedSeats.remove(seat);
                          bloc.add(DeleteSeat(seat: seat));
                          cubitConfirm.changeSeatPicked(seat, false);
                        } else {
                          selectedSeats.add(seat);
                          bloc.add(AddSeat(seat: seat));
                          cubitConfirm.changeSeatPicked(seat, true);
                        }
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: selectedSeats.contains(seat)
                          ? theme.primaryColor // Выбрано
                          : seat.status == SeatStatus.occupied
                              ? theme.hintColor // Занято
                              : theme.colorScheme.onSurface, // Свободно
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
