import 'package:cinema/core/widgets/widgets.dart';
import 'package:cinema/presentation/payment/view/payment.dart';
import 'package:cinema/presentation/ticket/bloc/seats_picker_bloc/seats_picker_bloc.dart';
import 'package:cinema/presentation/ticket/bloc/seats_picker_cubit/confirm_cubit.dart';
import 'package:cinema/presentation/ticket/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final _seatsPickerBloc = SeatsPickerBloc(9.6);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _seatsPickerBloc,
        ),
        BlocProvider(create: (context) => ConfirmCubit())
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const PaymentPage()));
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
                    title: 'Веном',
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
              const SliverToBoxAdapter(
                child: DatePicker(),
              ),
              const TimeShown(),
              const SliverToBoxAdapter(
                child: MainContainer(
                    title: 'Выбор мест', child: SeatsPickerWidget()),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TimeShown extends StatefulWidget {
  const TimeShown({
    super.key,
  });
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
            child: TimePickerWidget(times: const [
              '19:20',
              '20:20',
              '00:11',
              '00:12',
              '00:13',
            ], color: theme.colorScheme.onSecondary),
          )),
    );
  }
}
