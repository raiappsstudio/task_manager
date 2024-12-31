import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

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
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameEDcontroller,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Last Name"),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _mobileEDcontroller,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Mobile"),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailEDcontroller,
                      obscureText: true,
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
                        onPressed: () {},
                        child: Icon(Icons.arrow_circle_right_outlined)),
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
                                  style: const TextStyle(color: AppColors.themeColor),
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                    Navigator.pop(context);
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
    _firstNameEDcontroller.dispose();
    _lastNameEDcontroller.dispose();
    _mobileEDcontroller.dispose();
    super.dispose();
  }

}
