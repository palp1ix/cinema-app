import 'package:cinema/core/widgets/widgets.dart';
import 'package:cinema/repository/models/reserve/reserve.dart';
import 'package:cinema/repository/models/session/session.dart';
import 'package:cinema/repository/request/reserve_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {super.key,
      required this.selectedSeats,
      required this.session,
      required this.date,
      required this.time,
      required this.reserve});

  final List<int> selectedSeats;
  final Session session;
  final DateTime date;
  final String time;
  final Reserve reserve;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CinemaSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Проверьте информацию',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                InfoBlockWidget(
                  title: 'Фильм',
                  subtitle: widget.session.film.title,
                ),
                InfoBlockWidget(
                  title: 'Дата',
                  subtitle: '${widget.date.day}.${widget.date.month}',
                ),
                InfoBlockWidget(
                  title: 'Время',
                  subtitle: widget.time,
                ),
                InfoBlockWidget(
                  title: 'Места',
                  subtitle: widget.selectedSeats.toString(),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Checkbox(
                          value: _isSelected,
                          activeColor: theme.primaryColor,
                          onChanged: (value) {
                            setState(() {
                              _isSelected = value ?? false;
                            });
                          }),
                      const Flexible(
                        child: Text(
                          'Я осознаю, что денежные средства за неиспользованный билет не возвращаются',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                CinemaButton(
                    width: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      if (_isSelected) {
                        final reserveRequest =
                            ReserveRequest(dio: GetIt.I<Dio>());
                        final id = await reserveRequest.buy(widget.reserve);
                        final ticket = await reserveRequest.getTicket(id);
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await ImageGallerySaver.saveFile(
                                              ticket.path,
                                              isReturnPathOfIOS: true);
                                        },
                                        child: RotatedBox(
                                          quarterTurns: 45,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                right: 100),
                                            child: Image.file(ticket),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                      }
                    },
                    color: _isSelected ? null : theme.hintColor,
                    child: const Center(
                        child: Text('Оплатить',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InfoBlockWidget extends StatelessWidget {
  const InfoBlockWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MainContainer(
        title: title,
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: theme.colorScheme.surfaceContainer),
            child: Text(
              subtitle,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: theme.hintColor),
            )));
  }
}
