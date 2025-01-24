import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/widgets/center_circular_inprogress_ber.dart';
import 'package:task_manager/ui/widgets/snack_ber_messge.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

import '../utils/app_colors.dart';
import '../widgets/screen_background.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static String name = "/update-profile";

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}






class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final TextEditingController _firstNameEDcontroller = TextEditingController();
  final TextEditingController _lastNameEDcontroller = TextEditingController();
  final TextEditingController _mobileEDcontroller = TextEditingController();
  final TextEditingController _emailEDcontroller = TextEditingController();
  final TextEditingController _passwordEDcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  XFile? _pickedImage;
  bool updateInprogress = false;


  @override
  void initState() {
    super.initState();

    _firstNameEDcontroller.text = AuthController.userModel?.firstName?? "";
    _lastNameEDcontroller.text = AuthController.userModel?.lastName?? "";
    _mobileEDcontroller.text = AuthController.userModel?.mobile?? "";
    _emailEDcontroller.text = AuthController.userModel?.email?? "";



  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: TMAppBar(
        fromUpdateProfile: true,
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
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter the Mail';
                    }
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _lastNameEDcontroller,
                  decoration: InputDecoration(hintText: "Last Name"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter the Mail';
                    }
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _mobileEDcontroller,
                  decoration: InputDecoration(hintText: "Mobile"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter the Mail';
                    }
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  enabled: false,
                  controller: _emailEDcontroller,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordEDcontroller,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Password"),
                  
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible: updateInprogress == false,
                  replacement: CenterCirculerInprogressBer(),
                  child: ElevatedButton(
                      onPressed: () {
                        _updateProfile();
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
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
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
                  )),
              alignment: Alignment.center,
              child: Text(
                "Photo",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              _pickedImage == null ? "No item selected" : _pickedImage!.name,
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
  
  
  void _onTapUpdateButton (){
    if (_formKey.currentState!.validate()){
      _updateProfile();
    }
  }
  

  Future<void> _pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _pickedImage = image;
      setState(() {});
    }
  }

  Future<void> _updateProfile() async {
    updateInprogress = true;
    setState(() {});

    Map<String, dynamic> requsetBody = {
      "email": _emailEDcontroller.text.trim(),
      "firstName": _firstNameEDcontroller.text.trim(),
      "lastName": _lastNameEDcontroller.text.trim(),
      "mobile": _mobileEDcontroller.text.trim(),
    };

    if (_pickedImage != null) {
      List<int> imageBytes = await _pickedImage!.readAsBytes();
      requsetBody['photo'] = base64Encode(imageBytes);
    }

    if (_passwordEDcontroller.text.isNotEmpty) {
      requsetBody['password'] = _passwordEDcontroller.text;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfile,
      body: requsetBody);
    updateInprogress = false;
    setState(() {});
    if (response.isSuccess){
      _pickedImage = null;
      _passwordEDcontroller.clear();
      showSnackBerMessage(context, 'profile updated successfully! ');
    }else{
      showSnackBerMessage(context, response.errorMessage);

    }




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
