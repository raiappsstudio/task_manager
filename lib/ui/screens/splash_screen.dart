import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
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

    //token cheaking =====================================
    bool isUserLoggedIn = await AuthController.isUserLoggedIn();
    if (isUserLoggedIn) {
     // Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
      Get.offAllNamed(MainBottomNavScreen.name);
    } else {
     // Navigator.pushReplacementNamed(context, SignInScreen.name);
      Get.offAllNamed(SignInScreen.name);

    }
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
