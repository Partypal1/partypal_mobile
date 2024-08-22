import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

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
  late int _currentIndex;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 1)
    ).animate(_animationController);
    _sizeAnimation = Tween<double>(
      begin: 1,
      end: 0
    ).animate(_animationController);

    widget.isVisible.addListener(() {
      if(!widget.isVisible.value){
        _animationController.forward();
      } else{
        _animationController.reverse();  
      }    
    });
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: SizeTransition(
        sizeFactor: _sizeAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level2, context),
                // borderRadius: const BorderRadius.only(topLeft: Radius.elliptical(20, 10), topRight: Radius.elliptical(20, 10))
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(widget.iconPaths.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          widget.onTap?.call(index);
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox.square(
                                dimension: 20,
                                child: SvgPicture.asset(
                                  widget.iconPaths[index],
                                  colorFilter: index == _currentIndex
                                      ? ColorFilter.mode(
                                          Theme.of(context).colorScheme.onSurface,
                                          BlendMode.srcIn
                                        )
                                      : ColorFilter.mode(
                                          Theme.of(context).colorScheme.onSurface.withOpacity(0.32),
                                          BlendMode.srcIn
                                        ),
                                ),
                              ),
                              8.verticalSpace,
                              Text(
                                widget.labels[index],
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: index == _currentIndex
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.32)
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
