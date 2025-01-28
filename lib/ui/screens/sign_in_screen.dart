import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/center_circular_inprogress_ber.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_ber_messge.dart';

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
  bool _signInprogress = false;

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
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter the Mail';
                    }
                    if (value!.length < 6) {
                      return 'Enter a password more than 6 letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordEDcontroller,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Password"),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible: _signInprogress == false,
                  replacement: CenterCirculerInprogressBer(),
                  child: ElevatedButton(
                      onPressed: () {

                        _onTapSignIn();
                      },
                      child: Icon(Icons.arrow_circle_right_outlined)),
                ),
                const SizedBox(height: 48),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ForgotPasswordEmailScreen.name);
                        },
                        child: const Text("Forgot Password"),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: " Sign Up",
                              style:
                                  const TextStyle(color: AppColors.themeColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, SingUpScreen.name);
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

  void _onTapSignIn() {
    if (_formKey.currentState!.validate()) {
      _signInprogress = true;
      setState(() {});
      _signInUser();
    }
  }

  Future<void> _signInUser() async {
    Map<String, dynamic> requestbody = {
      "email": _emailEDcontroller.text.trim(),
      "password": _passwordEDcontroller.text,
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.signInUrl, body: requestbody);
    _signInprogress = false;
    setState(() {});

    if (response.isSuccess) {
      String token = response.responseData!['token'];
      UserModel userModel =UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);


      showSnackBerMessage(context, 'Sign In Successfull!');
      Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
    } else {
      if (response.statusCode == 401) {
        showSnackBerMessage(context, 'email and password is wrong');
      } else {
        showSnackBerMessage(context, response.errorMessage);
      }
    }
  }

  @override
  void dispose() {
    _emailEDcontroller.dispose();
    _passwordEDcontroller.dispose();
    super.dispose();
  }
}
