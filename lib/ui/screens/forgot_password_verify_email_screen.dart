import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/verify_otp_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  static const String name = '/forgot-password/verify-email';

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() =>
      _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState
    extends State<ForgotPasswordVerifyEmailScreen> {
  final TextEditingController _emailEDcontroller = TextEditingController();
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
                Text("Your Email Address", style: textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(
                  "A 6 digits of OTP will be sent to your email address",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailEDcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {

                      Navigator.pushNamed(context, VerifyOTPscreen.name);
                    },
                    child: Icon(Icons.arrow_circle_right_outlined)),
                const SizedBox(height: 48),
                Center(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: " Sign In",
                              style:
                                  const TextStyle(color: AppColors.themeColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, SignInScreen.name);
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
    super.dispose();
  }
}
