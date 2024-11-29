import 'package:flutter/material.dart';

class CinemaSearchBar extends StatelessWidget {
  const CinemaSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: theme.hintColor,
          ),
          const SizedBox(width: 15),
          Text(
            'Поиск',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.hintColor),
          )
        ],
      ),
    );
  }
}
