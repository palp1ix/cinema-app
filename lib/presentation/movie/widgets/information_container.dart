import 'package:flutter/material.dart';

class InformationContainer extends StatelessWidget {
  const InformationContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.rocket_launch,
            color: theme.primaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Купи один билет - получи второй бесплатно',
              style: TextStyle(
                  color: theme.primaryColor, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
