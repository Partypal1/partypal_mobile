import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? color;

  const CustomTextButton({
    required this.label,
    this.onTap,
    this.color,
    super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: color ?? Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold
                )
              ),
          ),
        ),
      ),
    );
  }
}