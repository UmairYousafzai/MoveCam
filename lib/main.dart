import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move_cam/screens/onboarding/onboarding_permission.dart';



final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 131, 57, 0),
        brightness: Brightness.light),
    textTheme: GoogleFonts.latoTextTheme());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: GeoCameraApp()));
}

class GeoCameraApp extends StatelessWidget {
  const GeoCameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Move Cam",
      theme: theme,
      home: const OnBoardingPermissionScreen(),
    );
  }
}
