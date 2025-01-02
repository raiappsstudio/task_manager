import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _emailEDcontroller = TextEditingController();
  final TextEditingController _passwordEDcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: ScreenBackground(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text("Get Started With", style: textTheme.titleLarge),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailEDcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordEDcontroller,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Password"),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {

                      Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);


                    },
                    child: Icon(Icons.arrow_circle_right_outlined)),
                const SizedBox(height: 48),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ForgotPasswordVerifyEmailScreen.name);
                        },
                        child: const Text("Forgot Password"),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: " Sign Up",
                              style: const TextStyle(color: AppColors.themeColor),
                              recognizer: TapGestureRecognizer()..onTap = () {

                                Navigator.pushNamed(context, SingUpScreen.name);
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }


  @override
  void dispose() {
    _emailEDcontroller.dispose();
    _passwordEDcontroller.dispose();
    super.dispose();
  }

}
