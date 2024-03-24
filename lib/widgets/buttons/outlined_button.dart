import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? color;
  final IconData? iconData;
  const CustomOutlinedButton({
    required this.label,
    this.onTap,
    this.color,
    this.iconData,
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
              padding: iconData == null
                ? const EdgeInsets.symmetric(horizontal: 24)
                : const EdgeInsets.only(left: 16, right: 24),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    iconData != null
                    ? Icon(
                      iconData,
                      size: 18,
                      color: color ?? Theme.of(context).colorScheme.onSurface,
                    )
                    : const SizedBox.shrink(),

                    iconData != null
                    ? 8.horizontalSpace
                    : const SizedBox.shrink(),

                    Text(
                      label,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: color ?? Theme.of(context).colorScheme.onSurface
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}