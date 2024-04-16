import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/models/place_model.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';
import 'dart:math' as math;

class PlaceHeatMapCard extends StatefulWidget {
  final Place place;
  const PlaceHeatMapCard({
    required this.place,
    super.key});

  @override
  State<PlaceHeatMapCard> createState() => _PlaceHeatMapCardState();
}

class _PlaceHeatMapCardState extends State<PlaceHeatMapCard>{
  late List<List<double>> heatMap;
  int selectedDayIndex = DateTime.now().weekday;

  @override
  void initState(){
    super.initState();
    heatMap = _generateHeatMap();
  }

  @override
  void dispose(){
    super.dispose();
  }

  List<List<double>> _generateHeatMap(){ //TODO: get the actual heat map from place model
    final random = math.Random();
    return List.generate(7, (index){
      return List.generate(8, (index) => (random.nextInt(7) + 2) / 10);
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          0.03.sw.verticalSpace,
      
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level2, context)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      'Heat map',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      
          0.03.sw.verticalSpace,
      
          _DaySelector( // day selector
            onTap: (value){
              setState(() {
                selectedDayIndex = value;
              });
            }
          ),
      
          0.03.sw.verticalSpace,
      
          Center( // graph
            child: SizedBox(
              width: 0.9.sw,
              height: 0.7.sw,
              child: CustomPaint(
                painter: _GraphPainter(
                  context,
                  heatMapForTheDay: heatMap[selectedDayIndex]
                ),
              ),
            ),
          ),
      
          0.05.sw.verticalSpace,
      
          Row( // legend
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level2, context),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox.square(
                                dimension: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              ),
                              Text(
                                '  Hot',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                '  high enegy',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.outline.withOpacity(0.5)
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox.square(
                                dimension: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              ),
                              Text(
                                '  Chill',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                '  low enegy',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.outline.withOpacity(0.5)
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          0.03.sw.verticalSpace
        ],
      ),
    );
  }
}

class _DaySelector extends StatefulWidget {
  final ValueChanged<int>? onTap;
  const _DaySelector({
    this.onTap,
    super.key
  });

  @override
  State<_DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<_DaySelector> {
  List<String> days = ['su', 'mo' ,'tu' ,'we', 'th', 'fr', 'sa'];
  int selectedDayIndex = DateTime.now().weekday;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        days.length,
        (index){
          return GestureDetector(
            onTap: (){
              setState(() {
                selectedDayIndex = index;
              });
              widget.onTap?.call(index);
            },
            child: SizedBox(
              width: 0.1.sw,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.05.sw),
                  color: selectedDayIndex == index
                    ? Theme.of(context).colorScheme.onSurface
                    : null,
                  border: selectedDayIndex == index
                    ? null
                    : Border.all(
                        width: 0.5,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                      )
                ),
                child: Center(
                  child: Text(
                    days[index],
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: selectedDayIndex == index
                        ? Theme.of(context).colorScheme.onInverseSurface
                        : Theme.of(context).colorScheme.onSurface
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      )
    );
  }
}

class _GraphPainter extends CustomPainter{
  final List<double> heatMapForTheDay;
  final BuildContext context;
  const _GraphPainter( this.context, {
    required this.heatMapForTheDay
  });

  Color _interpolateColor(Color color1, Color color2, double value){
    return Color.fromRGBO(
      color1.red + ((color2.red - color1.red) * value).floor(),
      color1.green + ((color2.green - color1.green) * value).floor(),
      color1.blue + ((color2.blue - color1.blue) * value).floor(),
      1
    );
  }

  final List<String> hours = const ['12am', '3am', '6am', '9am', '12pm', '3pm', '6pm', '9pm'];

  @override
  bool shouldRepaint(_GraphPainter oldDelegate) => oldDelegate.heatMapForTheDay != heatMapForTheDay;

  @override
  void paint(canvas, size){
    for (int i = 0; i <= heatMapForTheDay.length; i++){ // draw grid
      canvas.drawLine( // horizontal
        Offset(0, size.height * i/heatMapForTheDay.length),
        Offset(size.width, size.height * i/heatMapForTheDay.length),
        Paint()
          ..color = Theme.of(context).colorScheme.outline.withOpacity(0.5)
          ..strokeCap = StrokeCap.round
      );
      canvas.drawLine( // vertical
        Offset(size.width * i/heatMapForTheDay.length, 0),
        Offset(size.width * i/heatMapForTheDay.length, size.height),
        Paint()
          ..color = Theme.of(context).colorScheme.outline.withOpacity(0.5)
          ..strokeCap = StrokeCap.round
      );
    }

    for(int i = 0; i < hours.length; i++){ // draw legend
      final painter = TextPainter(
        text: TextSpan(
          text: hours[i],
          style: Theme.of(context).textTheme.labelSmall
        ),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr,
      ); 
      painter.layout(maxWidth: 50);
      painter.paint(
          canvas,
          Offset(
            size.width * i / hours.length + (size.width/hours.length - painter.size.width)/2,
            size.height
          )
        );
    }

    for (int i = 0; i < heatMapForTheDay.length; i++){ // draw points
      canvas.drawCircle(
        Offset(
          size.width * i/heatMapForTheDay.length + (size.width/ (2 * heatMapForTheDay.length)),
          size.height * (1 - heatMapForTheDay[i])
        ),
        10,
        Paint()
          ..color = _interpolateColor(Colors.blue, Colors.red, heatMapForTheDay[i])
      );
    }    
  }
}