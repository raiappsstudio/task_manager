import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/models/user_model.dart';
import '../../data/services/network_caller.dart';
import 'auth_controller.dart';
XFile? _pickedImage;


class UpdateProfileController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMassage => _errorMessage;

  Future<bool> UpdateProfile(String email, String firstname, String lastname, String mobile, String password, XFile? pickedImage) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestbody = {
      "email": email,
      "firstName": firstname,
      "lastName": lastname,
      "mobile": mobile,
    };

    if (pickedImage != null) {
      List<int> imageBytes = await pickedImage.readAsBytes();
      requestbody['photo'] = base64Encode(imageBytes);
    }

    if (password.isNotEmpty) {
      requestbody['password'] = password;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.updateProfile, body: requestbody);
    _inProgress = false;
    update();

    if (response.isSuccess) {
      String token = response.responseData!['token'];
      UserModel userModel = UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);

      isSuccess = true;
      _errorMessage = null;

    } else {
      _errorMessage = response.statusCode == 401
          ? 'Successfully not Update!'
          : response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }





// Future<bool> UpdateProfile(String email, String firstname, String lastname, String mobile, String password, String photo) async {
  //   bool isSuccess = false;
  //   _inProgress = true;
  //   update();
  //
  //   Map<String, dynamic> requestbody = {
  //     "email": email,
  //     "firstName": firstname,
  //     "lastName": lastname,
  //     "mobile": mobile,
  //   };
  //
  //
  //   if (_pickedImage != null) {
  //     List<int> imageBytes = await _pickedImage!.readAsBytes();
  //     requestbody['photo'] = base64Encode(imageBytes);
  //   }
  //
  //   if (password.isNotEmpty) {
  //     requestbody['password'] = password.toString();
  //   }
  //
  //
  //   final NetworkResponse response = await NetworkCaller.postRequest(
  //       url: Urls.updateProfile, body: requestbody);
  //   _inProgress = false;
  //   update();
  //
  //   if (response.isSuccess) {
  //     String token = response.responseData!['token'];
  //     UserModel userModel = UserModel.fromJson(response.responseData!['data']);
  //     await AuthController.saveUserData(token, userModel);
  //
  //     isSuccess = true;
  //     _errorMessage = null;
  //
  //   } else {
  //     if (response.statusCode == 401) {
  //       _errorMessage = 'Successfully not Update!';
  //     } else {
  //       _errorMessage = response.errorMessage;
  //     }
  //   }
  //   _inProgress = false;
  //   update();
  //   return isSuccess;
  // }
}
