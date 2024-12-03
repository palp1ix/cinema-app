import 'package:flutter/material.dart';

class CinemaTextField extends StatelessWidget {
  const CinemaTextField({
    super.key,
    required this.hintText,
    this.obscureText,
    required this.controller,
  });

  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        obscureText: obscureText ?? false,
        controller: controller,
        cursorColor: theme.primaryColor,
        decoration: InputDecoration(
            hintText: hintText, fillColor: theme.colorScheme.surfaceContainer),
      ),
    );
  }
}
