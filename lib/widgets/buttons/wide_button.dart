import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? labelColor;

  const WideButton({
    required this.label,
    this.onTap,
    this.backgroundColor,
    this.labelColor,
    super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 60,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: backgroundColor ?? Theme.of(context).colorScheme.inverseSurface
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: labelColor ?? Theme.of(context).colorScheme.surface
              )
            ),
          ),
        ),
      ),
    );
  }
}