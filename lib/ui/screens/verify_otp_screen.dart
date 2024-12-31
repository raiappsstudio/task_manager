import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/set_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class VerifyOTPscreen extends StatefulWidget {
  const VerifyOTPscreen({super.key});

  static const String name = '/verifyotpscreen';

  @override
  State<VerifyOTPscreen> createState() => _VerifyOTPscreenState();
}

class _VerifyOTPscreenState extends State<VerifyOTPscreen> {
  final TextEditingController _OTPEDcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: ScreenBackground(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text("PIN Verification", style: textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(
                  "A 6 digits of OTP has been sent to your email address",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(height: 24),

                //pin verify field=========================
                PinCodeTextField(
                  length: 6,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  controller: _OTPEDcontroller,
                  appContext: context,
                ),
                //pin verify field end===============================

                const SizedBox(height: 24),
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, SetPasswordScreen.name);

                }, child: Text("Verify")),
                const SizedBox(height: 48),
                Center(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "have an account?",
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
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      SignInScreen.name, (value) => false);
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
    _OTPEDcontroller.dispose();
    super.dispose();
  }
}
