import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/widgets/others/shimmer.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final String desciption;
  final String imagePath;

  const CategoryCard({
    required this.category,
    required this.desciption,
    required this.imagePath,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 0.7.sw,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(imagePath, fit: BoxFit.cover,)
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    top: 10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white
                        ),
                      ),
                      3.verticalSpace,
                      Text(
                        desciption,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCardLoading extends StatelessWidget {
  const CategoryCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Center(
        child: SizedBox.square(
          dimension: 0.7.sw,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              
              children: [
                const Expanded(child: SizedBox()),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level5, context)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                      top: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 22,
                          width: 80,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level3, context)
                            ),
                          )
                        ), 
                        3.verticalSpace,
                        SizedBox(
                          height: 14,
                          width: 100,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level3, context)
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}