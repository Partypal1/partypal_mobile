import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFilledButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? labelColor;
  final Color? backgroundColor;
  final IconData? iconData;

  const CustomFilledButton({
    required this.label,
    this.onTap,
    this.labelColor,
    this.backgroundColor,
    this.iconData,
    super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: backgroundColor ?? Theme.of(context).colorScheme.inverseSurface
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
                        color: labelColor ?? Theme.of(context).colorScheme.onInverseSurface,
                      )
                      : const SizedBox.shrink(),
          
                      iconData != null
                      ? 8.horizontalSpace
                      : const SizedBox.shrink(),
          
                      Text(
                        label,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: labelColor ?? Theme.of(context).colorScheme.onInverseSurface
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
