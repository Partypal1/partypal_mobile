import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/network/network_response.dart';
import 'package:partypal/services/profile_provider.dart';
import 'package:partypal/utils/router_util.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/buttons/wide_button.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';
import 'package:provider/provider.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({super.key});

  @override
  State<SetProfileScreen> createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String location = '';
  String binaryImage = '';
  bool _isUploadingProfile = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level0, context),
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
                        elevation: 20,
                        backgroundColor: Colors.transparent,
                        builder: (context){
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                  color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(0.03.sw),
                                  child: Column(
                                    children: [
                                      0.03.sw.verticalSpace,
                                      SizedBox.square( // picture
                                        dimension: 60,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.surfaceVariant,
                                            borderRadius: BorderRadius.circular(35)
                                          ),
                                        ),
                                      ),
                                      0.03.sw.verticalSpace,
                                      const ListTile(
                                        leading: Icon(Icons.image_outlined),
                                        title: Text('Choose from library'),
                                      ),
                                      0.02.sw.verticalSpace,
                                      const ListTile(
                                        leading: Icon(CupertinoIcons.delete),
                                        title: Text('Remove current picture'),
                                      ),
                                      0.03.sw.verticalSpace,
                                      WideButton(
                                        label: 'Save changes',
                                        onTap: (){
                                          //TODO: save changes
                                          routerConfig.pop();
                                        },
                                      ),
                                      0.03.sw.verticalSpace
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
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
      
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                          onChanged: (value){
                            username = value;
                          },
                          validator: (value){ //TODO: validate if the username is available
                            if(value == null || value.length < 3){
                              return 'Usernames should be at least 3 characters';
                            }
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
                          onChanged: (value){
                            location = value;
                          },
                          validator: (value){
                            if(value == null || value.length < 3){
                              return 'Enter a valid location';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                 
                  0.05.sh.verticalSpace,

                  _isUploadingProfile
                  ? const SizedBox.square(
                      dimension: 50,
                      child: CircularProgressIndicator(),
                    )
                  : WideButton(
                      label: 'Done',
                      onTap: _uploadProfile
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _uploadProfile() async{
    if(_formKey.currentState?.validate() ?? false){
      setState(() => _isUploadingProfile = true);
      ProfileProvider profile = Provider.of<ProfileProvider>(context, listen: false);
      NetworkResponse response = await profile.uploadProfile(
        context: context,
        username: username,
        location: location,
        image: 'binaryImage' //TODO: upload actual image
      );
      setState(() => _isUploadingProfile = false);
      if(response.successful){
        log('uploaded sucessfully');
        routerConfig.clearAndNavigate(RoutePaths.home);
      }
      else{
        //TODO: remove this
        routerConfig.clearAndNavigate(RoutePaths.home);
      }
    }
  }
}