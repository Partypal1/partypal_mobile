import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/theme/color_theme.dart';
import 'package:partypal/widgets/app_bar.dart';
import 'package:partypal/widgets/edit_picture.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({super.key});

  @override
  State<SetProfileScreen> createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(
                title: 'Set profile',
                hasBackButton: false 
              ),
            Padding(
              padding: EdgeInsets.all(0.03.sw),
              child: Column(
                children: [
                  SizedBox.square(
                    dimension: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(35)
                      ),
                    ),
                  ),
      
                  0.02.sh.verticalSpace,
      
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        // clipBehavior: Clip.antiAlias,
                        // shape: const RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                        // ),
                        backgroundColor: Colors.transparent,
                        builder: (context){
                          return const EditPicture();
                        }
                      );
                    },
                    child: Text(
                      'Choose picture',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary
                      ),
                    ),
                  ),
      
                  0.02.sh.verticalSpace,
      
                  TextFormField( // username
                    autofillHints: const [AutofillHints.username],
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter a username',
                      hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).textTheme.labelLarge?.color?.withOpacity(0.5)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      
                    ),
                    validator: (value){ //TODO: validate if the username is available
                      return null;
                    },
                  ),
      
                  0.02.sh.verticalSpace,
      
                  TextFormField( // location TODO: change this to a dropdown list
                    autofillHints: const [AutofillHints.location],
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      hintText: 'Preferred location',
                      hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).textTheme.labelLarge?.color?.withOpacity(0.5)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      
                    ),
                    validator: (value){
                      return null;
                    },
                  ),
      
                  0.05.sh.verticalSpace,
      
                  SizedBox( // done button
                    height: 60,
                    child: InkWell(
                      onTap: () {
                        routerConfig.push(RoutePaths.home);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: UIColors().inverseSurface
                        ),
                        child: Center(
                          child: Text(
                            'Done',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.surface
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}