import 'package:cinema/presentation/movie/widgets/advanced_info_container.dart';
import 'package:flutter/material.dart';

class AdvancedInformationWidget extends StatelessWidget {
  const AdvancedInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        AdvancedInfoContainer(
          icon: Image.asset(
            'assets/icons/star.png',
            width: 25,
            height: 25,
            color: theme.primaryColor,
          ),
          text: 'Рейтинг',
          value: '8.9/10',
        ),
        AdvancedInfoContainer(
          icon: Image.asset(
            'assets/icons/genre.png',
            width: 25,
            height: 25,
            color: theme.primaryColor,
          ),
          text: 'Жанр',
          value: 'Фантастика',
        ),
        AdvancedInfoContainer(
          icon: Image.asset(
            'assets/icons/clock.png',
            width: 25,
            height: 25,
            color: theme.primaryColor,
          ),
          text: 'Длительность',
          value: '2ч 10м',
        )
      ],
    );
  }
}
