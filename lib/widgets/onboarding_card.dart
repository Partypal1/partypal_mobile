import 'package:flutter/material.dart';

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
              color: Colors.white.withOpacity(0.95),
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
                      color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
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