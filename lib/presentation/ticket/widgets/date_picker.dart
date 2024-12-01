import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: theme.colorScheme.onSecondary,
          onPrimary: theme.colorScheme.onSurface,
        ),
      ),
      child: EasyDateTimeLinePicker(
        focusedDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 5),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
        locale: const Locale('ru'),
      ),
    );
  }
}
