import 'package:flutter/material.dart';
import 'package:partypal/widgets/tonal_elevation.dart';

class OnboardingCard extends StatelessWidget {
  final String title;
  final String body;
  final MediaQueryData mediaQueryData;
 
  const OnboardingCard({
    required this.title,
    required this.body,
    required this.mediaQueryData,
    super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          // width: mediaQueryData.size.aspectRatio >= 0.7 ? mediaQueryData.size.width / 2 : null,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 600
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level4, context),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}