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