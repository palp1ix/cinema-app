import 'package:cinema/core/widgets/app_bar.dart';
import 'package:cinema/core/widgets/main_container.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
                        color: theme.primaryColor,
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
          )
        ],
      ),
    );
  }
}
