import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/app_logo.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  //next page a jawar code====================
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  //next page jawer jonno fongson====================
  Future<void> moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}
