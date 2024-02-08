import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/widgets/tonal_elevation.dart';

class EditPicture extends StatelessWidget {
  const EditPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
      ),
      child: Padding(
        padding: EdgeInsets.all(0.03.sw),
        child: Column(
          children: [
            SizedBox.square( // picture
              dimension: 60,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(35)
                ),
              ),
            ),
            const Expanded(child: SizedBox()),

            const ListTile(
              leading: Icon(Icons.image_outlined),
              title: Text('Choose from library'),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text('Take photo'),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(CupertinoIcons.delete),
              title: Text('Remove current picture'),
            ),

            const Expanded(child: SizedBox()),
            SizedBox( // save changes button
              height: 60,
              child: InkWell(
                onTap: (){
                  //TODO: save changes
                  routerConfig.pop();
                  
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.inverseSurface
                  ),
                  child: Center(
                    child: Text(
                      'Save Changes',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onInverseSurface
                      )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}