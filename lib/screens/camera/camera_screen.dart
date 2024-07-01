import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({required this.camera, super.key});

  final CameraDescription camera;

  @override
  State<StatefulWidget> createState() {
    return _CameraScreen();
  }
}

class _CameraScreen extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _cameraControllerFuture;

  @override
  void initState() {
    super.initState();

    _cameraController = CameraController(widget.camera, ResolutionPreset.high);
    _cameraControllerFuture = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _cameraControllerFuture,
          builder: (ctx, snapShot) {
            if (snapShot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  CameraPreview(_cameraController),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black87,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.flash_on,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.flip_camera_ios_outlined,
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ))
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
