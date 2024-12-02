import 'package:cinema/core/widgets/widgets.dart';
import 'package:cinema/presentation/payment/view/payment.dart';
import 'package:cinema/presentation/ticket/bloc/seats_occupied_bloc.dart/seats_occupied_bloc.dart';
import 'package:cinema/presentation/ticket/bloc/seats_picker_bloc/seats_picker_bloc.dart';
import 'package:cinema/presentation/ticket/bloc/seats_picker_cubit/confirm_cubit.dart';
import 'package:cinema/presentation/ticket/widgets/widgets.dart';
import 'package:cinema/repository/managers/auth_manager/auth_manager.dart';
import 'package:cinema/repository/models/reserve/reserve.dart';
import 'package:cinema/repository/models/session/session.dart';
import 'package:cinema/repository/request/reserve_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

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
  final List<int> _pickedSeats = [];
  String time = '';
  DateTime date = DateTime.now();

  @override
  void initState() {
    _seatsOccupiedBloc.add(GetOccupiedSeats(sessionId: widget.session.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocProvider(
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
                          onPressed: () async {
                            final reserveRequest =
                                ReserveRequest(dio: GetIt.I<Dio>());
                            final userId = await GetIt.I<AuthManager>().getId();
                            final reserve = Reserve(
                                userId: userId ?? 1,
                                sessionId: widget.session.id,
                                seatIds: _pickedSeats);
                            reserveRequest.reserve(reserve);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaymentPage(
                                      session: widget.session,
                                      selectedSeats: _pickedSeats,
                                      date: date,
                                      time: time,
                                      reserve: reserve,
                                    )));
                          },
                          child: Text(
                            'Купить билет',
                            style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
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
                                fontSize: 20),
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
                TimeShown(onTimeChanged: (value) {
                  time = value;
                }),
                const SliverToBoxAdapter(
                  child: MainContainer(
                      title: 'Выбор мест', child: SeatsPickerWidget()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimeShown extends StatefulWidget {
  const TimeShown({
    super.key,
    required this.onTimeChanged,
  });
  final Function(String) onTimeChanged;
  @override
  State<TimeShown> createState() => _TimeShownState();
}

class _TimeShownState extends State<TimeShown> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: MainContainer(
          title: 'Время показа',
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: TimePickerWidget(
                times: const [
                  '13:10',
                  '14:50',
                  '16:45',
                  '17:30',
                  '22:10',
                ],
                color: theme.colorScheme.onSecondary,
                onTimeChanged: widget.onTimeChanged),
          )),
    );
  }
}
