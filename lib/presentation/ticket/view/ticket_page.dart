import 'package:auto_route/auto_route.dart';
import 'package:cinema/presentation/core/widgets/widgets.dart';
import 'package:cinema/presentation/ticket/bloc/reserve_bloc/reserve_bloc.dart';
import 'package:cinema/presentation/ticket/bloc/seats_occupied_bloc/seats_occupied_bloc.dart';
import 'package:cinema/presentation/ticket/bloc/seats_picker_bloc/seats_picker_bloc.dart';
import 'package:cinema/presentation/ticket/bloc/seats_picker_cubit/confirm_cubit.dart';
import 'package:cinema/presentation/ticket/widgets/widgets.dart';
import 'package:cinema/data/models/session/session.dart';
import 'package:cinema/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

@RoutePage()
class TicketPage extends StatefulWidget {
  const TicketPage({super.key, required this.title, required this.session});
  final String title;
  final Session session;

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final _seatsPickerBloc = SeatsPickerBloc(9.6);
  final _seatsOccupiedBloc = SeatsOccupiedBloc();
  final _reserveBloc = ReserveBloc();

  final List<int> _pickedSeats = [];
  DateTime date = DateTime.now();

  @override
  void initState() {
    _seatsOccupiedBloc.add(GetOccupiedSeats(sessionId: widget.session.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ReserveBloc, ReserveState>(
      bloc: _reserveBloc,
      listener: (context, state) {
        if (state is ReserveDone) {
          Navigator.pop(context);
          context.router.push(PaymentRoute(
              selectedSeats: _pickedSeats,
              session: widget.session,
              date: date,
              reserve: state.reserve));
        } else if (state is ReserveInProgress) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else {
          Navigator.pop(context);
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _seatsPickerBloc,
          ),
          BlocProvider(create: (context) => ConfirmCubit()),
          BlocProvider(
            create: (context) => _seatsOccupiedBloc,
          ),
        ],
        child: MultiProvider(
          providers: [
            Provider(create: (context) => _pickedSeats),
          ],
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: DividerThemeData(
                color: theme.hintColor.withOpacity(0.3),
              ),
            ),
            child: Scaffold(
              persistentFooterButtons: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Text(
                              'Цена: ',
                              style: TextStyle(
                                  color: theme.hintColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            BlocBuilder<SeatsPickerBloc, SeatsPickerState>(
                              bloc: _seatsPickerBloc,
                              builder: (context, state) {
                                if (state is PriceCounted) {
                                  return Text(
                                    '${state.price}р',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: theme.primaryColor),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        )),
                    BlocBuilder<ConfirmCubit, ConfirmState>(
                      builder: (context, state) {
                        if (state is ConfirmOn) {
                          return CinemaButton(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            onPressed: () {
                              _reserveBloc.add(ReserveSeatsEvent(
                                  sessionId: widget.session.id,
                                  seatIds: _pickedSeats));
                            },
                            child: Text(
                              'Купить билет',
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          );
                        } else {
                          return CinemaButton(
                            isAnimated: false,
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            onPressed: () {},
                            color: theme.hintColor.withOpacity(0.3),
                            child: Text(
                              'Выберите все пункты',
                              style: TextStyle(
                                  color: theme.hintColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
              body: CustomScrollView(
                slivers: [
                  const CinemaSliverAppBar(),
                  SliverToBoxAdapter(
                    child: MainContainer(
                        title: widget.title,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.location_on,
                                size: 30,
                                color: theme.colorScheme.onSecondary,
                              ),
                              title: const Text(
                                'Кинотеатр «Минск»',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'пр. Независимости 62, Минск',
                                style: TextStyle(
                                    color: theme.hintColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )),
                  ),
                  SliverToBoxAdapter(
                    child: DatePicker(onDateChange: (value) {
                      date = value;
                    }),
                  ),
                  const SliverToBoxAdapter(
                    child: MainContainer(
                        title: 'Выбор мест', child: SeatsPickerWidget()),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
