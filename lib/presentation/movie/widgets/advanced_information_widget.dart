import 'package:cinema/presentation/movie/widgets/advanced_info_container.dart';
import 'package:flutter/material.dart';

class AdvancedInformationWidget extends StatelessWidget {
  const AdvancedInformationWidget({
    super.key,
    required this.rating,
    required this.genre,
    required this.duration,
  });
  final int rating;
  final String genre;
  final String duration;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        AdvancedInfoContainer(
          icon: Image.asset(
            'assets/icons/star.png',
            width: 25,
            height: 25,
            color: theme.colorScheme.onSurface,
          ),
          text: 'Rating',
          value: '$rating/10',
        ),
        AdvancedInfoContainer(
          icon: Image.asset(
            'assets/icons/genre.png',
            width: 25,
            height: 25,
            color: theme.colorScheme.onSurface,
          ),
          text: 'Genre',
          value: genre,
        ),
        AdvancedInfoContainer(
          icon: Image.asset(
            'assets/icons/clock.png',
            width: 25,
            height: 25,
            color: theme.colorScheme.onSurface,
          ),
          text: 'Duration',
          value: duration,
        )
      ],
    );
  }
}
