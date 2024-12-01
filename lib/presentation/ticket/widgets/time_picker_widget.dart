import 'package:cinema/presentation/ticket/bloc/seats_picker_cubit/confirm_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimePickerWidget extends StatefulWidget {
  final List<String> times;
  final Color color;

  const TimePickerWidget({
    super.key,
    required this.times,
    required this.color,
  });
  @override
  // ignore: library_private_types_in_public_api
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  String? _selectedTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.times.map((time) {
        final isSelected = _selectedTime == time;
        return GestureDetector(
          onTap: () {
            setState(() {
              context.read<ConfirmCubit>().changeTimePicked(true, time);
              _selectedTime = time;
            });
          },
          child: FittedBox(
            fit: BoxFit.cover,
            child: AnimatedContainer(
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? widget.color : Colors.transparent,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: isSelected ? widget.color : theme.hintColor,
                  width: 2.0,
                ),
              ),
              child: Text(
                time,
                style: TextStyle(
                    color: isSelected
                        ? theme.colorScheme.onSurface
                        : theme.hintColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
