import 'package:flutter/material.dart';

class CinemaButton extends StatelessWidget {
  const CinemaButton({
    super.key,
    required this.color,
    required this.child,
    this.borderRadius,
    required this.onPressed,
  });

  final BorderRadius? borderRadius;
  final Color color;
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(30),
            color: color,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          padding: const EdgeInsets.all(15),
          child: child),
    );
  }
}
