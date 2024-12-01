import 'package:cinema/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

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
                const InfoBlockWidget(
                  title: 'Фильм',
                  subtitle: 'Веном. Последний танец',
                ),
                const InfoBlockWidget(
                  title: 'Дата',
                  subtitle: '23.12',
                ),
                const InfoBlockWidget(
                  title: 'Время',
                  subtitle: '16:20',
                ),
                const InfoBlockWidget(
                  title: 'Места',
                  subtitle: '24  25',
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
                    onPressed: () {
                      if (_isSelected) {
                        // some logic for successed payment
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
