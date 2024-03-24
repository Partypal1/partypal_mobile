import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partypal/screens/home/home.dart';
import 'package:partypal/widgets/buttons/filled_button.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  CameraController? _controller;
  bool _flashOn = false;
  @override
  void initState() {
    super.initState();
    HomeState homeState = context.findAncestorStateOfType<HomeState>()!;
    homeState.screenIndex.addListener(() {
      if(homeState.screenIndex.value != 2){ // Pause the camera if the bottom navigation bar is not on post screen
        _controller?.pausePreview();
      }
      else{
        _controller?.resumePreview();
      }
    });
  }

   @override
  void dispose(){
    _controller?.dispose();
    super.dispose();
  }

  Future<List<CameraDescription>> get _availableCameras {
    return availableCameras();
  }

  Future<CameraController> get _cameraController async {
    if (_controller == null){
      var cameras = await _availableCameras;
      _controller = CameraController(cameras.first, ResolutionPreset.high);
    }
    return _controller!;
  }

  void _toggleFlash(){
    setState(() {
      _flashOn = !_flashOn;
    });
    _controller?.setFlashMode(
      _flashOn ? FlashMode.torch : FlashMode.off
    );

  }

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox( // camera view
            height: double.infinity,
            width: double.infinity,
            child: FutureBuilder(
              future: _cameraController.then(
                (controller){
                  return controller.initialize();
                }
              ),
              builder: ((context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  return CameraPreview(_controller!);
                }
                return const Center(
                  child: SizedBox.square(
                    dimension: 50,
                    child: CircularProgressIndicator()
                  ),
                );
              }),  
            ),
          ),

          Align( // top buttons
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20
              ),
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: _toggleFlash,
                    icon: Icon(
                      _flashOn ? Icons.flash_on : Icons.flash_off,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align( // capture button
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: GestureDetector(
                onTap: () async {
                  final image = await _controller?.takePicture();
                  if (!context.mounted || image == null){
                    return;
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context){
                        return DisplayCameraImageScreen(imagePath: image.path);
                      }
                    )
                  );
                },
                child: SizedBox.square(
                  dimension: 80,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: Colors.white,
                        width: 6
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.white,
                        ),
                                      
                      ),
                    ),
                  ),
                ),
              )
            )
          )
        ],
      )
    );
  }
}


class DisplayCameraImageScreen extends StatelessWidget {
  final String imagePath;
  const DisplayCameraImageScreen({
    required this.imagePath,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox( // image
            height: double.infinity,
            width: double.infinity,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),

          Align( // top buttons
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.xmark,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const Expanded(child: SizedBox())
                ],
              ),
            ),
          ),

          Align( // post button
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: CustomFilledButton(
                label: 'Post',
                backgroundColor: Colors.white.withOpacity(0.8),
                labelColor: Colors.black,
                onTap: (){
                  // TODO: post picture
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}