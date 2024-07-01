import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:move_cam/screens/camera/camera_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../providers/permission_provider.dart';
import 'permission_card.dart';

class OnBoardingPermissionScreen extends ConsumerStatefulWidget {
  const OnBoardingPermissionScreen({super.key});

  @override
  ConsumerState<OnBoardingPermissionScreen> createState() {
    return _OnBoardingPermissionScreenState();
  }
}

class _OnBoardingPermissionScreenState
    extends ConsumerState<OnBoardingPermissionScreen> {
  void getCameraPermission(bool flag) async {
    bool status = await requestPermission(Permission.camera);

    ref
        .read(permissionProvider.notifier)
        .addPermission(Permission.camera, status);
  }

  void getLocationPermission(bool flag) async {
    bool status = await requestPermission(Permission.location);

    ref
        .read(permissionProvider.notifier)
        .addPermission(Permission.location, status);
  }

  void getGalleryPermission(bool flag) async {
    bool status = await requestPermission(Permission.storage);

    ref
        .read(permissionProvider.notifier)
        .addPermission(Permission.storage, status);
  }

  Future<bool> requestPermission(Permission permission) async {
    PermissionStatus status = await permission.request();

    return status.isGranted;
  }

  void moveToCameraScreen() async {
    var camera = await getCameras();
    if (mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => CameraScreen(
                    camera: camera,
                  )));
    }
  }

  Future<CameraDescription> getCameras() async {
    final cameras = await availableCameras();
    return cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    final permissionsStatus = ref.watch(permissionProvider);

    var isAllPermissionGiven =
        permissionsStatus.values.every((status) => status == true);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF189AB4),
                Color(0xFFFAF9F6),
                Color(0xFFFAF9F6),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Lottie.asset(
                  "assets/animations/onboarding_permission_anim.json",
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "We need some access",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.orange),
              ),
              Text(
                "You need to grant access to the device camera, Gallery, Location to take photos.",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      PermissionCard(
                        iconPath: "assets/svg_icons/camera.svg",
                        title: "Camera Permission",
                        description:
                            "This permission is needed to capture photos",
                        isChecked: permissionsStatus[Permission.camera],
                        onChanged: getCameraPermission,
                      ),
                      const SizedBox(height: 20),
                      PermissionCard(
                        iconPath: "assets/svg_icons/location.svg",
                        title: "Location Permission",
                        description:
                            "This permission is needed to fetch location",
                        isChecked: permissionsStatus[Permission.location],
                        onChanged: getLocationPermission,
                      ),
                      const SizedBox(height: 20),
                      PermissionCard(
                        iconPath: "assets/svg_icons/gallery.svg",
                        title: "Gallery Permission",
                        description:
                            "This permission is needed to fetch media from gallery",
                        isChecked: permissionsStatus[Permission.storage],
                        onChanged: getGalleryPermission,
                      ),
                      const SizedBox(height: 40),
                      Visibility(
                        visible: isAllPermissionGiven,
                        child: ElevatedButton(
                            onPressed: moveToCameraScreen,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      const SizedBox(height: 20),
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
