import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/controllers/update_profile_controller.dart';
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
  final UpdateProfileController _updateProfileController = Get.find<UpdateProfileController>();

  @override
  void initState() {
    super.initState();

    _firstNameEDcontroller.text = AuthController.userModel?.firstName ?? "";
    _lastNameEDcontroller.text = AuthController.userModel?.lastName ?? "";
    _mobileEDcontroller.text = AuthController.userModel?.mobile ?? "";
    _emailEDcontroller.text = AuthController.userModel?.email ?? "";

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
                GetBuilder<UpdateProfileController>(
                  builder: (context) {
                    return Visibility(
                      visible: _updateProfileController.inProgress == false,
                      replacement: CenterCirculerInprogressBer(),
                      child: ElevatedButton(
                          onPressed: () {
                            _onTapUpdateButton();                          },
                          child: Icon(Icons.arrow_circle_right_outlined)),
                    );
                  }
                ),
                const SizedBox(height: 48),

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

  void _onTapUpdateButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
      TMAppBar();
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
    final bool isSuccess = await _updateProfileController.UpdateProfile(
        _emailEDcontroller.text.trim(),
        _firstNameEDcontroller.text.trim(),
        _lastNameEDcontroller.text.trim(),
        _mobileEDcontroller.text.trim(),
        _passwordEDcontroller.text,
        _pickedImage // Pass the image here instead of password again
    );




    if (!isSuccess) {
      showSnackBerMessage(context, _updateProfileController.errorMassage!);
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
