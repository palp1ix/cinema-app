import 'package:flutter/material.dart';

class CinemaButton extends StatelessWidget {
  const CinemaButton({
    super.key,
    this.color,
    required this.child,
    this.borderRadius,
    required this.onPressed,
    this.padding,
    this.margin,
    this.width,
    this.isAnimated = true,
  });

  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final Color? color;
  final Widget child;
  final bool isAnimated;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: isAnimated
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(30),
                gradient: color == null
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.primaryColor,
                          theme.colorScheme.onSecondary,
                        ],
                      )
                    : LinearGradient(colors: [color!, color!]),
              ),
              width: width,
              margin: margin ??
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              padding: padding ?? const EdgeInsets.all(15),
              child: child)
          : Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(30),
                gradient: color == null
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.primaryColor,
                          theme.colorScheme.onSecondary,
                        ],
                      )
                    : LinearGradient(colors: [color!, color!]),
              ),
              width: width,
              margin: margin ??
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              padding: padding ?? const EdgeInsets.all(15),
              child: child),
    );
  }
}
