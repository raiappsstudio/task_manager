import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/cancel_task_list_screen.dart';
import 'package:task_manager/ui/screens/completed_task_list_screen.dart';
import 'package:task_manager/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/new_task_list_screen.dart';
import 'package:task_manager/ui/screens/progress_task_list_screen.dart';
import 'package:task_manager/ui/screens/set_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';
import 'package:task_manager/ui/screens/verify_otp_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});


  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //colors====================
          colorSchemeSeed: AppColors.themeColor,
          //Text style==============================
          textTheme: const TextTheme(
              titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              titleMedium: TextStyle(fontSize: 16),
              titleSmall: TextStyle(fontSize: 12),
          ),

          //inputText decoration==========================
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              fillColor: Colors.white,
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
          //elevated buttom theme==========================
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              fixedSize: const Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              foregroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 16),
            ),
          )), //light theme end here=================

      initialRoute: '/',
      navigatorKey: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == SplashScreen.name) {
          widget = const SplashScreen();
        } else if (settings.name == SignInScreen.name) {
          widget = const SignInScreen();
        } else if (settings.name == SingUpScreen.name) {
          widget = const SingUpScreen();
        } else if (settings.name == ForgotPasswordEmailScreen.name) {
          widget = const ForgotPasswordEmailScreen();
        } else if (settings.name == VerifyOTPscreen.name) {
          widget = const VerifyOTPscreen();
        } else if (settings.name == ResetPasswordScreen.name) {
          widget = const ResetPasswordScreen();
        }else if (settings.name == MainBottomNavScreen.name) {
          widget = const MainBottomNavScreen();
        }else if (settings.name == NewTaskListScreen.name) {
          widget = const NewTaskListScreen();
        }else if (settings.name == ProgressTaskListScreen.name) {
          widget = const ProgressTaskListScreen();
        }else if (settings.name == CompletdTaskListScreen.name) {
          widget = const CompletdTaskListScreen();
        }else if (settings.name == CancelTaskListScreen.name) {
          widget = const CancelTaskListScreen();
        }else if (settings.name == AddNewTaskScreen.name) {
          widget = const AddNewTaskScreen();
        }else if (settings.name == UpdateProfileScreen.name) {
          widget = const UpdateProfileScreen();
        }




        return MaterialPageRoute(builder: (_) => widget);
      },
    );
  }
}
