import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/services/profile_management_service.dart';
import 'package:partypal/utils/router_util.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/buttons/filled_button.dart';
import 'package:partypal/widgets/cards/circle_image.dart';
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
  final ImagePicker _imagePicker = ImagePicker();
  XFile? selectedImage;

  Future getImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = image ?? selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileManagementService>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                  profile.user != null
                  ? selectedImage == null
                    ? CircleImage(imageURL: profile.user?.profileImageURL, radius: 35,)
                    : SizedBox.square(
                      dimension: 70,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35)
                        ),
                        child: Image.file(
                          File(selectedImage!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const CircleImageLoading(radius: 35,),

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
                                      ListTile(
                                        leading: const Icon(Icons.image_outlined),
                                        title: const Text('Choose from library'),
                                        onTap: (){
                                          log('here');
                                          getImage();
                                        },
                                      ),
                                      0.02.sw.verticalSpace,
                                      ListTile(
                                        leading: const Icon(CupertinoIcons.delete),
                                        title: const Text('Remove current picture'),
                                        onTap: (){
                                          setState(() {
                                            selectedImage = null;
                                          });
                                        },
                                      ),
                                      // 0.03.sw.verticalSpace,
                                      // CustomFilledButton(
                                      //   label: 'Save changes',
                                      //   onTap: (){
                                      //     //TODO: save changes
                                      //     GoRouter.of(context).pop();
                                      //   },
                                      // ),
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
                        SizedBox(
                          height: 50,
                          child: TextFormField( // username
                            autofillHints: const [AutofillHints.username],
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              hintText: 'Enter a username',
                              hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).textTheme.labelLarge?.color?.withOpacity(0.5)
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
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
                        ),
                    
                         0.02.sh.verticalSpace,
                          
                        SizedBox(
                          height: 50,
                          child: TextFormField( // location TODO: change this to a dropdown list
                            autofillHints: const [AutofillHints.location],
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              labelText: 'Location',
                              hintText: 'Preferred location',
                              hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).textTheme.labelLarge?.color?.withOpacity(0.5)
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
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
                  : CustomFilledButton(
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
      ProfileManagementService profile = Provider.of<ProfileManagementService>(context, listen: false);
      bool successful = await profile.updateProfile(
        username: username,
        imagePath: selectedImage?.path,
        location: location
      );
      setState(() => _isUploadingProfile = false);
      if(successful){
        log('uploaded sucessfully');
      }
      else{
        log('problem updating profile');
      }
      if(mounted){
        GoRouter.of(context).clearStackAndNavigate(RoutePaths.home);
      }
    }
  }
}