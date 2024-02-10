import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? color;
  const CustomOutlinedButton({
    required this.label,
    this.onTap,
    this.color,
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
              border: Border.all(
                color: color ?? Theme.of(context).colorScheme.onSurface
              ),
              
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: color ?? Theme.of(context).colorScheme.onSurface
                  )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}