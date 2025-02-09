import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/center_circular_inprogress_ber.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_ber_messge.dart';
import 'package:get/get.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final TextEditingController _firstNameEDcontroller = TextEditingController();
  final TextEditingController _lastNameEDcontroller = TextEditingController();
  final TextEditingController _mobileEDcontroller = TextEditingController();
  final TextEditingController _emailEDcontroller = TextEditingController();
  final TextEditingController _passwordEDcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _signupInprogress = false;

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
                Text("Join With Us", style: textTheme.titleLarge),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _firstNameEDcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "First Name"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your First name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _lastNameEDcontroller,
                  decoration: InputDecoration(hintText: "Last Name"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter Your Last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _mobileEDcontroller,
                  decoration: InputDecoration(hintText: "Mobile"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your Mobile no";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailEDcontroller,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'enter your mail';
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
                      return 'enter your password';
                    }
                    if(value!.length <6 ){
                      return 'Enter a password more than 6 letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible: _signupInprogress == false,
                  replacement: CenterCirculerInprogressBer(),
                  child: ElevatedButton(
                      onPressed: () {
                        _onTapSignUpButton();
                      },
                      child: Icon(Icons.arrow_circle_right_outlined)),
                ),
                const SizedBox(height: 48),
                Center(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "You have an account?",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: " Sign In",
                              style:
                                  const TextStyle(color: AppColors.themeColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //Navigator.pop(context);
                                  Get.back();
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

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _registerUser();
    }
  }

  Future<void> _registerUser() async {
      _signupInprogress = true;
      setState(() {});

      Map<String, dynamic> requestbody = {
        "email": _emailEDcontroller.text.trim(),
        "firstName": _firstNameEDcontroller.text.trim(),
        "lastName": _lastNameEDcontroller.text.trim(),
        "mobile": _mobileEDcontroller.text.trim(),
        "password": _passwordEDcontroller.text,
        "photo": ""
      };

      final NetworkResponse response = await NetworkCaller.postRequest(
          url: Urls.registationUrl, body: requestbody);
      _signupInprogress = false;
      setState(() {});
      if (response.isSuccess) {
        _clearTextFields();
        showSnackBerMessage(context, 'New registration successfull');
        //Navigator.pushNamed(context, SignInScreen.name);
        Get.offNamed(SignInScreen.name);
      } else {
        showSnackBerMessage(context, response.errorMessage);
      }

  }

  void _clearTextFields() {
    _firstNameEDcontroller.clear();
    _lastNameEDcontroller.clear();
    _emailEDcontroller.clear();
    _passwordEDcontroller.clear();
    _mobileEDcontroller.clear();
  }

  @override
  void dispose() {
    _emailEDcontroller.dispose();
    _passwordEDcontroller.dispose();
    _firstNameEDcontroller.dispose();
    _lastNameEDcontroller.dispose();
    _mobileEDcontroller.dispose();
    super.dispose();
  }
}
