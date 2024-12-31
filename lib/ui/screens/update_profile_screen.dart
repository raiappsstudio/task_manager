import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

import '../utils/app_colors.dart';
import '../widgets/screen_background.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static String name = "/update-profile";

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

final TextEditingController _firstNameEDcontroller = TextEditingController();
final TextEditingController _lastNameEDcontroller = TextEditingController();
final TextEditingController _mobileEDcontroller = TextEditingController();
final TextEditingController _emailEDcontroller = TextEditingController();
final TextEditingController _passwordEDcontroller = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey();


class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: TMAppBar(
        fromUpadeProfile: true,
      ),
      body: SingleChildScrollView(
        child: ScreenBackground(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text("Update Profile", style: textTheme.titleLarge),
                    const SizedBox(height: 24),
                    _buildPhotoPicker(),
                    const SizedBox(height: 8),
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

  Widget _buildPhotoPicker() {
    return Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 56,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            )
                          ),
                          alignment: Alignment.center,
                          child: Text("Photo",style: TextStyle(color: Colors.white),),
                        ),
                        SizedBox(width: 16,),
                        Text("No item selected")
                      ],
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
