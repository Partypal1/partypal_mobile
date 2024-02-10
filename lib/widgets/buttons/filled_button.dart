import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? labelColor;
  final Color? backgroundColor;

  const CustomFilledButton({
    required this.label,
    this.onTap,
    this.labelColor,
    this.backgroundColor,
    super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FittedBox(
        child: SizedBox(
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor ?? Theme.of(context).colorScheme.inverseSurface
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: labelColor ?? Theme.of(context).colorScheme.onInverseSurface
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
