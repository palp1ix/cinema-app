import 'package:cinema/presentation/ticket/bloc/seats_occupied_bloc/seats_occupied_bloc.dart';
import 'package:cinema/presentation/ticket/widgets/seat_selection_widget.dart';
import 'package:cinema/data/models/seat/seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatsPickerWidget extends StatelessWidget {
  const SeatsPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SeatsPickerHeader(),
        SeatsPickerBody(),
      ],
    );
  }
}

class SeatsPickerHeader extends StatelessWidget {
  const SeatsPickerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        InfoElement(color: theme.colorScheme.onSurface, text: 'Доступно'),
        InfoElement(color: theme.hintColor, text: 'Занято'),
        InfoElement(color: theme.primaryColor, text: 'Выбрано'),
      ],
    );
  }
}

class SeatsPickerBody extends StatelessWidget {
  const SeatsPickerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SeatsOccupiedBloc>();
    return Column(
      children: [
        const ScreenWidget(),
        SizedBox(
          height: 250,
          child: BlocBuilder<SeatsOccupiedBloc, SeatsOccupiedState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is SeatsLoaded) {
                return SeatSelectionWidget(
                  seats: List.generate(
                    89,
                    (index) => Seat(
                      id: index + 1,
                      status: state.seats.contains(index)
                          ? SeatStatus.occupied
                          : SeatStatus.free,
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class ScreenWidgetPath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // Set the color of the line
      ..strokeWidth = 2 // Set the width of the line
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.5, 0, size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width * 0.85,
          70), // Set the size of the canvas
      painter: ScreenWidgetPath(),
    );
  }
}

class InfoElement extends StatelessWidget {
  const InfoElement({super.key, required this.color, required this.text});
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
