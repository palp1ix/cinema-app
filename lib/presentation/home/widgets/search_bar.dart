import 'package:auto_route/auto_route.dart';
import 'package:cinema/router/router.dart';
import 'package:flutter/material.dart';

class CinemaSearchBar extends StatelessWidget {
  const CinemaSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: MediaQuery.of(context).size.width - 100,
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
                'Search',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.hintColor),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: theme.hintColor.withOpacity(0.1)),
          width: 45,
          height: 45,
          child: IconButton(
            onPressed: () {
              context.router.push(const SignInRoute());
            },
            icon: const Icon(Icons.person),
            color: theme.hintColor,
          ),
        ),
        const SizedBox(width: 5)
      ],
    );
  }
}
