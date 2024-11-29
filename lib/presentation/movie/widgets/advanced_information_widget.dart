import 'package:cinema/presentation/movie/widgets/advanced_info_container.dart';
import 'package:flutter/material.dart';

class AdvancedInformationWidget extends StatelessWidget {
  const AdvancedInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AdvancedInfoContainer(
          icon: Icons.star_rounded,
          text: 'Рейтинг',
          value: '8.9/10',
        ),
        AdvancedInfoContainer(
          icon: Icons.movie_creation,
          text: 'Жанр',
          value: 'Фантастика',
        ),
        AdvancedInfoContainer(
          icon: Icons.schedule_rounded,
          text: 'Длительность',
          value: '2ч 10м',
        )
      ],
    );
  }
}
