import 'package:auto_route/auto_route.dart';
import 'package:cinema/presentation/core/widgets/widgets.dart';
import 'package:cinema/data/models/reserve/reserve.dart';
import 'package:cinema/data/models/session/session.dart';
import 'package:cinema/presentation/payment/bloc/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cinema/presentation/core/widgets/pdf_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {super.key,
      required this.selectedSeats,
      required this.session,
      required this.date,
      required this.reserve});

  final List<int> selectedSeats;
  final Session session;
  final DateTime date;
  final Reserve reserve;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isSelected = false;
  final _paymentBloc = PaymentBloc();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<PaymentBloc, PaymentState>(
      bloc: _paymentBloc,
      listener: (context, state) {
        if (state is PaymentSuccessed) {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) => SingleChildScrollView(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: PdfView(bytes: state.ticket),
                      ),
                    ),
                  )).whenComplete(() {
            if (mounted) {
              // ignore: use_build_context_synchronously
              context.router.replaceNamed('/');
            }
          });
        } else if (state is PaymentInProgress) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is PaymentError) {
          showDialog(
                  context: context,
                  builder: (context) =>
                      const Text('There was an error during payment'))
              .whenComplete(() {
            // ignore: use_build_context_synchronously
            if (mounted) Navigator.pop(context);
          });
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const CinemaSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Check information',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  InfoBlockWidget(
                    title: 'Movie',
                    subtitle: widget.session.film.title,
                  ),
                  InfoBlockWidget(
                    title: 'Date',
                    subtitle: _formatDate(widget.session.date),
                  ),
                  InfoBlockWidget(
                    title: 'Time',
                    subtitle: _formatTime(widget.session.date),
                  ),
                  InfoBlockWidget(
                    title: 'Seats',
                    subtitle: widget.selectedSeats.join(', '),
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
                            'I am aware that there are no refunds for unused tickets',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CinemaButton(
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        _paymentBloc.add(PayEvent(reserve: widget.reserve));
                      },
                      color: _isSelected ? null : theme.hintColor,
                      child: const Center(
                          child: Text('Buy',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateTime) {
    final fDate = dateTime.split('T')[0].split('-').reversed.toList();
    // Delete year
    fDate.removeLast();
    return fDate.join('.');
  }

  String _formatTime(String dateTime) {
    final fTime = dateTime.split('T')[1].split('.')[0].split(':');
    // Delete year
    fTime.removeLast();
    return fTime.join(':');
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
