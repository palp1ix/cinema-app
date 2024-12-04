import 'package:flutter/material.dart';

class AdvancedInfoContainer extends StatelessWidget {
  const AdvancedInfoContainer({
    super.key,
    required this.icon,
    required this.text,
    required this.value,
  });
  final Widget icon;
  final String text;
  final String value;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Flexible(
      child: Container(
        width: 130,
        decoration: BoxDecoration(
            border:
                Border.all(color: theme.colorScheme.surfaceContainer, width: 3),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            icon,
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
