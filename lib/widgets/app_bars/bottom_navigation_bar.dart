import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatefulWidget {
  final List<String> iconPaths;
  final List<String> labels;
  final ValueNotifier<bool> isVisible;
  final ValueChanged<int>? onTap;
  final int startIndex;

  const CustomBottomNavBar({
    required this.iconPaths,
    required this.labels,
    required this.isVisible,
    this.onTap,
    this.startIndex = 0,
    super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> with SingleTickerProviderStateMixin{
  late int currentIndex;
  late AnimationController offsetAnimationController;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.startIndex;
    offsetAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this
    );
    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 1)
    ).animate(offsetAnimationController);
    
    widget.isVisible.addListener(() {
      if(!widget.isVisible.value){
        offsetAnimationController.forward();
      } else{
        offsetAnimationController.reverse();  
      }    
    });
  }

  @override
  void dispose(){
    offsetAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offsetAnimation,
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(topLeft: Radius.elliptical(20, 10), topRight: Radius.elliptical(20, 10))
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(widget.iconPaths.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      widget.onTap?.call(index);
                      if (!(index == 1 || index == 2)) {
                        // dont change the currentIndex for i=1 or i=2 because a navigation is occouring
                        setState(() {
                          currentIndex = index;
                        });
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox.square(
                          dimension: 18,
                          child: SvgPicture.asset(
                            widget.iconPaths[index],
                            colorFilter: index == currentIndex
                                ? const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn)
                                : ColorFilter.mode(
                                    Colors.white.withOpacity(0.32),
                                    BlendMode.srcIn),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.labels[index],
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  color: index == currentIndex
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.32)),
                        )
                      ],
                    ),
                  );
                })),
          ),
        ),
      ),
    );
  }
}
